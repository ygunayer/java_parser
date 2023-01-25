Definitions.

IDENTIFIER = [A-Za-z]+[A-Za-z0-9_]*
FQN = {IDENTIFIER}(\.{IDENTIFIER})*
LINE_COMMENT = \/\/.*
WS = [\s\r\n\t\f]
STREAM_COMMENT = \/\*\*({WS}|.)+\*\/
ANNOTATION_NAME = \@{FQN}

Rules.

package   : {token, {package, TokenLine, token_as_atom(TokenChars)}}.
import    : {token, {import, TokenLine, token_as_atom(TokenChars)}}.
public    : {token, {public, TokenLine, token_as_atom(TokenChars)}}.
private   : {token, {private, TokenLine, token_as_atom(TokenChars)}}.
protected : {token, {protected, TokenLine, token_as_atom(TokenChars)}}.
static    : {token, {static, TokenLine, token_as_atom(TokenChars)}}.
enum      : {token, {enum, TokenLine, token_as_atom(TokenChars)}}.
class     : {token, {class, TokenLine, token_as_atom(TokenChars)}}.
final     : {token, {final, TokenLine, token_as_atom(TokenChars)}}.

{IDENTIFIER}      : {token, {identifier, TokenLine, token_as_atom(TokenChars)}}.
{FQN}             : {token, {fqn, TokenLine, list_to_binary(TokenChars)}}.
{ANNOTATION_NAME} : {token, {annotation_name, TokenLine, token_as_atom(drop_head(TokenChars))}}.
\;                : {token, {';', TokenLine, TokenChars}}.
\.\*              : {token, {'.*', TokenLine, TokenChars}}.
\{                : {token, {'{', TokenLine, TokenChars}}.
\}                : {token, {'}', TokenLine, TokenChars}}.
\,                : {token, {',', TokenLine, TokenChars}}.
\(                : {token, {'(', TokenLine, TokenChars}}.
\)                : {token, {')', TokenLine, TokenChars}}.
{LINE_COMMENT}    : skip_token.
{STREAM_COMMENT}  : skip_token.
{WS}+             : skip_token.

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
reserved_word('final') -> true.

token_as_atom(Token) -> binary_to_atom(list_to_binary(Token)).

drop_head([_ | Rest]) -> Rest.
