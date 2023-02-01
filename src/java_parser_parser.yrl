Nonterminals
  root
  package_stmt
  import_stmt
  import_stmts

  top_block

  class_block
  class_signature
  class_marker
  class_inheritance
  class_body
  class_body_item
  class_type_decl
  class_type_decls

  enum_block
  enum_signature
  enum_value
  enum_values
  enum_marker
  enum_inheritance

  field
  value
  expr
  chainable_expr
  lambda_expr
  expr_list
  method_call

  method_block
  method_signature
  typed_args
  method_body
  method_body_item

  annotation
  annotations
  visibility
  type
  type_list

  fqn
  fqn_list
.

Terminals
  package
  import
  public
  private
  protected
  static
  final
  enum
  class
  extends
  implements
  return
  new
  abstract

  true
  false
  null

  identifier
  wildcard_import
  string_literal
  integer
  float
  annotation_name

  ';'
  '{'
  '}'
  ','
  '('
  ')'
  '='
  '<'
  '>'
  '.'
  '+'
  '-'
  '*'
  '/'
  '&&'
  '||'
  '=='
  '!='
  '&'
  '|'
  '!'
  '::'
  '->'
  '['
  ']'
  '...'
.

Rootsymbol
  root
.

Unary 100 '!'.
Right 100 '='.
Left 300 '+'.
Left 300 '-'.
Left 400 '*'.
Left 400 '/'.
Left 500 '&'.
Left 500 '|'.
Left 500 '&&'.
Left 500 '||'.
Left 500 '=='.
Left 500 '!='.

