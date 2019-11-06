
%start programa
%token INIBLOQUE FINBLOQUE
%token LOCAL TIPO ID
%token PYC
%token CIN COUT
%token CADENA
%token RETURN

%token PORPOR
%token BORRLIST
%token INTHASH

%token CONST
%token DOLLAR

%token MAIN
%token IF ELSE
%token DO UNTIL WHILE
%token CORIZQ CORDER

%right COMA
%right ASIGN
%token MASMAS AT
%left ORLOG
%left ANDLOG
%left EQN
%left REL
%token SHIFT
%left ADDSUB
%left MULDIV
%right EXCL
%right MASMENOS
%token INTHAS
%token CONST ID
%token PARIZQ PARDER


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

cabecera_subprog : TIPO ID PARIZQ parametros PARDER
                 | TIPO ID PARIZQ PARDER

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
          | op_unarios expresion
          | expresion op_binarios expresion
          | expresion MASMAS expresion AT expresion
          | ID
          | constante
          | llamada_funcion ;

op_unarios : ADDSUB %prec MASMENOS
           | EXCL
           | INTHASH

op_binarios : ANDLOG
            | ORLOG
            | EQN
            | ADDSUB
            | MULDIV
            | ADDSUB
            | PORPOR
            | BORRLIST

llamada_funcion : ID PARIZQ lista_expresiones PARDER
                | ID PARIZQ PARDER ;

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
        yydebug=1;
    #endif

    yyparse();

    return 0;
}
