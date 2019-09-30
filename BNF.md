# PL - Práctica 1

## Lenguaje asignado: BBAAD
El lenguaje asignado está basado en la sintaxis de **C**, con las palabras reservadas en **inglés**, donde se añade a la lista de variables elementales la estructura de datos **lista**, los subprogramas son **funciones** y se incluye la estructura de control **do-until**.

## Descripción formal de la sintaxis del lenguaje usando BNF

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

<Marca_ini_declar_variables> ::= local <Inicio_de_bloque>
<Marca_fin_declar_variables> ::= <Fin_de_bloque>

<Cabecera_programa> ::= main

<Inicio_de_bloque> ::= {
<Fin_de_bloque> ::= }

<Variables_locales> ::= <Variables_locales> <Cuerpo_declar_variables> 
| <Cuerpo_declar_variables> 

<Cuerpo_declar_variables> ::= <Tipo_variable> <Lista_nombres_variables> ;

<Tipo_variable> ::= <Tipo_variable_simple> | <Tipo_variable_complejo>

<Tipo_variable_simple> ::= int | float | char | bool

<Tipo_variable_complejo> ::= list <Tipo_variable_simple>

<Lista_nombres_variables> ::= <ID> | <ID> , <Lista_nombres_variables>

# Cabecera función emulando a C
<Cabecera_subprog> ::= <Tipo_variable> <funcion>(<Parametros>) | <Tipo_variable> <ID>()
<Parametros> ::= <Parametro>, <Parametros> | <Parametro>
<Parametro> ::= <Tipo_variable> <ID>

<Sentencias> ::= <Sentencias> <Sentencia> | <Sentencia> 

<Sentencia> ::= <bloque>
| <sentencia_asignacion>
| <sentencia_if>
| <sentencia_while> 
| <sentencia_entrada>
| <sentencia_salida>
| <sentencia_return>
| <sentencia_do_until>

# El tipo de variable debe coincidir
<sentencia_asignacion> ::= <Tipo_variable> <ID> <op_asignacion> <expresion>
<op_asignacion> ::= =

<sentencia_if> ::= if ( <expresion> ) <bloque>

<sentencia_while> ::= while ( <expresion> ) <bloque>

<sentencia_entrada> ::= <nomb_entrada> <lista_variables>
<nomb_entrada> ::=  cin

<sentencia_salida> ::= <nomb_salida> <lista_expresiones_o_cadena>
<nomb_entrada> ::=  cout

<lista_variables> ::= <Tipo_Variable> , <lista_variables> | <Tipo_Variable>

<sentencia_return> ::= return <ID>

<sentencia_do_until> ::= do <bloque> until ( <expresion> ) ;

<expresion> ::= ( <expresion> ) 
|  <op_unario> <expresion>
|  <expresion> <op_binario> <expresion>
|  <identificador>
|  <constante>
|  <funcion> (si el lenguaje soporta funciones)
|  (Resto de expresiones del lenguaje de referencia)

```
