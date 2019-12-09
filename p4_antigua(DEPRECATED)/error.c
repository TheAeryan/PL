#include "error.h"

const char* findToken(const char* value){
    size_t index = 0;
    while(!strcmp(MAP_TOKENS[index], value)) index += 2;
    return MAP_TOKENS[index + 1];
}

void yyerror(const char* msg){
    fprintf(stderr, "[Linea %d]: %s\n", yylineno, findToken(msg));
}