Definitions.

DIGIT = [0-9]
IDENTIFIER = [A-Za-z]+[A-Za-z0-9_]*
WILDCARD_IMPORT = {IDENTIFIER}(\.{IDENTIFIER})*\.\*
LINE_COMMENT = \/\/.*
WS = [\s\r\n\t\f]
STREAM_COMMENT = \/\*([^*]|\*+[^*/])*\*+\/
ANNOTATION_NAME = \@{IDENTIFIER}(\.{IDENTIFIER})*
STRING_LITERAL = \"[^\"]*\"

Rules.

package    : {token, {package, TokenLine, token_as_atom(TokenChars)}}.
import     : {token, {import, TokenLine, token_as_atom(TokenChars)}}.
public     : {token, {public, TokenLine, token_as_atom(TokenChars)}}.
private    : {token, {private, TokenLine, token_as_atom(TokenChars)}}.
protected  : {token, {protected, TokenLine, token_as_atom(TokenChars)}}.
static     : {token, {static, TokenLine, token_as_atom(TokenChars)}}.
enum       : {token, {enum, TokenLine, token_as_atom(TokenChars)}}.
class      : {token, {class, TokenLine, token_as_atom(TokenChars)}}.
final      : {token, {final, TokenLine, token_as_atom(TokenChars)}}.
return     : {token, {return, TokenLine, token_as_atom(TokenChars)}}.
null       : {token, {null, TokenLine, token_as_atom(TokenChars)}}.
new        : {token, {new, TokenLine, token_as_atom(TokenChars)}}.
implements : {token, {implements, TokenLine, token_as_atom(TokenChars)}}.
extends    : {token, {extends, TokenLine, token_as_atom(TokenChars)}}.
abstract   : {token, {abstract, TokenLine, token_as_atom(TokenChars)}}.
true       : {token, {true, TokenLine, token_as_atom(TokenChars)}}.
false      : {token, {false, TokenLine, token_as_atom(TokenChars)}}.

{WILDCARD_IMPORT}    : {token, {wildcard_import, TokenLine, list_to_binary(TokenChars)}}.
{IDENTIFIER}         : {token, {identifier, TokenLine, list_to_binary(TokenChars)}}.
{ANNOTATION_NAME}    : {token, {annotation_name, TokenLine, list_to_binary(drop_head(TokenChars))}}.
{STRING_LITERAL}     : {token, {string_literal, TokenLine, list_to_binary(drop_head(drop_tail(TokenChars)))}}.
\-?{DIGIT}+          : {token, {integer, TokenLine, list_to_integer(TokenChars)}}.
\-?{DIGIT}\.{DIGIT}+ : {token, {float, TokenLine, list_to_float(TokenChars)}}.
\;                   : {token, {';', TokenLine, TokenChars}}.
\{                   : {token, {'{', TokenLine, TokenChars}}.
\}                   : {token, {'}', TokenLine, TokenChars}}.
\,                   : {token, {',', TokenLine, TokenChars}}.
\(                   : {token, {'(', TokenLine, TokenChars}}.
\)                   : {token, {')', TokenLine, TokenChars}}.
\=                   : {token, {'=', TokenLine, TokenChars}}.
\<                   : {token, {'<', TokenLine, TokenChars}}.
\>                   : {token, {'>', TokenLine, TokenChars}}.
\.                   : {token, {'.', TokenLine, TokenChars}}.
\:\:                 : {token, {'::', TokenLine, TokenChars}}.
\-\>                 : {token, {'->', TokenLine, TokenChars}}.
\[                   : {token, {'[', TokenLine, TokenChars}}.
\]                   : {token, {']', TokenLine, TokenChars}}.
\+                   : {token, {'+', TokenLine, TokenChars}}.
\-                   : {token, {'-', TokenLine, TokenChars}}.
\*                   : {token, {'*', TokenLine, TokenChars}}.
\/                   : {token, {'/', TokenLine, TokenChars}}.
\.\.\.               : {token, {'...', TokenLine, TokenChars}}.
\&\&                 : {token, {'&&', TokenLine, TokenChars}}.
\|\|                 : {token, {'||', TokenLine, TokenChars}}.
\=\=                 : {token, {'==', TokenLine, TokenChars}}.
\!\=                 : {token, {'!=', TokenLine, TokenChars}}.
\&                   : {token, {'&', TokenLine, TokenChars}}.
\|                   : {token, {'|', TokenLine, TokenChars}}.
\!                   : {token, {'!', TokenLine, TokenChars}}.
{LINE_COMMENT}       : skip_token.
{STREAM_COMMENT}     : skip_token.
{WS}+                : skip_token.

Erlang code.
-export([reserved_word/1]).

reserved_word('package') -> true;
reserved_word('import') -> true;
reserved_word('public') -> true;
reserved_word('private') -> true;
reserved_word('protected') -> true;
reserved_word('static') -> true;
reserved_word('enum') -> true;
reserved_word('class') -> true;
reserved_word('final') -> true;
reserved_word('return') -> true;
reserved_word('null') -> true;
reserved_word('new') -> true;
reserved_word('implements') -> true;
reserved_word('extends') -> true.

token_as_atom(Token) -> binary_to_atom(list_to_binary(Token)).

drop_head([_ | Rest]) -> Rest.

drop_tail(List) -> lists:droplast(List).
