# PL - Práctica 1

## Lenguaje asignado: BBAAD
El lenguaje asignado está basado en la sintaxis de **C**, con las palabras reservadas en **inglés**, donde se añade a la lista de variables elementales la estructura de datos **lista**, los subprogramas son **funciones** y se incluye la estructura de control **do-until**.

## Descripción formal de la sintaxis del lenguaje usando BNF

```
# Descripciones básicas
<letra> ::= [a-z, A-Z]
<digito> ::= [0-9]
<ID> ::= <letra><letras_o_digitos>
<letras_o_digitos> ::= <letra><letras_o_digitos>
                     | <digito><letras_o_digitos>
                     |
<caracter_ascii> ::= [ -~]
<cadena> ::= "<cadena_ascii>"
<cadena_ascii> ::= <caracter_ascii><cadena_ascii>
                 |
# Tipos
<Tipo_variable_simple> ::= int 
                         | float 
                         | char 
                         | bool
<Tipo_variable_complejo> ::= list <Tipo_variable_simple>
<Tipo_variable> ::= <Tipo_variable_simple> 
                  | <Tipo_variable_complejo>
                  
# Programa principal
<Programa> ::= <Cabecera_programa> <bloque> 
<Cabecera_programa> ::= main

# Bloque general
<bloque> ::= <Inicio_de_bloque>
             <Declar_de_variables_locales>
             <Declar_de_subprogs>
             <Sentencias>
             <sentencia_return>
             <Fin_de_bloque>
<Inicio_de_bloque> ::= {
<Fin_de_bloque> ::= }

# Variables locales
<Declar_de_variables_locales> ::= <Marca_ini_declar_variables> 
                                   <Variables_locales> 
                                   <Marca_fin_declar_variables> 
                                |                  
<Marca_ini_declar_variables> ::= local <Inicio_de_bloque>
<Marca_fin_declar_variables> ::= <Fin_de_bloque>
<Variables_locales> ::= <Variables_locales> <Cuerpo_declar_variables> 
                      | <Cuerpo_declar_variables>
<Cuerpo_declar_variables> ::= <Tipo_variable> <Lista_nombres_variables> ;
<Lista_nombres_variables> ::= <ID> 
                            | <ID> , <Lista_nombres_variables>
                            
# Subprogramas (funciones)
<Declar_de_subprogs> ::= <Declar_de_subprogs> <Declar_subprog> |
<Declar_subprog> ::= <Cabecera_subprog> <bloque> 
<Cabecera_subprog> ::= <Tipo_variable> <ID> (<Parametros>) 
                     | <Tipo_variable> <ID> ()
<Parametros> ::= <Parametro>, <Parametros> 
               | <Parametro>
<Parametro> ::= <Tipo_variable> <ID>

# Sentencia return
<sentencia_return> ::= return <ID> ;

# Sentencias
<Sentencias> ::= <Sentencias> <Sentencia> 
               | <Sentencia>
               |
<Sentencia> ::= <bloque>
              | <sentencia_asignacion>
              | <sentencia_if>
              | <sentencia_while> 
              | <sentencia_entrada>
              | <sentencia_salida>
              | <sentencia_do_until>

# Asignación
<sentencia_asignacion> ::= <ID> <op_asignacion> <expresion> ;
<op_asignacion> ::= =

# IF
<sentencia_if> ::= if (<expresion>) <bloque>

# While
<sentencia_while> ::= while (<expresion>) <bloque>

# Entrada
<sentencia_entrada> ::= <nomb_entrada> <lista_variables> ;
<nomb_entrada> ::=  cin
<lista_variables> ::= <ID> , <lista_variables> 
                    | <ID>
                    
# Salida
<sentencia_salida> ::= <nomb_salida> <lista_expresiones_o_cadena> ;
<nomb_entrada> ::=  cout
<lista_expresiones_o_cadena> ::= <lista_expresiones> 
                               | <cadena>
<lista_expresiones> ::= <expresiones> , <lista_expresiones> 
                      | <expresiones>

# Do-Until
<sentencia_do_until> ::= do <bloque> until (<expresion>) ;

# Expresión (devuelven un valor)
<expresion> ::= (<expresion>) 
              |  <op_unario> <expresion>
              |  <expresion> <op_binario> <expresion>
              # Operador ternario de listas
              |  <expresion> ++ <expresion> @ <expresion>
              |  <ID>
              |  <constante>
              |  <llamada_funcion>
# Op unario
<op_unario> ::= NOT
              | <<
              | >>
              | $
# Op binario
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
                           | >=
                           | >
                           | <
                           | <=
                           | ==
                           | !=
<op_binario_booleano> ::= AND 
                        | OR 
                        | XOR  
# Constantes
<constante> ::= <signo><digito><numero_decimal>
              | <bool_cte>
              | <caracter_cte>
              | <lista_cte>
<signo> ::= -
          | +
          |
<numero_decimal> ::= <digito><numero_decimal>  
                   | .<numero> 
                   | <digito>
<numero> ::= <digito><numero> 
           | <digito>
<caracter_cte> ::= "<caracter_ascii>"
                 | '<caracter_ascii>'
<bool_cte> ::= true
             | false
<lista_cte> ::= <abre_lista><tipo_lista_constante><fin_lista>
<abre_lista> ::= [
<fin_lista> ::= ]
<tipo_lista_constante> ::= <lista_int>
                         | <lista_float>
                         | <lista_char>
                         | <lista_bool>
<lista_int> ::= <signo><numero> 
              | <signo><numero>, <lista_int>
<lista_float> ::= <signo><digito><num_float>
                | <signo><digito><num_float>, <lista_float>
<num_float> ::= <digito><num_float> 
              | .<numero>
<lista_char> ::= <caracter_cte>
               | <caracter_cte>, <lista_char>
<lista_bool> ::= <bool_cte>
               | <bool_cte>, <lista_bool>

# Llamada a una función
<llamada_funcion> ::= <ID> (<lista_expresiones>) 
                    | <ID> ()
<lista_expresiones> ::= <expresion>, <lista_expresiones>
                      | <expresion>
```


