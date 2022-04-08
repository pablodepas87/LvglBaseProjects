################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/win/lv_example_win_1.c 

C_DEPS += \
./lvgl/examples/widgets/win/lv_example_win_1.d 

OBJS += \
./lvgl/examples/widgets/win/lv_example_win_1.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/win/%.o: ../lvgl/examples/widgets/win/%.c lvgl/examples/widgets/win/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-win

clean-lvgl-2f-examples-2f-widgets-2f-win:
	-$(RM) ./lvgl/examples/widgets/win/lv_example_win_1.d ./lvgl/examples/widgets/win/lv_example_win_1.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-win

