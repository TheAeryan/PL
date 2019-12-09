%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define YYERROR_VERBOSE

void yyerror( const char * msg );

#define MAX_TAM_TS 500

extern int yylineno;

// Esto elimina un Warning, no debería cambiar nada más.
int yylex();

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
  listaCaracter
} TipoDato;

typedef struct {
  TipoEntrada tipoEntrada;    // Tipo de entrada
  char* nombre;               // Nombre del identificador (no se usa con marca)
  TipoDato tipoDato;          // Tipo de dato
  int parametros;             // Nº de parámetros formales (sólo se usa con función)
} EntradaTS;

// La Tabla de Símbolos
EntradaTS ts[MAX_TAM_TS];

// Última entrada de la TS usada.
long int tope = -1;

// Tipo auxiliar para declaración de variables
TipoDato tipoTmp;

// Si entramos en un bloque de un subprograma
// Si es 0 es un bloque de un subprograma; en caso contrario no
int subProg = 0;

// Variables usadas para pasar argumentos a una función
#define MAX_ARGS 50
TipoDato argumentos_tipo_datos[MAX_ARGS];
int n_argumentos = 0;

typedef struct {
  int atributo;
  char* lexema;
  TipoDato dtipo;
} Atributos;

char* tipoAString(TipoDato tipo_dato) {
  switch (tipo_dato) {
    case real:
      return "float";
    case entero:
      return "int";
    case booleano:
      return "bool";
    case caracter:
      return "char";
    case listaReal:
      return "list_of float";
    case listaEntero:
      return "list_of int";
    case listaCaracter:
      return "list_of char";
    case listaBooleano:
      return "list_of bool";
    default:
      return "error";
  }
}

TipoDato tipoLista(TipoDato tipo_dato) {
  switch (tipo_dato) {
    case listaEntero:
      return entero;
    case listaCaracter:
      return caracter;
    case listaBooleano:
      return booleano;
    case listaReal:
      return real;
    default:
      fprintf(stderr, "Error en tipoLista(), tipo no es lista.\n");
      exit(EXIT_FAILURE);
  }
}

int esLista(TipoDato tipo_dato) {
  return tipo_dato == listaEntero || tipo_dato == listaReal
          || tipo_dato == listaBooleano || tipo_dato == listaCaracter;
}

void imprimir() {
  for (int i = 0; i <= tope; ++i) {
    printf("[%i]: ", i);
    switch(ts[i].tipoEntrada) {
      case variable:
        printf("Variable %s, tipo: %s\n", ts[i].nombre,
            tipoAString(ts[i].tipoDato));
        break;
      case funcion:
        printf("Funcion %s, tipo: %s, nº parametros: %i\n", ts[i].nombre,
            tipoAString(ts[i].tipoDato), ts[i].parametros);
        break;
      case marca:
        printf("Marca\n");
        break;
      case parametroFormal:
        printf("Parametro formal %s, tipo: %s\n", ts[i].nombre,
            tipoAString(ts[i].tipoDato));
        break;
      default:
        printf("error\n");
        break;
    }
  }
}

void idRepetida(char* id) {
  // Miramos si id estaba declarado después de la última marca
  for (int i = tope; ts[i].tipoEntrada != marca; --i) {
    if (ts[i].tipoEntrada != parametroFormal && !strcmp(ts[i].nombre, id)) {
      fprintf(stderr, "[%d] Error: identificador %s ya declarado\n", yylineno, id);
      fflush(stderr);
      exit(EXIT_FAILURE);
    }
  }
}

void insertarEntrada(TipoEntrada te, char* nombre, TipoDato tipo_dato, int nParam) {
  // Hacemos la entrada
  EntradaTS entrada = {
    te,
    strdup(nombre),
    tipo_dato,
    nParam
  };

  // Si la tabla está llena da error
  if (tope + 1 >= MAX_TAM_TS) {
    fprintf(stderr, "[%d] Error: La tabla de símbolos está llena\n", yylineno);
    fflush(stderr);
    exit(EXIT_FAILURE);
  }
  // Aumentamos el tope
  ++tope;
  // Añadimos la nueva entrada
  ts[tope] = entrada;
}

// Busca una entrada en la TS con el id especificado en el ámbito del programa
// actual. Si no lo encuentra, devuelve -1. No gestiona errores!
int buscarEntrada(char* id) {
  int i;
  int noEncontrado = 0;
  for (i = tope; i >= 0; --i) {
    if (ts[i].tipoEntrada != parametroFormal && !strcmp(id, ts[i].nombre)) {
      break;
    }
  }
  return i;
}

