#include "kernel/types.h"
#include "kernel/param.h"
#include "kernel/memlayout.h"
#include "kernel/spinlock.h"
#include "kernel/riscv.h"
#include "kernel/defs.h"
#include "elf.h"
#include "fs.h"
#include "proc.h"
#include <stdlib.h>

#define vaa (TRAPFRAME - PGSIZE)

pte_t *walk(pagetable_t pagetable, uint64 va, int alloc);
#define MAX_RINGBUFS 10
#define RINGBUF_SIZE 16

struct ringbuf {
  int refcount; // 0 for empty slot
  char name[16];
  void *buf[RINGBUF_SIZE];
  void *book; //using this for allowing reading or writing ---- 1 - allowed, 0 - not allowed
};

//Declaring the spinlock for ring buffer
struct {
  struct spinlock ringbuf_lock;
} ringbuf_lk;

struct ringbuf ringbufs[MAX_RINGBUFS];



uint64 create_the_buffer(char nameBuf[16], int open_or_close, uint64 *address_64bit_ring_buffer_mapped)
{
  int i,j;
  // uint64 first_va;

  //initializing the lock
  initlock(&ringbuf_lk.ringbuf_lock, "ring_lock");

  for(i=0; i<MAX_RINGBUFS; i++){
    if(ringbufs[i].name != nameBuf || ringbufs[i].refcount == 0 ){
      for(int k=0; k<16;k++)
        ringbufs[i].name[k] = nameBuf[k];
      //printf("Name of ring buffer: %s\n", ringbufs[i].name);
      break;
    }
  }
  if(open_or_close == 1){

    //acquiring lock
    acquire(&ringbuf_lk.ringbuf_lock);

    ringbufs[i].refcount++;
    
    /// the math here is = (2^39 - (4096*2)) =549755805696 (-) (4096*33)
    struct proc *pr = myproc();
    uint64 va = vaa - (35* PGSIZE);
    printf("At first the Virtual Address: %p %p\n", vaa, va);

    //uint64 *pa; //// now the physical address will be updated to the ring buffers buf variable

    // j is for holding the physical address of 16 pages
    for(j=0;j<16;j++){
      ringbufs[i].buf[j] = kalloc();
      memset(ringbufs[i].buf[j], 0, 4096);

    //1st mapping
      mappages(pr->pagetable, va, 4096, (uint64)ringbufs[i].buf[j], PTE_W|PTE_R|PTE_U);
      pte_t *pte;
      pte =  walk(pr->pagetable,va, 0);
      if(pte == 0)
        printf("unmapped\n");
      else
        printf("mapping 1st virual page\n");
      uvmunmap(pr->pagetable, va, PGROUNDUP(4096)/PGSIZE, 1);

    //2nd mapping
      va += 4096;
      mappages(pr->pagetable, va, 4096, (uint64)ringbufs[i].buf[j], PTE_W | PTE_R | PTE_U);
      pte_t *pte1;
      pte1 =  walk(pr->pagetable,va, 0);
      if(pte1 == 0)
        printf("unmapped\n");
      else
        printf("mapping 2nd virtual page\n");
      uvmunmap(pr->pagetable, va, PGROUNDUP(4096)/PGSIZE, 1);
    }
    
  //bookkeeping page
    ringbufs[i].book = kalloc();
    va += 4096;
    mappages(pr->pagetable, va, 4096, (uint64)ringbufs[i].book, PTE_W | PTE_R | PTE_U);
    pte_t *pte1;
    pte1 =  walk(pr->pagetable,va, 0);
    if(pte1 == 0)
      printf("unmapped\n");
    else
      printf("Bookkeeping pages are mapped\n");
    uvmunmap(pr->pagetable, va, PGROUNDUP(4096)/PGSIZE, 1);


    //releasing lock
    release(&ringbuf_lk.ringbuf_lock);

  }
  else{
    //free up memory;
    //acquire lock
     acquire(&ringbuf_lk.ringbuf_lock);
    for(j=0;j<16;j++){
      if(ringbufs[i].buf[j])
        kfree((char*)ringbufs[i].buf[j]);
    }
    if(ringbufs[i].book)
      kfree(ringbufs[i].book);
    if(ringbufs[i].refcount)
      ringbufs[i].refcount--;

    printf("\nBuffer closed\n\n");

    //   //release lock 
     release(&ringbuf_lk.ringbuf_lock);
  }

  return 0;
}


