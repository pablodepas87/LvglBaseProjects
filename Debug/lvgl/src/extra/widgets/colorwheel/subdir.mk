################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/src/extra/widgets/colorwheel/lv_colorwheel.c 

C_DEPS += \
./lvgl/src/extra/widgets/colorwheel/lv_colorwheel.d 

OBJS += \
./lvgl/src/extra/widgets/colorwheel/lv_colorwheel.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/src/extra/widgets/colorwheel/%.o: ../lvgl/src/extra/widgets/colorwheel/%.c lvgl/src/extra/widgets/colorwheel/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-colorwheel

clean-lvgl-2f-src-2f-extra-2f-widgets-2f-colorwheel:
	-$(RM) ./lvgl/src/extra/widgets/colorwheel/lv_colorwheel.d ./lvgl/src/extra/widgets/colorwheel/lv_colorwheel.o

.PHONY: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-colorwheel

