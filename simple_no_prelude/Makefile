



all: hello_llvm.so run_shared

hello_llvm.ll: hello_llvm.cr
	crystal build --prelude=empty --emit llvm-ir hello_llvm.cr -o hello_llvm.o

hello_llvm.o: hello_llvm.ll
	llc hello_llvm.ll --stats -filetype=obj -relocation-model=pic -o hello_llvm.o

hello_llvm.so: hello_llvm.o
	cc -shared hello_llvm.o -o hello_llvm.so

run_shared: run_shared.c
	cc run_shared.c -o run_shared -ldl

clean:
	rm -f hello_llvm.ll
	rm -f hello_llvm.o

fclean: clean
	rm -f hello_llvm.so
	rm -f run_shared

re: fclean all
