#BBAAD

*Lenguaje C*
*Inglés*
*Listas*
*Funciones*
*Do - Until*

```
<Programa> ::= <Cabecera_programa> <bloque> 

<bloque> ::= <Inicio_de_bloque>
<Declar_de_variables_locales>
<Declar_de_subprogs>
<Sentencias>
<Fin_de_bloque>

<Declar_de_subprogs> ::= <Declar_de_subprogs> <Declar_subprog> | 

<Declar_subprog> ::= <Cabecera_subprograma> <bloque> 

<Declar_de_variables_locales> ::= <Marca_ini_declar_variables> 
<Variables_locales> 
<Marca_fin_declar_variables> | 

<Cabecera_programa> ::= (Dependerá del lenguaje de referencia)

<Inicio_de_bloque> ::= {
<Fin_de_bloque> ::= }

<Variables_locales> ::= <Variables_locales> <Cuerpo_declar_variables> 
| <Cuerpo_declar_variables> 

<Cuerpo_declar_variables> ::= (Dependerá del lenguaje de referencia)

<Cabecera_subprog> ::= (Dependerá del lenguaje de referencia)

<Sentencias> ::= <Sentencias> <Sentencia> | <Sentencia> 

<Sentencia> ::= <bloque> | <sentencia_asignacion> | <sentencia_if> | <sentencia_while> 
|  <sentencia_entrada>
|  <sentencia_salida>
|  <sentencia_return> (si el lenguaje soporta funciones)
|  <llamada_proced> (si el lenguaje soporta proced.)
|  (Resto de sentencias del lenguaje asignado)

<sentencia_asignacion> ::= (Dependerá del lenguaje de referencia)

<sentencia_if> ::= (Dependerá del lenguaje de referencia)

<sentencia_while> ::= (Dependerá del lenguaje de referencia)

<sentencia_entrada> ::= <nomb_entrada> <lista_variables>

<sentencia_salida> ::= <nomb_salida> <lista_expresiones_o_cadena>

<expresion> ::= ( <expresion> ) 
|  <op_unario> <expresion>
|  <expresion> <op_binario> <expresion>
|  <identificador>
|  <constante>
|  <funcion> (si el lenguaje soporta funciones)
|  (Resto de expresiones del lenguaje de referencia)

```