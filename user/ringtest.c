#include "kernel/types.h"
#include "user/user.h"
#include "kernel/stat.h"


int main()
{
  uint64 addri = 0; // = (uint64 *)0;
  uint64* addr = &addri;

  printf("before addr %d\n", addr);
  int ring_desc = create_or_close_the_buffer_user("ring", 1, &addr);
  // addr = (uint64 *)-155648;
  printf("after getting addr from kernel %d\nring_desc = %d\n", addr, ring_desc);

  int bytesi = 0; // = (int *) 0;
  int *bytes = &bytesi;
  int bytes_want_to_read = 5;//(10485760/8);

  int start_time, elasped_time;
  start_time = uptime();

  printf("before write addr %d\n", addr);
  printf("before write bytes %d\n", bytes);
//start here
  ringbuf_start_write(ring_desc, &addr, bytes);
  printf("after start_write addr %p\n", addr);
  printf("after start_write bytes %d\n\n", *bytes);

  if(bytes_want_to_read < *bytes){
    printf("begin loop %d\n",*bytes);
    for(int i=0; i < bytes_want_to_read; i++){
      addr[i] = i;
      // printf("i = %d, addr[i]= %d\n", i, addr[i]);
      // printf("written on address %d\n", addr + i);
    }
    ringbuf_finish_write(ring_desc, bytes_want_to_read);
  }
  else{
    printf("begin loop %d\n",*bytes);
    for(int i=0; i < *bytes; i++){
      addr[i] = i;
      // printf("i = %d, addr[i]= %d\n", i, addr[i]);
      // printf("written on address %d\n", addr + i);
    }
    ringbuf_finish_write(ring_desc, *bytes);
  }

  printf("\n\n");
  check_bytes_written(ring_desc, bytes);
  printf("after checking bytes written addr %d\n", *addr);
  printf("after checking bytes written bytes %d\n", *bytes);

  ringbuf_start_read(ring_desc, addr, bytes);
  // printf("\nThe data written is shown below\n");
  for(int i=0; i < *bytes; i++){
    printf("%d ", addr[i]);
  }
  ringbuf_finish_read(ring_desc, *bytes);
  printf("\n\n");

  elasped_time = uptime()-start_time;
  printf("Elasped time is %d\n\n", elasped_time);

  create_or_close_the_buffer_user("ring", 0, &addr);

  exit(0);
}


