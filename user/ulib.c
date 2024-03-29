#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/fcntl.h"
#include "user/user.h"

uint64 vm_addr;

//// user library for ring buffer
struct user_ring_buf {
  uint64 *buf;
  struct book *book;
  int exists;
};

struct book {
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
}

int load(uint64 *p) {
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
}

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
        ringbuf(name, open_close, &vm_addr);
        rings[i].book->write_done = 0;
        rings[i].book->read_done = 0;
        rings[i].exists++;
        break;
      }
      else if(rings[i].exists != 0){
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
        rings[i].book->write_done = 0;
        rings[i].book->read_done = 0;
        rings[i].exists = 0;
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
  return i;
}

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
  *addr = (uint64*)vm_addr;
  if(*bytes == 0){
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
void ringbuf_finish_write(int ring_desc, int bytes){
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
}

void check_bytes_written(int ring_desc, int *bytes){
  *bytes = load(&(rings[ring_desc].book->write_done));
}

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
    *bytes /= 8;
  }
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
void ringbuf_finish_read(int ring_desc, int bytes){
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
}




char*
strcpy(char *s, const char *t)
{
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    ;
  return os;
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    ;
  return n;
}

void*
memset(void *dst, int c, uint n)
{
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    cdst[i] = c;
  }
  return dst;
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
}

char*
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
  return buf;
}

int
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
  close(fd);
  return r;
}

int
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
{
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    while(n-- > 0)
      *dst++ = *src++;
  } else {
    dst += n;
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}

int
memcmp(const void *s1, const void *s2, uint n)
{
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    if (*p1 != *p2) {
      return *p1 - *p2;
    }
    p1++;
    p2++;
  }
  return 0;
}

void *
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
}
