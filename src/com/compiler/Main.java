package com.compiler;

import java.io.FileReader;
import java.io.IOException;
import java.util.Objects;

public class Main {

    public static void main(String[] args) throws IOException{
    	validarArgs(args[0]);
    	Alexicon al = new Alexicon(new FileReader(args[0]));
    	Token token = al.nextToken();
    	while(Objects.nonNull(token)) {
    		System.out.println(token.toString());
    		token = al.nextToken();
    	}
    }

	private static void validarArgs(String args) {
		if(args.isEmpty()) {
			throw new RuntimeException("O arquivo de leitura deve ser passado como parâmetro.");
		}
		
	}
}
