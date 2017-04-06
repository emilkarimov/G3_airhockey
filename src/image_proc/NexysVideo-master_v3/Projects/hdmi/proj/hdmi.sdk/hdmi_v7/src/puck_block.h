#ifndef __MOTOR_LIB_H_
#define __MOTOR_LIB_H_

void set_threshold(unsigned int thres);
void set_h_start(unsigned int val);
void set_h_stop(unsigned int val);
void set_v_start(unsigned int val);
void set_v_stop(unsigned int val);
void set_pixel_count(unsigned int p_count);
void set_new_colour(unsigned int val);
//void set_update_rate(unsigned int val);

void puck_block_init();

unsigned int get_x_pos();
unsigned int get_y_pos();




#endif
