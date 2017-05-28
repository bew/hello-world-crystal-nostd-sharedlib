#include <dlfcn.h>
#include <stdio.h>

int main()
{
  void *lib_handler = dlopen("./crllvm.so", RTLD_NOW);
  if (dlerror()) {
    perror("dlopen");
    return 1;
  }

  void (*func)() = dlsym(lib_handler, "crystal_do_something");
  printf("func is at %p\n", func);
  if (dlerror()) {
    perror("dlsym");
    return 2;
  }

  func();

  dlclose(lib_handler);
  return (0);
}
