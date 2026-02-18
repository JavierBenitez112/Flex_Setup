%{
#include <stdio.h>
%}

/* DEFINICIONES REGULARES */
DIGITO      [0-9]
LETRA       [a-zA-Z]
HEX         0[xX][0-9a-fA-F]+
ENTERO      {DIGITO}+
/* Flotante: 12.34 */
FLOAT       {DIGITO}+\.{DIGITO}+
/* Científica: 1.2e-3, 10E+5, 1e10 (cubre enteros y flotantes con exponente) */
CIENTIFICA  ({DIGITO}+(\.{DIGITO}*)?|\.{DIGITO}+)[eE][+-]?{DIGITO}+

%%

    /* --- LITERALES NUMÉRICOS --- */

{HEX} {
    printf("TOKEN: HEXADECIMAL  | VALOR: %s\n", yytext);
}

{CIENTIFICA} {
    printf("TOKEN: CIENTIFICA   | VALOR: %s\n", yytext);
}

{FLOAT} {
    printf("TOKEN: FLOTANTE     | VALOR: %s\n", yytext);
}

{ENTERO} {
    printf("TOKEN: ENTERO       | VALOR: %s\n", yytext);
}

    /* --- OPERADORES RELACIONALES (Multi-caracter primero) --- */

"=="    { printf("TOKEN: OP_REL     | VALOR: IGUAL (%s)\n", yytext); }
"!="    { printf("TOKEN: OP_REL     | VALOR: DIFERENTE (%s)\n", yytext); }
"<="    { printf("TOKEN: OP_REL     | VALOR: MENOR_IGUAL (%s)\n", yytext); }
">="    { printf("TOKEN: OP_REL     | VALOR: MAYOR_IGUAL (%s)\n", yytext); }
"<"     { printf("TOKEN: OP_REL     | VALOR: MENOR (%s)\n", yytext); }
">"     { printf("TOKEN: OP_REL     | VALOR: MAYOR (%s)\n", yytext); }

    /* --- OPERADORES LÓGICOS --- */

"&&"    { printf("TOKEN: OP_LOG     | VALOR: AND (%s)\n", yytext); }
"||"    { printf("TOKEN: OP_LOG     | VALOR: OR (%s)\n", yytext); }
"!"     { printf("TOKEN: OP_LOG     | VALOR: NOT (%s)\n", yytext); }

    /* --- OPERADORES ARITMÉTICOS --- */

"+"     { printf("TOKEN: OP_ARIT    | VALOR: SUMA (%s)\n", yytext); }
"-"     { printf("TOKEN: OP_ARIT    | VALOR: RESTA (%s)\n", yytext); }
"*"     { printf("TOKEN: OP_ARIT    | VALOR: MULT (%s)\n", yytext); }
"/"     { printf("TOKEN: OP_ARIT    | VALOR: DIV (%s)\n", yytext); }

    /* --- MANEJO DE ESPACIOS Y ERRORES --- */

[ \t\n]+    { /* Ignorar espacios en blanco, tabulaciones y saltos de línea */ }

.           { printf("ERROR: Caracter no reconocido -> %s\n", yytext); }

%%

int main(int argc, char **argv) {
    /* Si se pasa un archivo como argumento, leer de él, si no, leer de consola */
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error al abrir el archivo");
            return 1;
        }
    }
    
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}