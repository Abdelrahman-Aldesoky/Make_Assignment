#------------------------------------------------------------------#
# Makefile for AVR projects  "Assignment"                          #
# Author: Abdelrahman Mohamed Ibrahim Al-desoky.                   #
# Date: 07/11/2023                                                 #
#                                                                  #
# This Makefile compiles C source files located in the current     #
# directory into a library for AVR Micro controllers. The          #
# Micro controller model and clock frequency are configurable      #
# through the config.mk file or environment variables. The         #
# Makefile automatically generates dependencies, so that source    #
# files are recompiled when the header files they include are      #
# modified.                                                        #
#                                                                  #
# The Makefile also includes a status report target that checks    #
# if the libraries were successfully produced, and records the     #
# date and time of generation and all libraries names. This works  #
# on both Windows CMD prompt and Linux. The output file is named   #
# Libraries_Status_Report.txt and is placed in the libraries       #
# directory inside the build directory specified in the variables. #
#------------------------------------------------------------------#

# Assign variables based on the OS
ifeq ($(OS),Windows_NT)
MK_DIR = if not exist $(subst /,\,$1) mkdir $(subst /,\,$1)
DEL_ALL = if exist $(subst /,\,$1) rmdir /s /q $(subst /,\,$1)
DATE_CMD = %date% %time%
REPORT = type $(subst /,\,$(L_BUILD_DIR))\Libraries_Status_Report.txt
else
MK_DIR = mkdir -p $1
DEL_ALL = rm -rf $1
DATE_CMD = $(shell date)
REPORT = cat $(L_BUILD_DIR)/Libraries_Status_Report.txt
endif

# Include config.mk if it exists you can assign most of the variables there and it will overwrite the ones in here
-include ../config.mk

# Toolchain definitions
CC ?= avr-gcc
AR ?= avr-ar

# Micro controller Variables
MCU ?= atmega32
F_CPU ?= 8000000

# Compiler flags
CFLAGS ?= -mmcu=$(MCU) -DF_CPU=$(F_CPU) -std=gnu99 -O2 -Wall

# Lib Makefile Directories Variables
L_BUILD_DIR := ../build
L_DEPS_DIR := ../build/dependencies
L_LIBS_DIR := ../build/libraries
L_OBJS_DIR := ../build/objects

# Source files
L_SRCS := $(wildcard *.c)

# Use the part of the filename before the underscore
BASE_NAMES := $(foreach src,$(L_SRCS),$(firstword $(subst _, ,$(basename $(src)))))

# Object files
OBJS := $(addprefix $(L_OBJS_DIR)/, $(addsuffix .o, $(BASE_NAMES)))
DEPS := $(addprefix $(L_DEPS_DIR)/, $(addsuffix .d, $(BASE_NAMES)))
LIBS := $(addprefix $(L_LIBS_DIR)/lib, $(addsuffix .a, $(BASE_NAMES)))

# Rule to create all (Default Rule)
all: $(LIBS)

# Rule to create static libraries
$(L_LIBS_DIR)/lib%.a : $(L_OBJS_DIR)/%.o
	@$(call MK_DIR,$(L_LIBS_DIR))
	@$(AR) rcs $@ $<
	@echo "Library Generation Time: $(DATE_CMD)"
	@echo "Generated Library: $(notdir $@)"

# Rule to create dependency files
$(L_DEPS_DIR)/%.d : %*.c
	@$(call MK_DIR,$(L_BUILD_DIR))
	@$(call MK_DIR,$(L_DEPS_DIR))
	@$(CC) -M -MT '$(L_OBJS_DIR)/$*.o' $< -MF $@

# Include dependencies
-include $(DEPS)

# Rule to create object files
$(L_OBJS_DIR)/%.o : %*.c
	@$(call MK_DIR,$(L_OBJS_DIR))
	@$(CC) $(CFLAGS) -c $< -o $@

