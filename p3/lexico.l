%option yylineno
%option noyywrap

%%

"{"																                   																				 {return INIBLOQUE ;}
"}"																                   																				 {return FINBLOQUE ;}
"["																                   																				 {return CORIZQ ;}
"]"																                   																				 {return CORDER ;}
"("																                   																				 {return PARIZQ ;}
")"																                   																				 {return PARDER ;}
";"																                   																				 {return PYC ;}
","																                   																				 {return COMA ;}
"="																                   																				 {return ASIGN ;}
"@"																                   																				 {return AT ;}
"cin"															                   																				 {return CIN ;}
"cout"														                   																				 {return COUT ;}
"return"													                   																				 {return RETURN ;}
"local"														                   																				 {return LOCAL ;}
"main"														                   																				 {return MAIN ;}
"do"															                   																				 {return DO ;}
"until"														                   																				 {return UNTIL ;}
"int"|"float"|"char"|"bool"|"list_of int"|"list_of float"|"list_of char"|"list_of bool"      {return TIPO ;}
"if"															                   																				 {return IF ;}
"while"														                   																				 {return WHILE ;}
"else"														                   																				 {return ELSE ;}
"||"																                 																				 {return ORLOG ;}
"&&"																                 																				 {return ANDLOG ;}
"=="|"!="															               																				 {return EQN ;}
"<"|">"|"<="|">="														         																				 {return REL ;}
"+"|"-"																               																				 {return ADDSUB ;}
"*"|"/"																               																				 {return MULDIV ;}
"!"																                   																				 {return EXCL ;}
"**"																                 																				 {return PORPOR ;}
"--"|"%"															               																				 {return BORRLIST ;}
"?"|"#"																               																				 {return INTHASH ;}
"++"																																											 	 {return MASMAS ;}
"$"																             																				       {return DOLLAR ;}
"<<"|">>"															           																				     {return SHIFT ;}
\"[^\"]*\"															       																				       {return CADENA ;}
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'	 																				 {return CONST ;}
[a-z|A-Z][a-z|A-Z|0-9|_]*																																	   {return ID ;}
[ \t\n]																																									 		 { ;}
<*>.|\n																{printf("Error en la línea %d. Lexema %s no reconocible.\n", yylineno, yytext);}

%%
