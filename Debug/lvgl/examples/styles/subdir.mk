################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/styles/lv_example_style_1.c \
../lvgl/examples/styles/lv_example_style_10.c \
../lvgl/examples/styles/lv_example_style_11.c \
../lvgl/examples/styles/lv_example_style_12.c \
../lvgl/examples/styles/lv_example_style_13.c \
../lvgl/examples/styles/lv_example_style_14.c \
../lvgl/examples/styles/lv_example_style_2.c \
../lvgl/examples/styles/lv_example_style_3.c \
../lvgl/examples/styles/lv_example_style_4.c \
../lvgl/examples/styles/lv_example_style_5.c \
../lvgl/examples/styles/lv_example_style_6.c \
../lvgl/examples/styles/lv_example_style_7.c \
../lvgl/examples/styles/lv_example_style_8.c \
../lvgl/examples/styles/lv_example_style_9.c 

C_DEPS += \
./lvgl/examples/styles/lv_example_style_1.d \
./lvgl/examples/styles/lv_example_style_10.d \
./lvgl/examples/styles/lv_example_style_11.d \
./lvgl/examples/styles/lv_example_style_12.d \
./lvgl/examples/styles/lv_example_style_13.d \
./lvgl/examples/styles/lv_example_style_14.d \
./lvgl/examples/styles/lv_example_style_2.d \
./lvgl/examples/styles/lv_example_style_3.d \
./lvgl/examples/styles/lv_example_style_4.d \
./lvgl/examples/styles/lv_example_style_5.d \
./lvgl/examples/styles/lv_example_style_6.d \
./lvgl/examples/styles/lv_example_style_7.d \
./lvgl/examples/styles/lv_example_style_8.d \
./lvgl/examples/styles/lv_example_style_9.d 

OBJS += \
./lvgl/examples/styles/lv_example_style_1.o \
./lvgl/examples/styles/lv_example_style_10.o \
./lvgl/examples/styles/lv_example_style_11.o \
./lvgl/examples/styles/lv_example_style_12.o \
./lvgl/examples/styles/lv_example_style_13.o \
./lvgl/examples/styles/lv_example_style_14.o \
./lvgl/examples/styles/lv_example_style_2.o \
./lvgl/examples/styles/lv_example_style_3.o \
./lvgl/examples/styles/lv_example_style_4.o \
./lvgl/examples/styles/lv_example_style_5.o \
./lvgl/examples/styles/lv_example_style_6.o \
./lvgl/examples/styles/lv_example_style_7.o \
./lvgl/examples/styles/lv_example_style_8.o \
./lvgl/examples/styles/lv_example_style_9.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/styles/%.o: ../lvgl/examples/styles/%.c lvgl/examples/styles/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-styles

clean-lvgl-2f-examples-2f-styles:
	-$(RM) ./lvgl/examples/styles/lv_example_style_1.d ./lvgl/examples/styles/lv_example_style_1.o ./lvgl/examples/styles/lv_example_style_10.d ./lvgl/examples/styles/lv_example_style_10.o ./lvgl/examples/styles/lv_example_style_11.d ./lvgl/examples/styles/lv_example_style_11.o ./lvgl/examples/styles/lv_example_style_12.d ./lvgl/examples/styles/lv_example_style_12.o ./lvgl/examples/styles/lv_example_style_13.d ./lvgl/examples/styles/lv_example_style_13.o ./lvgl/examples/styles/lv_example_style_14.d ./lvgl/examples/styles/lv_example_style_14.o ./lvgl/examples/styles/lv_example_style_2.d ./lvgl/examples/styles/lv_example_style_2.o ./lvgl/examples/styles/lv_example_style_3.d ./lvgl/examples/styles/lv_example_style_3.o ./lvgl/examples/styles/lv_example_style_4.d ./lvgl/examples/styles/lv_example_style_4.o ./lvgl/examples/styles/lv_example_style_5.d ./lvgl/examples/styles/lv_example_style_5.o ./lvgl/examples/styles/lv_example_style_6.d ./lvgl/examples/styles/lv_example_style_6.o ./lvgl/examples/styles/lv_example_style_7.d ./lvgl/examples/styles/lv_example_style_7.o ./lvgl/examples/styles/lv_example_style_8.d ./lvgl/examples/styles/lv_example_style_8.o ./lvgl/examples/styles/lv_example_style_9.d ./lvgl/examples/styles/lv_example_style_9.o

.PHONY: clean-lvgl-2f-examples-2f-styles

