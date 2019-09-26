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

<Cabecera_subprog> ::= (Dependerá del lenguaje de referencia)

<Sentencias> ::= <Sentencias> <Sentencia> | <Sentencia> 

<Sentencia> ::= <bloque>
| <sentencia_asignacion>
| <sentencia_if>
| <sentencia_while> 
| <sentencia_entrada>
| <sentencia_salida>
| <sentencia_return>
| <sentencia_do_until>

<sentencia_asignacion> ::= (Dependerá del lenguaje de referencia)

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