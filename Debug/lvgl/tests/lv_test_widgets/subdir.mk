################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/tests/lv_test_widgets/lv_test_label.c 

C_DEPS += \
./lvgl/tests/lv_test_widgets/lv_test_label.d 

OBJS += \
./lvgl/tests/lv_test_widgets/lv_test_label.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/tests/lv_test_widgets/%.o: ../lvgl/tests/lv_test_widgets/%.c lvgl/tests/lv_test_widgets/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-tests-2f-lv_test_widgets

clean-lvgl-2f-tests-2f-lv_test_widgets:
	-$(RM) ./lvgl/tests/lv_test_widgets/lv_test_label.d ./lvgl/tests/lv_test_widgets/lv_test_label.o

.PHONY: clean-lvgl-2f-tests-2f-lv_test_widgets

