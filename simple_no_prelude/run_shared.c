#include <dlfcn.h>
#include <stdio.h>

int main()
{
  char *err;

  void *lib_handler = dlopen("./hello_llvm.so", RTLD_NOW);
  if ((err = dlerror())) {
    puts("dlopen error: ");
    puts(err);
    return 1;
  }

  void (*func)() = dlsym(lib_handler, "crystal_do_something");
  printf("func `crystal_do_something` is at %p\n", func);
  if ((err = dlerror())) {
    puts("dlsym error: ");
    puts(err);
    return 2;
  }

  func();

  dlclose(lib_handler);
  return (0);
}
