
%start programa
%token MAIN
%token LOCAL
%token TIPO
%token ID
%token PYC
%token CIN COUT
%token CADENA
%token RETURN
%token IF ELSE
%token DO UNTIL
%token WHILE
%token SHIFT
%token DOLLAR
%token CONST
%token INIBLOQUE FINBLOQUE
%token CORIZQ CORDER
%token INTHASH
%token PARIZQ PARDER

/* Coma */
%left COMA

/* Ternario */
%right MASMAS AT

/* Asign */
%right ASIGN

/* Or log */
%left ORLOG

/* And log */
%left ANDLOG

/* Igual */
%left EQN

/* Rel */
%left REL

/* Op bin lista */
%left PORPOR BORRLIST

/* Sum rest */
%left ADDSUB

/* Mult div */
%left MULDIV

/* Unarios */
%right INTHASH MASMENOS EXCL

/* PostFix */
%left PARIZQ PARDER
/* %nonassoc PARENTHESIS */

%%

programa : MAIN bloque ;

bloque : INIBLOQUE declar_de_variables_locales declar_de_subprogs sentencias FINBLOQUE ;

declar_de_variables_locales : LOCAL INIBLOQUE variables_locales FINBLOQUE
                            | ;

variables_locales : variables_locales cuerpo_declar_variables
                  | cuerpo_declar_variables ;

cuerpo_declar_variables : TIPO lista_variables PYC ;

lista_variables : lista_variables COMA ID
                | ID ;

lista_expresiones : lista_expresiones COMA expresion
                  | expresion ;

declar_de_subprogs : declar_de_subprogs declar_subprog
                   | ;

declar_subprog : cabecera_subprog bloque ;

cabecera_subprog : TIPO ID PARIZQ cabecera_argumentos PARDER ;

cabecera_argumentos : parametros
                    | ;

parametros : parametros COMA parametro
           | parametro ;

parametro : TIPO ID ;

sentencias : sentencias sentencia
           | ;

sentencia : bloque
          | expresion PYC
          | sentencia_asignacion
          | sentencia_lista
          | sentencia_if
          | sentencia_while
          | sentencia_entrada
          | sentencia_salida
          | sentencia_do_until
          | sentencia_return ;

sentencia_asignacion : ID ASIGN expresion PYC ;

sentencia_lista : expresion SHIFT
                | DOLLAR expresion

sentencia_if : IF PARIZQ expresion PARDER sentencia bloque_else ;

bloque_else : ELSE sentencia
            | ;

sentencia_while : WHILE PARIZQ expresion PARDER sentencia ;

sentencia_entrada : CIN lista_variables PYC ;

sentencia_salida : COUT lista_expresiones_o_cadena PYC ;

lista_expresiones_o_cadena : lista_expresiones_o_cadena COMA expresion_cadena
                           | expresion_cadena ;

expresion_cadena : expresion
                 | CADENA ;

sentencia_do_until : DO sentencia UNTIL PARIZQ expresion PARDER PYC ;

sentencia_return : RETURN expresion PYC ;

expresion : PARIZQ expresion PARDER
          | op_unarios
          | op_binarios
          | op_terciario
          | llamada_funcion
          | ID
          | constante ;

op_unarios : ADDSUB expresion %prec MASMENOS
           | EXCL expresion
           | INTHASH expresion ;

op_binarios : expresion ANDLOG expresion
            | expresion ORLOG expresion
            | expresion EQN expresion
            | expresion ADDSUB expresion
            | expresion MULDIV expresion
            | expresion PORPOR expresion
            | expresion BORRLIST expresion
            | expresion REL expresion ;

op_terciario : expresion MASMAS expresion AT expresion ;

llamada_funcion : ID PARIZQ argumentos PARDER ;

argumentos : lista_expresiones
           | ;

constante : CONST
          | lista ;

lista : CORIZQ lista_expresiones CORDER
      | CORIZQ CORDER ;

%%

#include "lex.yy.c"

void yyerror(){
    printf("\nLine %d: Syntax Error: Unexpected \"%s\"", yylineno, yytext);
}

int main(){
    #ifdef YYDEBUG
        extern int yydebug;
        yydebug = 1;
    #endif

    yyparse();

    return 0;
}