# Rule to clean all generated files
clean:
	@$(call DEL_ALL,$(L_BUILD_DIR))
	@echo "Cleanup complete. All generated files have been removed."

# Status report rule
status:
	@echo "Libraries Status Report" > $(L_BUILD_DIR)/Libraries_Status_Report.txt
	@echo "Date and Time of Generation: $(DATE_CMD)" >> $(L_BUILD_DIR)/Libraries_Status_Report.txt
	@echo "Existing Libraries are as follows:" >> $(L_BUILD_DIR)/Libraries_Status_Report.txt

ifeq ($(OS),Windows_NT)
	@if exist "$(subst /,\,$(L_LIBS_DIR))\*.a" ( \
		dir /b $(subst /,\,$(L_LIBS_DIR))\*.a >> $(subst /,\,$(L_BUILD_DIR))/Libraries_Status_Report.txt; \
	) else ( \
		echo "No libraries found." >> $(subst /,\,$(L_BUILD_DIR))/Libraries_Status_Report.txt; \
	) 
else
	@if [ "`ls $(L_LIBS_DIR) 2>/dev/null`" ]; then \
		echo $(notdir $(wildcard $(L_LIBS_DIR)/*.a)) >> $(L_BUILD_DIR)/Libraries_Status_Report.txt; \
	else \
		echo "No libraries found." >> $(L_BUILD_DIR)/Libraries_Status_Report.txt; \
	fi;
endif

	@$(REPORT)

# Help target
help:
	@echo "|----------------------------------------HELP.------------------------------------------|"
	@echo "|                                                                                       |"
	@echo "|This Makefile compiles C source files located in the current directory into libraries  |"
	@echo "|for AVR Micro controller. The Micro controller model and clock frequency are           |"
	@echo "|configurable through the config.mk file or environment variables. The Makefile         |"
	@echo "|automatically generates dependencies, so that source files are recompiled automatically|"
	@echo "|when the header files corresponding to it get modified.                                |"
	@echo "|                                                                                       |"
	@echo "|The Makefile also includes a status report target that checks if the libraries were    |"
	@echo "|successfully produced, and records the date and time of generation and all library     |"
	@echo "|names. This works on both Windows CMD prompt and Linux. The output file is named       |"
	@echo "|Libraries_Status_Report.txt and is placed in the libraries directory inside the build  |"
	@echo "|directory specified in the variables. The status_report target is the default target   |"
	@echo "|and it builds all the libraries before generating the status report.                   |"
	@echo "|                                                                                       |"
	@echo "|Usage:                                                                                 |"
	@echo "|  make [TARGET] [VARIABLE=value]                                                       |"
	@echo "|                                                                                       |"
	@echo "|Targets:                                                                               |"
	@echo "|  all (default)           : Builds the libraries and generates status report.          |"
	@echo "|  status                  : Generates a status report.                                 |"
	@echo "|  clean                   : Removes all generated files so be careful.                 |"
	@echo "|  help                    : Displays this help menu.                                   |"
	@echo "|                                                                                       |"
	@echo "|Variables:                                                                             |"
	@echo "|  MCU   : The Micro controller model (default: atmega32).                              |"
	@echo "|  F_CPU : The Micro controller clock frequency in Hz (default: 8000000).               |"
	@echo "|  CFLAGS: Additional flags to pass to the compiler.                                    |"
	@echo "|                                                                                       |"
	@echo "|Examples:                                                                              |"
	@echo "|  make                                                                                 |"
	@echo "|  make all MCU=atmega328p F_CPU=16000000UL CFLAGS=-O2 -Wall                            |"
	@echo "|  make clean                                                                           |"
	@echo "|  make status                                                                          |"
	@echo "|  make help                                                                            |"
	@echo "|---------------------------------------------------------------------------------------|"

# Phony targets
.PHONY: all status clean help

# Delete on error so no corrupt files
.DELETE_ON_ERROR: