/* original parser id follows */
/* yysccsid[] = "@(#)yaccpar	1.9 (Berkeley) 02/21/93" */
/* (use YYMAJOR/YYMINOR for ifdefs dependent on parser version) */

#define YYBYACC 1
#define YYMAJOR 1
#define YYMINOR 9
#define YYPATCH 20170709

#define YYEMPTY        (-1)
#define yyclearin      (yychar = YYEMPTY)
#define yyerrok        (yyerrflag = 0)
#define YYRECOVERING() (yyerrflag != 0)
#define YYENOMEM       (-2)
#define YYEOF          0
#define YYPREFIX "yy"

#define YYPURE 0


#if ! defined(YYSTYPE) && ! defined(YYSTYPE_IS_DECLARED)
/* Default: YYSTYPE is the semantic value type. */
typedef int YYSTYPE;
# define YYSTYPE_IS_DECLARED 1
#endif

/* compatibility with bison */
#ifdef YYPARSE_PARAM
/* compatibility with FreeBSD */
# ifdef YYPARSE_PARAM_TYPE
#  define YYPARSE_DECL() yyparse(YYPARSE_PARAM_TYPE YYPARSE_PARAM)
# else
#  define YYPARSE_DECL() yyparse(void *YYPARSE_PARAM)
# endif
#else
# define YYPARSE_DECL() yyparse(void)
#endif

/* Parameters sent to lex. */
#ifdef YYLEX_PARAM
# define YYLEX_DECL() yylex(void *YYLEX_PARAM)
# define YYLEX yylex(YYLEX_PARAM)
#else
# define YYLEX_DECL() yylex(void)
# define YYLEX yylex()
#endif

/* Parameters sent to yyerror. */
#ifndef YYERROR_DECL
#define YYERROR_DECL() yyerror(const char *s)
#endif
#ifndef YYERROR_CALL
#define YYERROR_CALL(msg) yyerror(msg)
#endif

extern int YYPARSE_DECL();

