%option yylineno
%{
	#include "tabla.h"	
%}

%%

"{"																{return INIBLOQUE ;}
"}"																{return FINBLOQUE ;}
"["																{return CORIZQ ;}
"]"																{return CORDER ;}
"("																{return PARIZQ ;}
")"																{return PARDER ;}
";"																{return PYC ;}
","																{return COMA ;}
"="																{return ASIGN ;}
"@"																{return AT ;}
"++"																{return MASMAS ;}
"cin"																{return CIN ;}
"cout"																{return COUT ;}
"return"															{return RETURN ;}
"local"																{return LOCAL ;}
"main"																{return MAIN ;}
"do"																{return DO ;}
"until"																{return UNTIL ;}
"list_of"															{return LISTA ;}
"int"|"float"|"char"|"bool"													{return TIPOSIMPLE ;}
"if"																{return IF ;}
"while"																{return WHILE ;}
"else"																{return ELSE ;}
"+"|"-"																{return ADDSUB ;}
"||"																{return ORLOG ;}
"&&"																{return ANDLOG ;}
"|"																{return OR ;}
"^"																{return EXOR ;}
"&"																{return AND ;}
"=="|"!="															{return EQN ;}
"<"|">"|"<="|">="														{return REL ;}
"+"|"-"																{return ADDSUB ;}
"*"|"/"																{return MULDIV ;}
"!"																{return EXCL ;}
"**"																{return PORPOR ;}
"--"|"%"															{return BORRLIST ;}
"?"|"#"																{return INTHASH ;}
"@"																{return AT ;}
"++"																{return MASMAS ;}
"$"																{return DOLLAR ;}
"<<"|">>"															{return SHIFT ;}
\"[^\"]*\"															{return CADENA ;}
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'										{return CONST ;}
[a-z|A-Z][a-z|A-Z|0-9|_]*													{return ID ;}
[ \t\n]																{ ; }
<*>.|\n																{printf("Error en la línea %d. Lexema %s no reconocible.\n", yylineno, yytext);}
%%
main (){
	int val;
	val = yylex();

	while (val != 0){
		printf("%d\n", val);
		val = yylex();
	}

	exit(0);
}
