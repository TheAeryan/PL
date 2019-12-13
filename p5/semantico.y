%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define YYERROR_VERBOSE

FILE* yyout;

#define min(a, b) ({ __typeof__ (a) _a = (a); __typeof__ (b) _b = (b); _a < _b ? _a : _b; })
#define max(a, b) ({ __typeof__ (a) _a = (a); __typeof__ (b) _b = (b); _a > _b ? _a : _b; })

void yyerror( const char * msg );

#define MAX_TAM_TS 500

extern int yylineno;


char msgError[256];

// Esto elimina un Warning, no debería cambiar nada más.
int yylex();

/************************/
/* ESTRUCTURA DE LA TS */
/***********************/

// Para bucles if
typedef struct {
  char* etiquetaEntrada;
  char* etiquetaSalida;
  char* etiquetaElse;
} DescriptorDeInstrControl;

// Tipo de entrada
typedef enum {
  marca,
  funcion,
  variable,
  parametroFormal,
  descriptor
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
  error // Si da un error con expresiones
} TipoDato;

typedef struct {
  TipoEntrada tipoEntrada;    // Tipo de entrada
  char* nombre;               // Nombre del identificador (no se usa con marca)
  TipoDato tipoDato;          // Tipo de dato
  int parametros;             // Nº de parámetros formales (sólo se usa con función)
  DescriptorDeInstrControl* descriptor; // Descriptor de control (bucles IF - intermedio)
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
    case error:
      return "error";
    default:
      fprintf(stderr, "Error en tipoAString(), no se conoce el tipo dato\n");
      exit(EXIT_FAILURE);
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
    case error:
      return error;
    default:
      fprintf(stderr, "Error en tipoLista(), tipo no es lista.\n");
      exit(EXIT_FAILURE);
  }
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
    case error:
      return error;
    default:
      fprintf(stderr, "Error en tipoLista(), tipo no es lista.\n");
      exit(EXIT_FAILURE);
  }
}

char* tipoOp(TipoDato td, char * op) {
  if (!strcmp(op, "+") || !strcmp(op, "-") || !strcmp(op, "*") || !strcmp(op, "/") ||
        !strcmp(op, "**") || !strcmp(op, "--") || !strcmp(op, "%"))
    return tipoAString(td);

  if (!strcmp(op, "!") || !strcmp(op, "&&") || !strcmp(op, "||") || !strcmp(op, ">") || !strcmp(op, "?") ||
        !strcmp(op, "<") || !strcmp(op, ">=") || !strcmp(op, "<=") || !strcmp(op, "!=") || !strcmp(op, "=="))
    return "int";

  if (!strcmp(op, "#") || !strcmp(op, "@"))
    return tipoAString(tipoLista(td));
}

int esLista(TipoDato tipo_dato){
  return tipo_dato == listaEntero || tipo_dato == listaReal || tipo_dato == listaBooleano || tipo_dato == listaCaracter;
}

int esNumero(TipoDato tipo_dato){
  return tipo_dato == entero || tipo_dato == real;
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
        fprintf(stderr, "Error en imprimir(), no debería salir\n");
        exit(EXIT_FAILURE);
    }
  }
}

void idRepetida(char* id) {
  // Miramos si id estaba declarado después de la última marca
  int repetida = 0;
  for (int i = tope; !repetida && ts[i].tipoEntrada != marca; --i) {
    if (ts[i].tipoEntrada != parametroFormal && !strcmp(ts[i].nombre, id)) {
      sprintf(msgError, "ERROR SINTÁCTICO: identificador %s ya declarado\n", id);
      yyerror(msgError);
      repetida = 1;
    }
  }
}

void insertarEntrada(TipoEntrada te, char* nombre, TipoDato tipo_dato, int nParam, DescriptorDeInstrControl* descp) {
  // Hacemos la entrada
  EntradaTS entrada = {
    te,
    strdup(nombre),
    tipo_dato,
    nParam,
    descp
  };

  // Si la tabla está llena da error
  if (tope + 1 >= MAX_TAM_TS) {
    sprintf(msgError, "ERROR SINTÁCTICO: La tabla de símbolos está llena\n");
    yyerror(msgError);
  }
  // Aumentamos el tope
  ++tope;
  // Añadimos la nueva entrada
  ts[tope] = entrada;
}

