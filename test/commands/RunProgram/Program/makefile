# Makefile to compile testprog program
# - create an executable that is specific to the operating system
# - the executable is committed to the repository because it is small
#   and will save other developers the trouble of recompiling the program

ifdef OS
	# Windows
	EXENAME = testprog-win.exe
else
	# Assume Linux
	EXENAME = testprog-linux
endif

# Compile the executable, with program name matching the OS
$(EXENAME): testprog.o
	@echo "Compiling $(EXENAME)"
	$(CC) $(CFLAGS) -o $(EXENAME) $^ $(LDFLAGS)
