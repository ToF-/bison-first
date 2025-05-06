simple: simple.yy
	mkdir -p bin
	bison simple.yy -o simple.cc
	g++ -std=c++14 simple.cc -o bin/simple

rpcalc: rpcalc.y
	mkdir -p bin
	bison rpcalc.y
	cc -lm -o bin/rpcalc rpcalc.tab.c
