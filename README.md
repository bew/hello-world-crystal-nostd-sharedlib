# Hello LLVM - crystal shared library experiment

This is a baby experiment on LLVM compilation, to build a shared library from crystal source code

## Simple Crystal code, with an empty prelude

### Description

The generated library will exit the current process with error code `42`.

### Run the test

```sh
$ cd ./simple_no_prelude
```

1. Build the tester `run_shared`

```sh
$ make run_shared
```

2. Build the crystal shared library `hello_llvm.so`

```sh
$ make hello_llvm.so
```

3. Finally, run the binary `run_shared`, this will open the `hello_llvm.so` shared library, locate a function named `crystal_do_something`, then run it.

```sh
$ ./run_shared
$ echo $?           # The default `hello_llvm` just exit the process with 42
42
```

## Full Crystal code

TODO
