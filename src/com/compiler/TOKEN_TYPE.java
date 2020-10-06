/**
 * Token types enum
 * @author Maxwell Souza
 * @author Rodolpho Rossete
 */
package com.compiler;

public enum TOKEN_TYPE {
    ID,
    PAR_OPEN,       // (
    PAR_CLOSE,      // )
    BRACE_OPEN,     // {
    BRACE_CLOSE,    // }
    BRACKET_OPEN,   // [
    BRACKET_CLOSE,  // ]
    DOT,            // .
    COMMA,          // ,
    SEMICOL,        // ;
    // TYPES
    INT_NUM,
    FLOAT_NUM,
    STRING_LITERAL,
    INT,
    CHAR,
    BOOL,
    FLOAT,
    NULL,
    //Math
    PLUS,
    MINUS,
    MULTIPLY,
    DIVIDE,
    MOD,
    // LOGIC
    EQUALS,
    NOTEQ,
    NOT,
    AND,
    TRUE,
    FALSE,
    LESS_THAN,
    BIGGER_THAN,
    // Commands
    IF,
    ELSE,
    ITERATE,
    READ,
    PRINT,
    RETURN,
    SET,        // =
    TYPEDEF,    // ::
    RETURNDEF,  // :
}
