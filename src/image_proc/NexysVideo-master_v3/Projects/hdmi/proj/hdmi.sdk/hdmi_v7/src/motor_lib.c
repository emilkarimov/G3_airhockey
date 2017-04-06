#include "motor_lib.h"
//#include "xil_printf.h"
#include "motor_ip_mar27.h"
#include "xparameters.h"
#include "xil_io.h"

#define XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR 0x44a50000


void init_motor()
{
	reset_motor();
	printf("reset pass\n");
	set_speed(255);
	set_tol(20);
	set_pos(50);
	printf("before go pass\n");
	set_go();
	printf("motor rev = %d\n", get_rev());
	printf("motor curr_pos = %d\n", get_curr_pos());
}

void reset_motor()
{
	MOTOR_IP_MAR27_mWriteReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG0_OFFSET, 0);
	MOTOR_IP_MAR27_mWriteReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG0_OFFSET, 2);
}
void set_go()
{
    MOTOR_IP_MAR27_mWriteReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG0_OFFSET, 3);
}
void set_speed(unsigned int speed)
{
    MOTOR_IP_MAR27_mWriteReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG1_OFFSET, speed);
}
void set_tol(unsigned int tol)
{
    MOTOR_IP_MAR27_mWriteReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG3_OFFSET, tol);
}

void set_pos(unsigned int pos)
{
    MOTOR_IP_MAR27_mWriteReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG2_OFFSET, pos);
}

unsigned int get_rev()
{
	unsigned int rev;
	rev = MOTOR_IP_MAR27_mReadReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG5_OFFSET);
	return rev;
}

unsigned int get_curr_pos()
{
	unsigned int pos;
	pos = MOTOR_IP_MAR27_mReadReg(XPAR_MOTOR_IP_MAR27_0_S00_AXI_BASEADDR, MOTOR_IP_MAR27_S00_AXI_SLV_REG4_OFFSET);
	return pos;
}
