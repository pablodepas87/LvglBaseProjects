################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include lvgl/tests/lv_test_widgets/subdir.mk
-include lvgl/tests/lv_test_fonts/subdir.mk
-include lvgl/tests/lv_test_core/subdir.mk
-include lvgl/tests/subdir.mk
-include lvgl/src/widgets/subdir.mk
-include lvgl/src/misc/subdir.mk
-include lvgl/src/hal/subdir.mk
-include lvgl/src/gpu/subdir.mk
-include lvgl/src/font/subdir.mk
-include lvgl/src/extra/widgets/win/subdir.mk
-include lvgl/src/extra/widgets/tileview/subdir.mk
-include lvgl/src/extra/widgets/tabview/subdir.mk
-include lvgl/src/extra/widgets/spinner/subdir.mk
-include lvgl/src/extra/widgets/spinbox/subdir.mk
-include lvgl/src/extra/widgets/span/subdir.mk
-include lvgl/src/extra/widgets/msgbox/subdir.mk
-include lvgl/src/extra/widgets/meter/subdir.mk
-include lvgl/src/extra/widgets/list/subdir.mk
-include lvgl/src/extra/widgets/led/subdir.mk
-include lvgl/src/extra/widgets/keyboard/subdir.mk
-include lvgl/src/extra/widgets/imgbtn/subdir.mk
-include lvgl/src/extra/widgets/colorwheel/subdir.mk
-include lvgl/src/extra/widgets/chart/subdir.mk
-include lvgl/src/extra/widgets/calendar/subdir.mk
-include lvgl/src/extra/widgets/animimg/subdir.mk
-include lvgl/src/extra/themes/mono/subdir.mk
-include lvgl/src/extra/themes/default/subdir.mk
-include lvgl/src/extra/themes/basic/subdir.mk
-include lvgl/src/extra/layouts/grid/subdir.mk
-include lvgl/src/extra/layouts/flex/subdir.mk
-include lvgl/src/extra/subdir.mk
-include lvgl/src/draw/subdir.mk
-include lvgl/src/core/subdir.mk
-include lvgl/examples/widgets/win/subdir.mk
-include lvgl/examples/widgets/tileview/subdir.mk
-include lvgl/examples/widgets/textarea/subdir.mk
-include lvgl/examples/widgets/tabview/subdir.mk
-include lvgl/examples/widgets/table/subdir.mk
-include lvgl/examples/widgets/switch/subdir.mk
-include lvgl/examples/widgets/spinner/subdir.mk
-include lvgl/examples/widgets/spinbox/subdir.mk
-include lvgl/examples/widgets/span/subdir.mk
-include lvgl/examples/widgets/slider/subdir.mk
-include lvgl/examples/widgets/roller/subdir.mk
-include lvgl/examples/widgets/obj/subdir.mk
-include lvgl/examples/widgets/msgbox/subdir.mk
-include lvgl/examples/widgets/meter/subdir.mk
-include lvgl/examples/widgets/list/subdir.mk
-include lvgl/examples/widgets/line/subdir.mk
-include lvgl/examples/widgets/led/subdir.mk
-include lvgl/examples/widgets/label/subdir.mk
-include lvgl/examples/widgets/keyboard/subdir.mk
-include lvgl/examples/widgets/imgbtn/subdir.mk
-include lvgl/examples/widgets/img/subdir.mk
-include lvgl/examples/widgets/dropdown/subdir.mk
-include lvgl/examples/widgets/colorwheel/subdir.mk
-include lvgl/examples/widgets/checkbox/subdir.mk
-include lvgl/examples/widgets/chart/subdir.mk
-include lvgl/examples/widgets/canvas/subdir.mk
-include lvgl/examples/widgets/calendar/subdir.mk
-include lvgl/examples/widgets/btnmatrix/subdir.mk
-include lvgl/examples/widgets/btn/subdir.mk
-include lvgl/examples/widgets/bar/subdir.mk
-include lvgl/examples/widgets/arc/subdir.mk
-include lvgl/examples/widgets/animimg/subdir.mk
-include lvgl/examples/styles/subdir.mk
-include lvgl/examples/scroll/subdir.mk
-include lvgl/examples/porting/subdir.mk
-include lvgl/examples/layouts/grid/subdir.mk
-include lvgl/examples/layouts/flex/subdir.mk
-include lvgl/examples/get_started/subdir.mk
-include lvgl/examples/event/subdir.mk
-include lvgl/examples/assets/subdir.mk
-include lvgl/examples/anim/subdir.mk
-include lv_drivers/win32drv/subdir.mk
-include lv_drivers/wayland/subdir.mk
-include lv_drivers/sdl/subdir.mk
-include lv_drivers/indev/subdir.mk
-include lv_drivers/gtkdrv/subdir.mk
-include lv_drivers/display/subdir.mk
-include lv_drivers/subdir.mk
-include assets/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

OPTIONAL_TOOL_DEPS := \
$(wildcard ../makefile.defs) \
$(wildcard ../makefile.init) \
$(wildcard ../makefile.targets) \


BUILD_ARTIFACT_NAME := LvglBaseProjects
BUILD_ARTIFACT_EXTENSION :=
BUILD_ARTIFACT_PREFIX :=
BUILD_ARTIFACT := $(BUILD_ARTIFACT_PREFIX)$(BUILD_ARTIFACT_NAME)$(if $(BUILD_ARTIFACT_EXTENSION),.$(BUILD_ARTIFACT_EXTENSION),)

# Add inputs and outputs from these tool invocations to the build variables 

# All Target
all: main-build

# Main-build Target
main-build: LvglBaseProjects

# Tool invocations
LvglBaseProjects: $(OBJS) $(USER_OBJS) makefile objects.mk $(OPTIONAL_TOOL_DEPS)
	@echo 'Building target: $@'
	@echo 'Invoking: GCC C Linker'
	gcc  -o "LvglBaseProjects" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) LvglBaseProjects
	-@echo ' '

.PHONY: all clean dependents main-build

-include ../makefile.targets
