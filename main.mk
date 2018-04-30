CC = arm-none-eabi-gcc
SIZE = arm-none-eabi-size
OBJCOPY = arm-none-eabi-objcopy

COMMON_FLAGS = -mcpu=cortex-m3 -mthumb -mfloat-abi=soft -g3

DEFINES = -DEFM32GG332F512

INCLUDE += -I include -I CMSIS/Include -I ./ -I emlib/inc
INCLUDE += -I./emdrv/common/inc
INCLUDE += -I./emdrv/dmadrv/config
INCLUDE += -I./emdrv/dmadrv/inc
INCLUDE += -I./emdrv/gpiointerrupt/inc
INCLUDE += -I./emdrv/nvm/config
INCLUDE += -I./emdrv/nvm/inc
INCLUDE += -I./emdrv/rtcdrv/config
INCLUDE += -I./emdrv/rtcdrv/inc
INCLUDE += -I./emdrv/sleep/inc
INCLUDE += -I./emdrv/spidrv/config
INCLUDE += -I./emdrv/spidrv/inc
INCLUDE += -I./emdrv/tempdrv/config
INCLUDE += -I./emdrv/tempdrv/inc
INCLUDE += -I./emdrv/uartdrv/config
INCLUDE += -I./emdrv/uartdrv/inc
INCLUDE += -I./emdrv/ustimer/config
INCLUDE += -I./emdrv/ustimer/inc

WARNINGS := -Wall -Wimplicit-fallthrough -Wextra -Wfloat-equal -Wshadow

CFLAGS := $(COMMON_FLAGS) $(INCLUDE) $(DEFINES) $(WARNINGS) -O3 -std=gnu11 -pipe -ffunction-sections -fdata-sections

SUBMAKEFILES := main/main.mk startup_code/startup_code.mk SEGGER/SEGGER.mk emlib/emlib.mk emdrv/emdrv.mk

BUILD_DIR  := build

TARGET_DIR := build_output

#nosys.specs are required for printf
LDFLAGS = $(COMMON_FLAGS) -T linker_script/efm32gg.ld --specs=nosys.specs -Wl,--gc-sections

TARGET := main.elf

bin: $(TARGET_DIR)/main.elf
	$(OBJCOPY) -O binary $(TARGET_DIR)/main.elf $(TARGET_DIR)/main.bin

#clean:
#	rm -f main.bin main.map

size: $(TARGET_DIR)/main.elf
	$(SIZE) $(TARGET_DIR)/main.elf
