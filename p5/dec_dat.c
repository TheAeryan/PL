#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct {
  void** datos;
  int tam;
  int capacidad;
  int cursor;
  int tipo;
} VecDin;

typedef VecDin* Lista;

void redimensionar(Lista l, int capacidad) {
  void** datos = realloc(l->datos, sizeof(void*) * capacidad);
  if (datos) {
    l->datos = datos;
    l->capacidad = capacidad;
  }
}

void insertar(Lista l, void* dato) {
  if (l->capacidad == l->tam)
    redimensionar(l, l->capacidad * 2);
  l->datos[l->tam++] = dato;
  if (l->tam == 1)
    l->cursor = 0;
}

/*
  List Type
  int   = 0
  float = 1
  char  = 2
*/

Lista inicializar(int tipo) {
  Lista l = malloc(sizeof(VecDin));
  l->tam = 0;
  l->capacidad = 4;
  l->cursor = -1;
  l->tipo = tipo;
  l->datos = malloc(sizeof(void *) * l->capacidad);
  return l;
}

// Operador #
int getTam(Lista l) {
  return l->tam;
}

// Operador >>
void avanza(Lista l) {
  if (l->tam >= 0) {
    if (l->cursor + 1 < l->tam)
      l->cursor++;
    else
      fprintf(stderr, "ERROR avanza(): cursor ya está en el final.\n");
  } else
      fprintf(stderr, "ERROR avanza(): lista vacía.\n");
}

// Operador <<
void retrocede(Lista l) {
  if (l->tam >= 0) {
    if (l->cursor - 1 >= 0)
      l->cursor--;
    else
      fprintf(stderr, "ERROR retrocede(): cursor ya está al principio.\n");
  } else
      fprintf(stderr, "ERROR avanza(): lista vacía.\n");
}

// Operador $
void inicio(Lista l) {
  if (l->tam >= 0) {
    l->cursor = 0;
  } else
      fprintf(stderr, "ERROR inicio(): lista vacía.\n");

}

// Operador ?
void* getActual(Lista l) {
  if (l->cursor < 0) {
    fprintf(stderr, "ERROR getActual(): la lista está vacía.\n");
    return NULL;
  }
  return l->datos[l-> cursor];
}

void set(Lista l, int pos, void* dato) {
  if (pos >= 0 && pos < l->tam)
    l->datos[pos] = dato;
  else
    fprintf(stderr, "ERROR: set(): %s pos no válida, tam: %s.\n", pos, l->tam);
}

// Operador @
void* get(Lista l, int pos) {
  if (pos >= 0 && pos < l->tam)
    return l->datos[pos];
  else
    fprintf(stderr, "ERROR: get(): %s pos no válida, tam: %s.\n", pos, l->tam);
  return NULL;
}

void borrar(Lista l, int pos) {
  if (pos < 0 || pos >= l->tam) {
    fprintf(stderr, "ERROR: borrar(): %s pos no válida, tam: %s.\n", pos, l->tam);
    return;
  }

  l->datos[pos] = NULL;
  for (int i = pos; i < l->tam; ++i) {
    l->datos[i] = l->datos[i + 1];
    l->datos[i + 1] = NULL;
  }

  l->tam--;

  if(l->tam == 0)
    l->cursor = -1;

  if (l->tam > 0 && l->tam == l->capacidad / 4)
    redimensionar(l, l->capacidad / 2);
}

Lista copiar(Lista l, int pos) {
  Lista nueva = inicializar(l->tipo);
  for (int i = 0; i < pos; ++i) {
    void* aux = malloc(sizeof(void));
    memcpy(aux, l->datos[i], sizeof(void*));
    insertar(nueva, aux);
  }

  return nueva;
}

// Operador --
Lista borrarEn(Lista l, int pos) {
  Lista nueva = copiar(l, l->tam);
  borrar(nueva, pos);
  return nueva;
}

// Operador %
Lista borrarAPartirDe(Lista l, int pos) {
  return copiar(l, pos + 1);
}

// Operador ++ @
Lista insertarEn(Lista l, int pos, void* dato) {
  Lista nueva = copiar(l, pos);
  insertar(nueva, dato);
  for (int i = pos; i < l->tam; ++i) {
    void* aux = malloc(sizeof(void));
    memcpy(aux, l->datos[i], sizeof(void*));
    insertar(nueva, aux);
  }
  return nueva;
}

// Operador **
Lista concatenar(Lista l1, Lista l2) {
  Lista nueva = copiar(l1, l1->tam);
  for (int i = 0; i < l2->tam; ++i) {
    void* aux = malloc(sizeof(void));
    memcpy(aux, l2->datos[i], sizeof(void*));
    insertar(nueva, aux);
  }
  return nueva;
}

// https://stackoverflow.com/questions/8465006/how-do-i-concatenate-two-strings-in-c
char* concat(const char *s1, const char *s2)
{
    const size_t len1 = strlen(s1);
    const size_t len2 = strlen(s2);
    char *result = malloc(len1 + len2 + 1); // +1 for the null-terminator
    // in real code you would check for errors in malloc here
    memcpy(result, s1, len1);
    memcpy(result + len1, s2, len2 + 1); // +1 to copy the null-terminator
    return result;
}

char* listaAstring(Lista l){

  char* result = "[";
  for(int i = 0; i < l->tam; ++i){
    char* value = malloc(sizeof(char) * 10);
    if(l->tipo == 0){
      sprintf(value, "%d", *(int*)l->datos[i]);
    }else if(l->tipo == 1){
      sprintf(value, "%f", *(float*)l->datos[i]);
    }else if(l->tipo == 2){
      sprintf(value, "%c", *(char*)l->datos[i]);
    }

    result = concat(result, value);
  }
  result = concat(result, "]");

  return result;

}

void destruir(Lista l) {
  free(l->datos);
  l->tam = 0;
  l->capacidad = 0;
  l->cursor = -1;
  l->tipo = -1;
}

int* pInt(int n) {
  int* p = malloc(sizeof(int));
  *p = n;
  return p;
}

char* pChar(char c) {
  char* p = malloc(sizeof(char));
  *p = c;
  return p;
}

float* pFloat(float f) {
  float* p = malloc(sizeof(float));
  *p = f;
  return p;
}

void sumarListaInt(Lista l, int i) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pInt(*(int*)(l->datos[i]) + i);
}

void sumarListaFloat(Lista l, float f) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pFloat(*(float*)(l->datos[i]) + f);
}

void multiplicarListaInt(Lista l, int i) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pInt(*(int*)(l->datos[i]) * i);
}

void multiplicarListaFloat(Lista l, float f) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pFloat(*(float*)(l->datos[i]) * f);
}

void dividirListaInt(Lista l, int i) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pInt(*(int*)(l->datos[i]) / i);
}

void dividirListaFloat(Lista l, float f) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pFloat(*(float*)(l->datos[i]) / f);
}

void restarListaInt(Lista l, int i) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pInt(*(int*)(l->datos[i]) - i);
}

void restarListaFloat(Lista l, float f) {
  for (int i = 0; i < l->tam; ++i)
    l->datos[i] = pFloat(*(float*)(l->datos[i]) - f);
}
