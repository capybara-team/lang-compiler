/**
 * Token class
 * @author Maxwell Souza
 * @author Rodolpho Rossete
 */
package com.compiler;

public class Token {
    public TOKEN_TYPE type;
    public String lexeme = null;
    public int line, col;

    public Token(TOKEN_TYPE t, int l, int c, String lex) {
        type = t;
        line = l;
        col = c;
        lexeme = lex;
    }

    public Token(TOKEN_TYPE t, int l, int c) {
        type = t;
        line = l;
        col = c;
    }

	@Override
	public String toString() {
		return "Token: type: " + type + "\t Lexeme: " + lexeme + "\t Linha: " + line + "\t Coluna: " + col ;
	}
    
    


}
