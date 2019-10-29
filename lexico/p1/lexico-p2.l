%option yylineno
%{
	#include "tabla.h"	
%}

%%
"{"																	{return INIBLOQUE ;}
"}"																	{return FINBLOQUE ;}
"["																	{return CORIZQ ;}
"]"																	{return CORDER ;}
"("																	{return PARIZQ ;}
")"																	{return PARDER ;}
";"																	{return PYC ;}
","																	{return COMA ;}
"="																	{return ASIGN ;}
"@"																	{return AT ;}
"++"																{return MASMAS ;}
"cin"																{return CIN ;}
"cout"																{return COUT ;}
"return"															{return RETURN ;}
"local"																{return LOCAL ;}
"main"																{return MAIN ;}
"do"																{return DO ;}
"until"																{return UNTIL ;}
"list_of"															{return LISTA ;}
"int"|"float"|"char"|"bool"											{return TIPOSIMPLE ;}
"if"																{return IF ;}
"while"																{return WHILE ;}
"else"																{return ELSE ;}
"+"|"-"																{return BINYUN ;}
"*"|"/"|"%"|"**"|"=="|"!="|"&&"|"||"|"<"|">"|"<="|">="|"&"|"|"|"^"	{return OPBIN ;}
"--"|"!"|"#"|"<<"|">>"|"$"											{return OPUNARIO ;}
\"[^\"]*\"															{return CADENA ;}
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'					{return CONST ;}
[a-z|A-Z][a-z|A-Z|0-9|_]*											{return ID ;}
[ \t\n]																{ ; }
<*>.|\n																{printf("Error en la línea %d. Lexema %s no reconocible.\n", yylineno, yytext);}
%%