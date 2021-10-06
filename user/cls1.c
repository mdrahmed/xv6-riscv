#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define SIZE 128

int main()
{
  int fd[2], current_time=0,elasped_time;
  int cnt=0,check=0;

  if(pipe(fd)==-1){
    printf("An error ocurred");
    exit(1);
  }
  int cid = fork();
  if(cid == 0){
    close(fd[0]);
    int data[SIZE] = {0};
    for(int i=0;i<(1024*20);i++){
      int k=0;
      for(int j=(i*128);j<((i+1)*128);j++){
        data[k] = j;
        k++;
      }
      if(write(fd[1], data, 512) == -1){
        printf("An error occurred while writing the pipe\n");
        exit(1);
      }
    }
    close(fd[1]);
  }
  else if(cid > 0){
    close(fd[1]);
    int data1[SIZE] = {0};
    current_time = uptime();
    for(int i=0;i<(1024*20);i++){
      int rd = read(fd[0],data1, 512);
      cnt = cnt+rd;
      
      if(rd == -1){
        printf("An error occurred while reading the pipe\n");
        exit(1);
      }
      int k=0;
      for(int j=(i*128);j<((i+1)*128);j++){
        if(j != data1[k]){
          check = 1;
          printf("An error occured while receiving byte");
        }
        k++;
      }
    }
    cid = wait((int *)0);
    printf("Total byte data sent: %d and data perfection is %d\n",cnt, check);
    elasped_time = uptime()-current_time;
    printf("The total ticks are %d\n",elasped_time);
    close(fd[0]);
  }
  else{
    printf("An error occurred while forking.");
    exit(1);
  }

  exit(0); //Exiting with 0 error
} 