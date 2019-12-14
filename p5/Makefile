.SUFFIXES:

traductor: y.tab.c
	gcc -o traductor y.tab.c

y.tab.c: semantico.y lex.yy.c
	bison -d -v -o y.tab.c semantico.y

lex.yy.c: lexico.l
	flex lexico.l

limpia:
	rm -f traductor y.tab.c lex.yy.c y.output y.tab.h a.out dec_fun.c prog.c gencodigo1 gencodigo2

todo:
	make --no-print-directory limpia
	make --no-print-directory traductor

# Test
test: todo
	./traductor < ../pruebas/programa_correcto.prog
	gcc prog.c -o programa_correcto
	./programa_correcto

test_sintactico: todo
	./traductor < ../pruebas/errores_sintacticos.prog

generacion1: todo
	./traductor < ../pruebas/gencodigo1.prog
	gcc prog.c -o gencodigo1
	./gencodigo1

generacion2: todo
	./traductor < ../pruebas/gencodigo2.prog
	gcc prog.c -o gencodigo2
	./gencodigo2

lukas: todo
	./traductor < ../pruebas/prueba_lukas.prog
