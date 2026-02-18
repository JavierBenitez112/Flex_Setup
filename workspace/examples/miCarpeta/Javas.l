%{
#include <stdio.h>
%}

/* Definiciones de expresiones regulares */
LETRA          [a-zA-Z]
DIGITO         [0-9]
IDENTIFICADOR  ({LETRA}|_)+({LETRA}|{DIGITO}|_)*
ESPACIO        [ \t\n]+

%%

{IDENTIFICADOR} { 
    printf("Aceptado: '%s' es un identificador válido.\n", yytext); 
}

{ESPACIO}       { /* Ignorar espacios en blanco */ }

.               { 
    printf("Error: '%s' no es un componente de identificador válido.\n", yytext); 
}

%%

int main(int argc, char **argv) {
    printf("Ingrese identificadores para validar (Ctrl+D para salir):\n");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}