// Busca una entrada en la TS con el id especificado en el ámbito del programa
// actual. Si no lo encuentra, devuelve -1. No gestiona errores!
int buscarEntrada(char* id) {
  int i = tope;
  while(i >= 0 && (ts[i].tipoEntrada == parametroFormal || strcmp(id, ts[i].nombre)))
    --i;

  if (i < 0) {
    sprintf(msgError, "ERROR SINTÁCTICO: identificador %s no declarado\n", id);
    yyerror(msgError);
  }
  return i;
}

/****************/
/* FUNCIONES TS */
/****************/

void insertarMarca() {
  // Metemos la marca
  insertarEntrada(marca, "", -1, -1, NULL);
  // Si es subprograma añadimos las variables al bloque
  if (subProg) {
    for (int i = tope - 1; ts[i].tipoEntrada != funcion; --i) {
      insertarEntrada(variable, ts[i].nombre, ts[i].tipoDato, -1, NULL);
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
  insertarEntrada(variable, id, tipoTmp, -1, NULL);
}

void insertarFuncion(TipoDato tipoDato, char* id) {
  // Comprobamos que el id no esté usado ya
  idRepetida(id);
  insertarEntrada(funcion, id, tipoDato, 0, NULL);
}


void insertarDescriptor(char* etqEntrada, char* etqSalida, char* etqElse) {
  DescriptorDeInstrControl* descp = (DescriptorDeInstrControl*) malloc(sizeof(DescriptorDeInstrControl));
  descp->etiquetaEntrada = strdup(etqEntrada);
  descp->etiquetaSalida = strdup(etqSalida);
  descp->etiquetaElse = strdup(etqElse);
  insertarEntrada(descriptor, "", -1, -1, descp);
}


void insertarParametro(TipoDato tipoDato, char* id) {
  // Comprobamos que no haya parámetros con nombres repetidos
  // Además guardamos el índice de la función
  int i;
  int parametroRepetido = 0;
  for (i = tope; !parametroRepetido && ts[i].tipoEntrada != funcion; --i) {
    if (!strcmp(ts[i].nombre, id)) {
      sprintf(msgError, "ERROR SINTÁCTICO: identificador del parámetro %s ya declarado\n", id);
      yyerror(msgError);
      parametroRepetido = 1;
    }
  }
  // Añadimos la entrada
  insertarEntrada(parametroFormal, id, tipoDato, -1, NULL);
  // Actualizamos el nº de parámetros de la función
  ++ts[i].parametros;
}

TipoDato buscarID(char* id) {
  int i = buscarEntrada(id);

  if (i < 0)
    return error;
  return ts[i].tipoDato;
}

void comprobarAsignacion(char* id, TipoDato td) {
  int i = buscarEntrada(id);
  if (i >= 0) {
    if (ts[i].tipoEntrada != variable) {
      sprintf(msgError, "ERROR SINTÁCTICO: se intenta asignar a %s, y no es una variable\n", id);
      yyerror(msgError);
    } else {
      if (td != error && td != ts[i].tipoDato) {
        sprintf(msgError, "ERROR SINTÁCTICO: asignación incorrecta, %s es tipo %s y se obtuvo %s\n",
            id, tipoAString(td), tipoAString(td));
        yyerror(msgError);
      }
    }
  }
}

void expresionBooleana(TipoDato td) {
  if (td != error && td != booleano) {
    sprintf(msgError, "ERROR SINTÁCTICO: condición no es de tipo booleano, se tiene tipo %s",
        tipoAString(td));
    yyerror(msgError);
  }
}

void sentenciaLista(TipoDato td, char* sentencia) {
  if (td != error && !esLista(td)) {
    sprintf(msgError, "ERROR SINTÁCTICO: sentencia %s no aplicable al tipo %s\n",
        sentencia, tipoAString(td));
    yyerror(msgError);
  }
}

TipoDato mismoTipoLista(TipoDato t1, TipoDato t2) {

  if (t1 == error || t2 == error)
    return error;

  if (t1 != t2) {
    sprintf(msgError, "ERROR SINTÁCTICO: lista con dos tipos distintos %s y %s\n",
        tipoAString(t1), tipoAString(t2));
    yyerror(msgError);
    return error;
  }
  return t1;
}

TipoDato masMenos(int atr, TipoDato td) {
  if (td == error)
    return error;

  char* operador = atr ? "-" : "+";
  if (!esNumero(td)) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador %s no aplicable al tipo %s\n",
        operador, tipoAString(td));
    yyerror(msgError);
    return error;
  }
  return td;
}

TipoDato excl(TipoDato td) {
  if (td == error)
    return error;
  if (td != booleano) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador ! no aplicable al tipo %s\n",
        tipoAString(td));
    yyerror(msgError);
    return error;
  }
  return booleano;
}

