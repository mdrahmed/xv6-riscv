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
        int arr[1024];
        int n=read(fd[0],arr,sizeof(arr));
        printf("%d\n",n);
        for(i=0;i<n/4;i++){
            printf("%d ",arr[i]);
        }
        printf("\n");
    }
    else if(pid == 0){
        int arr[1024];
        for(int i=0;i<10;i++){
            arr[i] = i+1;
        }
        close(fd[0]);
        close(1);
        dup(fd[1]);
        write(1,arr,sizeof(arr));
    }
    else{
        printf("error");
    }
    exit(0);
}   



/* 
#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h> 
#include <stdlib.h> 
#include <sys/wait.h>
#define MAX 10
  
int main()
{
  
  int fd[2], i = 0;
  pipe(fd);
  pid_t pid = fork();
  
   if(pid > 0) {
      wait(NULL);
  
      // closing the standard input 
      close(0);
  
      // no need to use the write end of pipe here so close it
      close(fd[1]); 
  
       // duplicating fd[0] with standard input 0
      dup(fd[0]); 
      int arr[MAX];
  
      // n stores the total bytes read successfully
      int n = read(fd[0], arr, sizeof(arr));
      for ( i = 0;i < n/4; i++)
  
         // printing the array received from child process
          printf("%d ", arr[i]); 
  } 
  else if( pid == 0 ) {
      int arr[] = {1, 2, 3, 4, 5};
  
      // no need to use the read end of pipe here so close it
      close(fd[0]); 
  
       // closing the standard output
      close(1);    
  
      // duplicating fd[0] with standard output 1
      dup(fd[1]);  
      write(1, arr, sizeof(arr));
  } 
  
  else {
      printf("error\n"); //fork()
  }
  exit(0);
}  */