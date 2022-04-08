################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/msgbox/lv_example_msgbox_1.c 

C_DEPS += \
./lvgl/examples/widgets/msgbox/lv_example_msgbox_1.d 

OBJS += \
./lvgl/examples/widgets/msgbox/lv_example_msgbox_1.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/msgbox/%.o: ../lvgl/examples/widgets/msgbox/%.c lvgl/examples/widgets/msgbox/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-msgbox

clean-lvgl-2f-examples-2f-widgets-2f-msgbox:
	-$(RM) ./lvgl/examples/widgets/msgbox/lv_example_msgbox_1.d ./lvgl/examples/widgets/msgbox/lv_example_msgbox_1.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-msgbox

