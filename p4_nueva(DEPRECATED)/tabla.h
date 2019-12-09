 /* Tabla de símbolos para el analizador semántico */

#ifndef __TABLA_H__
#define __TABLA_H__

/*********/
/* TIPOS */
/*********/

/* Campos de las entradas */

// Tipo de entrada
typedef enum {
  marca,             // Marca de principio de bloque
  funcion,			     // Función
  variable,          // Variable local
  parametroFormal    // Parámetro de una función situada en una entrada anterior de la tabla
} TipoEntrada;

// Tipo de dato.
// Solo aplicable cuando TipoEntrada sea funcion, variable o parametro-formal
typedef enum {
  entero,
  real,
  booleano,
  caracter,
  listaentero,
  listareal,
  listabool,
  listachar,
  desconocido
} TipoDato;

/* Entradas de la TS */

typedef struct entrada_ts {
  TipoEntrada tipo_entrada; // Tipo de la entrada
  char* nombre;             // Nombre del identificador (si tipo_entrada es marca, no se usa)
  TipoDato tipo_dato;       // Tipo de dato
  int parametros;           // Número de parámetros. Solo se usa si tipo_entrada es funcion
} entrada_ts;

/*************************************/
/* VARIABLES DE LA TABLA DE SIMBOLOS */
/*************************************/

// Longitud máxima de la tabla de símbolos
#define MAX_TAM_TS 2000

// Tabla de símbolos. Es un array de MAX_TAM_TS elementos.
// Cada elemento es una entrada_ts
struct entrada_ts TS[MAX_TAM_TS];

// Última entrada de la tabla de símbolos usada. Se inicializa a -1
long int TOPE;

// Posición en la tabla de símbolos del último procedimiento
long int ultimaFuncion;

// Guardar si la proxima vez que entremos en un bloque, este es
// un subprograma y, en tal caso, inserta los parametros como
// variables en la pila.
int esSubProg;

/*************************************/
/* IMPRESIÓN DE LA TABLA DE SIMBOLOS */
/*************************************/

char * imprimeTipoE(TipoEntrada tipo);
char * imprimeTipoD (TipoDato tipo);

// Imprime toda la TS, desde la posición 0 hasta TOPE, inclusive
void imprimeTS();

/***********************/
/* FUNCIONES MANEJO TS */
/***********************/

/* Funciones auxiliares */

// Inserta una entrada en la tabla de símbolos, en la posición siguiente a TOPE.
// Si no hay espacio en la tabla, se informa del error y termina el programa.
void insertarEntrada(entrada_ts entrada);

// Función que lee un string (char*) y lo convierte al tipo
// TipoDato correspondiente (ej.: "real" -> real)
TipoDato stringToTipoDato(char* tipo_dato);

// Función que comprueba si un identificador ya está siendo
// usado en el mismo bloque para una variable o función.
// Devuelve 1 si está duplicado y 0 si no.
int identificadorDuplicado(char* identificador);


/* Funciones para insertar entradas en TS */

// Inserta una variable nueva al ser declarada.
// Comprueba que en el mismo bloque no se use el mismo identificador.
void insertarVariable(char* identificador, TipoDato tipo_dato);

// Inserta una función nueva al ser declarada.
// Comprueba que en el mismo bloque no se use el mismo identificador y
// actualiza el valor de esSubProg. Los parámetros se añadirán a continuación.
void insertarFuncion (char * identificador, char * str_tipo_dato);

// Inserta un parámetro de una función declarada anteriormente
// Además, aumenta en 1 el número de parámetros de dicha función
// (aquella cuya posición en la tabla es "ultimaFuncion")
void insertarParametroFuncion(char* identificador, char * str_tipo_dato);

// Inserta los parámetros de una función como variables locales
// dentro del bloque de dicha función.
void insertaParametrosComoVariables();

// Función llamada cuando empieza un bloque.
// Inserta una marca de inicio de bloque y, si es el cuerpo de un subprograma (es_subprog vale 1),
// se introducen los parámetros formales como variables locales
void inicioBloque();

// Función llamada cuando termina un bloque.
// Se eliminan todas las entradas de la TS hasta la última marca de
// inicio de bloque, inclusive.
void finBloque();

#endif