## TODO

- Ahora mismo nuestra gramática es ambigua al concatenar operaciones 
  en <expresion>. Por ejemplo se puede obtener `NOT <expresion> + <expresion>`
  de dos formas distintas. Realmente no se si eso es un problema porque
  la especificacion de `<expresion>` viene definida asi en el guión.
- Añadir constantes de tipo `list <tipo_simple>` en generación y tokens
- Revisar tokens

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
| OPBINNOBOOL   | 271           | 0: + 1: - 2: * 3: / 4: -- 5: % 6: ** 7: >= 8: <= 9: > 10: < 11: == 12: != | ("+"\|"-"\|"*"\|"/"\|"--"\|"%"\|"**"\|">="\|"<="\|">"\|"<"\|"=="\|"!=")                                                            |
| ARROBA        | 272           |                                  | "@"                                                   |
| INTERROG      | 273           |                                  | "?"                                                   |
| OPUNARIO      | 274           | 0: NOT 1: >> 2: << 3: $          | ("NOT"\|">>"\|"<<"\|"$")                               |
| CONST         | 275           |                                  | ( (-?)(0\|([1-9][0-9]*))(\.[0-9]+)? \| true \| false \| '\[ -\~\]' \| "\[ -\~\]") |
| ASIGN         | 276           |                                  | "="                                                   |
| COMA          | 277           |                                  | ","                                                   |
| MAIN          | 278           |                                  | "main"                                                |
| DO            | 279           |                                  | "do"                                                  |
| UNTIL         | 280           |                                  | "until"                                               |
| WHILE         | 281           |                                  | "while"                                               |
| IF            | 282           |                                  | "if"                                                  |
 
## Referencias

- Explicación de la expresión regular `[ -~]`: [https://catonmat.net/my-favorite-regex](https://catonmat.net/my-favorite-regex).
