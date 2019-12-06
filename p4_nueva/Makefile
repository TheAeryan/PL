.SUFFIXES:

prueba: y.tab.c
	gcc -o prueba y.tab.c tabla.c

y.tab.c: semantico.y lex.yy.c
	bison -d -v -o y.tab.c semantico.y

lex.yy.c: lexico.l
	flex lexico.l

limpia:
	rm -f prueba y.tab.c y.tab.h lex.yy.c y.output

todo:
	make --no-print-directory limpia
	make --no-print-directory prueba

# Test
test_programita: todo
	./prueba < ../pruebas/programa_correcto.prog

test_vacio: todo
	./prueba < ../pruebas/programa_vacio.prog

test_sintactico: todo
	./prueba < ../pruebas/errores_sintacticos.txt
