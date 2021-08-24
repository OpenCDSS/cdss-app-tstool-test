# Program

This folder contains the source code and executables for a simple test program,
compiled for Linux and Windows, which is used with the RunProgram command tests.

To compile the program, execute the following in this folder:

```
make
```

The output of the compile is:

* `testprog-linux` - Linux executable, compiled with `gcc`
* `testprog-win` - Windows executable, **to be implemented**

Object files (`*.o) are ignored via the main `.gitignore` file.

Use the `run-testprog.sh` script to test whether the program is working as intended,
via visual inspection.
