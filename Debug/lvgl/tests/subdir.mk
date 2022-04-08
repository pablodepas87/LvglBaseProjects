################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/tests/lv_test_assert.c \
../lvgl/tests/lv_test_main.c 

C_DEPS += \
./lvgl/tests/lv_test_assert.d \
./lvgl/tests/lv_test_main.d 

OBJS += \
./lvgl/tests/lv_test_assert.o \
./lvgl/tests/lv_test_main.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/tests/%.o: ../lvgl/tests/%.c lvgl/tests/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-tests

clean-lvgl-2f-tests:
	-$(RM) ./lvgl/tests/lv_test_assert.d ./lvgl/tests/lv_test_assert.o ./lvgl/tests/lv_test_main.d ./lvgl/tests/lv_test_main.o

.PHONY: clean-lvgl-2f-tests