#define INIBLOQUE 257
#define FINBLOQUE 258
#define LOCAL 259
#define TIPO 260
#define ID 261
#define PYC 262
#define CIN 263
#define COUT 264
#define CADENA 265
#define RETURN 266
#define PORPOR 267
#define BORRLIST 268
#define INTHASH 269
#define CONST 270
#define DOLLAR 271
#define MAIN 272
#define IF 273
#define ELSE 274
#define DO 275
#define UNTIL 276
#define WHILE 277
#define CORIZQ 278
#define CORDER 279
#define COMA 280
#define ASIGN 281
#define MASMAS 282
#define AT 283
#define ORLOG 284
#define ANDLOG 285
#define EQN 286
#define REL 287
#define SHIFT 288
#define ADDSUB 289
#define MULDIV 290
#define EXCL 291
#define MASMENOS 292
#define INTHAS 293
#define PARIZQ 294
#define PARDER 295
#define YYERRCODE 256
typedef short YYINT;
static const YYINT yylhs[] = {                           -1,
    0,    1,    2,    2,    5,    5,    6,    7,    7,    8,
    8,    3,    3,   10,   11,   11,   12,   12,   13,    4,
    4,   14,   14,   14,   14,   14,   14,   14,   14,   14,
   14,   15,   16,   16,   17,   23,   23,   18,   19,   20,
   24,   24,   25,   25,   21,   22,    9,    9,    9,    9,
    9,    9,    9,   26,   26,   26,   27,   27,   27,   27,
   27,   27,   27,   27,   29,   29,   28,   28,   30,   30,
};
static const YYINT yylen[] = {                            2,
    2,    5,    4,    0,    2,    1,    3,    3,    1,    3,
    1,    2,    0,    2,    5,    4,    3,    1,    2,    2,
    0,    1,    2,    1,    1,    1,    1,    1,    1,    1,
    1,    4,    2,    2,    6,    2,    0,    5,    3,    3,
    3,    1,    1,    1,    7,    3,    3,    2,    3,    5,
    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
    1,    1,    1,    1,    4,    3,    1,    1,    3,    2,
};
static const YYINT yydefred[] = {                         0,
    0,    0,    0,    1,    0,   13,    0,    0,    0,    0,
    6,    0,    0,   12,    0,    9,    0,    3,    5,    0,
    2,    0,    0,    0,    0,   56,   67,    0,    0,    0,
    0,    0,   54,   55,    0,   22,    0,   20,   24,   25,
   26,   27,   28,   29,   30,   31,    0,   52,   53,   68,
   14,    7,    0,    0,    0,    0,    0,    0,   44,    0,
    0,   42,    0,    0,    0,    0,    0,   70,    0,    0,
    0,   23,   63,   64,    0,   58,   57,   59,   33,   60,
   61,    0,    0,    8,    0,   16,    0,   18,    0,   66,
    0,   39,   40,    0,   46,    0,    0,    0,   69,    0,
   47,    0,    0,   19,    0,   15,   32,   65,   41,    0,
    0,    0,    0,    0,   17,    0,    0,   38,    0,    0,
   35,    0,   36,   45,
};
static const YYINT yydgoto[] = {                          2,
   36,    6,    8,   13,   10,   11,   17,   69,   37,   14,
   15,   87,   88,   38,   39,   40,   41,   42,   43,   44,
   45,   46,  121,   61,   62,   47,   82,   48,   49,   50,
};
static const YYINT yysindex[] = {                      -267,
 -241,    0, -223,    0, -218,    0, -213, -210, -206, -204,
    0, -199,   64,    0, -241,    0, -256,    0,    0, -237,
    0, -268, -206, -217,  154,    0,    0,  154, -231,  122,
 -230,  140,    0,    0,  154,    0,  168,    0,    0,    0,
    0,    0,    0,    0,    0,    0,  154,    0,    0,    0,
    0,    0, -196, -257,  154, -249, -255, -228,    0,  289,
 -253,    0,  204,  289,  154, -209,  154,    0, -220,  289,
  192,    0,    0,    0,  154,    0,    0,    0,    0,    0,
    0,  154,  289,    0, -193,    0, -261,    0,  217,    0,
 -258,    0,    0, -217,    0,  228, -225,  248,    0,  154,
    0,  280,  289,    0, -189,    0,    0,    0,    0,  122,
  154,  122,  289,  154,    0, -201,  260,    0,  289,  122,
    0, -187,    0,    0,
};
static const YYINT yyrindex[] = {                         0,
    0,    0,  -20,    0,    0,    0,    0,   93,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,  179,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0, -164,    0, -252,
    0,    0,    0,    9,    0,    0,    0,    0,    0, -265,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0, -129,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,  -94,    0,    0,    0,    0,    0,    0,    0,
    0,    0, -262,    0,    0,   35,    0,    0,  -59,    0,
    0,    0,    0,    0,
};
static const YYINT yygindex[] = {                         0,
   34,    0,    0,    0,    0,   68,   56,   24,  -24,    0,
    0,    0,  -22,  -28,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,  -13,    0,    0,    0,    0,    0,
};
#define YYTABLESIZE 579
static const YYINT yytable[] = {                         60,
   63,   66,   85,   64,    1,   52,   92,   70,   93,   43,
   71,   58,   55,   11,   11,    3,   10,   10,  105,   26,
   27,  100,   83,   53,   53,   56,   94,   43,   32,   11,
   89,   70,   10,  106,    4,    5,  108,   86,    7,   33,
   96,   34,   98,   58,   35,   90,    9,   59,   51,   12,
  102,   26,   27,   18,   16,    9,   54,  103,   99,  100,
   32,   20,   65,   67,   84,   56,   97,  104,  111,   60,
   85,   33,  120,   34,  124,  113,   35,   19,   57,   91,
  109,  116,  115,  118,    0,    0,  117,    0,    0,  119,
    0,  123,   51,   51,    0,    0,   51,   51,   51,   51,
    0,   51,   51,   51,   51,   51,   51,    0,   51,   51,
   51,   51,   51,   51,   51,   51,    0,   51,   51,   51,
   51,   51,    0,   51,   51,   51,   51,   48,   48,    0,
   51,   48,   48,   48,   48,    0,   48,    0,    0,   48,
   48,   48,    0,   48,   48,   48,   48,   48,   48,   48,
   48,    0,    0,   48,    0,    0,    0,    0,   48,    0,
    0,   48,   49,   49,   48,   48,   49,   49,   49,   49,
    0,   49,    0,    0,   49,   49,   49,    0,   49,   49,
   49,   49,   49,   49,   49,   49,    0,    0,   49,    0,
    0,    0,    0,   49,    0,    0,   49,   50,   50,   49,
   49,   50,   50,   50,   50,    0,   50,    0,    0,   50,
   50,   50,    0,   50,   50,   50,   50,   50,   50,   50,
   50,    0,    0,   50,    0,    0,    0,    0,   50,    0,
    0,   50,    0,    0,   50,   50,    4,    4,    0,    4,
    4,    0,    4,    4,    0,    4,    0,    0,    4,    4,
    4,    0,    4,    0,    4,    0,    4,    4,    0,    0,
    0,    0,    0,    0,    0,   34,   34,    0,    4,   34,
    4,   34,   34,    4,   34,    0,    0,   34,   34,   34,
    0,   34,   34,   34,   34,   34,   34,    0,    0,    0,
    0,   37,   37,    0,    0,   37,    0,   37,   37,   34,
   37,    0,   34,   37,   37,   37,    0,   37,    0,   37,
   37,   37,   37,    0,    0,    0,    0,    0,    0,    0,
    3,   21,    0,   37,   22,   37,   23,   24,   37,   25,
    0,    0,   26,   27,   28,    0,   29,    0,   30,    0,
   31,   32,    0,    0,    0,    0,    0,    0,    0,   21,
   21,    0,   33,   21,   34,   21,   21,   35,   21,    0,
    0,   21,   21,   21,    0,   21,    0,   21,    0,   21,
   21,    0,    0,    0,    0,    0,    0,    0,    3,    0,
    0,   21,   22,   21,   23,   24,   21,   25,    0,    0,
   26,   27,   28,    0,   29,    0,   30,    0,   31,   32,
   58,    0,    0,    0,    0,    0,    0,    0,   26,   27,
   33,    0,   34,    0,   58,   35,    0,   32,   68,    0,
    0,    0,   26,   27,    0,    0,    0,    0,   33,   72,
   34,   32,    0,   35,   73,   74,    0,    0,    0,    0,
   51,    0,   33,    0,   34,   51,   51,   35,    0,   75,
    0,   76,   77,   78,    0,   79,   80,   81,   73,   74,
   51,    0,   51,   51,   51,   95,   51,   51,   51,    0,
   73,   74,    0,   75,    0,   76,   77,   78,  107,    0,
   80,   81,    0,   73,   74,   75,  101,   76,   77,   78,
    0,    0,   80,   81,   73,   74,    0,    0,   75,    0,
   76,   77,   78,    0,    0,   80,   81,    0,    0,   75,
    0,   76,   77,   78,   73,   74,   80,   81,    0,    0,
    0,    0,  110,    0,    0,    0,   73,   74,    0,   75,
    0,   76,   77,   78,    0,    0,   80,   81,    0,    0,
    0,   75,  112,   76,   77,   78,   73,   74,   80,   81,
    0,    0,    0,    0,  122,   73,   74,    0,    0,    0,
    0,   75,  114,   76,   77,   78,    0,    0,   80,   81,
   75,    0,   76,   77,   78,    0,    0,   80,   81,
};
static const YYINT yycheck[] = {                         24,
   25,   30,  260,   28,  272,  262,  262,   32,  262,  262,
   35,  261,  281,  279,  280,  257,  279,  280,  280,  269,
  270,  280,   47,  280,  280,  294,  280,  280,  278,  295,
   55,   56,  295,  295,    1,  259,  295,  295,  257,  289,
   65,  291,   67,  261,  294,  295,  260,  265,   15,  260,
   75,  269,  270,  258,  261,  260,  294,   82,  279,  280,
  278,  261,  294,  294,  261,  294,  276,  261,  294,   94,
  260,  289,  274,  291,  262,  100,  294,   10,   23,   56,
   94,  110,  105,  112,   -1,   -1,  111,   -1,   -1,  114,
   -1,  120,  257,  258,   -1,   -1,  261,  262,  263,  264,
   -1,  266,  267,  268,  269,  270,  271,   -1,  273,  274,
  275,  276,  277,  278,  279,  280,   -1,  282,  283,  284,
  285,  286,   -1,  288,  289,  290,  291,  257,  258,   -1,
  295,  261,  262,  263,  264,   -1,  266,   -1,   -1,  269,
  270,  271,   -1,  273,  274,  275,  276,  277,  278,  279,
  280,   -1,   -1,  283,   -1,   -1,   -1,   -1,  288,   -1,
   -1,  291,  257,  258,  294,  295,  261,  262,  263,  264,
   -1,  266,   -1,   -1,  269,  270,  271,   -1,  273,  274,
  275,  276,  277,  278,  279,  280,   -1,   -1,  283,   -1,
   -1,   -1,   -1,  288,   -1,   -1,  291,  257,  258,  294,
  295,  261,  262,  263,  264,   -1,  266,   -1,   -1,  269,
  270,  271,   -1,  273,  274,  275,  276,  277,  278,  279,
  280,   -1,   -1,  283,   -1,   -1,   -1,   -1,  288,   -1,
   -1,  291,   -1,   -1,  294,  295,  257,  258,   -1,  260,
  261,   -1,  263,  264,   -1,  266,   -1,   -1,  269,  270,
  271,   -1,  273,   -1,  275,   -1,  277,  278,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,  257,  258,   -1,  289,  261,
  291,  263,  264,  294,  266,   -1,   -1,  269,  270,  271,
   -1,  273,  274,  275,  276,  277,  278,   -1,   -1,   -1,
   -1,  257,  258,   -1,   -1,  261,   -1,  263,  264,  291,
  266,   -1,  294,  269,  270,  271,   -1,  273,   -1,  275,
  276,  277,  278,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
  257,  258,   -1,  289,  261,  291,  263,  264,  294,  266,
   -1,   -1,  269,  270,  271,   -1,  273,   -1,  275,   -1,
  277,  278,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  257,
  258,   -1,  289,  261,  291,  263,  264,  294,  266,   -1,
   -1,  269,  270,  271,   -1,  273,   -1,  275,   -1,  277,
  278,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  257,   -1,
   -1,  289,  261,  291,  263,  264,  294,  266,   -1,   -1,
  269,  270,  271,   -1,  273,   -1,  275,   -1,  277,  278,
  261,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  269,  270,
  289,   -1,  291,   -1,  261,  294,   -1,  278,  279,   -1,
   -1,   -1,  269,  270,   -1,   -1,   -1,   -1,  289,  262,
  291,  278,   -1,  294,  267,  268,   -1,   -1,   -1,   -1,
  262,   -1,  289,   -1,  291,  267,  268,  294,   -1,  282,
   -1,  284,  285,  286,   -1,  288,  289,  290,  267,  268,
  282,   -1,  284,  285,  286,  262,  288,  289,  290,   -1,
  267,  268,   -1,  282,   -1,  284,  285,  286,  262,   -1,
  289,  290,   -1,  267,  268,  282,  295,  284,  285,  286,
   -1,   -1,  289,  290,  267,  268,   -1,   -1,  282,   -1,
  284,  285,  286,   -1,   -1,  289,  290,   -1,   -1,  282,
   -1,  284,  285,  286,  267,  268,  289,  290,   -1,   -1,
   -1,   -1,  295,   -1,   -1,   -1,  267,  268,   -1,  282,
   -1,  284,  285,  286,   -1,   -1,  289,  290,   -1,   -1,
   -1,  282,  295,  284,  285,  286,  267,  268,  289,  290,
   -1,   -1,   -1,   -1,  295,  267,  268,   -1,   -1,   -1,
   -1,  282,  283,  284,  285,  286,   -1,   -1,  289,  290,
  282,   -1,  284,  285,  286,   -1,   -1,  289,  290,
};
#define YYFINAL 2
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
#define YYMAXTOKEN 295
#define YYUNDFTOKEN 328
#define YYTRANSLATE(a) ((a) > YYMAXTOKEN ? YYUNDFTOKEN : (a))
#if YYDEBUG
static const char *const yyname[] = {

"end-of-file",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"INIBLOQUE","FINBLOQUE","LOCAL",
"TIPO","ID","PYC","CIN","COUT","CADENA","RETURN","PORPOR","BORRLIST","INTHASH",
"CONST","DOLLAR","MAIN","IF","ELSE","DO","UNTIL","WHILE","CORIZQ","CORDER",
"COMA","ASIGN","MASMAS","AT","ORLOG","ANDLOG","EQN","REL","SHIFT","ADDSUB",
"MULDIV","EXCL","MASMENOS","INTHAS","PARIZQ","PARDER",0,0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"illegal-symbol",
};
static const char *const yyrule[] = {
"$accept : programa",
"programa : MAIN bloque",
"bloque : INIBLOQUE declar_de_variables_locales declar_de_subprogs sentencias FINBLOQUE",
"declar_de_variables_locales : LOCAL INIBLOQUE variables_locales FINBLOQUE",
"declar_de_variables_locales :",
"variables_locales : variables_locales cuerpo_declar_variables",
"variables_locales : cuerpo_declar_variables",
"cuerpo_declar_variables : TIPO lista_variables PYC",
"lista_variables : lista_variables COMA ID",
"lista_variables : ID",
"lista_expresiones : lista_expresiones COMA expresion",
"lista_expresiones : expresion",
"declar_de_subprogs : declar_de_subprogs declar_subprog",
"declar_de_subprogs :",
"declar_subprog : cabecera_subprog bloque",
"cabecera_subprog : TIPO ID PARIZQ parametros PARDER",
"cabecera_subprog : TIPO ID PARIZQ PARDER",
"parametros : parametros COMA parametro",
"parametros : parametro",
"parametro : TIPO ID",
"sentencias : sentencias sentencia",
"sentencias :",
"sentencia : bloque",
"sentencia : expresion PYC",
"sentencia : sentencia_asignacion",
"sentencia : sentencia_lista",
"sentencia : sentencia_if",
"sentencia : sentencia_while",
"sentencia : sentencia_entrada",
"sentencia : sentencia_salida",
"sentencia : sentencia_do_until",
"sentencia : sentencia_return",
"sentencia_asignacion : ID ASIGN expresion PYC",
"sentencia_lista : expresion SHIFT",
"sentencia_lista : DOLLAR expresion",
"sentencia_if : IF PARIZQ expresion PARDER sentencia bloque_else",
"bloque_else : ELSE sentencia",
"bloque_else :",
"sentencia_while : WHILE PARIZQ expresion PARDER sentencia",
"sentencia_entrada : CIN lista_variables PYC",
"sentencia_salida : COUT lista_expresiones_o_cadena PYC",
"lista_expresiones_o_cadena : lista_expresiones_o_cadena COMA expresion_cadena",
"lista_expresiones_o_cadena : expresion_cadena",
"expresion_cadena : expresion",
"expresion_cadena : CADENA",
"sentencia_do_until : DO sentencia UNTIL PARIZQ expresion PARDER PYC",
"sentencia_return : RETURN expresion PYC",
"expresion : PARIZQ expresion PARDER",
"expresion : op_unarios expresion",
"expresion : expresion op_binarios expresion",
"expresion : expresion MASMAS expresion AT expresion",
"expresion : ID",
"expresion : constante",
"expresion : llamada_funcion",
"op_unarios : ADDSUB",
"op_unarios : EXCL",
"op_unarios : INTHASH",
"op_binarios : ANDLOG",
"op_binarios : ORLOG",
"op_binarios : EQN",
"op_binarios : ADDSUB",
"op_binarios : MULDIV",
"op_binarios : ADDSUB",
"op_binarios : PORPOR",
"op_binarios : BORRLIST",
"llamada_funcion : ID PARIZQ lista_expresiones PARDER",
"llamada_funcion : ID PARIZQ PARDER",
"constante : CONST",
"constante : lista",
"lista : CORIZQ lista_expresiones CORDER",
"lista : CORIZQ CORDER",

};
#endif

