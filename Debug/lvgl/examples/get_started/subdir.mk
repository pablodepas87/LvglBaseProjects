################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/get_started/lv_example_get_started_1.c \
../lvgl/examples/get_started/lv_example_get_started_2.c \
../lvgl/examples/get_started/lv_example_get_started_3.c 

C_DEPS += \
./lvgl/examples/get_started/lv_example_get_started_1.d \
./lvgl/examples/get_started/lv_example_get_started_2.d \
./lvgl/examples/get_started/lv_example_get_started_3.d 

OBJS += \
./lvgl/examples/get_started/lv_example_get_started_1.o \
./lvgl/examples/get_started/lv_example_get_started_2.o \
./lvgl/examples/get_started/lv_example_get_started_3.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/get_started/%.o: ../lvgl/examples/get_started/%.c lvgl/examples/get_started/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-get_started

clean-lvgl-2f-examples-2f-get_started:
	-$(RM) ./lvgl/examples/get_started/lv_example_get_started_1.d ./lvgl/examples/get_started/lv_example_get_started_1.o ./lvgl/examples/get_started/lv_example_get_started_2.d ./lvgl/examples/get_started/lv_example_get_started_2.o ./lvgl/examples/get_started/lv_example_get_started_3.d ./lvgl/examples/get_started/lv_example_get_started_3.o

.PHONY: clean-lvgl-2f-examples-2f-get_started

