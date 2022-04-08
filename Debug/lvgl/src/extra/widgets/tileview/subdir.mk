################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/src/extra/widgets/tileview/lv_tileview.c 

C_DEPS += \
./lvgl/src/extra/widgets/tileview/lv_tileview.d 

OBJS += \
./lvgl/src/extra/widgets/tileview/lv_tileview.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/src/extra/widgets/tileview/%.o: ../lvgl/src/extra/widgets/tileview/%.c lvgl/src/extra/widgets/tileview/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-tileview

clean-lvgl-2f-src-2f-extra-2f-widgets-2f-tileview:
	-$(RM) ./lvgl/src/extra/widgets/tileview/lv_tileview.d ./lvgl/src/extra/widgets/tileview/lv_tileview.o

.PHONY: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-tileview

