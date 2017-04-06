################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/demo.c \
../src/motor_lib.c \
../src/platform.c \
../src/puck_block.c \
../src/strategy.c \
../src/video_demo.c 

OBJS += \
./src/demo.o \
./src/motor_lib.o \
./src/platform.o \
./src/puck_block.o \
./src/strategy.o \
./src/video_demo.o 

C_DEPS += \
./src/demo.d \
./src/motor_lib.d \
./src/platform.d \
./src/puck_block.d \
./src/strategy.d \
./src/video_demo.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -Wall -O0 -g3 -c -fmessage-length=0 -MT"$@" -I../../hdmi_v7_bsp/microblaze_0/include -mlittle-endian -mxl-barrel-shift -mxl-pattern-compare -mno-xl-soft-div -mcpu=v9.6 -mno-xl-soft-mul -mxl-multiply-high -mhard-float -mxl-float-convert -mxl-float-sqrt -Wl,--no-relax -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


