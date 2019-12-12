%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


#define YYERROR_VERBOSE

#define min(a, b) ({ __typeof__ (a) _a = (a); __typeof__ (b) _b = (b); _a < _b ? _a : _b; })
#define max(a, b) ({ __typeof__ (a) _a = (a); __typeof__ (b) _b = (b); _a > _b ? _a : _b; })

void yyerror( const char * msg );

#define MAX_TAM_TS 500

extern int yylineno;

// Esto elimina un Warning, no debería cambiar nada más.
int yylex();

/************************/
/* ESTRUCTURA DE LA TS */
/***********************/

// Tipo de entrada
typedef unsigned int TipoEntrada;
#define MARK     0b0001
#define FUNCTION 0b0010
#define VARIABLE 0b0100
#define FORMAL   0b1000

// Si TipoEntrada es función, variable, o parametro-formal; indica el tipo de dato
// No se usa en otro caso
typedef unsigned int TipoDato;
#define INTEGER 0b0001
#define REAL    0b0010
#define BOOLEAN 0b0100
#define CHAR    0b1000
#define NUM_TYPES 4
#define LIST   (1 << (NUM_TYPES + 1))
#define NUMBER  (INTEGER | REAL)

#define TYPEDLIST(a) ({ __typeof__ (a) _a = (a); _a & LIST })
#define TYPED(a) ({ __typeof__ (a) _a = (a); _a & ~(1 << (NUM_TYPES + 1)) })
#define isisNUMBER(a) ({ __typeof__ (a) _a = (a); _a & (INTEGER | REAL) })

typedef struct {
  TipoEntrada tipoEntrada;    // Tipo de entrada
  char* nombre;               // Nombre del identificador (no se usa con marca)
  TipoDato tipoDato;          // Tipo de dato
  int parametros;             // Nº de parámetros formales (sólo se usa con función)
} EntradaTS;

// La Tabla de Símbolos
EntradaTS ts[MAX_TAM_TS];

// Última entrada de la TS usada.
long int TOPE = -1;

// Tipo auxiliar para declaración de variables
TipoDato TEMP;

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

char* toString(TipoDato tipo_dato) {
  const char* NAMETYPE = { "int", "float", "bool", "char" };
  return strcat(TYPEDLIST(tipo_dato) ? "list_of" "", NAMETYPE[tipo_dato]);
}

void imprimir() {
  for (int i = 0; i <= TOPE; ++i) {
    printf("[%i]: ", i);
    switch(ts[i].tipoEntrada) {
      case VARIABLE: printf("Variable %s, tipo: %s\n", ts[i].nombre, toString(ts[i].tipoDato)); break;
      case FUNCTION: printf("Funcion %s, tipo: %s, nº parametros: %i\n", ts[i].nombre, toString(ts[i].tipoDato), ts[i].parametros); break;
      case MARK:     printf("Marca\n"); break;
      case FORMAL:   printf("Parametro formal %s, tipo: %s\n", ts[i].nombre, toString(ts[i].tipoDato)); break;
      default: printf("error\n");
    }
  }
}

void idRepetida(char* id, TipoEntrada end) {
  // Miramos si id estaba declarado después de la última MARK
  for (int i = TOPE; ts[i].tipoEntrada != end; --i) {
    if (ts[i].tipoEntrada != FORMAL && !strcmp(ts[i].nombre, id)) {
      fprintf(stderr, "[%d] Error: identificador %s ya declarado\n", yylineno, id);
      fflush(stderr);
      exit(EXIT_FAILURE);
    }
  }
}

void insertarEntrada(TipoEntrada entrada, char* nombre, TipoDato tipo_dato, int nParam) {

  // Si la tabla está llena da error
  if (TOPE + 1 >= MAX_TAM_TS) {
    fprintf(stderr, "[%d] Error: La tabla de símbolos está llena\n", yylineno);
    fflush(stderr);
    exit(EXIT_FAILURE);
  }

  // Añadimos la nueva entrada
  ts[++TOPE] = {
    entrada,
    strdup(nombre),
    tipo_dato,
    nParam
  };
}

