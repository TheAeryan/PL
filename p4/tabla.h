 /* Tabla de símbolos para el analizador semántico */

#ifndef __TABLA_H__
#define __TABLA_H__

/*********************/
/* TABLA DE SÍMBOLOS */
/*********************/

/* Campos de las entradas */

// Tipo de entrada
typedef enum {
  marca,             // Marca de principio de bloque
  funcion,			 // Función
  variable,          // Variable local
  parametro-formal   // Parámetro de una función situada en una entrada anterior de la tabla
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
  listachar
} TipoDato;

/* Entradas de la TS */

typedef struct entrada_ts {
  TipoEntrada tipo_entrada; // Tipo de la entrada
  char* nombre;             // Nombre del identificador (si tipo_entrada es marca, no se usa)
  TipoDato tipo_dato;       // Tipo de dato
  int parametros;           // Número de parámetros. Solo se usa si tipo_entrada es funcion
} entrada_ts; 

/* Tabla de símbolos */

#define MAX_TAM_TS 2000 // Longitud máxima de la tabla de símbolos

struct entrada_ts TS[MAX_TAM_TS]; // Tabla de símbolos. Es un array de MAX_TAM_TS elementos. Cada elemento es una entrada_ts
long int TOPE; // Última entrada de la tabla de símbolos usada. Se inicializa a 0

#endif