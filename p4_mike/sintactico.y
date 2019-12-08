%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define YYERROR_VERBOSE

void yyerror( const char * msg );

#define MAX_TAM_TS 500

extern int yylineno;


/************************/
/* ESTRUCTURA DE LA TS */
/***********************/

// Tipo de entrada
typedef enum {
  marca,
  funcion,
  variable,
  parametroFormal
} TipoEntrada;

// Si TipoEntrada es función, variable, o parametro-formal; indica el tipo de dato
// No se usa en otro caso
typedef enum {
  entero,
  real,
  booleano,
  caracter,
  listaEntero,
  listaReal,
  listaBooleano,
  listaCaracter,
  desconocido
} TipoDato;


typedef struct {
  TipoEntrada tipoEntrada;    // Tipo de entrada
  char* nombre;               // Nombre del identificador (con marca no se usa)
  TipoDato tipoDato;          // Tipo de dato
  int parametros;             // Nº de parámetros forales (con función solo)
} EntradaTS;

// La Tabla de Símbolos
EntradaTS ts[MAX_TAM_TS];

// Última entrada de la TS usada.
long int tope = -1;

// Tipo auxiliar para declaración de variables
TipoDato tipoTmp = desconocido;

// Si entramos en un bloque de un subprograma
// Si es 0 es un bloque de un subprograma; en caso contrario no
int subProg = 0;

typedef struct {
  int atributo;
  char* lexema;
  TipoDato dtipo;
} Atributos;

char* tipoAString(TipoDato td) {
  switch (td) {
    case real:
      return "real";
    case entero:
      return "entero";
    case booleano:
      return "booleano";
    case caracter:
      return "caracter";
    default:
      return "error";
  }
}

void imprimir() {
  for (int i = 0; i <= tope; ++i)
    switch(ts[i].tipoEntrada) {
      case variable:
        printf("Variable %s\n", ts[i].nombre);
        break;
      case funcion:
        printf("Funcion %s\n", ts[i].nombre);
        break;
      case marca:
        printf("Marca\n");
        break;
      case parametroFormal:
        printf("Parametro formal %s\n", ts[i].nombre);
        break;
      default:
        printf("error\n");
        break;
    }
}

void idRepetida(char* id) {
  // Miramos si id estaba declarado después de la última marca
  for (int i = tope; ts[i].tipoEntrada != marca; --i) {
    if (!ts[i].tipoEntrada != parametroFormal && !strcmp(ts[i].nombre, id)) {
      fprintf(stderr, "[%d] Error: identificador %s ya declarado\n", yylineno, id);
      fflush(stderr);
      exit(EXIT_FAILURE);
    }
  }
}

void insertarEntrada(EntradaTS entrada) {
  // Si la tabla está llena da error
  if (tope + 1 >= MAX_TAM_TS) {
    fprintf(stderr, "[%d] Error: La tabla de símbolos está llena\n", yylineno);
    fflush(stderr);
    exit(EXIT_FAILURE);
  }
  // Aumentamos el tope
  ++tope;
  // Añadimos la ueva entrada
  ts[tope] = entrada;
}

/****************/
/* FUNCIONES TS */
/****************/

void insertarMarca() {
  // Ponemos una marca al inicio del bloque
  EntradaTS marcaBloque = { marca, "", desconocido, -1 };
  // Metemos la entrada
  insertarEntrada(marcaBloque);
  // Si es subprograma añadimos las variables al bloque
  if (subProg) {
    for (int i = tope - 1; ts[i].tipoEntrada != funcion; --i) {
      EntradaTS entrada = { variable, ts[i].nombre, ts[i].tipoDato, -1 };
      insertarEntrada(entrada);
    }
  }
}

void vaciarEntradas() {
  // Hasta la última marca borramos todo
  while (ts[tope].tipoEntrada != marca)
    --tope;
  // Elimina la última marca
  --tope;
}

void insertarVariable(char* id) {
  // Comprobamos que no esté repetida la id
  idRepetida(id);
  // Si no está duplicado añadimos la entrada
  EntradaTS entrada = { variable, strdup(id), tipoTmp, -1 };
  insertarEntrada(entrada);
}

void insertarFuncion(TipoDato tipoDato, char* id) {
  // Comprobamos que el id no esté usado ya
  idRepetida(id);
  // Añadimos la entrada
  EntradaTS entrada = { funcion, strdup(id), tipoDato, 0 };
  insertarEntrada(entrada);
}

void insertarParametro(TipoDato tipoDato, char* id) {
  // Comprobamos que no haya parámetros con nombres repetidos
  // Además guardamos el índice de la función
  int i;
  for (i = tope; ts[i].tipoEntrada != funcion; --i) {
    if (!strcmp(ts[i].nombre, id)) {
      fprintf(stderr, "[%d] Error: parámetro %s ya declarado\n", yylineno, id);
      fflush(stderr);
      exit(EXIT_FAILURE);
    }
  }
  // Añadimos la entrada
  EntradaTS entrada = { parametroFormal, strdup(id), tipoDato, -1};
  insertarEntrada(entrada);
  // Actualizamos el nº de parámetros de la función
  ++ts[i].parametros;
}

void comprobarTipo(Atributos atr, TipoDato td) {
  if (atr.dtipo != td) {
    fprintf(stderr, "[%d] Error: %s es tipo %s, se esperaba %s\n", yylineno, atr.lexema, tipoAString(atr.dtipo), tipoAString(td));
  }
}


#define YYSTYPE Atributos
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

bloque : INIBLOQUE { insertarMarca(); }
         declar_de_variables_locales
         declar_de_subprogs sentencias
         FINBLOQUE { vaciarEntradas(); } ;

declar_de_variables_locales : LOCAL INIBLOQUE variables_locales FINBLOQUE
                            | %empty ;

variables_locales : variables_locales cuerpo_declar_variables
                  | cuerpo_declar_variables ;

cuerpo_declar_variables : TIPO { tipoTmp = $1.dtipo; } lista_variables PYC
                        | error ;

lista_variables : ID COMA lista_variables { insertarVariable($1.lexema); }
                | ID { insertarVariable($1.lexema); } ;

lista_expresiones : lista_expresiones COMA expresion
                  | expresion ;

declar_de_subprogs : declar_de_subprogs declar_subprog
                   | %empty ;

declar_subprog : cabecera_subprog { subProg = 1; }
                 bloque           { subProg = 0; };

cabecera_subprog : TIPO ID { insertarFuncion($1.dtipo, $2.lexema); } PARIZQ cabecera_argumentos PARDER ;

cabecera_argumentos : parametros
                    | %empty
                    | error ;

parametros : parametros COMA parametro
           | parametro ;

parametro : TIPO ID { insertarParametro($1.dtipo, $2.lexema); };

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

sentencia_asignacion : ID ASIGN expresion PYC { comprobarTipo($1, $3.dtipo); } ;

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

expresion : PARIZQ expresion PARDER { $$.dtipo = $2.dtipo; }
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
          | ID { $$.dtipo = $1.dtipo; }
          | constante { $$.dtipo = $1.dtipo; }
          | error ;

llamada_funcion : ID PARIZQ argumentos PARDER ;

argumentos : lista_expresiones
           | %empty ;

constante : CONST { $$.dtipo = $1.dtipo; }
          | lista ;

lista : CORIZQ lista_expresiones CORDER
      | CORIZQ CORDER ;

%%

#include "lex.yy.c"

void yyerror(const char *msg){
  fprintf(stderr, "[Linea %d]: %s\n", yylineno, msg);
}

int main(){
  yyparse();

  return 0;
}
