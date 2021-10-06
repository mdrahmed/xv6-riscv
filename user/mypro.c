#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define SIZE 4096

int main()
{  
    //fprintf(1, "My 2nd xv6 program\n");  
	//char buffer[1024] = "dfhsafhkd asfhdkasdfhk";
	int fd[2];
	if(pipe(fd)==-1){
		printf("An error ocurred");
                exit(1);
	}
        int cid = fork();
        if(cid == 0){
          close(fd[0]);
          int x=11;
          write(fd[1], &x, sizeof(int));
          close(fd[1]);
        }
        else{
          close(fd[1]);
          int y;
          read(fd[0], &y, sizeof(int));
          close(fd[0]);
          printf("Child process send: %d\n", y);
        }
    exit(0);
}   