// Busca una entrada en la TS con el id especificado en el ámbito del programa
// actual. Si no lo encuentra, devuelve -1. No gestiona errores!
int buscarEntrada(char* id, TipoEntrada type){
  for (int i = TOPE; i >= 0; --i) {
    if (ts[i].tipoEntrada == type && strcmp(id, ts[i].nombre)) {
      return i;
    }
  }
  return -1;
}

// Busca una entrada en la TS con el id especificado en el ámbito del programa actual,
// que además sea de tipo variable. Gestiona errores.
int buscarEntradaVariable(char* id) {
  int i = buscarEntrada(id, VARIABLE);
  if (i < 0) {
    fprintf(stderr, "[%d] Error: VARIABLE %s no declarada\n", yylineno, id);
    exit(EXIT_FAILURE);
  }
  return i;
}

int buscarEntradaFuncion(char* id) {
  int i = buscarEntrada(id, FUNCTION);
  if (i < 0) {
    fprintf(stderr, "[%d] Error: función %s no declarada\n", yylineno, id);
    exit(EXIT_FAILURE);
  }
  return i;
}

/****************/
/* FUNCIONES TS */
/****************/

void insertarMarca() {
  // Metemos la MARK
  insertarEntrada(MARK, "", -1, -1);
  // Si es subprograma añadimos las VARIABLEs al bloque
  //if (subProg) {
  for (int i = TOPE - 1; ts[i].tipoEntrada != FUNCTION; --i) {
    insertarEntrada(VARIABLE, ts[i].nombre, ts[i].tipoDato, -1);
  }
  subProg = 0;
}

void vaciarEntradas() {
  // Hasta la última MARK borramos todo
  while (ts[--TOPE].tipoEntrada != MARK);
}

void insertarVariable(char* id) {
  // Comprobamos que no esté repetida la id
  idRepetida(id, MARK);
  // Si no está duplicado añadimos la entrada
  insertarEntrada(VARIABLE, id, TEMP, -1);
}

void insertarFuncion(TipoDato tipoDato, char* id) {
  // Comprobamos que el id no esté usado ya
  idRepetida(id, MARK);
  // Añadimos la entrada
  insertarEntrada(FUNCTION, id, tipoDato, 0);
}

void insertarParametro(TipoDato tipoDato, char* id) {
  // Comprobamos que no haya parámetros con nombres repetidos
  idRepetida(id, FUNCTION);
  // Añadimos la entrada
  insertarEntrada(FORMAL, id, tipoDato, -1);
  // Actualizamos el nº de parámetros de la función
  ++ts[i].parametros;
}

void comprobarAsignacion(char* id, TipoDato td) {
  TipoDato tdID = ts[buscarEntradaVariable(id)].tipoDato;
  if (tdID != td) {
    fprintf(stderr, "[%d] Error: asignación incorrecta, %s es tipo %s y se obtuvo %s\n", yylineno, id, toString(tdID), toString(td));
    exit(EXIT_FAILURE);
  }
}

void expresionBooleana(TipoDato td) {
  if (td != BOOLEAN) {
    fprintf(stderr, "[%d] Error: condición no es de tipo booleano, se tiene tipo %s", yylineno, toString(td));
    exit(EXIT_FAILURE);
  }
}

void sentenciaLista(TipoDato td, char* sentencia) {
  if (!esLista(td)) {
    fprintf(stderr, "[%d] Error: sentencia %s no aplicable al tipo %s\n",
        yylineno, sentencia, toString(td));
    exit(EXIT_FAILURE);
  }
}

TipoDato mismoTipoLista(TipoDato t1, TipoDato t2) {
  if (t1 != t2) {
    fprintf(stderr, "[%d] Error: lista dos tipos de tipo %s y %s\n",
        yylineno, toString(t1), toString(t2));
    exit(EXIT_FAILURE);
  }
  return t1;
}

