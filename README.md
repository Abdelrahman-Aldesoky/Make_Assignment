# Make Assignment

This project contains two Makefiles. They compile C source files into .hex, .elf, and .a files for AVR Microcontrollers. <br>
The Microcontroller model and clock frequency are configurable. <br>
You can set them through the config.mk file or environment variables. <br>
The Makefiles automatically generate dependencies. <br>
This means that source files are recompiled when the header files they include are modified. <br>

This ensures efficient building. <br>
Only the parts of the project that have changed are recompiled. <br>
For example, if a part of a library has changed, only that library will be recompiled. Not all of the libraries.

The project is capable of compiling multiple application programs with the libraries. <br>
It's designed to be efficient. It only compiles with the libraries needed for the specific application. <br>
If multiple applications share the same libraries, those libraries only need to be compiled once. <br>
They can be used by all the applications that need them.

## Configuration File (config.mk)

The config.mk file is used to configure both the main and library Makefiles. It contains the following variables:

- `MCU`: The Microcontroller model (default: atmega32).
- `F_CPU`: The Microcontroller clock frequency in Hz (default: 8000000).
- `M_BUILD_DIR`, `M_DEPS_DIR`, `M_LIBS_DIR`, `M_OBJS_DIR`, `M_SRCS_DIR`, `M_INCS_DIR`: Directories for the main Makefile.
- `L_BUILD_DIR`, `L_DEPS_DIR`, `L_LIBS_DIR`, `L_OBJS_DIR`: Directories for the library Makefile.
- `LDFLAGS`: Linker flag.
- `CC`, `AR`, `OBJCOPY`, `SIZE`: Toolchain definitions.
- `CFLAGS`: Additional flags to pass to the compiler.

## Main Makefile

The main Makefile compiles C source files. They are located in the src directory. <br>
It compiles them into .hex and .elf files. It also includes a status target. <br>
This checks if the .hex files were successfully produced. <br>
It records the date and time of generation. <br>
This works on both Windows CMD prompt and Linux. <br>
The output file is named Status_Report.txt. <br>
It is placed in the build directory specified in the variables.

### Usage

```bash
make [TARGET] [VARIABLE=value]
```

### Targets

- `all` (default): Builds the .hex and .elf files.
- `libs`: Builds all the outdated libraries in my lib directory.
- `status`: Generates a status report.
- `clean`: Removes all generated files.
- `help`: Displays the help menu.

### Variables

- `MCU`: The Microcontroller model (default: atmega32).
- `F_CPU`: The Microcontroller clock frequency in Hz (default: 8000000).
- `CFLAGS`: Additional flags to pass to the compiler.

## Library Makefile

The library Makefile compiles C source files. <br>
They are located in the current directory. <br>
It compiles them into libraries for AVR Microcontrollers. <br>
It also includes a status target. <br>
This checks if the libraries were successfully produced. <br>
It records the date and time of generation and all library names. <br>
This works on both Windows CMD prompt and Linux. <br>
The output file is named Libraries_Status_Report.txt. <br>
It is placed in the libraries directory inside the build directory specified in the variables. <br>
The all target is the default target. <br>
It builds all the libraries that need to built.

### Usage

```bash
make [TARGET] [VARIABLE=value]
```

### Targets

- `all` (default): Builds all the libraries.
- `status`: Generates a status report.
- `clean`: Removes all generated files.
- `help`: Displays the help menu.

### Variables

- `MCU`: The Microcontroller model (default: atmega32).
- `F_CPU`: The Microcontroller clock frequency in Hz (default: 8000000).
- `CFLAGS`: Additional flags to pass to the compiler.
