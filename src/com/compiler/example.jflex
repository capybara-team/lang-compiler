package com.compiler;
/* JFlex example: partial Java language lexer specification */
import java_cup.runtime.*;

/**
 * This class is a simple example lexer.
 */

%%

%class Alexicon
%unicode
%cup
%line
%column

%{
  StringBuffer tempString = new StringBuffer();

  private Symbol symbol(TOKEN_TYPE type) {
    return new Token(type, yyline, yycolumn);
  }
  private Symbol symbol(TOKEN_TYPE type, String lexeme) {
    return new Token(type, yyline, yycolumn, lexeme);
  }
%}

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

%state STRING

%%

/* keywords */
<YYINITIAL> "if"            { return symbol(TOKEN_TYPE.IF); }
<YYINITIAL> "else"          { return symbol(TOKEN_TYPE.ELSE); }
<YYINITIAL> "iterate"       { return symbol(TOKEN_TYPE.ITERATE); }
<YYINITIAL> "read"          { return symbol(TOKEN_TYPE.READ); }
<YYINITIAL> "print"         { return symbol(TOKEN_TYPE.PRINT); }
<YYINITIAL> "return"        { return symbol(TOKEN_TYPE.RETURN); }
<YYINITIAL> {
    /* operators */
    "="                     { return symbol(TOKEN_TYPE.SET); }
    "=="                     { return symbol(TOKEN_TYPE.EQUALS); }
    "!="                     { return symbol(TOKEN_TYPE.NOTEQ); }
    "+"                     { return symbol(TOKEN_TYPE.PLUS); }
    "-"                     { return symbol(TOKEN_TYPE.MINUS); }
    "*"                     { return symbol(TOKEN_TYPE.MULTIPLY); }
    "/"                     { return symbol(TOKEN_TYPE.DIVIDE); }
    "%"                     { return symbol(TOKEN_TYPE.MOD); }
    ";"                     { return symbol(TOKEN_TYPE.SEMICOL); }
}

<YYINITIAL> {
    /* types */
    "int"                     { return symbol(TOKEN_TYPE.INT); }
}
<YYINITIAL> {
  /* identifiers */
  {Identifier}                   { return symbol(TOKEN_TYPE.IDENTIFIER); }

  /* literals */
  {DecIntegerLiteral}            { return symbol(TOKEN_TYPE.INTEGER_LITERAL); }
  \"                             { tempString.setLength(0); yybegin(STRING); }

  /* operators */
  "="                            { return symbol(TOKEN_TYPE.EQ); }
  "=="                           { return symbol(TOKEN_TYPE.EQEQ); }
  "+"                            { return symbol(TOKEN_TYPE.PLUS); }

  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { /* ignore */ }
}

<STRING> {
  \"                             { yybegin(YYINITIAL);
                                   return symbol(TOKEN_TYPE.STRING_LITERAL,
                                   tempString.toString()); }
  [^\n\r\"\\]+                   { tempString.append( yytext() ); }
  \\t                            { tempString.append('\t'); }
  \\n                            { tempString.append('\n'); }

  \\r                            { tempString.append('\r'); }
  \\\"                           { tempString.append('\"'); }
  \\                             { tempString.append('\\'); }
}

<INT> {

}

<FLOAT> {
}

/* error fallback */
[^]                              { throw new Error("Illegal character <"+
                                                    yytext()+">"); }