/* OPERATIONS */
/* UNARY OPERATIONS */
const char* ADDSUB  = { "+", "-" };
const char* EXCL    = { "!" };
const char* INTHASH = { "?", "#" };

TipoDato unary(int op, const char* ops, TipoDato type, TipoDato restriction){

  if (type & ~restriction) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable al tipo %s\n", yylineno, ops[op], toString(type));
    exit(EXIT_FAILURE);
  }

  return type;
};

TipoDato masMenos(int op, TipoDato td){
  char* operador = ADDSUB[op];
  
  return td;
}

TipoDato excl(int op, TipoDato td){
  if (td != BOOLEAN) {
    fprintf(stderr, "[%d] Error: operador ! no aplicable al tipo %s\n", yylineno, toString(td));
    exit(EXIT_FAILURE);
  }
  return BOOLEAN;
}

TipoDato intHash(int op, TipoDato td){
  char* operador = INTHASH[op];
  if (!esLista(td)) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable al tipo %s\n",
        yylineno, operador, toString(td));
    exit(EXIT_FAILURE);
  }

  if (op)
    return tipoLista(td);
  else
    return entero;
}

/* BINARY OPERATIONS */
const char* AT       = { "@" };
const char* EQN      = { "==", "!="};
const char* AND      = { "&&" };
const char* OR       = { "||" };
const char* ADDSUB   = { "+", "-" }; 
const char* MULDIV   = { "*", "/" };
const char* PORPOR   = { "**" };
const char* BORRLIST = { "%", "--" }; 

TipoDato binary(TipoDato type1, TipoDato restriction1, int op, const char* ops, TipoDato type2, TipoDato restriction2){

  if (type1 & ~restriction1 || type2 & ~restriction2) {

    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n", yylineno, ops[op], toString(td1), toString(td2));
    exit(EXIT_FAILURE);
  
  }
  
  return type1;
}

TipoDato eqn(TipoDato td1, int op, TipoDato td2) {
  char* operador = EQN[op];

  if (td1 != td2) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n", yylineno, operador, toString(td1), toString(td2));
    exit(EXIT_FAILURE);
  }
  return BOOLEAN;
}

TipoDato op2Binario(TipoDato td1, int op, TipoDato td2, char* op1, char* op2) {
  char* operador = op ? op1 : op2;
  int l1 = esLista(td1);
  int l2 = esLista(td2);
  TipoDato tipo1 = l1 ? tipoLista(td1) : td1;
  TipoDato tipo2 = l2 ? tipoLista(td2) : td2;

  int error = (l1 && l2) ||
              (tipo1 != tipo2) ||
              !isNUMBER(tipo1);
              
  TipoDato resultado = td1;

  if (!error && (l1 || l2) ) {
    // Llegado a este punto hay exactamente una lista. Vemos si el tipo de
    // la lista encaja con el tipo del otro atributo:
    if ( (operador == op2) || l1 ) {
      resultado = l1 ? td1 : td2;
    } else {
      error = 1;
    }
  }

  if (error) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n", yylineno, operador, toString(td1), toString(td2));
    exit(EXIT_FAILURE);
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
  if (td1 != td2 || !esLista(td1) || !esLista(td2)) {
    fprintf(stderr, "[%d] Error: operador ** no aplicable a los tipos %s, %s\n",
        yylineno, toString(td1), toString(td2));
    exit(EXIT_FAILURE);
  }
  return td1;
}

TipoDato borrList(TipoDato td1, int op, TipoDato td2) {
  char* operador = BORRLIST[op];

  if (!esLista(td1) || td2 != entero) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n", yylineno, operador, toString(td1), toString(td2));
    exit(EXIT_FAILURE);
  }
  return td1;
}

TipoDato rel(TipoDato td1, int op, TipoDato td2) {
  const char* relational = { "<", ">", "<=", "=>" };
  char* operador = relational[op];

  if (td1 != td2 || !isNUMBER(td1) || !isNUMBER(td2)) {
    fprintf(stderr, "[%d] Error: operador %s no aplicable a los tipos %s, %s\n", yylineno, operador, toString(td1), toString(td2));
    exit(EXIT_FAILURE);
  }
  return BOOLEAN;
}

