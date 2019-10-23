%start programa
%token INIBLOQUE FINBLOQUE
%token LOCAL TIPOSIMPLE ID 
%token PARIZQ PARDER
%token PYC
%token CIN COUT
%token CADENA
%token RETURN
%token OPBIN OPUNARIO BINYUN
%token AT MASMAS
%token CONST
%token ASIGN
%token COMA
%token MAIN
%token IF ELSE 
%token DO UNTIL WHILE
%token LISTA
%token CORIZQ CORDER


%left OLOG 
%left YLOG
%left ORBIT
%left EXORBIT
%left ANDBIT
%left IGUAL NOIGUAL
%left MENOR MENIGUAL MAYOR MAYIGUAL
%left MAS MENOS
%left MULT DIV MOD
%right MAS MENOS NEGACION 
%right MENOSPREFIJO
%right MASPREFIJO
%left MENOSPOSFIJO
%left MASPOSFIJO

{Faltan los operadores de listas y la precedencia}


%%

programa : cabecera_programa bloque ;

cabecera_programa : MAIN ;

bloque : INIBLOQUE declar_de_variables_locales declar_de_subprogs sentencias FINBLOQUE ;

declar_de_variables_locales : marca_ini_declar_variables variables_locales marca_fin_declar_variables
                            | ;

marca_ini_declar_variables : LOCAL INIBLOQUE ;

variables_locales : variables_locales cuerpo_declar_variables
                  | cuerpo_declar_variables ;

cuerpo_declar_variables : tipo_variable lista_variables PYC ;

marca_fin_declar_variables : FINBLOQUE ;

declar_de_subprogs : declar_de_subprogs declar_subprog
                   | ;

declar_subprog : cabecera_subprog bloque ;

cabecera_subprog : tipo_variable ID PARIZQ parametros PARDER ;

tipo_variable : tipo_variable_simple
              | tipo_variable_complejo ;

tipo_variable_simple : int 
                     | float
                     | char
                     | bool ;

tipo_variable_complejo : LISTA tipo_variable_simple ;

lista_variables : ID COMA lista_variables
                | ID ;

parametros : parametro COMA parametros
           | parametro ;

parametro : tipo_variable ID ;

sentencias : sentencias sentencia
           | sentencia
           | ;

sentencia : bloque
          | expresion PYC
          | sentencia_asignacion
          | sentencia_if
          | sentencia_while
          | sentencia_entrada
          | sentencia_salida
          | sentencia_do_until
          | sentencia_return ;

expresion : op_unario expresion
          | expresion op_binario expresion
          | expresion MASMAS expresion AT expresion
          | ID
          | constante
          | llamada_funcion
          | PARIZQ expresion PARDER ;

op_unario : OPUNARIO ;

op_binario : OPBIN ;

constante : CONST
          | lista ;

lista : CORIZQ lista_expresiones CORDER
      | CORIZQ CORDER ;

llamada_funcion : ID PARIZQ lista_expresiones PARDER
                | ID PARIZQ PARDER ;

lista_expresiones : expresion COMA lista_expresiones
                  | expresion ;

sentencia_asignacion : ID op_asignacion expresion PYC ;
op_asignacion : ASIGN ;

sentencia_if : IF PARIZQ expresion PARDER sentencia bloque_else ;

bloque_else : else sentencia
            | ;

sentencia_while : WHILE PARIZQ expresion PARDER sentencia ;

sentencia_entrada : CIN lista_variables PYC ;

sentencia_salida : COUT lista_expresiones_o_cadena PYC ;

lista_expresiones_o_cadena : expresion_cadena , lista_expresion_o_cadena
                           | expresion_cadena ;

expresion_cadena : expresion
                 | cadena ;

sentencia_do_until : DO sentencia UNTIL PARIZQ expresion PARDER PYC ;

sentencia_return : RETURN expresion PYC ;

%%

#include "../lexico/lex.yy.c"

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