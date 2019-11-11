.SUFFIXES:

prueba: y.tab.c
	gcc -o prueba y.tab.c

y.tab.c: sintactico.y lex.yy.c
#	yacc -d -v -o y.tab.c sintactico.y
	bison -d -v -o y.tab.c sintactico.y

lex.yy.c: lexico.l
	flex lexico.l

limpia:
	rm -f prueba y.tab.c lex.yy.c y.output y.tab.h

todo:
	make limpia
	make prueba