int      yydebug;
int      yynerrs;

int      yyerrflag;
int      yychar;
YYSTYPE  yyval;
YYSTYPE  yylval;

/* define the initial stack-sizes */
#ifdef YYSTACKSIZE
#undef YYMAXDEPTH
#define YYMAXDEPTH  YYSTACKSIZE
#else
#ifdef YYMAXDEPTH
#define YYSTACKSIZE YYMAXDEPTH
#else
#define YYSTACKSIZE 10000
#define YYMAXDEPTH  10000
#endif
#endif

#define YYINITSTACKSIZE 200

typedef struct {
    unsigned stacksize;
    YYINT    *s_base;
    YYINT    *s_mark;
    YYINT    *s_last;
    YYSTYPE  *l_base;
    YYSTYPE  *l_mark;
} YYSTACKDATA;
/* variables for the parser stack */
static YYSTACKDATA yystack;
#line 143 "sintactico.y"

#include "lex.yy.c"

void yyerror(){
    printf("\nLine %d: Syntax Error: Unexpected \"%s\"", yylineno, yytext);
}

int main(){
    #ifdef YYDEBUG
        yydebug=1;
    #endif

    yyparse();

    return 0;
}
#line 443 "y.tab.c"

#if YYDEBUG
#include <stdio.h>	/* needed for printf */
#endif

