%option yylineno
%%
"{"																	{return 257 ;}
"}"																	{return 258 ;}
"["																	{return 282 ;}
"]"																	{return 283 ;}
"("																	{return 262 ;}
")"																	{return 263 ;}
";"																	{return 264 ;}
","																	{return 276 ;}
"="																	{return 275 ;}
"@"																	{return 271 ;}
"++"																{return 272 ;}
"cin"																{return 265 ;}
"cout"																{return 266 ;}
"return"															{return 268 ;}
"local"																{return 259 ;}
"main"																{return 277 ;}
"do"																{return 278 ;}
"until"																{return 279 ;}
"list_of"															{return 281 ;}
"int"|"float"|"char"|"bool"											{return 260 ;}
"if"|"while"														{return 280 ;}
"+"|"-"																{return 273 ;}
"*"|"/"|"%"|"**"|"=="|"!="|"&&"|"||"|"<"|">"|"<="|">="|"&"|"|"|"^"	{return 269 ;}
"--"|"!"|"#"|"<<"|">>"|"$"											{return 270 ;}
\"[^\"]*\"															{return 267 ;}
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'					{return 274 ;}
[a-z|A-Z][a-z|A-Z|0-9|_]*											{return 261 ;}
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
