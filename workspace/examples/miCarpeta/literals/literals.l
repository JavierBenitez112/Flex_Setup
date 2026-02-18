%{
#include <stdio.h>
%}

%x COMMENT

DIGIT   [0-9]
HEX     0[xX][0-9a-fA-F]+
INT     {DIGIT}+
FLOAT   {DIGIT}+\.{DIGIT}+
SCI     ({DIGIT}+(\.{DIGIT}*)?|\.{DIGIT}+)[eE][+-]?{DIGIT}+
STRING  \"(\\.|[^"\\])*\"
ID      [a-zA-Z_][a-zA-Z0-9_]*

%%

"//".* { }
"/*"                    { BEGIN(COMMENT); }
<COMMENT>"*/"           { BEGIN(INITIAL); }
<COMMENT>(.|\n)         { }

{STRING}                { printf("TOKEN: STRING       | VALOR: %s\n", yytext); }
{HEX}                   { printf("TOKEN: HEXADECIMAL  | VALOR: %s\n", yytext); }
{SCI}                   { printf("TOKEN: CIENTIFICA   | VALOR: %s\n", yytext); }
{FLOAT}                 { printf("TOKEN: FLOTANTE     | VALOR: %s\n", yytext); }
{INT}                   { printf("TOKEN: ENTERO       | VALOR: %s\n", yytext); }
{ID}                    { printf("TOKEN: IDENTIFICADOR| VALOR: %s\n", yytext); }

"=="                    { printf("TOKEN: OP_REL       | VALOR: IGUAL (%s)\n", yytext); }
"!="                    { printf("TOKEN: OP_REL       | VALOR: DIFERENTE (%s)\n", yytext); }
"<="                    { printf("TOKEN: OP_REL       | VALOR: MENOR_IGUAL (%s)\n", yytext); }
">="                    { printf("TOKEN: OP_REL       | VALOR: MAYOR_IGUAL (%s)\n", yytext); }
"<"                     { printf("TOKEN: OP_REL       | VALOR: MENOR (%s)\n", yytext); }
">"                     { printf("TOKEN: OP_REL       | VALOR: MAYOR (%s)\n", yytext); }

"&&"                    { printf("TOKEN: OP_LOG       | VALOR: AND (%s)\n", yytext); }
"||"                    { printf("TOKEN: OP_LOG       | VALOR: OR (%s)\n", yytext); }
"!"                     { printf("TOKEN: OP_LOG       | VALOR: NOT (%s)\n", yytext); }

"+"                     { printf("TOKEN: OP_ARIT      | VALOR: SUMA (%s)\n", yytext); }
"-"                     { printf("TOKEN: OP_ARIT      | VALOR: RESTA (%s)\n", yytext); }
"*"                     { printf("TOKEN: OP_ARIT      | VALOR: MULT (%s)\n", yytext); }
"/"                     { printf("TOKEN: OP_ARIT      | VALOR: DIV (%s)\n", yytext); }

[ \t\n]+                { }
.                       { printf("ERROR: Desconocido  | VALOR: %s\n", yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) return 1;
    }
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}