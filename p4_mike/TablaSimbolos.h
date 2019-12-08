#ifndef __TABLA_SIMBOLOS_H__
#define __TABLA_SIMBOLOS_H__

// Nº de entradas máximas de la TS
#define MAX_TAM_TS 500

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

/*****************/
/* FUNCIONES AUX */
/*****************/

// Mira si la id está repetida (ya declarada), en caso afirmativo
// manda un error y termina; si no, no hace nada.
void idRepetida(char* id);

// Añade la entrada en la TS, en la posición siguiente a TOPE
// e incrementa TOPE. Si no hay espacio, da error y aborta.
void insertarEntrada(EntradaTS entrada);


/****************/
/* FUNCIONES TS */
/****************/

// Inserta una marca de inicio de bloque, y si es un bloque
// de subprograma, añade los parámetros al bloque
void insertarMarca();

// Cuando acaba el bloque, se borran todas las entradas
// hasta la marca
void vaciarEntradas();

// Inserta la variable con la id, si no está repetida
void insertarVariable(char* id);

// Inserta la función con el tipo dado, si no está repetida
void insertarFuncion(TipoDato tipoDato, char* id);

// Inserta el parámetro y actualiza el nº de parámetros de la función
void insertarParametro(TipoDato tipoDato, char* id);


#endif
