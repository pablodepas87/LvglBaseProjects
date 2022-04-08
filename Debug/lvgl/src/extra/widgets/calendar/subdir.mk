################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/src/extra/widgets/calendar/lv_calendar.c \
../lvgl/src/extra/widgets/calendar/lv_calendar_header_arrow.c \
../lvgl/src/extra/widgets/calendar/lv_calendar_header_dropdown.c 

C_DEPS += \
./lvgl/src/extra/widgets/calendar/lv_calendar.d \
./lvgl/src/extra/widgets/calendar/lv_calendar_header_arrow.d \
./lvgl/src/extra/widgets/calendar/lv_calendar_header_dropdown.d 

OBJS += \
./lvgl/src/extra/widgets/calendar/lv_calendar.o \
./lvgl/src/extra/widgets/calendar/lv_calendar_header_arrow.o \
./lvgl/src/extra/widgets/calendar/lv_calendar_header_dropdown.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/src/extra/widgets/calendar/%.o: ../lvgl/src/extra/widgets/calendar/%.c lvgl/src/extra/widgets/calendar/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-calendar

clean-lvgl-2f-src-2f-extra-2f-widgets-2f-calendar:
	-$(RM) ./lvgl/src/extra/widgets/calendar/lv_calendar.d ./lvgl/src/extra/widgets/calendar/lv_calendar.o ./lvgl/src/extra/widgets/calendar/lv_calendar_header_arrow.d ./lvgl/src/extra/widgets/calendar/lv_calendar_header_arrow.o ./lvgl/src/extra/widgets/calendar/lv_calendar_header_dropdown.d ./lvgl/src/extra/widgets/calendar/lv_calendar_header_dropdown.o

.PHONY: clean-lvgl-2f-src-2f-extra-2f-widgets-2f-calendar

