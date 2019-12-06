%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "tabla.h"

// Los atributos sintetizados serán de tipo char*
typedef char* atributo_pila;

#define YYSTYPE atributo_pila

int yylex();

// <Variables Auxiliares>

// Almacena el tipo de dato de las variables de una declaración
// (ej.: int a, b, c;)
TipoDato tipo_variables;

void yyerror( const char * msg );

#define YYERROR_VERBOSE
%}

%start programa
%token MAIN
%token LOCAL
%token TIPO
%token PYC
%token CIN COUT
%token CADENA
%token RETURN
%token IF ELSE
%token DO UNTIL
%token WHILE
%token SHIFT
%token CONST
%token INIBLOQUE FINBLOQUE
%token CORIZQ CORDER
%token COMA
%token ASIGN
%token PARDER PARIZQ
%token DOLLAR
%token ID

/* Ternario */
%right MASMAS AT

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
%precedence INTHASH EXCL
%%

programa : MAIN bloque ;

ini_bloque : INIBLOQUE { inicioBloque(); } ;

fin_bloque : FINBLOQUE { finBloque(); } ;

bloque : ini_bloque declar_de_variables_locales declar_de_subprogs sentencias fin_bloque ;

declar_de_variables_locales : LOCAL ini_bloque variables_locales fin_bloque
                            | %empty ;

variables_locales : variables_locales cuerpo_declar_variables
                  | cuerpo_declar_variables ;

cuerpo_declar_variables : TIPO {
                          // Guardo el tipo de dato de la lista de variables
                          tipo_variables = stringToTipoDato($1);
                        } lista_variables PYC
                        | error ;

lista_variables : ID COMA lista_variables { insertarVariable($1, tipo_variables); }
                | ID {
                      // Inserto la variable según el tipo correspondiente
                      // (almacenado en "tipo_variables")
                      // Esta función comprueba si existe un identificador duplicado
                      insertarVariable($1, tipo_variables);
                }
                ;

lista_expresiones : lista_expresiones COMA expresion
                  | expresion ;

declar_de_subprogs : declar_de_subprogs declar_subprog
                   | %empty ;

declar_subprog : cabecera_subprog bloque ;

cabecera_subprog : TIPO ID {
                    // Inserto la entrada de la función.
                    // Los parámetros se insertarán después.
                    insertarFuncion($2, $1);
                  } PARIZQ cabecera_argumentos PARDER ;

cabecera_argumentos : parametros
                    | %empty
                    | error ;

parametros : parametros COMA parametro
           | parametro ;

parametro : TIPO ID {
              // Inserto el parámetro en la tabla
              // (esta función ya se encarga en aumentar el número
              // de parámetros de la función en 1)
              insertarParametroFuncion($2, $1);
           } ;

sentencias : sentencias sentencia
           | %empty ;

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

sentencia_lista : expresion SHIFT PYC
                | DOLLAR expresion PYC ;

sentencia_if : IF PARIZQ expresion PARDER sentencia bloque_else ;

bloque_else : ELSE sentencia
            | %empty ;

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
          | ADDSUB expresion %prec EXCL
          | EXCL expresion
          | INTHASH expresion
          | expresion AT expresion
          | expresion ANDLOG expresion
          | expresion ORLOG expresion
          | expresion EQN expresion
          | expresion ADDSUB expresion
          | expresion MULDIV expresion
          | expresion PORPOR expresion
          | expresion BORRLIST expresion
          | expresion REL expresion
          | expresion MASMAS expresion AT expresion
          | llamada_funcion
          | ID
          | constante
          | error ;

llamada_funcion : ID PARIZQ argumentos PARDER ;

argumentos : lista_expresiones
           | %empty ;

constante : CONST
          | lista ;

lista : CORIZQ lista_expresiones CORDER
      | CORIZQ CORDER ;

%%

#include "lex.yy.c"

void yyerror(const char *msg){
  fprintf(stderr, "[Linea %d]: %s\n", yylineno, msg);
}

int main(){
  // <Inicializar variables de tabla.h>

  TOPE = -1;
  ultimaFuncion = -1;
  esSubProg = 0;

  yyparse();

  return 0;
}
