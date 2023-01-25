Nonterminals
  root
  block
  package_decl
  import_decl
  import_decls
  import_name
  visibility
  annotations
  annotation
  marker_annotation
  enum_decl
  enum_body
  enum_value
  enum_values
  class_decl
  class_body
  class_block
  field
  type_name
  typed_arg
  typed_args
  method_decl
  method_sig
.

Terminals
  package
  import
  fqn
  annotation_name
  public
  private
  protected
  enum
  identifier
  class
  final
  '.*'
  ';'
  '{'
  '}'
  ','
  '('
  ')'
  '@'
.

Rootsymbol
  root
.

% Top level rules
root -> package_decl block : maps:merge(#{package => '$1', imports => []}, '$2').
root -> package_decl import_decls : #{package => '$1', imports => '$2'}.
root -> package_decl import_decls block : maps:merge(#{package => '$1', imports => '$2'}, '$3').

package_decl -> 'package' fqn ';' : binary_to_atom(unwrap('$2')).

import_decl -> 'import' import_name ';' : unwrap('$2').
import_decls -> import_decl : ['$1'].
import_decls -> import_decl import_decls : ['$1'] ++ '$2'.

% Main Block
block -> enum_decl : #{enum => '$1'}.
block -> class_decl : #{class => '$1'}.

% Enums
enum_decl -> 'enum' identifier '{' enum_body '}' : #{visibility => 'private', name => unwrap('$2'), body => '$4', annotations => []}.
enum_decl -> visibility 'enum' identifier '{' enum_body '}' : #{visibility => '$1', name => unwrap('$3'), body => '$5', annotations => []}.
enum_decl -> annotations 'enum' identifier '{' enum_body '}' : #{visibility => 'private', name => unwrap('$3'), body => '$5', annotations => '$1'}.
enum_decl -> annotations visibility 'enum' identifier '{' enum_body '}' : #{visibility => '$2', name => unwrap('$4'), body => '$6', annotations => '$1'}.

enum_body -> enum_values : [{enum_values, '$1'}].
enum_body -> enum_values class_block : [{enum_values, '$1'}] ++ '$2'.

enum_values -> enum_value : ['$1'].
enum_values -> enum_value ';' : ['$1'].
enum_values -> enum_value ',' enum_values : ['$1'] ++ '$3'.
enum_values -> enum_value ',' enum_values ';' : ['$1'] ++ '$3'.

enum_value -> identifier : #{name => unwrap('$1'), args => []}.
enum_value -> identifier '(' typed_args ')' : #{name => unwrap('$1'), args => '$3'}.

% Classes
class_decl -> 'class' identifier '{' '}' : make_class('private', unwrap('$2'), []).
class_decl -> 'class' identifier '{' class_body '}' : make_class('private', unwrap('$2'), unwrap('$4')).
class_decl -> visibility 'class' identifier '{' '}' : make_class(unwrap('$1'), unwrap('$3'), []).
class_decl -> visibility 'class' identifier '{' class_body '}' : make_class(unwrap('$1'), unwrap('$3'), unwrap('$5')).

class_body -> class_block : ['$1'].
class_body -> class_block class_body : ['$1'] ++ '$2'.

class_block -> field ';' : {field, '$1'}.
class_block -> method_decl : {method, '$1'}.

% Methods
method_decl -> method_sig '{' '}' : maps:merge('$1', #{body => []}).
%method_decl -> method_sig '{' method_body '}' : maps:merge('$1', #{body => []}).

method_sig -> type_name identifier '(' ')' : #{visibility => 'private', returns => unwrap('$1'), name => unwrap('$2'), args => []}.
method_sig -> type_name identifier '(' typed_args ')' : #{visibility => 'private', returns => unwrap('$1'), name => unwrap('$2'), args => '$4'}.
method_sig -> visibility type_name identifier '(' ')' : #{visibility => unwrap('$1'), returns => unwrap('$2'), name => unwrap('$3'), args => []}.
method_sig -> visibility type_name identifier '(' typed_args ')' : #{visibility => unwrap('$1'), returns => unwrap('$2'), name => unwrap('$3'), args => '$5'}.

% Annotations
annotations -> annotation : ['$1'].
annotations -> annotation annotations : ['$1'] ++ '$2'.

annotation -> marker_annotation : '$1'.

marker_annotation -> annotation_name : #{name => unwrap('$1'), args => []}.

% Generic rules
typed_args -> typed_arg : ['$1'].
typed_args -> typed_arg ',' typed_args : ['$1'] ++ '$3'.

typed_arg -> type_name identifier : #{type => unwrap('$1'), name => unwrap('$2'), final => false}.
typed_arg -> 'final' type_name identifier : #{type => unwrap('$2'), name => unwrap('$3'), final => true}.

visibility -> 'public' : unwrap('$1').
visibility -> 'private' : unwrap('$1').
visibility -> 'protected' : unwrap('$1').

field -> typed_arg : maps:merge(#{visibility => 'private'}, '$1').
field -> visibility typed_arg : maps:merge(#{visibility => 'private'}, '$2').

type_name -> fqn : unwrap('$1').
type_name -> identifier : unwrap('$1').

import_name -> fqn : unwrap('$1').
import_name -> fqn '.*' : list_to_binary([unwrap('$1'), unwrap('$2')]).

Erlang code.
unwrap({_, _, Val}) -> Val;
unwrap(Val) -> Val.

make_class(Visibility, Name, Body) -> #{visibility => Visibility, name => Name, body => Body}.
