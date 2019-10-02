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
<Tipo_variable_complejo> ::= list_of <Tipo_variable_simple>
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

<Cabecera_subprog> ::= <Tipo_variable> <llamada_funcion>

<llamada_funcion> ::= <ID> (<lista_expresiones>) 
                    | <ID> ()

<Parametros> ::= <Parametro>, <Parametros> 
               | <Parametro>

<Parametro> ::= <Tipo_variable> <ID>

# Sentencia return
<sentencia_return> ::= return <tipos_expresion> ;

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
<sentencia_asignacion> ::= <ID> <op_asignacion> <tipos_expresion> ;
<tipos_expresion> ::= <expresion> | <expresion_lista>
<op_asignacion> ::= =

# IF
<sentencia_if> ::= if ( <expresion> ) <bloque>

# While
<sentencia_while> ::= while ( <expresion> ) <bloque>

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
<lista_expresiones> ::= <expresion> , <lista_expresiones> 
                     | <expresion>

# Do-Until
<sentencia_do_until> ::= do <bloque> until (<expresion>) ;

# Expresión sin ambigüedad
<expresion>    ::= <expresion_1> <op_muldivmod> <expresion> | <expresion_1>
<op_muldivmod> ::= * | / | %

<expresion_1> ::= <expresion_2> <op_masmenos> <expresion_1> | <expresion_2>
<op_masmenos> ::= + | -

<expresion_2> ::= <expresion_3> <op_shift> <expresion_2> | <expresion_3>
<op_shift>    ::= >> | <<

<expresion_3>   ::= <expresion_4> <op_relational> <expresion_4> | <expresion_4>
<op_relational> ::= < | > | <= | >=

<expresion_4>     ::= <expresion_5> <op_eqrelational> <expresion_4> | <expresion_5>
<op_eqrelational> ::= == | !=

<expresion_5> ::= <expresion_6> <op_and> <expresion_5> | <expresion_6>
<op_and>      ::= &

<expresion_6> ::= <expresion_7> <op_xor> <expresion_6> | <expresion_7>
<op_xor>      ::= ^

<expresion_7> ::= <expresion_8> <op_or> <expresion_7> | <expresion_8>
<op_or>       ::= |

<expresion_8> ::= <expresion_9> <op_andand> <expresion_8> | <expresion_9>
<op_andand>   ::= &&

<expresion_9> ::= <expresion_10> <op_oror> <expresion_9> | <expresion_10>
<op_oror>     ::= ||

# Unary
<expresion_10> ::= <op_unary> <expresion_10> | <expresion_11>
<op_unary>     ::= ++ | -- | + | - | ! | ~

<expresion_11> ::= (<expresion>) | <llamada_funcion> | <constante>

# Expresión Listas
<expresion_lista> ::= <op_lis_un> <expresion_lista_1> | <expresion_lista_1>  
<op_unario_lista> ::= # | ?

<expresion_lista_1> ::= <expresion_lista_2> <op_lisnum_bin> <entero> | <expresion_lista_2>
<op_binario_lista>  ::= @ | -- | %

<expresion_lista_2> ::= <expresion_lista_3> <op_lislis_bin> <expresion_lista_> | <expresion_lista_3>
<op_lislis_bin>     ::= **

<expresion_lista_3> ::= <expresion_lista_4> <op_lisnum_op> <entero>
                     | <entero> <op_lisnum_op> <expresion_lista_4>  
                     | <expresion_lista_4>

<expresion_lista_4> ::= <expresion_lista_5> ++ <entero> @ <entero> | <expresion_lista_5>

<expresion_lista_5> ::= <lista> | (<expresion_lista>) | <ID>

# Constantes
<constante> ::= <entero>
               | <real>
               | <bool>
               | <caracter>
               | <lista>
               | <ID>

<signo> ::= -
         | +
         |

<real> ::= <entero> <decimal>
         | <decimal>
         | <entero> .

<decimal> ::= . <numero>

<entero> ::= <signo> <numero>
            | <numero>

<numero> ::= <digito> <numero> | <digito>

<caracter> ::= " <caracter_ascii> "
            | ' <caracter_ascii> '

<bool> ::= true
         | false

<lista> ::= <lista_inicio> <lista_expresiones> <lista_fin>
<lista_inicio> ::= [
<lista_fin>    ::= ]
```


## TODO

- Ahora mismo nuestra gramática es ambigua al concatenar operaciones 
  en <expresion>. Por ejemplo se puede obtener `NOT <expresion> + <expresion>`
  de dos formas distintas. Realmente no se si eso es un problema porque
  la especificacion de `<expresion>` viene definida asi en el guión.
- Añadir constantes de tipo `list <tipo_simple>` en generación y tokens
- Revisar tokens

## Tabla de Tokens

| Token         | id | Atributos                        | Patrón     |
|---------------|----|----------------------------------|------------|
| INIBLOQUE     | 0  | | "{" |
| FINBLOQUE     | 1  | | "}" |
| LOCAL         | 2  | | "local" |
| TIPOSIMPLE    | 3  | 0: int 1: float 2: char 3: bool  | `"int"|"float"|"char"|"bool"` |
| ID            | 4  | | [a-z|A-Z][a-z|A-Z|0-9]* |
| PARIZQ        | 5  | | "(" |
| PARDER        | 6  | | ")" |
| PYC           | 7  | | ";" |
| CIN           | 8  | | "cin" |
| COUT          | 9  | | "cout" |
| CADENA        | 10 | | `[ -~]*` |
| RETURN        | 11 | | "return" |
| OPBITWISE     | 12 | 0: & 1: \| 2: ^ | `"&"|"|"|"^" ` |
| OPBINNOBOOL   | 13 | 0: + 1: - 2: * 3: / 5: % 6: ** 7: == 8: != 9: && 10: \|\| | `"+"|"-"|"*"|"/"|"%"\|"**"|"=="|"!="|"&&"|"||"` |
| OPUNARIO      | 14 | 0: -- 1: ++ 2: ! | `"++"|"--"|"!"`
| OPRELACIONAL  | 15 | 0: < 1: > 2: <= 3: >= | `"<"|">"|"<="|">="` |
| OPLISTA       | 16 | 0: @ 1: ** 2: #     | `"@"|"**"|"#"` |
| OPUNARIOLS    | 17 | 0: >> 1: << 2: $ | `"NOT"\|">>"\|"<<"\|"$"` |
| ENTERO        | 18 | | ` (-|+)?[0-9]+ ` |
| REAL          | 19 | | ` ENTERO.[0-9]* ` |
| BOOLEAN       | 20 | 0: true 1: false | ` "true"|"false" ` |
| ASIGN         | 21 | | "=" |
| COMA          | 22 | | "," |
| MAIN          | 23 | | "main" |
| DO            | 24 | | "do" |
| UNTIL         | 25 | | "until" |
| WHILE         | 26 | | "while" |
| IF            | 27 | | "if" |
| LISTA         | 28 | | "list_of" |
 
## Referencias

- Explicación de la expresión regular `[ -~]`: [https://catonmat.net/my-favorite-regex](https://catonmat.net/my-favorite-regex).
- https://import.viva64.com/docx/terminology/Priority/image1.png
