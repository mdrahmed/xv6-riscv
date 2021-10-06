#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

/* Defining size of 128 to pass 128 integers from child to parent process.
The size of an integer is 4 bytes. So, I am sending 4*128 = 512 bytes at 
a time. */
#define SIZE 128 

int main()
{
    /* Declaring count variable to see how much has been passed and 
    check variable will check if the data are recieved correctly or not. */
    int fd[2], current_time=0, elasped_time = 0, count=0, check=0;

    if(pipe(fd) == -1){ //creating pipe and checking for error
        printf("An error occured while creating the pipe\n");
        exit(1); 
    }

    int cid = fork(); //Creating the child process;

    if(cid == 0){ //This is the child process as fork returns 0 to child
        close(fd[0]); //closing read function of child process
        int sending_data[SIZE] = {0}; //Declaring data of 128 size to send and initializing with value 0

        for(int i=0;i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
            int k=0;
            for(int j=(i*128); j<((i+1)*128); j++){
                sending_data[k] = j; //This for loop passes unique values to data;
                k++;
            }
            if(write(fd[1], sending_data, 512) == -1){ //sends data to parent process as well as checks for exception
                printf("An error occurred during writing\n");
                exit(1);
            }
        }

        close(fd[1]); //closing write end after wrting
    }

    else if(cid > 0){ // This is the parent process as fork returns child id to parent
        close(fd[1]); //closing the write function of the parent
        int received_data[SIZE] = {0}; //Declaring receiving data and initializing it to 0

        current_time = uptime(); //getting the current time in the parent process

        /* To verify the data I sent is received correctly or not I am creating the data again 
        and checking it with the received data */
        for(int i=0; i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
            int read_data =  read(fd[0], received_data, 512); //Receiving data with read function

            count = count+read_data; //Counting the total number of data read

            if(read_data == -1){ //checking if any error occurred while receiving data
                printf("An error occurred while reading\n"); 
                exit(1);
            }

            int k=0;
            for(int j=(i*128); j < ((i+1)*128); j++){
                if(j != received_data[k]){ // I sent the value of j to parent and now checking if the value matches with the received data. 
                    printf("An error occurred while receiving data\n"); // If the received data doesn't match then an error message will be printed
                    check = 1; // Value of check will be changed to 1 if any byte went missing
                }
                k++;
            }
        }

        cid = wait((int *)0); //The parent will wait for child before exiting
        
        // Now, the total byte data sent will be printed which is 10485760 or 10 MB
        
        printf("Total byte data sent: %d byte\n",count);

        // if the data received correctly then it will print 0 otherwise 1
        if(check == 0)
            printf("Data received correctly as flag value is %d\n", check);
        else
            printf("A byte went missing as flag value is %d\n", check);

        //The total time taken for sending and receiving data is printed
        elasped_time = uptime()-current_time;
        printf("The total ticks are %d\n",elasped_time);
    }

    else{ 
        printf("An error occurred while forking");
        exit(1);
    }

    exit(0); //Exiting with 0 error
}