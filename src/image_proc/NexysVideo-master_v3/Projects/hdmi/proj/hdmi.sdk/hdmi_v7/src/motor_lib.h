#ifndef __MOTOR_LIB_H_
#define __MOTOR_LIB_H_

void init_motor();
void reset_motor(); // this resets and releases reset. The go signal is also set low. Call go() after this
void set_speed(unsigned int speed);
void set_tol(unsigned int tol);
void set_pos(unsigned int pos);
void set_go();
unsigned int get_curr_pos();
unsigned int get_rev();


#endif
