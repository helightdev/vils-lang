lexer grammar VilsLexer;

BLOCK_BEGIN : '%begin' -> pushMode(BLOCK_HEADER_MODE);
SUBROUTINE_BEGIN : '%subroutine';
PSEUDO_INPUT : '$in';
PSEUDO_ARG : '$arg';
PSEUDO_OUTPUT : '$out';
PSEUDO_VOID : '$void' ;

BANG : '!' ;
QUESTION : '?' ;
EQ : '=' ;
DARR : '=>' ;
SARR : '->' ;
TARR : '=|';
CHAIN : '|' ;
PER : '%' ;
DOT : '.' ;
COMMA : ',' ;
COLON : ':' ;
AT : '@' ;
LP : '(' ;
RP : ')' ;
LB : '[' ;
RB : ']' ;
LC : '{' ;
RC : '}' ;

IDENTIFIER
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

NODE_IDENTIFIER
    : '#' [a-zA-Z0-9_]+
    ;

NULL
    : 'null'
    ;

BOOLEAN
    : 'true'
    | 'false'
    ;

// Json-compatible string
STRING
    : '"' (ESCAPED_CHAR | SAFE_CHAR)* '"'
    ;

// Json-compatible number
NUMBER
    : '-'? INT_PART ('.' [0-9]+)? EXP_PART?
    ;

fragment ESCAPED_CHAR
    : '\\' (["\\/bfnrt] | UNICODE)
    ;

fragment SAFE_CHAR
    : ~ ["\\\u0000-\u001F]
    ;

fragment UNICODE
    : 'u' HEX HEX HEX HEX
    ;

fragment HEX
    : [0-9a-fA-F]
    ;

fragment INT_PART
    : '0'
    | [1-9] [0-9]*
    ;

fragment EXP_PART
    : [Ee] [+-]? [0-9]+
    ;

WS
    : [ \t\r\n]+ -> skip
    ;

mode BLOCK_HEADER_MODE;
    BLOCK_HEADER_ID
        : [a-zA-Z_] [a-zA-Z0-9_]*
        ;
    BLOCK_HEADER_END
        : [ \t]* [\r]?[\n] -> popMode, pushMode(BLOCK_MODE)
        ;
    BLOCK_HEADER_WS
        : [ \t]+ -> skip
        ;

mode BLOCK_MODE;
    BLOCK_LINE
        : ~[\r\n]* [\r]?[\n]
        ;
    BLOCK_END
        : '%end' -> popMode
        ;