################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../assets/mouse_cursor_icon.c 

C_DEPS += \
./assets/mouse_cursor_icon.d 

OBJS += \
./assets/mouse_cursor_icon.o 


# Each subdirectory must supply rules for building sources it contributes
assets/%.o: ../assets/%.c assets/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-assets

clean-assets:
	-$(RM) ./assets/mouse_cursor_icon.d ./assets/mouse_cursor_icon.o

.PHONY: clean-assets