% Top level blocks
root -> package_stmt : #{package => '$1', imports => []}.
root -> package_stmt top_block : maps:merge(#{package => '$1', imports => []}, '$2').
root -> package_stmt import_stmts top_block : maps:merge(#{package => '$1', imports => '$2'}, '$3').

package_stmt -> 'package' fqn ';' : '$2'.

import_stmt -> 'import' fqn ';' : '$2'.
import_stmt -> 'import' wildcard_import ';' : string:split(unwrap('$2'), <<".">>, all).

import_stmts -> import_stmt : ['$1'].
import_stmts -> import_stmt import_stmts : ['$1'] ++ '$2'.

top_block -> class_block : #{class => '$1'}.
top_block -> enum_block : #{enum => '$1'}.

% Top Level Class Block
class_block -> class_signature '{' '}' : maps:merge('$1', #{body => []}).
class_block -> class_signature '{' class_body '}' : maps:merge('$1', #{body => '$3'}).

class_signature -> class_marker : '$1'.
class_signature -> class_marker class_inheritance : maps:merge(#{inheritance => '$1'}, '$1').
class_signature -> annotations class_marker : maps:merge(#{annotations => '$1'}, '$2').
class_signature -> annotations class_marker class_inheritance : maps:merge(#{annotations => '$1', inheritance => '$3'}, '$2').

class_marker -> 'class' class_type_decl : #{name => '$2'}.
class_marker -> 'abstract' 'class' class_type_decl : #{name => '$3', abstract => true}.
class_marker -> 'final' 'class' class_type_decl : #{name => '$3', final => true}.
class_marker -> visibility 'class' class_type_decl : #{name => '$3', visibility => '$1'}.
class_marker -> visibility 'abstract' 'class' class_type_decl : #{name => '$4', visibility => '$1', abstract => true}.
class_marker -> visibility 'final' 'class' class_type_decl : #{name => '$4', visibility => '$1', final => true}.

class_inheritance -> 'extends' class_type_decl : #{extends => '$2'}.
class_inheritance -> 'implements' class_type_decls : #{implements => '$2'}.
class_inheritance -> 'extends' class_type_decl 'implements' class_type_decls : #{extends => '$2', implements => '$4'}.

class_body -> class_body_item : ['$1'].
class_body -> class_body_item class_body : ['$1'] ++ '$2'.

class_body_item -> field ';' : {field, '$1'}.
class_body_item -> method_block : {method, '$1'}.

class_type_decl -> identifier : unwrap('$1').
class_type_decl -> identifier '<' type_list '>' : {generic, unwrap('$1'), '$3'}.

class_type_decls -> class_type_decl : ['$1'].
class_type_decls -> class_type_decl ',' class_type_decls : ['$1'] ++ '$3'.

% Top Level Enum Block
enum_block -> enum_signature '{' '}' : maps:merge('$1', #{values => []}).
enum_block -> enum_signature '{' enum_values '}' : maps:merge('$1', #{values => '$3'}).
enum_block -> enum_signature '{' enum_values ';' '}' : maps:merge('$1', #{values => '$3'}).
enum_block -> enum_signature '{' enum_values ';' class_body '}' : maps:merge('$1', #{values => '$3', body => '$5'}).

enum_signature -> enum_marker : '$1'.
enum_signature -> annotations enum_marker : maps:merge(#{annotations => '$1'}, '$2').
enum_signature -> annotations enum_marker enum_inheritance : maps:merge(#{annotations => '$1', inheritance => '$3'}, '$2').

enum_marker -> 'enum' identifier : #{name => unwrap('$2')}.
enum_marker -> visibility 'enum' identifier : #{name => unwrap('$3'), visibility => '$1'}.

enum_inheritance -> 'extends' fqn : #{extends => '$2'}.
enum_inheritance -> 'implements' fqn_list : #{implements => '$2'}.
enum_inheritance -> 'extends' fqn 'implements' fqn_list : #{extends => '$2', implements => '$4'}.

enum_values -> enum_value : ['$1'].
enum_values -> enum_value ',' : ['$1'].
enum_values -> enum_value ',' enum_values : ['$1'] ++ '$3'.

enum_value -> identifier : #{name => unwrap('$1')}.
enum_value -> identifier '(' ')' : #{name => unwrap('$1'), args => []}.
enum_value -> identifier '(' expr_list ')' : #{name => unwrap('$1'), args => '$3'}.
enum_value -> annotations identifier : #{name => unwrap('$2'), annotations => '$1'}.
enum_value -> annotations identifier '(' ')' : #{name => unwrap('$2'), args => [], annotations => '$1'}.
enum_value -> annotations identifier '(' expr_list ')' : #{name => unwrap('$2'), args => '$4', annotations => '$1'}.

% Methods
method_block -> method_signature '{' '}' : maps:merge(#{body => []}, '$1').
method_block -> method_signature '{' method_body '}' : maps:merge(#{body => '$3'}, '$1').

method_signature -> type identifier '(' ')' : #{type => '$1', name => unwrap('$2'), args => []}.
method_signature -> type identifier '(' typed_args ')' : #{type => '$1', name => unwrap('$2'), args => '$4'}.
method_signature -> 'static' type identifier '(' ')' : #{type => '$2', name => unwrap('$3'), args => [], static => true}.
method_signature -> 'static' type identifier '(' typed_args ')' : #{type => '$2', name => unwrap('$3'), args => '$5', static => true}.
method_signature -> visibility type identifier '(' ')' : #{type => '$2', name => unwrap('$3'), args => [], visibility => '$1'}.
method_signature -> visibility type identifier '(' typed_args ')' : #{type => '$2', name => unwrap('$3'), args => '$5', visibility => '$1'}.
method_signature -> visibility 'static' type identifier '(' ')' : #{type => '$2', name => unwrap('$3'), args => [], visibility => '$1', static => true}.
method_signature -> visibility 'static' type identifier '(' typed_args ')' : #{type => '$3', name => unwrap('$4'), args => '$6', visibility => '$1', static => true}.

typed_args -> type identifier : [#{type => '$1', name => unwrap('$2')}].
typed_args -> type identifier ',' typed_args : [#{type => '$1', name => unwrap('$2')}] ++ '$4'.
typed_args -> 'final' type identifier : [#{type => '$2', final => true, name => unwrap('$3')}].
typed_args -> 'final' type identifier ',' typed_args : [#{type => '$2', final => true, name => unwrap('$3')}] ++ '$5'.

method_body -> method_body_item ';' : ['$1'].
method_body -> method_body_item ';' method_body : ['$1'] ++ '$3'.

method_body_item -> type identifier : {var, #{type => '$1', name => unwrap('$2')}}.
method_body_item -> type identifier '=' expr : {var, #{type => '$1', name => unwrap('$2'), value => '$4'}}.
method_body_item -> 'final' type identifier '=' expr : {var, #{type => '$2', name => unwrap('$3'), value => '$5', final => true}}.
method_body_item -> 'return' expr : {return, '$2'}.

% Fields
field -> type identifier : #{visibility => 'private', type => '$1', name => unwrap('$2')}.
field -> visibility type identifier :  #{visibility => '$1', type => '$2', name => unwrap('$3')}.
field -> visibility 'static' type identifier :  #{visibility => '$1', static => true, type => '$3', name => unwrap('$4')}.
field -> visibility 'final' type identifier :  #{visibility => '$1', final => true, type => '$3', name => unwrap('$4')}.
field -> visibility 'static' 'final' type identifier :  #{visibility => '$1', static => true, final => true, type => '$4', name => unwrap('$5')}.

field -> type identifier '=' expr : #{visibility => 'private', type => '$1', name => unwrap('$2'), default => '$4'}.
field -> visibility type identifier '=' expr :  #{visibility => '$1', type => '$2', name => unwrap('$3'), default => '$5'}.
field -> visibility 'static' type identifier '=' expr :  #{visibility => '$1', static => true, type => '$3', name => unwrap('$4'), default => '$6'}.
field -> visibility 'final' type identifier '=' expr :  #{visibility => '$1', final => true, type => '$3', name => unwrap('$4'), default => '$6'}.
field -> visibility 'static' 'final' type identifier '=' expr :  #{visibility => '$1', static => true, final => true, type => '$4', name => unwrap('$5'), default => '$7'}.

% Values & Expressions
value -> integer : unwrap('$1').
value -> float : unwrap('$1').
value -> string_literal : unwrap('$1').
value -> true : unwrap('$1').
value -> false : unwrap('$1').
value -> 'null' : unwrap('$1').

expr -> '!' expr : {'!', '$2'}.
expr -> chainable_expr : '$1'.
expr -> expr '+' expr : {'+', '$1', '$3'}.
expr -> expr '-' expr : {'-', '$1', '$3'}.
expr -> expr '*' expr : {'*', '$1', '$3'}.
expr -> expr '/' expr : {'/', '$1', '$3'}.
expr -> expr '==' expr : {'==', '$1', '$3'}.
expr -> expr '!=' expr : {'!=', '$1', '$3'}.
expr -> expr '&&' expr : {'&&', '$1', '$3'}.
expr -> expr '||' expr : {'||', '$1', '$3'}.
expr -> expr '&' expr : {'&', '$1', '$3'}.
expr -> expr '|' expr : {'|', '$1', '$3'}.
expr -> expr '.' expr : {chain, '$1'}.
expr -> fqn '::' identifier : {method_ref, '$1', unwrap('$3')}.
expr -> lambda_expr : {lambda, '$1'}.

chainable_expr -> '(' expr ')' : '$2'.
chainable_expr -> fqn : {ref, unwrap('$1')}.
chainable_expr -> method_call : {call, '$1'}.
chainable_expr -> value : '$1'.

lambda_expr -> '(' ')' '->' expr : #{body => '$3', args => []}.
lambda_expr -> '(' ')' '->' '{' method_body '}' : #{body => '$5', args => []}.
lambda_expr -> identifier '->' expr  : #{body => '$3', args => [unwrap('$1')]}.
lambda_expr -> identifier '->' '{' method_body '}' : #{body => '$4', args => [unwrap('$1')]}.
lambda_expr -> '(' typed_args ')' '->' expr : #{body => '$5', args => '$2'}.
lambda_expr -> '(' typed_args ')' '->' '{' method_body '}' : #{body => '$6', args => '$2'}.
%lambda_expr -> '(' fqn_list ')' '->' '{' method_body '}' : #{body => '$6', args => '$2'}.

expr_list -> expr : ['$1'].
expr_list -> expr ',' expr_list : ['$1'] ++ '$3'.

method_call -> 'new' fqn '(' ')' : {new, '$2', []}.
method_call -> 'new' fqn '(' expr_list ')' : {new, '$2', '$4'}.
method_call -> fqn '(' ')' : {'$1', []}.
method_call -> fqn '(' expr_list ')' : {'$1', '$3'}.
method_call -> fqn '.' identifier '(' ')' : {{'$1', unwrap('$3')}, []}.
method_call -> fqn '.' identifier '(' expr_list ')' : {{'$1', unwrap('$3')}, '$4'}.
method_call -> fqn '::' identifier '(' ')' : {{'::', '$1', unwrap('$3')}, []}.
method_call -> fqn '::' identifier '(' expr_list ')' : {{'::', '$1', unwrap('$3')}, '$4'}.

% Common
annotation -> annotation_name : #{name => unwrap('$1')}.
annotation -> annotation_name '(' ')' : #{name => unwrap('$1'), args => []}.
annotation -> annotation_name '(' expr_list ')' : #{name => unwrap('$1'), args => '$3'}.

annotations -> annotation : ['$1'].
annotations -> annotation annotations : ['$1'] ++ '$2'.

visibility -> 'public' : public.
visibility -> 'private' : private.
visibility -> 'protected' : protected.

type -> fqn : '$1'.
type -> fqn '<' type_list '>' : {generic, '$1', '$3'}.
type -> type '[' ']' : {array, '$1'}.
type -> type '...' : {varargs, '$1'}.

type_list -> type : ['$1'].
type_list -> type ',' type_list : ['$1'] ++ '$3'.

% Utility
fqn -> identifier : unwrap('$1').
fqn -> identifier '.' fqn : lists:flatten([unwrap('$1')] ++ ['$3']).

fqn_list -> identifier : [unwrap('$1')].
fqn_list -> identifier ',' fqn_list : [unwrap('$1')] ++ unwrap('$3').

Erlang code.
unwrap({_, _, Val}) -> Val;
unwrap(Val) -> Val.
