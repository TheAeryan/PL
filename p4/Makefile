.SUFFIXES:

traductor: y.tab.c
	gcc -o traductor y.tab.c

y.tab.c: semantico.y lex.yy.c
	bison -d -v -o y.tab.c semantico.y

lex.yy.c: lexico.l
	flex lexico.l

limpia:
	rm -f traductor y.tab.c lex.yy.c y.output y.tab.h

todo:
	make --no-print-directory limpia
	make --no-print-directory traductor

# Test
test_programita: todo
	./traductor < ../pruebas/programa_correcto.prog

test_sintactico: todo
	./traductor < ../pruebas/errores_sintacticos.txt
