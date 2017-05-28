

all: build_tool/build_lib hello_llvm.so run_shared

build_tool/build_lib: build_lib.cr
	mkdir -vp build_tool
	crystal build build_lib.cr -o build_tool/build_lib

%.so: %.cr
	./build_tool/build_lib $^ --prelude=empty

run_shared: run_shared.c
	cc run_shared.c -o run_shared -ldl

clean:
	rm -f hello_llvm.ll
	rm -f hello_llvm.o

fclean: clean
	rm -f hello_llvm.so
	rm -f run_shared

re: fclean all
