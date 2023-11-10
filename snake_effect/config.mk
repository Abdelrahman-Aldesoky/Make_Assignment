# Project name currently its named same as the parent directory
PROJECT_NAME := $(notdir $(CURDIR))

# Micro controller Variables
MCU = atmega32
F_CPU = 8000000

# Main Makefile Directories Variables
M_BUILD_DIR := ./build
M_DEPS_DIR := ./build/dependencies
M_LIBS_DIR := ./build/libraries
M_OBJS_DIR := ./build/objects
M_SRCS_DIR := ./src
M_INCS_DIR := ./inc

# Lib Makefile Directories Variables
L_BUILD_DIR := ../build
L_DEPS_DIR := ../build/dependencies
L_LIBS_DIR := ../build/libraries
L_OBJS_DIR := ../build/objects

# Toolchain definitions
CC := avr-gcc
AR := avr-ar
OBJCOPY := avr-objcopy
SIZE := avr-size

# Compiler flags linker flag
CFLAGS = -mmcu=$(MCU) -DF_CPU=$(F_CPU) -std=gnu99 -O2 -Wall
LDFLAGS = -L$(M_LIBS_DIR)