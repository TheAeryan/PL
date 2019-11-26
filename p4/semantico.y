%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "lex.yy.c"
#include "tabla.h"
#include "error.h"

%}

/* Para permitir mensajes de error bonitos */
%error-verbose

/* Structs usados en herencia para la tabla de símbolos */
 %union{
  char * lexema;
  struct atributos atrib;
  TipoDato tipo;
 }

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
%left MUL DIV

/* Unarios */
%precedence INTHASH EXCL

%%

programa : MAIN bloque ;

bloque : inicio_bloque
         declar_de_variables_locales
         declar_de_subprogs
         sentencias
         fin_bloque ;

inicio_bloque: INIBLOQUE { entraBloqueTS(); }

fin_bloque: FINBLOQUE { salBloqueTS(); }

declar_de_variables_locales : LOCAL inicio_bloque variables_locales fin_bloque
                            | %empty ;

variables_locales : variables_locales cuerpo_declar_variables
                  | cuerpo_declar_variables ;

cuerpo_declar_variables : TIPO lista_variables PYC {
                            for(int i=0; i<$2.lid.tope_id; i++) {
                              insertaVar($2.lid.lista_ids[i], $1);
                            }
                          }
                        | error ;

lista_variables : ID COMA lista_variables {
                    $$.lid.lista_ids[$$.lid.tope_id] = $1;
                    $$.lid.tope_id++;
                  }
                | ID {
                  $$.lid.lista_ids[$$.lid.tope_id] = $1;
                  $$.lid.tope_id++;
                } ;

lista_expresiones : lista_expresiones COMA expresion
                  | expresion ;

declar_de_subprogs : declar_de_subprogs declar_subprog
                   | %empty ;

declar_subprog : cabecera_subprog bloque ;

cabecera_subprog : TIPO ID PARIZQ {
                     insertaProcedimiento($2);
                   }
                   cabecera_argumentos PARDER ;

cabecera_argumentos : parametros
                    | %empty
                    | error ;

parametros : parametros COMA parametro
           | parametro ;

parametro : TIPO ID { insertaParametro($2, $1); } ;

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

sentencia_if : IF {
                insertaIf("", "");
              }
              PARIZQ expresion PARDER {
                comprobarCondicion();
                // TODO: Implementar esta función que comprueba que
                // la expresión del if es booleana.
              } sentencia bloque_else {
                salEstructuraControl();
              } ;

bloque_else : ELSE sentencia
            | %empty ;

sentencia_while : WHILE {
                  insertaWhile("");
                } PARIZQ expresion PARDER {
                  comprobarCondicion();
                } sentencia {
                  salEstructuraControl();
                } ;

sentencia_entrada : CIN lista_variables PYC ;

sentencia_salida : COUT lista_expresiones_o_cadena PYC ;

lista_expresiones_o_cadena : lista_expresiones_o_cadena COMA expresion_cadena
                           | expresion_cadena ;

expresion_cadena : expresion
                 | CADENA ;

sentencia_do_until : DO {
                      insertaRepeatUntil("");
                    } sentencia UNTIL PARIZQ expresion PARDER PYC {
                      salEstructuraControl();
                    } ;

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
          | expresion MUL expresion
          | expresion DIV expresion
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

int main(){

  yyparse();
  return 0;

}
