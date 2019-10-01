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

<ID> ::= [a-z, A-Z][a-z, A-Z, 0-9]*

# Cabecera función emulando a C
<Cabecera_subprog> ::= <Tipo_variable> <ID>(<Parametros>) 
                     | <Tipo_variable> <ID>()
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
<sentencia_asignacion> ::= <ID> <op_asignacion> <expresion> ;
<op_asignacion> ::= =

<sentencia_if> ::= if ( <expresion> ) <bloque>
<sentencia_while> ::= while ( <expresion> ) <bloque>

<sentencia_entrada> ::= <nomb_entrada> <lista_variables> ;
<nomb_entrada> ::=  cin

<lista_variables> ::= <ID> , <lista_variables> | <ID>

<sentencia_salida> ::= <nomb_salida> <lista_expresiones_o_cadena> ;
<nomb_entrada> ::=  cout

<lista_expresiones_o_cadena> ::= <lista_expresiones> | <cadena>
<lista_expresiones> ::= <expresiones> , <lista_expresiones> | <expresiones>
# Cualquier concatenación de caracteres ASCII. Mirar referencias.
<cadena> ::= "[ -~]*"

<sentencia_return> ::= return <ID> ;

<sentencia_do_until> ::= do <bloque> until ( <expresion> ) ;

<expresion> ::= ( <expresion> ) 
              |  <op_unario> <expresion>
              |  <expresion> <op_binario> <expresion>
              |  <ID>
              |  <constante>
              |  <funcion>
              
<op_binario> ::= <op_binario_booleano> | <op_binario_no_booleano>
<op_binario_no_booleano> ::= + | - | * | /
<op_binario_booleano> ::= AND | OR | XOR
<op_unario> ::= NOT

<constante> ::= (-?)(0|([1-9][0-9]*))(\.[0-9]+)?
              | true
              | false
             
# Llamada a una función
<funcion> ::= <ID> (<lista_ids_o_expresiones>)
<lista_ids_o_expresiones> ::= <ID>, <lista_ids_o_expresiones>
                            | <expresion>, <lista_ids_o_expresiones>
                            |
```


TODO:
- Ahora mismo nuestra gramática es ambigua al concatenar operaciones 
  en <expresion>. Por ejemplo se puede obtener `NOT <expresion> + <expresion>`
  de dos formas distintas. Realmente no se si eso es un problema porque
  la especificacion de <expresion> viene definida asi en el guión.
- Repasar las expresiones regulares de <constante> y <cadena>. Las
  he copiado de por ahi analizándolas con cuidado pero otro par de ojos
  viene bien.
 
## Referencias

- Explicación de la expresión regular `[ -~]`: [https://catonmat.net/my-favorite-regex](https://catonmat.net/my-favorite-regex).