// Busca una entrada en la TS con el id especificado en el ámbito del programa actual,
// que además sea de tipo variable. Gestiona errores.
int buscarEntradaVariable(char* id) {
  int i = buscarEntrada(id);
  if (i < 0 || ts[i].tipoEntrada != variable) {
    fprintf(stderr, "[%d] Error: variable %s no declarada\n", yylineno, id);
    exit(EXIT_FAILURE);
  }
  return i;
}

int buscarEntradaFuncion(char* id) {
  int i = buscarEntrada(id);
  if (i < 0 || ts[i].tipoEntrada != funcion) {
    fprintf(stderr, "[%d] Error: función %s no declarada\n", yylineno, id);
    exit(EXIT_FAILURE);
  }
  return i;
}

/****************/
/* FUNCIONES TS */
/****************/

void insertarMarca() {
  // Metemos la marca
  insertarEntrada(marca, "", -1, -1);
  // Si es subprograma añadimos las variables al bloque
  if (subProg) {
    for (int i = tope - 1; ts[i].tipoEntrada != funcion; --i) {
      insertarEntrada(variable, ts[i].nombre, ts[i].tipoDato, -1);
    }
    subProg = 0;
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
  insertarEntrada(variable, id, tipoTmp, -1);
}

void insertarFuncion(TipoDato tipoDato, char* id) {
  // Comprobamos que el id no esté usado ya
  idRepetida(id);
  // Añadimos la entrada
  insertarEntrada(funcion, id, tipoDato, 0);
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
  insertarEntrada(parametroFormal, id, tipoDato, -1);
  // Actualizamos el nº de parámetros de la función
  ++ts[i].parametros;
}

void comprobarAsignacion(char* id, TipoDato td) {
  TipoDato tdID = ts[buscarEntradaVariable(id)].tipoDato;
  if (tdID != td) {
    fprintf(stderr, "[%d] Error: asignación incorrecta, %s es tipo %s y se obtuvo %s\n",
        yylineno, id, tipoAString(tdID), tipoAString(td));
    exit(EXIT_FAILURE);
  }
}

void expresionBooleana(TipoDato td) {
  if (td != booleano) {
    fprintf(stderr, "[%d] Error: condición no es de tipo booleano, se tiene tipo %s",
        yylineno, tipoAString(td));
    exit(EXIT_FAILURE);
  }
}

void sentenciaLista(TipoDato td, char* sentencia) {
  if (!esLista(td)) {
    fprintf(stderr, "[%d] Error: sentencia %s no aplicable al tipo %s\n",
        yylineno, sentencia, tipoAString(td));
    exit(EXIT_FAILURE);
  }
}

TipoDato mismoTipoLista(TipoDato t1, TipoDato t2) {
  if (t1 != t2) {
    fprintf(stderr, "[%d] Error: lista dos tipos de tipo %s y %s\n",
        yylineno, tipoAString(t1), tipoAString(t2));
    exit(EXIT_FAILURE);
  }
  return t1;
}

TipoDato aTipoLista(TipoDato td) {
  switch (td) {
    case entero:
      return listaEntero;
    case real:
      return listaReal;
    case caracter:
      return listaCaracter;
    case booleano:
      return listaBooleano;
    default:
      fprintf(stderr, "Error en tipoLista(), tipo no es lista.\n");
      exit(EXIT_FAILURE);
  }
}

TipoDato masMenos(int atr, TipoDato td) {
  char* operador = atr ? "-" : "+";
  if (td != real && td != entero) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable al tipo %s\n",
        yylineno, operador, tipoAString(td));
    exit(EXIT_FAILURE);
  }

  return td;
}

TipoDato excl(TipoDato td) {
  if (td != booleano) {
    fprintf(stderr, "[%d] Error: operador ! no aplicable al tipo %s\n",
        yylineno, tipoAString(td));
    exit(EXIT_FAILURE);
  }

  return booleano;
}

TipoDato intHash(int atr, TipoDato td) {
  char* operador = atr ? "#" : "?";
  if (!esLista(td)) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable al tipo %s\n",
        yylineno, operador, tipoAString(td));
    exit(EXIT_FAILURE);
  }
  if (atr)
    return tipoLista(td);
  else
    return entero;
}

TipoDato at(TipoDato td1, TipoDato td2) {
  if (!esLista(td1) || td2 != entero) {
    fprintf(stderr, "[%d] Error: operador @ no aplicable a los tipos %s, %s\n",
        yylineno, tipoAString(td1), tipoAString(td2));
    exit(EXIT_FAILURE);
  }

  return tipoLista(td1);
}

TipoDato andLog(TipoDato td1, TipoDato td2) {
  if (td1 != booleano || td2 != booleano) {
    fprintf(stderr, "[%d] Error: operador && no aplicable a los tipos %s, %s\n",
        yylineno, tipoAString(td1), tipoAString(td2));
    exit(EXIT_FAILURE);
  }
  return booleano;
}

