#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include <stddef.h>
//#include <unistd.h>

#define SIZE 4096

int main()
{  
    int fd[2],i;
    pipe(fd);
    int pid = fork();

    

    if(pid > 0){
        wait(NULL);
        close(0);
        close(fd[1]);
        dup(fd[1]);

        int bytes = 10;
        int *data;
        data = (int*)malloc(bytes);

        int n=read(fd[0],data,sizeof(data));
        printf("%d\n",n);
        for(i=0;i<n/4;i++){
            printf("%d ",data[i]);
        }
        printf("\n");
    }
    else if(pid == 0){

        int bytes = 10;
        int *data;
        data = (int*)malloc(bytes);

        for(int i=0;i<bytes;i++){
            data[i] = i+1;
            printf("%d ",data[i]);
        }

        close(fd[0]);
        close(1);
        dup(fd[1]);
        write(fd[1],data,sizeof(data));
    }
    else{
        printf("error");
    }
    exit(0);
}   

/* 
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define SIZE 4096

int main()
{
  int fd[2], current_time,elasped_time;


  int bytes = 1024;
  int *data;
  data = (int*)malloc(bytes);

  if(pipe(fd)==-1){
    printf("An error ocurred");
    exit(1);
  }
  //printf("%d\n", current_time);
  int cid = fork();
  if(cid == 0){
    close(fd[0]);
    //int x = 11;
    for(int i=0;i<bytes;i++){
      data[i] = i*10;
    }
    if(write(fd[1], data, sizeof(data)) == -1){
      printf("An error ocurred while writing the pipe\n");
      exit(1);
    }
    close(fd[1]);
  }
  else{
    current_time = uptime();
    close(fd[1]);
    //int y;
    
    // int bytes = 1024;
    // int *data;
    // data = (int*)malloc(bytes);
    // for(int i=0;i<bytes;i++){
    // }*//*
    if(read(fd[0],data, sizeof(data)) == -1){
      printf("An error ocurred while reading\n");
      exit(1);
    }
    
    for(int i=0;i<bytes;i++){
      elasped_time = uptime()-current_time;
      printf(1,"Child process send: %d. The process is completed in %d ticks\n", data[i], elasped_time);
    }
    
    close(fd[0]);
  }
  exit(0);
}  */