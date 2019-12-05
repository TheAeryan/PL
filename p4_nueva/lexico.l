%option yylineno
%option noyywrap

%%

"{"                                                      { yylval=strdup(yytext); return INIBLOQUE; }
"}"                                                      { yylval=strdup(yytext); return FINBLOQUE; }
"["                                                      { yylval=strdup(yytext); return CORIZQ; }
"]"                                                      { yylval=strdup(yytext); return CORDER; }
"("                                                      { yylval=strdup(yytext); return PARIZQ; }
")"                                                      { yylval=strdup(yytext); return PARDER; }
";"                                                      { yylval=strdup(yytext); return PYC; }
","                                                      { yylval=strdup(yytext); return COMA; }
"="                                                      { yylval=strdup(yytext); return ASIGN; }
"@"                                                      { yylval=strdup(yytext); return AT; }
"cin"                                                    { yylval=strdup(yytext); return CIN; }
"cout"                                                   { yylval=strdup(yytext); return COUT; }
"return"                                                 { yylval=strdup(yytext); return RETURN; }
"local"                                                  { yylval=strdup(yytext); return LOCAL; }
"main"                                                   { yylval=strdup(yytext); return MAIN; }
"do"                                                     { yylval=strdup(yytext); return DO; }
"until"                                                  { yylval=strdup(yytext); return UNTIL; }
"int"                                                    { yylval=strdup(yytext); return TIPO; }
"float"                                                  { yylval=strdup(yytext); return TIPO; }
"char"                                                   { yylval=strdup(yytext); return TIPO; }
"bool"                                                   { yylval=strdup(yytext); return TIPO; }
"list_of"" "+"int"                                       { yylval=strdup(yytext); return TIPO; }
"list_of"" "+"float"                                     { yylval=strdup(yytext); return TIPO; }
"list_of"" "+"char"                                      { yylval=strdup(yytext); return TIPO; }
"list_of"" "+"bool"                                      { yylval=strdup(yytext); return TIPO; }
"if"                                                     { yylval=strdup(yytext); return IF; }
"while"                                                  { yylval=strdup(yytext); return WHILE; }
"else"                                                   { yylval=strdup(yytext); return ELSE; }
"||"                                                     { yylval=strdup(yytext); return ORLOG; }
"&&"                                                     { yylval=strdup(yytext); return ANDLOG; }
"=="|"!="                                                { yylval=strdup(yytext); return EQN; }
"<"|">"|"<="|">="                                        { yylval=strdup(yytext); return REL; }
"+"|"-"                                                  { yylval=strdup(yytext); return ADDSUB; }
"*"|"/"                                                  { yylval=strdup(yytext); return MULDIV; }
"!"                                                      { yylval=strdup(yytext); return EXCL; }
"**"                                                     { yylval=strdup(yytext); return PORPOR; }
"--"|"%"                                                 { yylval=strdup(yytext); return BORRLIST; }
"?"|"#"                                                  { yylval=strdup(yytext); return INTHASH; }
"++"                                                     { yylval=strdup(yytext); return MASMAS; }
"$"                                                      { yylval=strdup(yytext); return DOLLAR; }
"<<"|">>"                                                { yylval=strdup(yytext); return SHIFT; }
\"[^\"]*\"                                               { yylval=strdup(yytext); return CADENA; }
([0-9]+)|([0-9]*\.[0-9]*)|"true"|"false"|\'[^\']\'       { yylval=strdup(yytext); return CONST; }
[a-z|A-Z][a-z|A-Z|0-9|_]*                                { yylval=strdup(yytext); return ID; }
[ \t\n]                                                  { ; }
<*>.|\n                                                  {printf("Error en la línea %d. Lexema %s no reconocible.\n", yylineno, yytext);}

%%