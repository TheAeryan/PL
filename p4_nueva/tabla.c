 #include "tabla.h"

/* Ver tabla.h para la documentación */

/*************************************/
/* IMPRESIÓN DE LA TABLA DE SIMBOLOS */
/*************************************/

char * imprimeTipoE(TipoEntrada tipo){
  switch (tipo) {
    case marca: return "marca";
    case funcion: return "función";
    case variable: return "variable";
    case parametroFormal: return "parámetro";
    default: return "error";
  }
}

char * imprimeTipoD (TipoDato tipo){
  switch (tipo) {
    case entero: return "entero";
    case real: return "real";
    case booleano: return "booleano";
    case caracter: return "carácter";
    case listaentero: return "lista de enteros";
    case listareal: return "lista de reales";
    case listabool: return "lista de booleanos";
    case listachar: return "lista de caracteres";
    case desconocido: return "desconocido";
    default: return "error";
  }
}

void imprimeTS(){
  char sangria[100] = "\0";
  printf("Tabla de símbolos en la línea %d:\n", yylineno);
  fflush(stdout);
  for (int i = 0; i <= TOPE; i++) {
    if (TS[i].tipo_entrada == marca) {
     strcat(sangria, "  ");
     printf("%s [marca]\n", sangria);
    } else {
      printf("%s%s: '%s'", sangria, imprimeTipoE(TS[i].tipo_entrada), TS[i].nombre);

      if (TS[i].tipo_entrada == variable ||
          TS[i].tipo_entrada == parametroFormal) {
        printf(" de tipo %s\n", imprimeTipoD(TS[i].tipo_dato));
      } else {
        printf(" con %d parámetros\n", TS[i].parametros);
      }
    }
  }
}

/***********************/
/* FUNCIONES MANEJO TS */
/***********************/

/* Funciones auxiliares */

void insertarEntrada(entrada_ts entrada){
	TOPE++;

	if (TOPE >= MAX_TAM_TS) {
		printf("[%d] Error: La tabla de símbolos está llena\n", yylineno);
		fflush(stdout);
		exit(2);
	}

	TS[TOPE] = entrada;
}

TipoDato stringToTipoDato(char* tipo_dato){
	TipoDato tipo_dato_nuevo;

	if (strcmp(tipo_dato, "entero") == 0)
		tipo_dato_nuevo = entero;
	else if (strcmp(tipo_dato, "real") == 0)
		tipo_dato_nuevo = real;
	else if (strcmp(tipo_dato, "booleano") == 0)
		tipo_dato_nuevo = booleano;
	else if (strcmp(tipo_dato, "caracter") == 0)
		tipo_dato_nuevo = caracter;
	else if (strcmp(tipo_dato, "list_of int") == 0)
		tipo_dato_nuevo = listaentero;
	else if (strcmp(tipo_dato, "list_of float") == 0)
		tipo_dato_nuevo = listareal;
	else if (strcmp(tipo_dato, "list_of bool") == 0)
		tipo_dato_nuevo = listabool;
	else if (strcmp(tipo_dato, "list_of char") == 0)
		tipo_dato_nuevo = listachar;
  else {
    printf("[%d] Error semántico: Identificador duplicado '%s'\n",
        yylineno, identificador);
    tipo_dato_nuevo = desconocido;
  }

	return tipo_dato_nuevo;
}

int identificadorDuplicado(char* identificador) {
  for (int j = TOPE; j >= 0; j--) {
    if (!strcmp(TS[j].nombre, identificador) &&
       (TS[j].tipo_entrada == variable ||
         TS[j].tipo_entrada == funcion)) {
      return 1;
    } else if (TS[j].tipo_entrada == marca) {
      // Si llegamos al final del bloque, sabemos que no está duplicado
      return 0;
    }
  }
}

/* Funciones para insertar entradas en TS */

void insertarVariable(char* identificador, TipoDato tipo_dato){
	if ( identificadorDuplicado(identificador) ) {
		printf("[%d] Error semántico: Identificador duplicado '%s'\n",
        yylineno, identificador);
		return;
	}

	entrada_ts entrada = {
		variable,
		strdup(identificador),
		tipo_dato,
		0
	};

	insertarEntrada(entrada);
}

void insertarFuncion (char * identificador, char * str_tipo_dato) {
  if ( identificadorDuplicado(identificador) ) {
		printf("[%d] Error semántico: Identificador duplicado '%s'\n",
        yylineno, identificador);
		return;
	}

  // TODO: estoy asumiendo que todas nuestras funciones devuelven algo
  // es decir, NO TENEMOS TIPO VOID. Si esto no es cierto y si que hay
  // tipo void, hay que añadir la posibilidad de que el tipo sea desconocido.
  tipo_funcion = stringToTipoDato(str_tipo_dato);

  entrada_ts entrada = {
    funcion,
    strdup(identificador),
    tipo_funcion,
    0 // Número de parámetros, inicialmente 0.
  };

  insertarEntrada(entrada_ts);
  ultimaFuncion = TOPE;
  esSubProg = 1;
}

void insertaParametrosComoVariables(){
  for (int i = 1; i <= TS[ultimaFuncion].parametros; i++)
    insertarVariable(TS[ultimaFuncion + i].nombre, TS[ultimaFuncion + i].tipo_dato);
}

void inicioBloque(){
	const entrada_ts marca_ini_bloque = {
		marca,
		(char) 0,
		desconocido,
		0
	};

	insertaTS(marca_ini_b loque);

	if (esSubProg) {
		insertaParametrosComoVariables();
    esSubProg = 0;
  }
}

void finBloque(){
  // Imprimir los contenidos de la TS
  imprimeTS();

	for(int j = TOPE; j >= 0; j--){
		if(TS[j].tipo_entrada == marca){
			TOPE = j-1;
			return;
		}
	}
}
