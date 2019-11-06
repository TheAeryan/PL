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

#define MAIN 257
#define LOCAL 258
#define TIPO 259
#define ID 260
#define PYC 261
#define CIN 262
#define COUT 263
#define CADENA 264
#define RETURN 265
#define IF 266
#define ELSE 267
#define DO 268
#define UNTIL 269
#define WHILE 270
#define SHIFT 271
#define DOLLAR 272
#define CONST 273
#define INIBLOQUE 274
#define FINBLOQUE 275
#define CORIZQ 276
#define CORDER 277
#define COMA 278
#define MASMAS 279
#define AT 280
#define ASIGN 281
#define ORLOG 282
#define ANDLOG 283
#define EQN 284
#define REL 285
#define PORPOR 286
#define BORRLIST 287
#define ADDSUB 288
#define MULDIV 289
#define INTHAS 290
#define MASMENOS 291
#define EXCL 292
#define PARIZQ 293
#define PARDER 294
#define INTHASH 295
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
    0,    0,    0,    0,    0,    0,    0,    0,   67,    2,
    0,   54,   55,    0,   56,   22,    0,   20,   24,   25,
   26,   27,   28,   29,   30,   31,    0,   52,   53,   68,
   14,    7,    0,    0,    0,    0,    0,   51,   44,    0,
    0,   42,    0,    0,    0,    0,    0,   70,    0,    0,
    0,   23,   33,    0,   58,   57,   59,   63,   64,   60,
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
static const YYINT yysindex[] = {                      -253,
 -257,    0, -208,    0, -217,    0, -200, -198, -196, -213,
    0, -191,   11,    0, -257,    0, -246,    0,    0, -218,
 -228, -196, -225,   36, -216,   79, -214,   36,    0,    0,
   88,    0,    0,   36,    0,    0,  107,    0,    0,    0,
    0,    0,    0,    0,    0,    0,   36,    0,    0,    0,
    0,    0, -184, -256,   36,  -32, -224,    0,    0, -127,
 -212,    0,  136,   36, -189,   36, -127,    0, -251, -127,
  161,    0,    0,   36,    0,    0,    0,    0,    0,    0,
    0,   36, -127,    0, -179,    0, -223,    0,  150,    0,
 -220,    0,    0, -225,    0,  174, -211,  187,    0,   36,
    0, -163, -127,    0, -176,    0,    0,    0,    0,   79,
   36,   79, -127,   36,    0, -182,  200,    0, -127,   79,
    0, -174,    0,    0,
};
static const YYINT yyrindex[] = {                         0,
    0,    0, -252,    0,    0,    0,    0,   45,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
  121,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0, -205,
    0,    0,    0,    0,    0,    0,  -57,    0,    0, -249,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0, -165,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0, -129,    0,    0,    0,    0,    0,    0,    0,
    0,    0, -247,    0,    0,  -23,    0,    0,  -93,    0,
    0,    0,    0,    0,
};
static const YYINT yygindex[] = {                         0,
    4,    0,    0,    0,    0,   78,   68,   35,  -22,    0,
    0,    0,  -12,  -26,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    5,    0,    0,    0,    0,    0,
};
#define YYTABLESIZE 494
static const YYINT yytable[] = {                         65,
   60,   63,   85,    1,    4,   67,    4,    4,   70,    4,
    4,   71,    4,    4,   52,    4,    3,    4,   51,    4,
    4,    4,    4,    4,   83,   99,  100,   11,   11,   10,
   10,   53,   89,   70,   58,    4,   92,   86,   59,    4,
    4,   96,    4,   98,   11,    9,   10,   29,   93,    5,
   31,  102,   55,   53,  105,   43,    7,  100,    9,  103,
   12,   18,   32,   16,   56,   94,   33,   34,   20,   35,
  106,   60,   43,  108,   54,   84,   64,  113,   66,   97,
  104,  111,   85,  116,  120,  118,  124,   19,  117,   57,
   91,  119,  115,  123,   48,   48,   48,   48,  109,   48,
   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
   48,   48,   48,    0,   48,   74,  114,    0,   75,   76,
   77,    0,   78,   79,   80,   81,   48,   48,   48,   48,
   49,   49,   49,   49,    0,   49,   49,   49,   49,   49,
   49,   49,   49,   49,   49,   49,   49,   49,   49,    0,
   49,   74,    0,    0,   75,   76,   77,    0,   78,   79,
   80,   81,   49,   49,   49,   49,   50,   50,   50,   50,
    0,   50,   50,   50,   50,   50,   50,   50,   50,   50,
   50,   50,   50,   50,   50,    0,   50,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,   50,   50,
   50,   50,   34,    0,   34,   34,    0,   34,   34,   34,
   34,   34,   34,    0,   34,   34,   34,   34,   34,    0,
    0,    0,    0,    0,    0,    0,    0,   58,    0,    0,
    0,    0,    0,    0,   34,   34,   37,   34,   37,   37,
   29,   37,   37,   31,   37,   37,   37,    0,   37,   37,
   37,   37,   37,    0,    0,   32,    0,    0,    0,   33,
   34,   90,   35,    0,   37,    0,    0,    0,   37,   37,
   21,   37,   22,   23,    0,   24,   25,    0,   26,    0,
   27,    0,   28,   29,    3,   30,   31,    0,    0,    0,
    0,    0,    0,    0,    0,   58,    0,    0,   32,    0,
    0,    0,   33,   34,   21,   35,   21,   21,   29,   21,
   21,   31,   21,    0,   21,    0,   21,   21,   21,   21,
   21,    0,    0,   32,    0,    0,    0,   33,   34,    0,
   35,    0,   21,    0,    0,    0,   21,   21,   21,   21,
   22,   23,    0,   24,   25,    0,   26,   58,   27,    0,
   28,   29,    3,    0,   31,    0,    0,    0,    0,    0,
   29,    0,    0,   31,   68,    0,   32,   72,    0,    0,
   33,   34,    0,   35,    0,   32,    0,   73,    0,   33,
   34,   51,   35,    0,    0,   74,    0,    0,   75,   76,
   77,   51,   78,   79,   80,   81,   95,    0,    0,   51,
    0,    0,   51,   51,   51,    0,   51,   51,   51,   51,
  107,    0,    0,    0,   74,    0,    0,   75,   76,   77,
    0,   78,   79,   80,   81,    0,    0,    0,   74,    0,
    0,   75,   76,   77,    0,   78,   79,   80,   81,   74,
    0,    0,   75,   76,   77,    0,   78,   79,   80,   81,
    0,    0,   74,    0,  101,   75,   76,   77,    0,   78,
   79,   80,   81,    0,    0,   74,    0,  110,   75,   76,
   77,    0,   78,   79,   80,   81,    0,    0,   74,    0,
  112,   75,   76,   77,    0,   78,   79,   80,   81,    0,
    0,    0,    0,  122,
};
static const YYINT yycheck[] = {                         26,
   23,   24,  259,  257,    1,   28,  259,  260,   31,  262,
  263,   34,  265,  266,  261,  268,  274,  270,   15,  272,
  273,  274,  275,  276,   47,  277,  278,  277,  278,  277,
  278,  278,   55,   56,  260,  288,  261,  294,  264,  292,
  293,   64,  295,   66,  294,  259,  294,  273,  261,  258,
  276,   74,  281,  278,  278,  261,  274,  278,  259,   82,
  259,  275,  288,  260,  293,  278,  292,  293,  260,  295,
  294,   94,  278,  294,  293,  260,  293,  100,  293,  269,
  260,  293,  259,  110,  267,  112,  261,   10,  111,   22,
   56,  114,  105,  120,  260,  261,  262,  263,   94,  265,
  266,  267,  268,  269,  270,  271,  272,  273,  274,  275,
  276,  277,  278,   -1,  280,  279,  280,   -1,  282,  283,
  284,   -1,  286,  287,  288,  289,  292,  293,  294,  295,
  260,  261,  262,  263,   -1,  265,  266,  267,  268,  269,
  270,  271,  272,  273,  274,  275,  276,  277,  278,   -1,
  280,  279,   -1,   -1,  282,  283,  284,   -1,  286,  287,
  288,  289,  292,  293,  294,  295,  260,  261,  262,  263,
   -1,  265,  266,  267,  268,  269,  270,  271,  272,  273,
  274,  275,  276,  277,  278,   -1,  280,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  292,  293,
  294,  295,  260,   -1,  262,  263,   -1,  265,  266,  267,
  268,  269,  270,   -1,  272,  273,  274,  275,  276,   -1,
   -1,   -1,   -1,   -1,   -1,   -1,   -1,  260,   -1,   -1,
   -1,   -1,   -1,   -1,  292,  293,  260,  295,  262,  263,
  273,  265,  266,  276,  268,  269,  270,   -1,  272,  273,
  274,  275,  276,   -1,   -1,  288,   -1,   -1,   -1,  292,
  293,  294,  295,   -1,  288,   -1,   -1,   -1,  292,  293,
  260,  295,  262,  263,   -1,  265,  266,   -1,  268,   -1,
  270,   -1,  272,  273,  274,  275,  276,   -1,   -1,   -1,
   -1,   -1,   -1,   -1,   -1,  260,   -1,   -1,  288,   -1,
   -1,   -1,  292,  293,  260,  295,  262,  263,  273,  265,
  266,  276,  268,   -1,  270,   -1,  272,  273,  274,  275,
  276,   -1,   -1,  288,   -1,   -1,   -1,  292,  293,   -1,
  295,   -1,  288,   -1,   -1,   -1,  292,  293,  260,  295,
  262,  263,   -1,  265,  266,   -1,  268,  260,  270,   -1,
  272,  273,  274,   -1,  276,   -1,   -1,   -1,   -1,   -1,
  273,   -1,   -1,  276,  277,   -1,  288,  261,   -1,   -1,
  292,  293,   -1,  295,   -1,  288,   -1,  271,   -1,  292,
  293,  261,  295,   -1,   -1,  279,   -1,   -1,  282,  283,
  284,  271,  286,  287,  288,  289,  261,   -1,   -1,  279,
   -1,   -1,  282,  283,  284,   -1,  286,  287,  288,  289,
  261,   -1,   -1,   -1,  279,   -1,   -1,  282,  283,  284,
   -1,  286,  287,  288,  289,   -1,   -1,   -1,  279,   -1,
   -1,  282,  283,  284,   -1,  286,  287,  288,  289,  279,
   -1,   -1,  282,  283,  284,   -1,  286,  287,  288,  289,
   -1,   -1,  279,   -1,  294,  282,  283,  284,   -1,  286,
  287,  288,  289,   -1,   -1,  279,   -1,  294,  282,  283,
  284,   -1,  286,  287,  288,  289,   -1,   -1,  279,   -1,
  294,  282,  283,  284,   -1,  286,  287,  288,  289,   -1,
   -1,   -1,   -1,  294,
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
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"MAIN","LOCAL","TIPO","ID","PYC",
"CIN","COUT","CADENA","RETURN","IF","ELSE","DO","UNTIL","WHILE","SHIFT",
"DOLLAR","CONST","INIBLOQUE","FINBLOQUE","CORIZQ","CORDER","COMA","MASMAS","AT",
"ASIGN","ORLOG","ANDLOG","EQN","REL","PORPOR","BORRLIST","ADDSUB","MULDIV",
"INTHAS","MASMENOS","EXCL","PARIZQ","PARDER","INTHASH",0,0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"illegal-symbol",
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
#line 160 "sintactico.y"

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
#line 427 "y.tab.c"

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