TipoDato orLog(TipoDato td1, TipoDato td2) {
  if (td1 != booleano || td2 != booleano) {
    fprintf(stderr, "[%d] Error: operador || no aplicable a los tipos %s, %s\n",
        yylineno, tipoAString(td1), tipoAString(td2));
    exit(EXIT_FAILURE);
  }

  return booleano;
}

TipoDato eqn(TipoDato td1, int atr, TipoDato td2) {
  char* operador = atr ? "!=" : "==";
  if (td1 != td2) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n",
        yylineno, operador, tipoAString(td1), tipoAString(td2));
    exit(EXIT_FAILURE);
  }
  return booleano;
}

TipoDato porPor(TipoDato td1, TipoDato td2) {
  if (td1 != td2 || !esLista(td1) || !esLista(td2)) {
    fprintf(stderr, "[%d] Error: operador ** no aplicable a los tipos %s, %s\n",
        yylineno, tipoAString(td1), tipoAString(td2));
    exit(EXIT_FAILURE);
  }

  return td1;
}

TipoDato borrList(TipoDato td1, int atr, TipoDato td2) {
  char* operador = atr ? "%" : "--";
  if (!esLista(td1) || td2 != entero) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n",
        yylineno, operador, tipoAString(td1), tipoAString(td2));
    exit(EXIT_FAILURE);
  }

  return td1;
}

TipoDato rel(TipoDato td1, int atr, TipoDato td2) {
  char* operador;
  switch (atr) {
    case 0:
      operador = "<";
      break;
    case 1:
      operador = ">";
      break;
    case 2:
      operador = "<=";
      break;
    case 3:
      operador = ">=";
      break;
  }
  if (td1 != td2 || (td1 != real && td1 != entero) || (td2 != real && td2 != entero)) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n",
        yylineno, operador, tipoAString(td1), tipoAString(td2));
    exit(EXIT_FAILURE);
  }

  return booleano;
}

TipoDato ternario(TipoDato td1, TipoDato td2, TipoDato td3) {
  if (!esLista(td1) || tipoLista(td1) != td2 || td3 != entero) {
    fprintf(stderr, "[%d] Error: operador ++ @ no aplicable a los tipos %s, %s, %s\n",
        yylineno, tipoAString(td1), tipoAString(td2), tipoAString(td3));
    exit(EXIT_FAILURE);
  }

  return td1;
}

void comprobarReturn(TipoDato td) {
  int i = tope;
  int marcaEncontrada = 0;
  int funcionEncontrada = 0;

  while (i >= 1 && !funcionEncontrada) {
    funcionEncontrada = marcaEncontrada && ts[i].tipoEntrada == funcion;
    marcaEncontrada = (!marcaEncontrada && ts[i].tipoEntrada == marca) ||
                      (marcaEncontrada && ts[i].tipoEntrada == parametroFormal);
    --i;
  }

  if (funcionEncontrada) ++i;

  if (i <= 0) {
    fprintf(stderr, "[%d] Error: return no asignado a ninguna función\n", yylineno);
    exit(EXIT_FAILURE);
  }

  if (td != ts[i].tipoDato) {
    fprintf(stderr, "[%d] Error: return devuelve tipo %s, y función es de tipo %s\n",
        yylineno, tipoAString(td), tipoAString(ts[i].tipoDato));
    exit(EXIT_FAILURE);
  }
}

