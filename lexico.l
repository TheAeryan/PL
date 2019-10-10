%%
%byaccj
%{
    private Parser yyparser ;
    public Yylex(java.io.Reader r, Parser p ){
        this(r);
        linea_actual = 1 ;
        yyparser = p ;
    }

    private int linea_actual;
    public int lineaActual(){ return linea_actual; }
%}
%%

// Corchetes
"{" { return Parser.INIBLOQUE; }
"}" { return Parser.FINBLOQUE; }

// Palabra reservada
"local" { return Parser.LOCAL; }

// Variables
"int"|"float"|"char"|"bool" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.TIPOSIMPLE; }
[a-zA-Z][a-zA-Z0-9_]* { yyparser.yylval = new ParserVal((Object) yytext()); return Parser.IDENTIFICADOR; }

// Paréntesis
"(" { return Parser.PARIZQ; }
")" { return Parser.PARDER; }

// Punto y Coma
";" { return Parser.PYC; }

// Entrada / Salida
"cin" { return Parser.CIN; }
"cout" { return Parser.COUT; }

// Operadores Binarios No Unarios
"*"|"/"|"%"|"**"|"=="|"!="|"&&"|"\|\|"|"<"|">"|"<="|">="|"&"|"\|"|"^" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.OPBIN ; }

// Operadores Unarios no Binarios
"--"|"!"|"#"|"<<"|">>"|"$" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.OPUNARIO ; }

// Operadores Especiales
"@" { yyparser.yylval = new ParserVal(new Character(yytext().charAt(0))); return Parser.AT; }
"++" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.MASMAS; }

// Operadores Binarios y Unarios
"+"|"-"{ yyparser.yylval = new ParserVal(new Character(yytext().charAt(0))); return Parser.BINYUN; }

// Tipos
(-|+)?[0-9]+ { yyparser.yylval = new ParserVal( new Integer(yytext()) ); return Parser.ENTERO ; }
(-|+)?[0-9]+\.[0-9]* { yyparser.yylval = new ParserVal( new Double(yytext()) ); return Parser.REAL ; }
"true"|"false" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.BOOLEAN; }
\'[ -~]\' { yyparser.yylval = new ParserVal(new Character(yytext().charAt(0))); return Parser.CHAR; }

// Asignacion
"=" { yyparser.yylval = new ParserVal(new Character(yytext().charAt(0))); return Parser.ASIGN; }

// Coma
"," { yyparser.yylval = new ParserVal(new Character(yytext().charAt(0))); return Parser.COMA; }

// main
"main" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.MAIN; }

// Bucle do while/until
"do" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.DO; }
"while" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.UNTIL; }
"until" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.WHILE; }

// Comparador if
"if" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.WHILE; }

// Comparador list_of
"list_of" { yyparser.yylval = new ParserVal(new String((Object) yytext())); return Parser.LISTA; }

// Corchetes
"[" { yyparser.yylval = new ParserVal(new Character(yytext().charAt(0))); return Parser.CORIZQ; }
"]" { yyparser.yylval = new ParserVal(new Character(yytext().charAt(0))); return Parser.CORDER; }


\n { linea_actual ++ ; }
[ \t]+ {}


. { yyparser.yyerror("el(los) carácter(es) ’"+yytext()+"’ no forma(n) ningún token conocido"); }