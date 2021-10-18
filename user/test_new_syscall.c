#include "kernel/types.h"
#include "user/user.h"
#include "kernel/stat.h"

void a(int *b, int *c){
  *b = 100;
  *c = 222;
}

int main()
{
  int pid = fork();

  uint64 addri = 0; // = (uint64 *)0;
  uint64* addr = &addri;
  int bytesi = 0; // = (int *) 0;
  int *bytes = &bytesi;

  int bytes_want = 14;// 65536;//(10485760/8);
  // int start_time, elasped_time;
  // start_time = uptime();

  if(pid > 0){
    ////parent process
    int ring_desc = create_or_close_the_buffer_user("ring", 1);

    check_bytes_written(ring_desc, bytes);
    printf("after checking bytes written addr %d\n", *addr);
    printf("after checking bytes written bytes %d\n", *bytes);

    ringbuf_start_read(ring_desc, addr, bytes);
    // printf("\nThe data written is shown below\n");
    for(int i=0; i < *bytes; i++){
      // printf(" %d ", addr[i]);
    }
    ringbuf_finish_read(ring_desc, *bytes);
    printf("\n\n");
    
    create_or_close_the_buffer_user("ring", 0);
  }
  else if(pid ==0 ){
    ////child process

    int ring_desc = create_or_close_the_buffer_user("ring", 1);

    printf("before write addr %d\n", addr);
    printf("before write bytes %d\n", bytes);
  //start here
    ringbuf_start_write(ring_desc, &addr, bytes);
    printf("after start_write addr %d\n", addr);
    printf("after start_write bytes %d\n\n", *bytes);

    if(bytes_want < *bytes){
      for(int i=0; i < bytes_want; i++){
        addr[i] = i;
        printf("written on address %d\n", addr[i]);
      }
      ringbuf_finish_write(ring_desc, bytes_want);
    }
    else{
      for(int i=0; i < *bytes; i++){
        addr[i] = i;
        printf("written on address %d\n", addr + i);
      }
      ringbuf_finish_write(ring_desc, *bytes);
    }
    create_or_close_the_buffer_user("ring", 0);
  }
  else{
    printf("An error occurred while forking.");
  }
  


  // printf("\n\n");
  // elasped_time = uptime()-start_time;
  // printf("Elasped time is %d\n\n", elasped_time);


  exit(0);
}