TipoDato comprobarFuncion(char* id) {
  int iFuncion = buscarEntradaFuncion(id);
  int n_argumentos_esperados = ts[iFuncion].parametros;
  int error = 0;

  if ( n_argumentos != n_argumentos_esperados ) {
    fprintf(stderr, "[%d] Error: número de argumentos errónea al llamar a la función %s. Esperados: %d, encontrados: %d\n",
        yylineno, id, n_argumentos_esperados, n_argumentos);
    error = 1;
  }

  if (n_argumentos_esperados < n_argumentos)
    n_argumentos = n_argumentos_esperados;
  for (int i=0; i<n_argumentos; i++) {
    TipoDato tipoEsperado = ts[iFuncion + i + 1].tipoDato;
    TipoDato tipoObtenido = argumentos_tipo_datos[i];
    if ( tipoEsperado != tipoObtenido ) {
      fprintf(stderr, "[%d] Error: argumento número %d de tipo erróneo al llamar a la función %s. Esperado: %s, encontrado: %s\n",
          yylineno, i, id, tipoAString(tipoEsperado), tipoAString(tipoObtenido));
      error = 1;
    }
  }

  // De esta forma mostramos el máximo número de errores posibles.
  if (error) {
    exit(EXIT_FAILURE);
  }

  // Borramos los argumentos recibidos.
  n_argumentos = 0;

  // Devolvemos el tipo de la función.
  return ts[iFuncion].tipoDato;
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
         declar_de_subprogs
         sentencias
         FINBLOQUE { vaciarEntradas(); } ;

declar_de_variables_locales : LOCAL INIBLOQUE variables_locales FINBLOQUE
                            | %empty ;

variables_locales : variables_locales cuerpo_declar_variables
                  | cuerpo_declar_variables ;

cuerpo_declar_variables : TIPO { tipoTmp = $1.dtipo; } lista_variables PYC
                        | error ;

lista_variables : ID COMA lista_variables { insertarVariable($1.lexema); }
                | ID { insertarVariable($1.lexema); } ;

declar_de_subprogs : declar_de_subprogs declar_subprog
                   | %empty ;

declar_subprog : cabecera_subprog { subProg = 1; }
                 bloque ;

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

sentencia_asignacion : ID ASIGN expresion PYC { comprobarAsignacion($1.lexema, $3.dtipo); } ;

sentencia_lista : expresion SHIFT PYC { sentenciaLista($1.dtipo, $2.lexema); }
                | DOLLAR expresion PYC { sentenciaLista($2.dtipo, $1.lexema); } ;

sentencia_if : IF PARIZQ expresion PARDER sentencia bloque_else { expresionBooleana($3.dtipo); } ;

bloque_else : ELSE sentencia
            | %empty ;

sentencia_while : WHILE PARIZQ expresion PARDER sentencia { expresionBooleana($3.dtipo); } ;

sentencia_entrada : CIN lista_id PYC ;

lista_id : lista_id COMA ID
         | ID ;

sentencia_salida : COUT lista_expresiones_o_cadena PYC ;

lista_expresiones_o_cadena : lista_expresiones_o_cadena COMA expresion_cadena
                           | expresion_cadena ;

expresion_cadena : expresion
                 | CADENA ;

sentencia_do_until : DO sentencia UNTIL PARIZQ expresion PARDER PYC { expresionBooleana($5.dtipo); };

sentencia_return : RETURN expresion PYC { comprobarReturn($2.dtipo); } ;

expresion : PARIZQ expresion PARDER                  { $$.dtipo = $2.dtipo; }
          | ADDSUB expresion %prec EXCL              { $$.dtipo = masMenos($1.atributo, $2.dtipo); }
          | EXCL expresion                           { $$.dtipo = excl($2.dtipo); }
          | INTHASH expresion                        { $$.dtipo = intHash($1.atributo, $2.dtipo); }
          | expresion AT expresion                   { $$.dtipo = at($1.dtipo, $3.dtipo); }
          | expresion ANDLOG expresion               { $$.dtipo = andLog($1.dtipo, $3.dtipo); }
          | expresion ORLOG expresion                { $$.dtipo = orLog($1.dtipo, $3.dtipo); }
          | expresion EQN expresion                  { $$.dtipo = eqn($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion ADDSUB expresion               { $$.dtipo = $1.dtipo; }
          | expresion MULDIV expresion               { $$.dtipo = $1.dtipo; }
          | expresion PORPOR expresion               { $$.dtipo = porPor($1.dtipo, $3.dtipo); }
          | expresion BORRLIST expresion             { $$.dtipo = borrList($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion REL expresion                  { $$.dtipo = rel($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion MASMAS expresion AT expresion  { $$.dtipo = ternario($1.dtipo, $3.dtipo, $5.dtipo); }
          | llamada_funcion                          { $$.dtipo = $1.dtipo; }
          | ID                                       { $$.dtipo = ts[buscarEntradaVariable($1.lexema)].tipoDato; }
          | constante                                { $$.dtipo = $1.dtipo; }
          | error ;

llamada_funcion : ID PARIZQ argumentos PARDER { $$.dtipo = comprobarFuncion($1.lexema); } ;

argumentos : lista_argumentos
           | %empty ;

lista_argumentos : lista_argumentos COMA expresion {
                    argumentos_tipo_datos[n_argumentos] = $3.dtipo;
                    n_argumentos++;
                  }
                 | expresion {
                    argumentos_tipo_datos[n_argumentos] = $1.dtipo;
                    n_argumentos++;
                  }

constante : CONST { $$.dtipo = $1.dtipo; }
          | lista { $$.dtipo = $1.dtipo; } ;

lista : CORIZQ lista_expresiones CORDER { $$.dtipo = aTipoLista($2.dtipo); } ;

lista_expresiones : lista_expresiones COMA expresion { $$.dtipo = mismoTipoLista($1.dtipo, $3.dtipo);  }
                  | expresion { $$.dtipo = $1.dtipo; };

%%

#include "lex.yy.c"

void yyerror(const char *msg){
  fprintf(stderr, "[Linea %d]: %s\n", yylineno, msg);
}

int main(){
  yyparse();

  return 0;
}
