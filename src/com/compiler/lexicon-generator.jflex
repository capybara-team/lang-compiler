/**
 * Lexicon class
 * @author Maxwell Souza
 * @author Rodolpho Rossete
 */
package com.compiler;

%%

%class Alexicon
%unicode
%line
%column
%type Token
%function nextToken

%{
  StringBuffer tempString = new StringBuffer();

  private Token symbol(TOKEN_TYPE type) {
    return new Token(type, yyline+1, yycolumn+1, yytext());
  }
  private Token symbol(TOKEN_TYPE type, String lexeme) {
    return new Token(type, yyline+1, yycolumn+1, lexeme);
  }
%}

LineTerminator = \r|\n|\r\n
WhiteSpace     = {LineTerminator} | [ \t\f]
InputCharacter = [^\r\n]
Numero         = 0 | [1-9][0-9]*
Float         = {Numero}\.{Numero}

/* comments */
Comment = {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "--" {InputCharacter}* {LineTerminator}?
DocumentationComment = "{-" {CommentContent} "-"+ "}"
CommentContent       = ( [^*] | \*+ [^/*] )*

Identifier = [:jletter:] [:jletterdigit:]*

DecIntegerLiteral = 0 | [1-9][0-9]*

%state STRING
%state INT
%state FLOAT

%%


<YYINITIAL>{
  /* keywords */
  "if"            { return symbol(TOKEN_TYPE.IF); }
  "else"          { return symbol(TOKEN_TYPE.ELSE); }
  "iterate"       { return symbol(TOKEN_TYPE.ITERATE); }
  "read"          { return symbol(TOKEN_TYPE.READ); }
  "print"         { return symbol(TOKEN_TYPE.PRINT); }
  "return"        { return symbol(TOKEN_TYPE.RETURN); }

  /* types */
    "Int"           { return symbol(TOKEN_TYPE.INT); }
    "Char"          {return symbol(TOKEN_TYPE.CHAR); }
    "Bool"          {return symbol(TOKEN_TYPE.BOOL); }
    "Float"         {return symbol(TOKEN_TYPE.FLOAT);}
    "ID"            {return symbol(TOKEN_TYPE.ID);   }
    "null"          {return symbol(TOKEN_TYPE.NULL); }
    "true"          {return symbol(TOKEN_TYPE.TRUE); }
    "false"         {return symbol(TOKEN_TYPE.FALSE);}

 /* identifiers */
 {Identifier}    { return symbol(TOKEN_TYPE.ID); }

   /* literals */
   {Float}                   {return symbol(TOKEN_TYPE.FLOAT_NUM);}
   {Numero}                  {return symbol(TOKEN_TYPE.INT_NUM);}
   \"                        { tempString.setLength(0); yybegin(STRING); }



  /* operators */
  "="             { return symbol(TOKEN_TYPE.SET); }
  "=="            { return symbol(TOKEN_TYPE.EQUALS); }
  "!="            { return symbol(TOKEN_TYPE.NOTEQ); }
  "!"            { return symbol(TOKEN_TYPE.NOT); }
  "+"             { return symbol(TOKEN_TYPE.PLUS); }
  "-"             { return symbol(TOKEN_TYPE.MINUS); }
  "*"             { return symbol(TOKEN_TYPE.MULTIPLY); }
  "/"             { return symbol(TOKEN_TYPE.DIVIDE); }
  "%"             { return symbol(TOKEN_TYPE.MOD); }
  ";"             { return symbol(TOKEN_TYPE.SEMICOL); }
  /*Logic*/
  "<"             {return symbol(TOKEN_TYPE.LESS_THAN);}
  ">"             {return symbol(TOKEN_TYPE.BIGGER_THAN);}
  "&&"            {return symbol(TOKEN_TYPE.AND);}

  "("             {return symbol(TOKEN_TYPE.PAR_OPEN);}
  ")"             {return symbol(TOKEN_TYPE.PAR_CLOSE);}
  "{"             {return symbol(TOKEN_TYPE.BRACE_OPEN);}
  "}"             {return symbol(TOKEN_TYPE.BRACE_CLOSE);}
  "["             {return symbol(TOKEN_TYPE.BRACKET_OPEN);}
  "]"             {return symbol(TOKEN_TYPE.BRACKET_CLOSE);}
  "."             {return symbol(TOKEN_TYPE.DOT);}
  ","             {return symbol(TOKEN_TYPE.COMMA);}
  "::"            {return symbol(TOKEN_TYPE.TYPEDEF);}
  ":"             {return symbol(TOKEN_TYPE.RETURNDEF);}

  /* comments */
  {Comment}       { /* Ignora */ }
  /* whitespace */
  {WhiteSpace}    { /* Ignora */ }

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

/* error fallback */
[^]                              { throw new Error("Illegal character <"+
                                                    yytext()+">"); }