#include <stdlib.h>	/* needed for malloc, etc */
#include <string.h>	/* needed for memset */

/* allocate initial stack or double stack size, up to YYMAXDEPTH */
static int yygrowstack(YYSTACKDATA *data)
{
    int i;
    unsigned newsize;
    YYINT *newss;
    YYSTYPE *newvs;

    if ((newsize = data->stacksize) == 0)
        newsize = YYINITSTACKSIZE;
    else if (newsize >= YYMAXDEPTH)
        return YYENOMEM;
    else if ((newsize *= 2) > YYMAXDEPTH)
        newsize = YYMAXDEPTH;

    i = (int) (data->s_mark - data->s_base);
    newss = (YYINT *)realloc(data->s_base, newsize * sizeof(*newss));
    if (newss == 0)
        return YYENOMEM;

    data->s_base = newss;
    data->s_mark = newss + i;

    newvs = (YYSTYPE *)realloc(data->l_base, newsize * sizeof(*newvs));
    if (newvs == 0)
        return YYENOMEM;

    data->l_base = newvs;
    data->l_mark = newvs + i;

    data->stacksize = newsize;
    data->s_last = data->s_base + newsize - 1;
    return 0;
}

#if YYPURE || defined(YY_NO_LEAKS)
static void yyfreestack(YYSTACKDATA *data)
{
    free(data->s_base);
    free(data->l_base);
    memset(data, 0, sizeof(*data));
}
#else
#define yyfreestack(data) /* nothing */
#endif

