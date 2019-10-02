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

<Declar_subprog> ::= <Cabecera_subprog> <bloque> 

<Declar_de_variables_locales> ::= <Marca_ini_declar_variables> 
                                    <Variables_locales> 
                                    <Marca_fin_declar_variables> 
                                | 

<Marca_ini_declar_variables> ::= local <Inicio_de_bloque>
<Marca_fin_declar_variables> ::= <Fin_de_bloque>

<Cabecera_programa> ::= main

<Inicio_de_bloque> ::= {
<Fin_de_bloque> ::= }

<Variables_locales> ::= <Variables_locales> <Cuerpo_declar_variables> 
                      | <Cuerpo_declar_variables> 

<Cuerpo_declar_variables> ::= <Tipo_variable> <Lista_nombres_variables> ;

<Tipo_variable> ::= <Tipo_variable_simple> 
                  | <Tipo_variable_complejo>

<Tipo_variable_simple> ::= int 
                         | float 
                         | char 
                         | bool

<Tipo_variable_complejo> ::= list <Tipo_variable_simple>

<Lista_nombres_variables> ::= <ID> 
                            | <ID> , <Lista_nombres_variables>

# <ID> = [a-z, A-Z][a-z, A-Z, 0-9]*  
<ID> ::= <letra><letras_o_digitos>
<letras_o_digitos> ::= <letra><letras_o_digitos>
                     | <digito><letras_o_digitos>
                     |
<letra> ::= [a-z, A-Z]
<digito> ::= [0-9]

# Cabecera función emulando a C
<Cabecera_subprog> ::= <Tipo_variable> <ID>(<Parametros>) 
                     | <Tipo_variable> <ID>()
<Parametros> ::= <Parametro>, <Parametros> 
               | <Parametro>
<Parametro> ::= <Tipo_variable> <ID>

<Sentencias> ::= <Sentencias> <Sentencia> 
               | <Sentencia> 

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

<lista_variables> ::= <ID> , <lista_variables> 
                    |<ID>

<sentencia_salida> ::= <nomb_salida> <lista_expresiones_o_cadena> ;
<nomb_entrada> ::=  cout

<lista_expresiones_o_cadena> ::= <lista_expresiones> 
                               | <cadena>
<lista_expresiones> ::= <expresiones> , <lista_expresiones> 
                      | <expresiones>
                  
# <cadena> = "[ -~]"                    
<cadena> ::= "<cadena_ascii>"
<cadena_ascii> ::= <caracter_ascii><cadena_ascii> | 
<caracter_ascii> ::= [ -~]

<sentencia_return> ::= return <ID> ;

<sentencia_do_until> ::= do <bloque> until ( <expresion> ) ;

<expresion> ::= ( <expresion> ) 
              |  <op_unario> <expresion>
              |  <expresion> <op_binario> <expresion>
              # Operador ternario de listas
              |  <expresion> ++ <expresion> @ <expresion>
              |  <ID>
              |  <constante>
              |  <funcion>   

<op_binario> ::= <op_binario_booleano> 
               | <op_binario_no_booleano>
               
<op_binario_no_booleano> ::= + 
                           | - 
                           | * 
                           | /
                           | @
                           | --
                           | %
                           | **
                           
<op_binario_booleano> ::= AND 
                        | OR 
                        | XOR  

<op_binario_lista> ::=
<op_unario> ::= NOT

# <constante> = (0|([1-9][0-9]*))(\.[0-9]+)?
<constante> ::= <signo><numero_decimal>
              | true
              | false
<signo> ::= -|
<numero_decimal> ::= <digito><numero_decimal> | <digito> | .<numero>
<numero> ::= <digito><numero> | <digito>
             
# Llamada a una función
<funcion> ::= <ID> (<lista_ids_o_expresiones>) 
            | <ID> ()
<lista_ids_o_expresiones> ::= <ID>, <lista_ids_o_expresiones>
                            | <expresion>, <lista_ids_o_expresiones>
                            | <ID>
                            | <expresion>
```


## TODO

- Ahora mismo nuestra gramática es ambigua al concatenar operaciones 
  en <expresion>. Por ejemplo se puede obtener `NOT <expresion> + <expresion>`
  de dos formas distintas. Realmente no se si eso es un problema porque
  la especificacion de `<expresion>` viene definida asi en el guión.
- Repasar las reglas que generan `<ID>`, `<cadena>` y `<constante>`.

## Tabla de Tokens

| Token         | Identificador | Atributos                        | Patrón                                                |
|---------------|---------------|----------------------------------|-------------------------------------------------------|
| INIBLOQUE     | 257           |                                  | "{"                                                   |
| FINBLOQUE     | 258           |                                  | "}"                                                   |
| LOCAL         | 259           |                                  | "local"                                               |
| TIPOSIMPLE    | 260           | 0: int 1: float 2: char 3: bool  | ("int"\|"float"\|"char"\|"bool")                      |
| TIPOCOMPUESTO | 261           |                                  | list ("int"\|"float"\|"char"\|"bool")                 |
| ID            | 262           |                                  | [a-z, A-Z][a-z, A-Z, 0-9]*                            |
| PARIZQ        | 263           |                                  | "("                                                   |
| PARDER        | 264           |                                  | ")"                                                   |
| PYC           | 265           |                                  | ";"                                                   |
| CIN           | 266           |                                  | "cin"                                                 |
| COUT          | 267           |                                  | "cout"                                                |
| CADENA        | 268           |                                  | "\[ -~\]*"                                            |
| RETURN        | 269           |                                  | "return"                                              |
| OPBINBOOL     | 270           | 0: AND 1: OR 2: XOR              | ("AND"\|"OR"\|"XOR")                                  |
| OPBINNOBOOL   | 271           | 0: + 1: - 2: * 3: / 4: @ 5: -- 6: % 7: ** | ("+"\|"-"\|"*"\|"/"\|"@"\|"--"\|"%"\|"**")   |
| OPUNARIO      | 272           |                                  | "NOT"                                                 |
| CONST         | 273           |                                  | ( (-?)(0\|([1-9][0-9]*))(\.[0-9]+)? \| true \| false )|
| ASIGN         | 274           |                                  | "="                                                   |
| COMA          | 275           |                                  | ","                                                   |
| MAIN          | 276           |                                  | "main"                                                |
| DO            | 277           |                                  | "do"                                                  |
| UNTIL         | 278           |                                  | "until"                                               |
| WHILE         | 279           |                                  | "while"                                               |
| IF            | 280           |                                  | "if"                                                  |
 
## Referencias

- Explicación de la expresión regular `[ -~]`: [https://catonmat.net/my-favorite-regex](https://catonmat.net/my-favorite-regex).
