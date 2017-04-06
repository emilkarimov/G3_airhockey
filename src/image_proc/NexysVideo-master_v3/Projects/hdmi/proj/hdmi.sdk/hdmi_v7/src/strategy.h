

#ifndef SRC_STRATEGY_H_
#define SRC_STRATEGY_H_

int strategy;
#define y_low 387
#define y_high  2000

#define x_low 250
#define x_high 950


void do_work();
unsigned int predict_intercept(int x_dir, int y_dir, unsigned int x_pos, unsigned int y_pos);

#endif /* SRC_STRATEGY_H_ */