#define YYABORT  goto yyabort
#define YYREJECT goto yyabort
#define YYACCEPT goto yyaccept
#define YYERROR  goto yyerrlab

int
YYPARSE_DECL()
{
    int yym, yyn, yystate;
#if YYDEBUG
    const char *yys;

    if ((yys = getenv("YYDEBUG")) != 0)
    {
        yyn = *yys;
        if (yyn >= '0' && yyn <= '9')
            yydebug = yyn - '0';
    }
#endif

    yym = 0;
    yyn = 0;
    yynerrs = 0;
    yyerrflag = 0;
    yychar = YYEMPTY;
    yystate = 0;

#if YYPURE
    memset(&yystack, 0, sizeof(yystack));
#endif

    if (yystack.s_base == NULL && yygrowstack(&yystack) == YYENOMEM) goto yyoverflow;
    yystack.s_mark = yystack.s_base;
    yystack.l_mark = yystack.l_base;
    yystate = 0;
    *yystack.s_mark = 0;

yyloop:
    if ((yyn = yydefred[yystate]) != 0) goto yyreduce;
    if (yychar < 0)
    {
        yychar = YYLEX;
        if (yychar < 0) yychar = YYEOF;
#if YYDEBUG
        if (yydebug)
        {
            if ((yys = yyname[YYTRANSLATE(yychar)]) == NULL) yys = yyname[YYUNDFTOKEN];
            printf("%sdebug: state %d, reading %d (%s)\n",
                    YYPREFIX, yystate, yychar, yys);
        }
#endif
    }
    if (((yyn = yysindex[yystate]) != 0) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == (YYINT) yychar)
    {
#if YYDEBUG
        if (yydebug)
            printf("%sdebug: state %d, shifting to state %d\n",
                    YYPREFIX, yystate, yytable[yyn]);
#endif
        if (yystack.s_mark >= yystack.s_last && yygrowstack(&yystack) == YYENOMEM) goto yyoverflow;
        yystate = yytable[yyn];
        *++yystack.s_mark = yytable[yyn];
        *++yystack.l_mark = yylval;
        yychar = YYEMPTY;
        if (yyerrflag > 0)  --yyerrflag;
        goto yyloop;
    }
    if (((yyn = yyrindex[yystate]) != 0) && (yyn += yychar) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == (YYINT) yychar)
    {
        yyn = yytable[yyn];
        goto yyreduce;
    }
    if (yyerrflag != 0) goto yyinrecovery;

    YYERROR_CALL("syntax error");

    goto yyerrlab; /* redundant goto avoids 'unused label' warning */
yyerrlab:
    ++yynerrs;

yyinrecovery:
    if (yyerrflag < 3)
    {
        yyerrflag = 3;
        for (;;)
        {
            if (((yyn = yysindex[*yystack.s_mark]) != 0) && (yyn += YYERRCODE) >= 0 &&
                    yyn <= YYTABLESIZE && yycheck[yyn] == (YYINT) YYERRCODE)
            {
#if YYDEBUG
                if (yydebug)
                    printf("%sdebug: state %d, error recovery shifting\
 to state %d\n", YYPREFIX, *yystack.s_mark, yytable[yyn]);
#endif
                if (yystack.s_mark >= yystack.s_last && yygrowstack(&yystack) == YYENOMEM) goto yyoverflow;
                yystate = yytable[yyn];
                *++yystack.s_mark = yytable[yyn];
                *++yystack.l_mark = yylval;
                goto yyloop;
            }
            else
            {
#if YYDEBUG
                if (yydebug)
                    printf("%sdebug: error recovery discarding state %d\n",
                            YYPREFIX, *yystack.s_mark);
#endif
                if (yystack.s_mark <= yystack.s_base) goto yyabort;
                --yystack.s_mark;
                --yystack.l_mark;
            }
        }
    }
    else
    {
        if (yychar == YYEOF) goto yyabort;
#if YYDEBUG
        if (yydebug)
        {
            if ((yys = yyname[YYTRANSLATE(yychar)]) == NULL) yys = yyname[YYUNDFTOKEN];
            printf("%sdebug: state %d, error recovery discards token %d (%s)\n",
                    YYPREFIX, yystate, yychar, yys);
        }
#endif
        yychar = YYEMPTY;
        goto yyloop;
    }

yyreduce:
#if YYDEBUG
    if (yydebug)
        printf("%sdebug: state %d, reducing by rule %d (%s)\n",
                YYPREFIX, yystate, yyn, yyrule[yyn]);
#endif
    yym = yylen[yyn];
    if (yym > 0)
        yyval = yystack.l_mark[1-yym];
    else
        memset(&yyval, 0, sizeof yyval);

    switch (yyn)
    {
    }
    yystack.s_mark -= yym;
    yystate = *yystack.s_mark;
    yystack.l_mark -= yym;
    yym = yylhs[yyn];
    if (yystate == 0 && yym == 0)
    {
#if YYDEBUG
        if (yydebug)
            printf("%sdebug: after reduction, shifting from state 0 to\
 state %d\n", YYPREFIX, YYFINAL);
#endif
        yystate = YYFINAL;
        *++yystack.s_mark = YYFINAL;
        *++yystack.l_mark = yyval;
        if (yychar < 0)
        {
            yychar = YYLEX;
            if (yychar < 0) yychar = YYEOF;
#if YYDEBUG
            if (yydebug)
            {
                if ((yys = yyname[YYTRANSLATE(yychar)]) == NULL) yys = yyname[YYUNDFTOKEN];
                printf("%sdebug: state %d, reading %d (%s)\n",
                        YYPREFIX, YYFINAL, yychar, yys);
            }
#endif
        }
        if (yychar == YYEOF) goto yyaccept;
        goto yyloop;
    }
    if (((yyn = yygindex[yym]) != 0) && (yyn += yystate) >= 0 &&
            yyn <= YYTABLESIZE && yycheck[yyn] == (YYINT) yystate)
        yystate = yytable[yyn];
    else
        yystate = yydgoto[yym];
#if YYDEBUG
    if (yydebug)
        printf("%sdebug: after reduction, shifting from state %d \
to state %d\n", YYPREFIX, *yystack.s_mark, yystate);
#endif
    if (yystack.s_mark >= yystack.s_last && yygrowstack(&yystack) == YYENOMEM) goto yyoverflow;
    *++yystack.s_mark = (YYINT) yystate;
    *++yystack.l_mark = yyval;
    goto yyloop;

yyoverflow:
    YYERROR_CALL("yacc stack overflow");

yyabort:
    yyfreestack(&yystack);
    return (1);

yyaccept:
    yyfreestack(&yystack);
    return (0);
}