/* TERNARY OPERATIONS */
TipoDato ternario(TipoDato td1, TipoDato td2, TipoDato td3) {
  if (!esLista(td1) || tipoLista(td1) != td2 || td3 != entero) {
    fprintf(stderr, "[%d] Error: operador ++ @ no aplicable a los tipos %s, %s, %s\n", yylineno, toString(td1), toString(td2), toString(td3));
    exit(EXIT_FAILURE);
  }
  return td1;
}

void comprobarReturn(TipoDato td) {
  int i = TOPE;
  int marcaEncontrada = 0;
  int funcionEncontrada = 0;

  while (i >= 1 && !funcionEncontrada) {
    funcionEncontrada = marcaEncontrada && ts[i].tipoEntrada == FUNCTION;
    marcaEncontrada = (!marcaEncontrada && ts[i].tipoEntrada == MARK) ||
                      (marcaEncontrada && ts[i].tipoEntrada == FORMAL);
    --i;
  }

  if (funcionEncontrada) ++i;

  if (i <= 0) {
    fprintf(stderr, "[%d] Error: return no asignado a ninguna función\n", yylineno);
    exit(EXIT_FAILURE);
  }

  if (td != ts[i].tipoDato) {
    fprintf(stderr, "[%d] Error: return devuelve tipo %s, y función es de tipo %s\n",
        yylineno, toString(td), toString(ts[i].tipoDato));
    exit(EXIT_FAILURE);
  }
}

TipoDato comprobarFuncion(char* id) {
  int iFuncion = buscarEntradaFuncion(id);
  int n_argumentos_esperados = ts[iFuncion].parametros;
  int error = 0;

  if ( n_argumentos != n_argumentos_esperados ) {
    fprintf(stderr, "[%d] Error: número de argumentos errónea al llamar a la función %s. Esperados: %d, encontrados: %d\n", yylineno, id, n_argumentos_esperados, n_argumentos);
    error = 1;
  }  

  n_argumentos = min(n_argumentos, n_argumentos_esperados);
  
  for(int i = 0; i < n_argumentos; i++){
    TipoDato tipoEsperado = ts[iFuncion + i + 1].tipoDato;
    TipoDato tipoObtenido = argumentos_tipo_datos[i];
    if(tipoEsperado != tipoObtenido){
      fprintf(stderr, "[%d] Error: argumento número %d de tipo erróneo al llamar a la función %s. Esperado: %s, encontrado: %s\n", yylineno, i, id, toString(tipoEsperado), toString(tipoObtenido));
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

cuerpo_declar_variables : TIPO { TEMP = $1.dtipo; } lista_variables PYC
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
          | ADDSUB expresion %prec EXCL              { $$.dtipo = unary($1.atributo, , $2.dtipo); }
          | EXCL expresion                           { $$.dtipo = excl    ($1.atributo, $2.dtipo); }
          | INTHASH expresion                        { $$.dtipo = intHash ($1.atributo, $2.dtipo); }
          | expresion AT expresion                   { $$.dtipo = at      ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion ANDLOG expresion               { $$.dtipo = andLog  ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion ORLOG expresion                { $$.dtipo = orLog   ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion EQN expresion                  { $$.dtipo = eqn     ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion ADDSUB expresion               { $$.dtipo = addSub  ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion MULDIV expresion               { $$.dtipo = porDiv  ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion PORPOR expresion               { $$.dtipo = porPor  ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion BORRLIST expresion             { $$.dtipo = borrList($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion REL expresion                  { $$.dtipo = rel     ($1.dtipo, $2.atributo, $3.dtipo); }
          | expresion MASMAS expresion AT expresion  { $$.dtipo = ternario($1.dtipo, $2.atributo, $3.dtipo, $4.atributo, $5.dtipo); }
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

lista : CORIZQ lista_expresiones CORDER { $$.dtipo = TYPED($2.dtipo); } ;

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
