#include "kernel/types.h"
#include "user/user.h"
#include "kernel/stat.h"


void* my(void *dst, const void *src, uint n)
{
  //64 bit declaration
  typedef uint64 __attribute__((__may_alias__)) u64;
  const u64 *s;
  u64 *d;
  //int cnt =n,k=0;
  //trying 32 bit
  /* typedef uint32 __attribute__((__may_alias__)) u32;
  const u32 *s;
  u32 *d; */
  s = src;
  d = dst;

  if(s < d && s + n > d){
    s += (n*8);
    d += (n*8);
    while(n >= 8){
      *--d = *--s;
      n -= 8;
    }
    const char *s2;
    char *d2;
    s2 = (const char*)s;
    d2 = (char*)d;
    while(n-- > 0)
      *--d2 = *--s2;
  } 
  else{
    while(n >= 8){
      *d++ = *s++;
      n -= 8;
    }
    const char *s2;
    char *d2;
    s2 = (const char*)s;
    d2 = (char*)d;
    while(n-- > 0){
      *d2++ = *s2++;
    }
  }

  return dst;
}

void*
memmove_(void *dst, const void *src, uint n)
{
  const char *s;
  char *d;

  s = src;
  d = dst;
  
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}

int main()
{
  char *from = (char*)malloc(4096);
  char *to = (char*)malloc(4096);
  int start,end,i;
  for(i=0; i<4096;i++){
    from[i] = i;
  }

  start = uptime();
  for(int i=0;i<1000000;i++){
    memmove_(to,from,4096);
  }
  end = uptime();
  printf("Total ticks: %d\n", (end-start));

  exit(0);
}


