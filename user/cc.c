#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define SIZE 128


// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
/*
 * Compute x = (7^5 * x) mod (2^31 - 1)
 * without overflowing 31 bits:
 *      (2^31 - 1) = 127773 * (7^5) + 2836
 * From "Random number generators: good ones are hard to find",
 * Park and Miller, Communications of the ACM, vol. 31, no. 10,
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
    hi = x / 127773;
    lo = x % 127773;
    x = 16807 * lo - 2836 * hi;
    if (x < 0)
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
    *ctx = x;
    return (x);
}

unsigned long rand_next = 1;

int
rand(void)
{
    return (do_rand(&rand_next));
}


int main()
{
  //int fd[2], current_time=0,elasped_time;
  //int check=0;
  //int data[SIZE] = {0};
  //int data1[SIZE] = {0};
/* 
    for(int i=0;i<(20);i++){
      for(int j=(i*10);j<((i+1)*10);j++){
        int k=0;
        data[k] = j;
        k++;
      }
      for(int j=(i*10);j<((i+1)*10);j++){
        int k=0;
        if(j != data[k]){
          check = 1;
          printf("%d %d %d\n",j,data[k],i);
        }
        k++;
      }
    } *//* 
    for(int i=0; i<10;i++)
    printf("%d\n",rand()); */
    printf("%d", sizeof(int));
  exit(0);
} 