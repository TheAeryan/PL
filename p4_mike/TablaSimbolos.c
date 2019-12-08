#include "TablaSimbolos.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylineno;

/*****************/
/* FUNCIONES AUX */
/*****************/

void idRepetida(char* id) {
  // Miramos si id estaba declarado después de la última marca
  for (int i = tope; ts[i].tipoEntrada != marca; --i) {
    if (!ts[i].tipoEntrada != parametroFormal && !strcmp(ts[i].nombre, id)) {
      fprintf(stderr, "[%d] Error: identificador %s ya declarado", yylineno, id);
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
  int i = tope;
  // Hasta la última marca borramos todo
  while (ts[i].tipoEntrada != marca)
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
      fprintf(stderr, "[%d] Error: parámetro %s ya declarado", yylineno, id);
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