TipoDato intHash(int atr, TipoDato td) {
  if (td == error)
    return error;

  char* operador = atr ? "#" : "?";
  if (!esLista(td)) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador %s no aplicable al tipo %s\n",
        operador, tipoAString(td));
    yyerror(msgError);
    return error;
  }

  if (atr)
    return tipoLista(td);
  else
    return entero;
}

TipoDato at(TipoDato td1, TipoDato td2) {
  if (td1 == error || td2 == error)
    return error;

  if (!esLista(td1) || td2 != entero) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador @ no aplicable a los tipos %s, %s\n",
        tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }

  return tipoLista(td1);
}

TipoDato andLog(TipoDato td1, TipoDato td2) {
  if (td1 == error || td2 == error)
    return error;

  if (td1 != booleano || td2 != booleano) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador && no aplicable a los tipos %s, %s\n",
        tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }

  return booleano;
}

TipoDato orLog(TipoDato td1, TipoDato td2) {
  if (td1 == error || td2 == error)
    return error;

  if (td1 != booleano || td2 != booleano) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador || no aplicable a los tipos %s, %s\n",
        tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }

  return booleano;
}

TipoDato eqn(TipoDato td1, int atr, TipoDato td2) {
  if (td1 == error || td2 == error)
    return error;

  char* operador = atr ? "!=" : "==";
  if (td1 != td2) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador %s no aplicable a los tipos %s, %s\n",
        operador, tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }

  return booleano;
}

// Comprueba el tipo de la operación binaria realizada. En caso de error, lo
// gestiona. En caso contrario, devuelve el tipo tras la operación binaria.
// IMPORTANTE: Se asume que op1 esta asociado al valor 1 del atributo (atr)
// mientras que op2 está asociado al valor 0.
// IMPORTANE: Se asume que el op1 es simétrico y que el op2 no es simétrico y
// unicamente funciona de la forma "T op2 T" o bien "list_of T op2 T".
TipoDato op2Binario(TipoDato td1, int atr, TipoDato td2, char* op1, char* op2) {
  if (td1 == error || td2 == error)
    return error;

  char* operador = atr ? op1 : op2;
  int l1 = esLista(td1);
  int l2 = esLista(td2);
  TipoDato tipo1 = l1 ? tipoLista(td1) : td1;
  TipoDato tipo2 = l2 ? tipoLista(td2) : td2;

  int op_error = (l1 && l2) ||
              (tipo1 != tipo2) ||
              !esNumero(tipo1);

  TipoDato resultado = td1;

  if (!op_error && (l1 || l2) ) {
    // Llegado a este punto hay exactamente una lista. Vemos si el tipo de
    // la lista encaja con el tipo del otro atributo:
    if ( (operador == op2) || l1 ) {
      resultado = l1 ? td1 : td2;
    } else {
      op_error = 1;
    }
  }

  if (op_error) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador %s no aplicable a los tipos %s, %s\n",
        operador, tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }
  return resultado;
}

TipoDato addSub(TipoDato td1, int atr, TipoDato td2) {
  return op2Binario(td1, atr, td2, "-", "+");
}

TipoDato porDiv(TipoDato td1, int atr, TipoDato td2) {
  return op2Binario(td1, atr, td2, "/", "*");
}

TipoDato porPor(TipoDato td1, TipoDato td2) {
  if (td1 == error || td2 == error)
    return error;

  if (td1 != td2 || !esLista(td1) || !esLista(td2)) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador ** no aplicable a los tipos %s, %s\n",
        tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }

  return td1;
}

TipoDato borrList(TipoDato td1, int atr, TipoDato td2) {
  if (td1 == error || td2 == error)
    return error;

  char* operador = atr ? "%" : "--";
  if (!esLista(td1) || td2 != entero) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador %s no aplicable a los tipos %s, %s\n",
        operador, tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }

  return td1;
}

TipoDato rel(TipoDato td1, int atr, TipoDato td2) {
  if (td1 == error || td2 == error)
    return error;

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

  if (td1 != td2 || !esNumero(td1) || !esNumero(td2)) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador %s no aplicable a los tipos %s, %s\n",
        operador, tipoAString(td1), tipoAString(td2));
    yyerror(msgError);
    return error;
  }

  return booleano;
}

