simple: simple.yy
	mkdir -p bin
	bison simple.yy -o simple.cc
	g++ -std=c++14 simple.cc -o bin/simple

rpcalc: rpcalc.y
	mkdir -p bin
	bison rpcalc.y
	cc -lm -o bin/rpcalc rpcalc.tab.c

loner: loner.y
	mkdir -p bin
	bison loner.y
	cc -lm -o bin/loner loner.tab.c

calc: calc.y
	mkdir -p bin
	bison calc.y
	cc -lm -o bin/calc calc.tab.c

