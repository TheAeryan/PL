/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    MAIN = 258,
    LOCAL = 259,
    TIPO = 260,
    PYC = 261,
    CIN = 262,
    COUT = 263,
    CADENA = 264,
    RETURN = 265,
    IF = 266,
    ELSE = 267,
    DO = 268,
    UNTIL = 269,
    WHILE = 270,
    SHIFT = 271,
    CONST = 272,
    INIBLOQUE = 273,
    FINBLOQUE = 274,
    CORIZQ = 275,
    CORDER = 276,
    COMA = 277,
    ASIGN = 278,
    PARDER = 279,
    ID = 280,
    PARIZQ = 281,
    MASMAS = 282,
    AT = 283,
    ORLOG = 284,
    ANDLOG = 285,
    EQN = 286,
    REL = 287,
    PORPOR = 288,
    BORRLIST = 289,
    ADDSUB = 290,
    MULDIV = 291,
    DOLLAR = 292,
    INTHASH = 293,
    MASMENOS = 294,
    EXCL = 295
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
