simple: simple.yy
	mkdir -p bin
	bison simple.yy -o simple.cc
	g++ -std=c++14 simple.cc -o bin/simple
