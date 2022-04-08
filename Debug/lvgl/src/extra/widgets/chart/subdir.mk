################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/src/extra/widgets/chart/lv_chart.c 

C_DEPS += \
./lvgl/src/extra/widgets/chart/lv_chart.d 

OBJS += \
./lvgl/src/extra/widgets/chart/lv_chart.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/src/extra/widgets/chart/%.o: ../lvgl/src/extra/widgets/chart/%.c lvgl/src/extra/widgets/chart/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-chart

clean-lvgl-2f-src-2f-extra-2f-widgets-2f-chart:
	-$(RM) ./lvgl/src/extra/widgets/chart/lv_chart.d ./lvgl/src/extra/widgets/chart/lv_chart.o

.PHONY: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-chart

