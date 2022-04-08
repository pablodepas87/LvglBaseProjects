################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/chart/lv_example_chart_1.c \
../lvgl/examples/widgets/chart/lv_example_chart_2.c \
../lvgl/examples/widgets/chart/lv_example_chart_3.c \
../lvgl/examples/widgets/chart/lv_example_chart_4.c \
../lvgl/examples/widgets/chart/lv_example_chart_5.c \
../lvgl/examples/widgets/chart/lv_example_chart_6.c \
../lvgl/examples/widgets/chart/lv_example_chart_7.c 

C_DEPS += \
./lvgl/examples/widgets/chart/lv_example_chart_1.d \
./lvgl/examples/widgets/chart/lv_example_chart_2.d \
./lvgl/examples/widgets/chart/lv_example_chart_3.d \
./lvgl/examples/widgets/chart/lv_example_chart_4.d \
./lvgl/examples/widgets/chart/lv_example_chart_5.d \
./lvgl/examples/widgets/chart/lv_example_chart_6.d \
./lvgl/examples/widgets/chart/lv_example_chart_7.d 

OBJS += \
./lvgl/examples/widgets/chart/lv_example_chart_1.o \
./lvgl/examples/widgets/chart/lv_example_chart_2.o \
./lvgl/examples/widgets/chart/lv_example_chart_3.o \
./lvgl/examples/widgets/chart/lv_example_chart_4.o \
./lvgl/examples/widgets/chart/lv_example_chart_5.o \
./lvgl/examples/widgets/chart/lv_example_chart_6.o \
./lvgl/examples/widgets/chart/lv_example_chart_7.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/chart/%.o: ../lvgl/examples/widgets/chart/%.c lvgl/examples/widgets/chart/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-chart

clean-lvgl-2f-examples-2f-widgets-2f-chart:
	-$(RM) ./lvgl/examples/widgets/chart/lv_example_chart_1.d ./lvgl/examples/widgets/chart/lv_example_chart_1.o ./lvgl/examples/widgets/chart/lv_example_chart_2.d ./lvgl/examples/widgets/chart/lv_example_chart_2.o ./lvgl/examples/widgets/chart/lv_example_chart_3.d ./lvgl/examples/widgets/chart/lv_example_chart_3.o ./lvgl/examples/widgets/chart/lv_example_chart_4.d ./lvgl/examples/widgets/chart/lv_example_chart_4.o ./lvgl/examples/widgets/chart/lv_example_chart_5.d ./lvgl/examples/widgets/chart/lv_example_chart_5.o ./lvgl/examples/widgets/chart/lv_example_chart_6.d ./lvgl/examples/widgets/chart/lv_example_chart_6.o ./lvgl/examples/widgets/chart/lv_example_chart_7.d ./lvgl/examples/widgets/chart/lv_example_chart_7.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-chart

