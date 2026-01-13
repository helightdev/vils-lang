parser grammar VilsParser;

options { tokenVocab=VilsLexer; }

compilationUnit
    : topLevelStatement* EOF
    ;

topLevelStatement
    : block
    | subroutine
    | graphStatement
    ;

graphStatement
    : edgeDeclaration
    | edgeMacroInvocation
    ;

subroutine
    : SUBROUTINE_BEGIN IDENTIFIER graphStatement*
    ;

block
    : BLOCK_BEGIN BLOCK_HEADER_ID+ BLOCK_HEADER_END BLOCK_LINE* BLOCK_END
    ;

// Edges
edgeDeclaration
    : annotation* nodeRefList DARR nodeRef transformation*
    ;

transformation
    : annotation* transformInvocation
    | annotation* transformExecute
    ;

transformInvocation
    : CHAIN IDENTIFIER value?
    ;

transformExecute
    : PER IDENTIFIER value?
    ;

edgeMacroInvocation
    : annotation* BANG IDENTIFIER value?
    | annotation* BANG IDENTIFIER IDENTIFIER
    ;

// Node References
nodeRef
    : NODE_IDENTIFIER
    | PSEUDO_INPUT
    | PSEUDO_ARG
    | PSEUDO_OUTPUT
    | PSEUDO_VOID
    | nodeRef AT NUMBER
    | IDENTIFIER COLON nodeRef
    ;

executableRef
    : DOT IDENTIFIER
    ;

nodeRefList
    : nodeRef (',' nodeRef)*
    ;

annotation
    : AT IDENTIFIER LP value? RP
    | AT IDENTIFIER
    | AT IDENTIFIER COLON value
    | AT IDENTIFIER COLON IDENTIFIER
    ;

// Values
value
    : STRING
    | NUMBER
    | BOOLEAN
    | NULL
    | nodeRef
    | executableRef
    | valueList
    | valueObj
    ;

valueObj
    : LC RC
    | LC valuePair COMMA? RC
    | LC valuePair (COMMA? valuePair)+ RC
    ;

valueList
    : LB (value (',' value)*)? RB
    ;

valuePair
    : IDENTIFIER COLON value
    | STRING COLON value
    ;