TipoDato ternario(TipoDato td1, TipoDato td2, TipoDato td3) {
  if (td1 == error || td2 == error || td3 == error)
    return error;

  if (!esLista(td1) || tipoLista(td1) != td2 || td3 != entero) {
    sprintf(msgError, "ERROR SINTÁCTICO: operador ++ @ no aplicable a los tipos %s, %s, %s\n",
        yylineno, tipoAString(td1), tipoAString(td2), tipoAString(td3));
    yyerror(msgError);
    return error;
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
    sprintf(msgError, "ERROR SINTÁCTICO: return no asignado a ninguna función\n");
    yyerror(msgError);
  } else if (td != error && td != ts[i].tipoDato) {
    sprintf(msgError, "ERROR SINTÁCTICO: return devuelve tipo %s, y función es de tipo %s\n",
        tipoAString(td), tipoAString(ts[i].tipoDato));
    yyerror(msgError);
  }
}

TipoDato comprobarFuncion(char* id) {
  int iFuncion = buscarEntrada(id);

  if (iFuncion < 0)
    return error;

  if (ts[iFuncion].tipoEntrada != funcion) {
    sprintf(msgError, "ERROR SINTÁCTICO: %s no es una función y no puede ser llamada\n", id);
    yyerror(msgError);
    return error;
  }

  int n_argumentos_esperados = ts[iFuncion].parametros;

  if ( n_argumentos != n_argumentos_esperados ) {
    sprintf(msgError, "ERROR SINTÁCTICO: número de argumentos errónea al llamar a la función %s. Esperados: %d, encontrados: %d\n",
        id, n_argumentos_esperados, n_argumentos);
    yyerror(msgError);
  }

  n_argumentos = min(n_argumentos, n_argumentos_esperados);

  for (int i = 0; i < n_argumentos; i++){
    TipoDato tipoEsperado = ts[iFuncion + i + 1].tipoDato;
    TipoDato tipoObtenido = argumentos_tipo_datos[i];
    if (tipoObtenido != error && tipoEsperado != tipoObtenido){
      sprintf(msgError, "ERROR SINTÁCTICO: argumento número %d de tipo erróneo al llamar a la función %s. Esperado: %s, encontrado: %s\n",
          i, id, tipoAString(tipoEsperado), tipoAString(tipoObtenido));
      yyerror(msgError);
    }
  }

  // De esta forma mostramos el máximo número de errores posibles.

  // Borramos los argumentos recibidos.
  n_argumentos = 0;

  // Devolvemos el tipo de la función.
  return ts[iFuncion].tipoDato;
}


// **********************************
// ** Generación código intermedio **
// **********************************

int hayError = 0;
int deep = 0;
int prof = 0;

#define addTab() { for (int i = 0; i < deep; ++i) fprintf(yyout, "\t"); }
#define gen(f_, ...) { if (!hayError) {addTab(); fprintf(yyout, f_, ##__VA_ARGS__); fflush(yyout);} }

char* temporal() {
  static int indice = 1;
  char* temp = malloc(sizeof(char) * 10);
  sprintf(temp, "temp%i", indice++);
  return temp;
}

char* etiqueta() {
  static int indice = 1;
  char* etiqueta = malloc(sizeof(char) * 14);
  sprintf(etiqueta, "etiqueta%i", indice++);
  return etiqueta;
}

char* leerOp(TipoDato td, char* exp1, char* op, char* exp2) {
  char* etiqueta = temporal();
  gen("%s %s;\n", tipoOp(td, op), etiqueta);
  gen("%s = %s %s %s;\n", etiqueta, exp1, op, exp2);
  return etiqueta;
}


char* leerCte(char* cte, int atr) {
  if (atr == 3) {
    if (!strcmp("true", cte))
      return "1";
    else
      return "0";
  }
  return cte;
}

