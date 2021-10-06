#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define PIPESIZE 1024

int ab(int a){
  return a*10;
}


struct user_ring_buf {
  void *buf;
  void *book;
  int exists;
};

struct user_ring_buf rings[10];

void store(int *p, int v) {
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
}

int load(int *p) {
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
// }
// void ringbuf_start_read(int ring_desc, char *addr, int *bytes);
// void ringbuf_finish_read(int ring_desc, int bytes);

// void ringbuf_start_write(int ring_desc, char *addr, int *bytes);
// void ringbuf_finish_write(int ring_desc, int bytes);

int create_the_buffer_user(char name[16], int open_close){
  // printf("%s", name);
  int i=0;
  // for(i=0; i < 10; i++){
  //   if(rings[i].exists == 0){
  //     if(open_close == 1){ // open
  //       ringbuf(name, open_close, rings[i].buf);
  //       //rings[i].book = calculate the page number of the bookeeping
  //     }
  //     //else -- it will try ot check whether it will be able to read or write,
  //   }
  // }
  return i;
}

void read_ring(int ring_desc){
  //ringbuf_start_read(ring_desc, rings[ring_desc].buf, bytes);
}
void write_ring(int ring_desc, int *bytes){
  ringbuf_start_write(ring_desc, rings[ring_desc].buf, bytes);
}

void ringbuf_start_read(int ring_desc, char *addr, int *bytes){ // address ta double pointer hobe
  // struct proc *pr = myproc();
}
void ringbuf_finish_read(int ring_desc, int bytes){

}

void ringbuf_start_write(int ring_desc, char *addr, int *bytes){ // address ta double pointer hobe
  // int i = 0, *cnt = bytes;
  // struct proc *pr = myproc();
  //copyin(pr->pagetable, ch, addr + i, k);
  //kernel side e write & read korbe
  // char ch[PIPESIZE];
  // int k=PIPESIZE;
  // if(cnt < PIPESIZE)
  //   k = cnt;
  // if(copyin(pr->pagetable, ch, addr + i, k) == -1)
  //   break;
  // for(int j=0; j<k; j++){
  //   pi->data[pi->nwrite++ % PIPESIZE] = ch[j];
  // }
  // i+=k;
  // cnt -= k;
}

void ringbuf_finish_write(int ring_desc, int bytes){

}

int main()
{
    exit(0);
}
