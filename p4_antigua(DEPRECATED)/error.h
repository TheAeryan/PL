#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define NUM_TOKENS 38

extern int yylineno;

const char* MAP_TOKENS[2 * NUM_TOKENS] = {
    "INIBLOQUE", "{",
    "FINBLOQUE", "}",
    "LOCAL"    , "local",
    "TIPO"     , "tipo",
    "ID"       , "identificador",
    "PARIZQ"   , "(",
    "PARDER"   , ")",
    "PYC"      , ";",
    "CIN"      , "cin",
    "COUT"     , "cout",
    "CADENA"   , "string",
    "RETURN"   , "return",
    "ORLOG"    , "||",
    "ANDLOG"   , "&&",
    "EQN"      , "== or !=",
    "REL"      , "< or > or <= or >=",
    "ADDSUB"   , "+ or -",
    "MUL"      , "*",
    "DIV"      , "/",
    "EXCL"     , "!",
    "PORPOR"   , "**",
    "BORRLIST" , "-- or %",
    "INTHASH"  , "? or #",
    "AT"       , "@",
    "MASMAS"   , "++",
    "DOLLAR"   , "$",
    "SHIFT"    , "<< or >>",
    "CONST"    , "constante",
    "ASIGN"    , "=",
    "COMA"     , ",",
    "MAIN"     , "main",
    "DO"       , "do",
    "UNTIL"    , "until",
    "IF"       , "if",
    "WHILE"    , "while",
    "ELSE"     , "else",
    "CORIZQ"   , "]",
    "CORDER"   , "]"
};

const char* findToken(const char*);

void yyerror(const char*);