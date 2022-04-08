################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/src/extra/widgets/keyboard/lv_keyboard.c 

C_DEPS += \
./lvgl/src/extra/widgets/keyboard/lv_keyboard.d 

OBJS += \
./lvgl/src/extra/widgets/keyboard/lv_keyboard.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/src/extra/widgets/keyboard/%.o: ../lvgl/src/extra/widgets/keyboard/%.c lvgl/src/extra/widgets/keyboard/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-keyboard

clean-lvgl-2f-src-2f-extra-2f-widgets-2f-keyboard:
	-$(RM) ./lvgl/src/extra/widgets/keyboard/lv_keyboard.d ./lvgl/src/extra/widgets/keyboard/lv_keyboard.o

.PHONY: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-keyboard

