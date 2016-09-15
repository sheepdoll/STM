#
#  Copyright (c) 2011 Arduino.  All right reserved.
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#  See the GNU Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

# Tool suffix when cross-compiling
ifndef ARM_GCC_TOOLCHAIN
ARM_GCC_TOOLCHAIN = /usr/bin
endif
CROSS_COMPILE = $(ARM_GCC_TOOLCHAIN)/arm-none-eabi-

# Compilation tools
AR = $(CROSS_COMPILE)ar
CC = $(CROSS_COMPILE)gcc
AS = $(CROSS_COMPILE)as
NM = $(CROSS_COMPILE)nm
ifeq ($(OS),Windows_NT)
RM=cs-rm -Rf
#RM=del /s /f
else
RM=rm -Rf
endif

SEP=/

# ---------------------------------------------------------------------------------------
# C Flags

CFLAGS += -Wall -Wformat=2 -Wuninitialized
CFLAGS += -Wmain -Wparentheses -Wsequence-point -Wswitch -Wtrigraphs
CFLAGS += -Wunknown-pragmas -Wformat -Wchar-subscripts -Wcomment -Wimplicit-int
#CFLAGS += -Wpedantic
#CFLAGS += -Wextra
CFLAGS += -Winit-self -Wswitch-default -Wlogical-op -Wvla -Wwrite-strings
CFLAGS += -Werror-implicit-function-declaration -Wsign-compare -Wstrict-prototypes
CFLAGS += -Wreturn-type -Wunused -Wfloat-equal -Wundef -Wshadow -Wpointer-arith
CFLAGS += -Waggregate-return -Wstrict-prototypes -Wunreachable-code -Wpacked
CFLAGS += -Wmissing-format-attribute -Wno-deprecated-declarations -Wnested-externs
CFLAGS += -Winline -Wlong-long -Winvalid-pch -Wmissing-include-dirs
CFLAGS += -Os

# Cause too many warnings or false positives
#CFLAGS += -Wconversion -Wunused-parameter -Wmissing-prototypes -Wmissing-declarations
#CFLAGS += -Wmissing-noreturn -Wredundant-decls -Wbad-function-cast -Wcast-align

# Enable by -Wall
#CFLAGS += -Wmain -Wparentheses -Wsequence-point -Wswitch -Wtrigraphs
#CFLAGS += -Wunknown-pragmas -Wformat -Wchar-subscripts -Wcomment -Wimplicit-int

# To reduce application size use only integer printf function.
CFLAGS += -Dprintf=iprintf

CFLAGS += --param max-inline-insns-single=500 -mcpu=cortex-m3 -mthumb -mlong-calls -ffunction-sections -fdata-sections -std=c99 -msoft-float -mfloat-abi=soft
CFLAGS += $(OPTIMIZATION) $(INCLUDES) -D$(CHIP)


# ---------------------------------------------------------------------------------------
# ASM Flags

ASFLAGS = -mcpu=cortex-m3 -mthumb
#-Wall -a $(INCLUDES)