char* tipoIntermedio(TipoDato td) {
  if (td == booleano)
    return "int";
  else
    return tipoAString(td);
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

bloque : INIBLOQUE { insertarMarca(); if (deep > 0) { gen("{\n"); ++deep; } }
         declar_de_variables_locales { if (deep == 0) { gen("int main()\n"); gen("{\n"); ++deep; } }
         declar_de_subprogs
         sentencias
         FINBLOQUE { vaciarEntradas(); --deep; gen("}\n\n") } ;

declar_de_variables_locales : LOCAL INIBLOQUE variables_locales FINBLOQUE { gen("\n"); }
                            | %empty ;

variables_locales : variables_locales cuerpo_declar_variables
                  | cuerpo_declar_variables ;

cuerpo_declar_variables : TIPO { tipoTmp = $1.dtipo; }
                          lista_variables PYC { gen("%s %s;\n", tipoIntermedio($1.dtipo), $3.lexema); }
                        | error ;

lista_variables : ID COMA lista_variables {
                    insertarVariable($1.lexema);
                    $$.lexema = malloc(sizeof($1.lexema) + sizeof($3.lexema) + 3);
                    sprintf($$.lexema, "%s, %s", $1.lexema, $3.lexema);
                  }
                | ID { insertarVariable($1.lexema); $$.lexema = $1.lexema; } ;

declar_de_subprogs : declar_de_subprogs declar_subprog
                   | %empty ;

declar_subprog : cabecera_subprog { subProg = 1; }
                 bloque ;

cabecera_subprog : TIPO ID { insertarFuncion($1.dtipo, $2.lexema); }
                    PARIZQ cabecera_argumentos PARDER {
                      gen("%s %s(%s)\n", tipoIntermedio($1.dtipo), $2.lexema, $5.lexema);
                    };

cabecera_argumentos : parametros { $$.lexema = $1.lexema; }
                    | %empty     { $$.lexema = ""; }
                    | error ;

parametros : parametros COMA parametro {
                $$.lexema = malloc(sizeof($1.lexema) + sizeof($3.lexema) + 3);
                sprintf($$.lexema, "%s, %s", $1.lexema, $3.lexema);
              }
            | parametro { $$.lexema = $1.lexema; } ;

parametro : TIPO ID {
              insertarParametro($1.dtipo, $2.lexema);
              $$.lexema = malloc(sizeof($1.lexema) + sizeof($2.lexema) + 2);
              sprintf($$.lexema, "%s %s", tipoIntermedio($1.dtipo), $2.lexema);
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

sentencia_asignacion : ID ASIGN { gen("{\n"); ++deep; }
                        expresion PYC {
                          comprobarAsignacion($1.lexema, $4.dtipo);
                          gen("%s = %s;\n", $1.lexema, $4.lexema);
                          --deep;
                          gen("}\n");
                       } ;

sentencia_lista : expresion SHIFT PYC { sentenciaLista($1.dtipo, $2.lexema); gen("%s %s;\n", $1.lexema, $2.lexema); }
                | DOLLAR expresion PYC { sentenciaLista($2.dtipo, $1.lexema); gen("%s %s;\n", $1.lexema, $2.lexema); } ;

sentencia_if : IF PARIZQ { gen("{\n"); ++deep; insertarDescriptor("", etiqueta(), etiqueta()); }
                expresion {
                    expresionBooleana($4.dtipo);
                    gen("if (!%s) goto %s;\n", $4.lexema, ts[tope].descriptor->etiquetaElse);
                  }
                PARDER sentencia {
                    DescriptorDeInstrControl* ds = ts[tope].descriptor;
                    gen("goto %s;\n\n", ds->etiquetaSalida);
                    gen("%s:\n", ds->etiquetaElse);
                    ++deep;
                  }
                bloque_else {
                    --deep;
                    --deep;
                    gen("}\n\n");
                    gen("%s:\n", ts[tope].descriptor->etiquetaSalida);
                    --tope;
                  };

bloque_else : ELSE sentencia
            | %empty ;

sentencia_while : WHILE PARIZQ {
                      gen("{\n");
                      ++deep;
                      insertarDescriptor(etiqueta(), etiqueta(), "");
                      gen("%s:\n", ts[tope].descriptor->etiquetaEntrada);
                      ++deep;
                    }
                  expresion {
                      expresionBooleana($4.dtipo);
                      gen("if (!%s) goto %s;\n", $4.lexema, ts[tope].descriptor->etiquetaSalida);
                    }
                  PARDER sentencia {
                      gen("goto %s;\n\n", ts[tope].descriptor->etiquetaEntrada);
                      --deep;
                      gen("%s:\n", ts[tope].descriptor->etiquetaSalida);
                      --deep;
                      gen("}\n");
                      --tope;
                    } ;

sentencia_do_until : DO {
                          gen("{\n");
                          ++deep;
                          insertarDescriptor(etiqueta(), "", "");
                          gen("%s:\n", ts[tope].descriptor->etiquetaEntrada);
                          ++deep;
                        }
                      sentencia UNTIL PARIZQ expresion {
                          expresionBooleana($6.dtipo);
                          gen("if (!%s) goto %s;\n", $6.lexema, ts[tope].descriptor->etiquetaEntrada);
                          --deep;
                          --deep;
                          gen("}\n");
                          --tope;
                        }
                      PARDER PYC ;

sentencia_entrada : CIN lista_id PYC { gen("printf()"); };

lista_id : lista_id COMA ID {
              $$.lexema = malloc(sizeof($1.lexema) + sizeof($3.lexema) + 3);
              sprintf($$.lexema, "%s, %s", $1.lexema, $3.lexema);
            }
         | ID { $$.lexema = $1.lexema; };

sentencia_salida : COUT lista_expresiones_o_cadena PYC ;

lista_expresiones_o_cadena : lista_expresiones_o_cadena COMA expresion_cadena
                           | expresion_cadena ;

expresion_cadena : expresion
                 | CADENA ;

sentencia_return : RETURN {gen("{\n"); ++deep; }
                    expresion PYC {
                      comprobarReturn($3.dtipo);
                      gen("return %s;\n", $3.lexema);
                      --deep;
                      gen("}\n");
                    } ;

expresion : PARIZQ expresion PARDER                  { $$.lexema = $2.lexema; $$.dtipo = $2.dtipo; }
          | ADDSUB expresion %prec EXCL              { $$.lexema = leerOp($2.dtipo, "", $1.lexema, $2.lexema); $$.dtipo = masMenos($1.atributo, $2.dtipo); }
          | EXCL expresion                           { $$.lexema = leerOp($2.dtipo, "", $1.lexema, $2.lexema); $$.dtipo = excl($2.dtipo); }
          | INTHASH expresion                        { $$.lexema = leerOp($2.dtipo, "", $1.lexema, $2.lexema); $$.dtipo = intHash($1.atributo, $2.dtipo); }
          | expresion AT expresion                   { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = at($1.dtipo, $3.dtipo); }
          | expresion ANDLOG expresion               { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = andLog($1.dtipo, $3.dtipo); }
          | expresion ORLOG expresion                { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = orLog($1.dtipo, $3.dtipo); }
          | expresion EQN expresion                  { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = eqn($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion ADDSUB expresion               { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = addSub($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion MULDIV expresion               { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = porDiv($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion PORPOR expresion               { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = porPor($1.dtipo, $3.dtipo); }
          | expresion BORRLIST expresion             { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = borrList($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion REL expresion                  { $$.lexema = leerOp($1.dtipo, $1.lexema, $2.lexema, $3.lexema); $$.dtipo = rel($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion MASMAS expresion AT expresion  { $$.dtipo = ternario($1.dtipo, $3.dtipo, $5.dtipo); }
          | llamada_funcion                          { $$.lexema = $1.lexema; $$.dtipo = $1.dtipo; }
          | ID                                       { $$.lexema = $1.lexema; $$.dtipo = buscarID($1.lexema); }
          | constante                                { $$.lexema = $1.lexema; $$.dtipo = $1.dtipo; }
          | error ;

llamada_funcion : ID PARIZQ argumentos PARDER {
                    $$.dtipo = comprobarFuncion($1.lexema);
                    $$.lexema = malloc(sizeof($1.lexema) + sizeof($3.lexema) + 3);
                    sprintf($$.lexema, "%s(%s)", $1.lexema, $3.lexema);
                } ;

argumentos : lista_argumentos
           | %empty ;

lista_argumentos : lista_argumentos COMA expresion {
                    $$.lexema = malloc(sizeof($1.lexema) + sizeof($3.lexema) + 3);
                    sprintf($$.lexema, "%s, %s", $1.lexema, $3.lexema);
                    argumentos_tipo_datos[n_argumentos] = $3.dtipo;
                    n_argumentos++;
                  }
                 | expresion {
                    $$.lexema = $1.lexema;
                    argumentos_tipo_datos[n_argumentos] = $1.dtipo;
                    n_argumentos++;
                  } ;

constante : CONST { $$.lexema = leerCte($1.lexema, $1.atributo); $$.dtipo = $1.dtipo; }
          | lista { $$.dtipo = $1.dtipo; } ;

lista : CORIZQ lista_expresiones CORDER { $$.dtipo = aTipoLista($2.dtipo); } ;

lista_expresiones : lista_expresiones COMA expresion { $$.dtipo = mismoTipoLista($1.dtipo, $3.dtipo);  }
                  | expresion { $$.dtipo = $1.dtipo; };

%%

#include "lex.yy.c"

void yyerror(const char *msg){
  fprintf(stderr, "[Linea %d] %s\n", yylineno, msg);
  fflush(stderr);
  hayError = 1;
}

int main(){
  yyparse();
  yyout = stdout;

  return 0;
}
