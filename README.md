# 'Hello world' crystal shared library experiment

This is a baby experiment on LLVM compilation, to build a shared library from crystal source code

## Simple Crystal code, with an empty prelude

### Description

The generated library will exit the current process with error code `42`.

### Run the test

```sh
$ cd ./simple_no_prelude
```

1. Build the tester `run_shared` (written in C)

   ```sh
   $ make run_shared
   ```

2. Build the shared library `hello_llvm.so` (written in Crystal, without stdlib)

   ```sh
   $ make hello_llvm.so
   ```

3. Finally, run the binary `run_shared`, this will open the `hello_llvm.so` shared library, locate a function named `crystal_do_something`, then run it.

   ```sh
   $ ./run_shared
   $ echo $?
   42
   ```
