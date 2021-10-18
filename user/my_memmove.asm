
user/_my_memmove:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <my>:
#include "user/user.h"
#include "kernel/stat.h"


void* my(void *dst, const void *src, uint n)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  const u32 *s;
  u32 *d; */
  s = src;
  d = dst;

  if(s < d && s + n > d){
   6:	06a5e163          	bltu	a1,a0,68 <my+0x68>
    d2 = (char*)d;
    while(n-- > 0)
      *--d2 = *--s2;
  } 
  else{
    while(n >= 8){
   a:	479d                	li	a5,7
   c:	04c7fb63          	bgeu	a5,a2,62 <my+0x62>
  10:	ff86071b          	addiw	a4,a2,-8
  14:	0037571b          	srliw	a4,a4,0x3
  18:	2705                	addiw	a4,a4,1
  1a:	02071793          	slli	a5,a4,0x20
  1e:	01d7d713          	srli	a4,a5,0x1d
  22:	00e587b3          	add	a5,a1,a4
  26:	86aa                	mv	a3,a0
      *d++ = *s++;
  28:	05a1                	addi	a1,a1,8
  2a:	06a1                	addi	a3,a3,8
  2c:	ff85b803          	ld	a6,-8(a1)
  30:	ff06bc23          	sd	a6,-8(a3)
    while(n >= 8){
  34:	fef59ae3          	bne	a1,a5,28 <my+0x28>
      *d++ = *s++;
  38:	972a                	add	a4,a4,a0
      n -= 8;
  3a:	8a1d                	andi	a2,a2,7
    }
    const char *s2;
    char *d2;
    s2 = (const char*)s;
    d2 = (char*)d;
    while(n-- > 0){
  3c:	fff6069b          	addiw	a3,a2,-1
  40:	ce11                	beqz	a2,5c <my+0x5c>
  42:	02069613          	slli	a2,a3,0x20
  46:	9201                	srli	a2,a2,0x20
  48:	0605                	addi	a2,a2,1
  4a:	963e                	add	a2,a2,a5
      *d2++ = *s2++;
  4c:	0785                	addi	a5,a5,1
  4e:	0705                	addi	a4,a4,1
  50:	fff7c683          	lbu	a3,-1(a5)
  54:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0){
  58:	fec79ae3          	bne	a5,a2,4c <my+0x4c>
    }
  }

  return dst;
}
  5c:	6422                	ld	s0,8(sp)
  5e:	0141                	addi	sp,sp,16
  60:	8082                	ret
    while(n >= 8){
  62:	872a                	mv	a4,a0
  64:	87ae                	mv	a5,a1
  66:	bfd9                	j	3c <my+0x3c>
  if(s < d && s + n > d){
  68:	02061713          	slli	a4,a2,0x20
  6c:	01d75793          	srli	a5,a4,0x1d
  70:	00f58733          	add	a4,a1,a5
  74:	f8e57be3          	bgeu	a0,a4,a <my+0xa>
    s += (n*8);
  78:	577d                	li	a4,-1
  7a:	9301                	srli	a4,a4,0x20
  7c:	8f7d                	and	a4,a4,a5
  7e:	070e                	slli	a4,a4,0x3
  80:	95ba                	add	a1,a1,a4
    d += (n*8);
  82:	972a                	add	a4,a4,a0
    while(n >= 8){
  84:	479d                	li	a5,7
  86:	04c7fc63          	bgeu	a5,a2,de <my+0xde>
  8a:	ff86079b          	addiw	a5,a2,-8
  8e:	0037d79b          	srliw	a5,a5,0x3
  92:	2785                	addiw	a5,a5,1
  94:	02079693          	slli	a3,a5,0x20
  98:	01d6d793          	srli	a5,a3,0x1d
  9c:	40f008b3          	neg	a7,a5
  a0:	40f587b3          	sub	a5,a1,a5
    d += (n*8);
  a4:	86ba                	mv	a3,a4
      *--d = *--s;
  a6:	15e1                	addi	a1,a1,-8
  a8:	16e1                	addi	a3,a3,-8
  aa:	0005b803          	ld	a6,0(a1)
  ae:	0106b023          	sd	a6,0(a3)
    while(n >= 8){
  b2:	fef59ae3          	bne	a1,a5,a6 <my+0xa6>
      *--d = *--s;
  b6:	9746                	add	a4,a4,a7
      n -= 8;
  b8:	8a1d                	andi	a2,a2,7
    while(n-- > 0)
  ba:	fff6069b          	addiw	a3,a2,-1
  be:	de59                	beqz	a2,5c <my+0x5c>
  c0:	02069613          	slli	a2,a3,0x20
  c4:	9201                	srli	a2,a2,0x20
  c6:	fff64613          	not	a2,a2
  ca:	963e                	add	a2,a2,a5
      *--d2 = *--s2;
  cc:	17fd                	addi	a5,a5,-1
  ce:	177d                	addi	a4,a4,-1
  d0:	0007c683          	lbu	a3,0(a5)
  d4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
  d8:	fef61ae3          	bne	a2,a5,cc <my+0xcc>
  dc:	b741                	j	5c <my+0x5c>
    s += (n*8);
  de:	87ae                	mv	a5,a1
  e0:	bfe9                	j	ba <my+0xba>

00000000000000e2 <memmove_>:

void*
memmove_(void *dst, const void *src, uint n)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	addi	s0,sp,16
  char *d;

  s = src;
  d = dst;
  
  if(s < d && s + n > d){
  e8:	02a5e563          	bltu	a1,a0,112 <memmove_+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
  ec:	fff6069b          	addiw	a3,a2,-1
  f0:	ce11                	beqz	a2,10c <memmove_+0x2a>
  f2:	1682                	slli	a3,a3,0x20
  f4:	9281                	srli	a3,a3,0x20
  f6:	0685                	addi	a3,a3,1
  f8:	96ae                	add	a3,a3,a1
  fa:	87aa                	mv	a5,a0
      *d++ = *s++;
  fc:	0585                	addi	a1,a1,1
  fe:	0785                	addi	a5,a5,1
 100:	fff5c703          	lbu	a4,-1(a1)
 104:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
 108:	fed59ae3          	bne	a1,a3,fc <memmove_+0x1a>

  return dst;
}
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	addi	sp,sp,16
 110:	8082                	ret
  if(s < d && s + n > d){
 112:	02061713          	slli	a4,a2,0x20
 116:	9301                	srli	a4,a4,0x20
 118:	00e587b3          	add	a5,a1,a4
 11c:	fcf578e3          	bgeu	a0,a5,ec <memmove_+0xa>
    d += n;
 120:	972a                	add	a4,a4,a0
    while(n-- > 0)
 122:	fff6069b          	addiw	a3,a2,-1
 126:	d27d                	beqz	a2,10c <memmove_+0x2a>
 128:	02069613          	slli	a2,a3,0x20
 12c:	9201                	srli	a2,a2,0x20
 12e:	fff64613          	not	a2,a2
 132:	963e                	add	a2,a2,a5
      *--d = *--s;
 134:	17fd                	addi	a5,a5,-1
 136:	177d                	addi	a4,a4,-1
 138:	0007c683          	lbu	a3,0(a5)
 13c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 140:	fef61ae3          	bne	a2,a5,134 <memmove_+0x52>
 144:	b7e1                	j	10c <memmove_+0x2a>

0000000000000146 <main>:

int main()
{
 146:	7179                	addi	sp,sp,-48
 148:	f406                	sd	ra,40(sp)
 14a:	f022                	sd	s0,32(sp)
 14c:	ec26                	sd	s1,24(sp)
 14e:	e84a                	sd	s2,16(sp)
 150:	e44e                	sd	s3,8(sp)
 152:	e052                	sd	s4,0(sp)
 154:	1800                	addi	s0,sp,48
  char *from = (char*)malloc(4096);
 156:	6505                	lui	a0,0x1
 158:	00001097          	auipc	ra,0x1
 15c:	960080e7          	jalr	-1696(ra) # ab8 <malloc>
 160:	892a                	mv	s2,a0
  char *to = (char*)malloc(4096);
 162:	6505                	lui	a0,0x1
 164:	00001097          	auipc	ra,0x1
 168:	954080e7          	jalr	-1708(ra) # ab8 <malloc>
 16c:	89aa                	mv	s3,a0
 16e:	4781                	li	a5,0
  int start,end,i;
  for(i=0; i<4096;i++){
 170:	6685                	lui	a3,0x1
    from[i] = i;
 172:	00f90733          	add	a4,s2,a5
 176:	00f70023          	sb	a5,0(a4)
  for(i=0; i<4096;i++){
 17a:	0785                	addi	a5,a5,1
 17c:	fed79be3          	bne	a5,a3,172 <main+0x2c>
  }

  start = uptime();
 180:	00000097          	auipc	ra,0x0
 184:	592080e7          	jalr	1426(ra) # 712 <uptime>
 188:	8a2a                	mv	s4,a0
 18a:	000f44b7          	lui	s1,0xf4
 18e:	24048493          	addi	s1,s1,576 # f4240 <__global_pointer$+0xf2e6f>
  for(int i=0;i<1000000;i++){
    memmove_(to,from,4096);
 192:	6605                	lui	a2,0x1
 194:	85ca                	mv	a1,s2
 196:	854e                	mv	a0,s3
 198:	00000097          	auipc	ra,0x0
 19c:	f4a080e7          	jalr	-182(ra) # e2 <memmove_>
  for(int i=0;i<1000000;i++){
 1a0:	34fd                	addiw	s1,s1,-1
 1a2:	f8e5                	bnez	s1,192 <main+0x4c>
  }
  end = uptime();
 1a4:	00000097          	auipc	ra,0x0
 1a8:	56e080e7          	jalr	1390(ra) # 712 <uptime>
  printf("Total ticks: %d\n", (end-start));
 1ac:	414505bb          	subw	a1,a0,s4
 1b0:	00001517          	auipc	a0,0x1
 1b4:	9f050513          	addi	a0,a0,-1552 # ba0 <malloc+0xe8>
 1b8:	00001097          	auipc	ra,0x1
 1bc:	842080e7          	jalr	-1982(ra) # 9fa <printf>

  exit(0);
 1c0:	4501                	li	a0,0
 1c2:	00000097          	auipc	ra,0x0
 1c6:	4b8080e7          	jalr	1208(ra) # 67a <exit>

00000000000001ca <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e422                	sd	s0,8(sp)
 1ce:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 1d0:	0f50000f          	fence	iorw,ow
 1d4:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 1d8:	6422                	ld	s0,8(sp)
 1da:	0141                	addi	sp,sp,16
 1dc:	8082                	ret

00000000000001de <load>:

int load(uint64 *p) {
 1de:	1141                	addi	sp,sp,-16
 1e0:	e422                	sd	s0,8(sp)
 1e2:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 1e4:	0ff0000f          	fence
 1e8:	6108                	ld	a0,0(a0)
 1ea:	0ff0000f          	fence
}
 1ee:	2501                	sext.w	a0,a0
 1f0:	6422                	ld	s0,8(sp)
 1f2:	0141                	addi	sp,sp,16
 1f4:	8082                	ret

00000000000001f6 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 1f6:	7139                	addi	sp,sp,-64
 1f8:	fc06                	sd	ra,56(sp)
 1fa:	f822                	sd	s0,48(sp)
 1fc:	f426                	sd	s1,40(sp)
 1fe:	f04a                	sd	s2,32(sp)
 200:	ec4e                	sd	s3,24(sp)
 202:	e852                	sd	s4,16(sp)
 204:	e456                	sd	s5,8(sp)
 206:	e05a                	sd	s6,0(sp)
 208:	0080                	addi	s0,sp,64
 20a:	8a2a                	mv	s4,a0
 20c:	89ae                	mv	s3,a1
 20e:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 210:	4785                	li	a5,1
 212:	00001497          	auipc	s1,0x1
 216:	9de48493          	addi	s1,s1,-1570 # bf0 <rings+0x8>
 21a:	00001917          	auipc	s2,0x1
 21e:	ac690913          	addi	s2,s2,-1338 # ce0 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 222:	00001b17          	auipc	s6,0x1
 226:	9b6b0b13          	addi	s6,s6,-1610 # bd8 <vm_addr>
  if(open_close == 1){
 22a:	04f59063          	bne	a1,a5,26a <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 22e:	00001497          	auipc	s1,0x1
 232:	9ca4a483          	lw	s1,-1590(s1) # bf8 <rings+0x10>
 236:	c099                	beqz	s1,23c <create_or_close_the_buffer_user+0x46>
 238:	4481                	li	s1,0
 23a:	a899                	j	290 <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 23c:	865a                	mv	a2,s6
 23e:	4585                	li	a1,1
 240:	00000097          	auipc	ra,0x0
 244:	4da080e7          	jalr	1242(ra) # 71a <ringbuf>
        rings[i].book->write_done = 0;
 248:	00001797          	auipc	a5,0x1
 24c:	9a078793          	addi	a5,a5,-1632 # be8 <rings>
 250:	6798                	ld	a4,8(a5)
 252:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 256:	6798                	ld	a4,8(a5)
 258:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 25c:	4b98                	lw	a4,16(a5)
 25e:	2705                	addiw	a4,a4,1
 260:	cb98                	sw	a4,16(a5)
        break;
 262:	a03d                	j	290 <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 264:	04e1                	addi	s1,s1,24
 266:	03248463          	beq	s1,s2,28e <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 26a:	449c                	lw	a5,8(s1)
 26c:	dfe5                	beqz	a5,264 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 26e:	865a                	mv	a2,s6
 270:	85ce                	mv	a1,s3
 272:	8552                	mv	a0,s4
 274:	00000097          	auipc	ra,0x0
 278:	4a6080e7          	jalr	1190(ra) # 71a <ringbuf>
        rings[i].book->write_done = 0;
 27c:	609c                	ld	a5,0(s1)
 27e:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 282:	609c                	ld	a5,0(s1)
 284:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 288:	0004a423          	sw	zero,8(s1)
 28c:	bfe1                	j	264 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 28e:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 290:	00001797          	auipc	a5,0x1
 294:	9487b783          	ld	a5,-1720(a5) # bd8 <vm_addr>
 298:	00fab023          	sd	a5,0(s5)
  return i;
}
 29c:	8526                	mv	a0,s1
 29e:	70e2                	ld	ra,56(sp)
 2a0:	7442                	ld	s0,48(sp)
 2a2:	74a2                	ld	s1,40(sp)
 2a4:	7902                	ld	s2,32(sp)
 2a6:	69e2                	ld	s3,24(sp)
 2a8:	6a42                	ld	s4,16(sp)
 2aa:	6aa2                	ld	s5,8(sp)
 2ac:	6b02                	ld	s6,0(sp)
 2ae:	6121                	addi	sp,sp,64
 2b0:	8082                	ret

00000000000002b2 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 2b2:	1101                	addi	sp,sp,-32
 2b4:	ec06                	sd	ra,24(sp)
 2b6:	e822                	sd	s0,16(sp)
 2b8:	e426                	sd	s1,8(sp)
 2ba:	1000                	addi	s0,sp,32
 2bc:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 2be:	00001797          	auipc	a5,0x1
 2c2:	91a7b783          	ld	a5,-1766(a5) # bd8 <vm_addr>
 2c6:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 2c8:	421c                	lw	a5,0(a2)
 2ca:	e79d                	bnez	a5,2f8 <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 2cc:	00001697          	auipc	a3,0x1
 2d0:	91c68693          	addi	a3,a3,-1764 # be8 <rings>
 2d4:	669c                	ld	a5,8(a3)
 2d6:	6398                	ld	a4,0(a5)
 2d8:	67c1                	lui	a5,0x10
 2da:	9fb9                	addw	a5,a5,a4
 2dc:	00151713          	slli	a4,a0,0x1
 2e0:	953a                	add	a0,a0,a4
 2e2:	050e                	slli	a0,a0,0x3
 2e4:	9536                	add	a0,a0,a3
 2e6:	6518                	ld	a4,8(a0)
 2e8:	6718                	ld	a4,8(a4)
 2ea:	9f99                	subw	a5,a5,a4
 2ec:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 2ee:	60e2                	ld	ra,24(sp)
 2f0:	6442                	ld	s0,16(sp)
 2f2:	64a2                	ld	s1,8(sp)
 2f4:	6105                	addi	sp,sp,32
 2f6:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 2f8:	00151793          	slli	a5,a0,0x1
 2fc:	953e                	add	a0,a0,a5
 2fe:	050e                	slli	a0,a0,0x3
 300:	00001797          	auipc	a5,0x1
 304:	8e878793          	addi	a5,a5,-1816 # be8 <rings>
 308:	953e                	add	a0,a0,a5
 30a:	6508                	ld	a0,8(a0)
 30c:	0521                	addi	a0,a0,8
 30e:	00000097          	auipc	ra,0x0
 312:	ed0080e7          	jalr	-304(ra) # 1de <load>
 316:	c088                	sw	a0,0(s1)
}
 318:	bfd9                	j	2ee <ringbuf_start_write+0x3c>

000000000000031a <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 31a:	1141                	addi	sp,sp,-16
 31c:	e406                	sd	ra,8(sp)
 31e:	e022                	sd	s0,0(sp)
 320:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 322:	00151793          	slli	a5,a0,0x1
 326:	97aa                	add	a5,a5,a0
 328:	078e                	slli	a5,a5,0x3
 32a:	00001517          	auipc	a0,0x1
 32e:	8be50513          	addi	a0,a0,-1858 # be8 <rings>
 332:	97aa                	add	a5,a5,a0
 334:	6788                	ld	a0,8(a5)
 336:	0035959b          	slliw	a1,a1,0x3
 33a:	0521                	addi	a0,a0,8
 33c:	00000097          	auipc	ra,0x0
 340:	e8e080e7          	jalr	-370(ra) # 1ca <store>
}
 344:	60a2                	ld	ra,8(sp)
 346:	6402                	ld	s0,0(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret

000000000000034c <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 34c:	1101                	addi	sp,sp,-32
 34e:	ec06                	sd	ra,24(sp)
 350:	e822                	sd	s0,16(sp)
 352:	e426                	sd	s1,8(sp)
 354:	1000                	addi	s0,sp,32
 356:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 358:	00151793          	slli	a5,a0,0x1
 35c:	97aa                	add	a5,a5,a0
 35e:	078e                	slli	a5,a5,0x3
 360:	00001517          	auipc	a0,0x1
 364:	88850513          	addi	a0,a0,-1912 # be8 <rings>
 368:	97aa                	add	a5,a5,a0
 36a:	6788                	ld	a0,8(a5)
 36c:	0521                	addi	a0,a0,8
 36e:	00000097          	auipc	ra,0x0
 372:	e70080e7          	jalr	-400(ra) # 1de <load>
 376:	c088                	sw	a0,0(s1)
}
 378:	60e2                	ld	ra,24(sp)
 37a:	6442                	ld	s0,16(sp)
 37c:	64a2                	ld	s1,8(sp)
 37e:	6105                	addi	sp,sp,32
 380:	8082                	ret

0000000000000382 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 382:	1101                	addi	sp,sp,-32
 384:	ec06                	sd	ra,24(sp)
 386:	e822                	sd	s0,16(sp)
 388:	e426                	sd	s1,8(sp)
 38a:	1000                	addi	s0,sp,32
 38c:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 38e:	00151793          	slli	a5,a0,0x1
 392:	97aa                	add	a5,a5,a0
 394:	078e                	slli	a5,a5,0x3
 396:	00001517          	auipc	a0,0x1
 39a:	85250513          	addi	a0,a0,-1966 # be8 <rings>
 39e:	97aa                	add	a5,a5,a0
 3a0:	6788                	ld	a0,8(a5)
 3a2:	611c                	ld	a5,0(a0)
 3a4:	ef99                	bnez	a5,3c2 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 3a6:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 3a8:	41f7579b          	sraiw	a5,a4,0x1f
 3ac:	01d7d79b          	srliw	a5,a5,0x1d
 3b0:	9fb9                	addw	a5,a5,a4
 3b2:	4037d79b          	sraiw	a5,a5,0x3
 3b6:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 3b8:	60e2                	ld	ra,24(sp)
 3ba:	6442                	ld	s0,16(sp)
 3bc:	64a2                	ld	s1,8(sp)
 3be:	6105                	addi	sp,sp,32
 3c0:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 3c2:	00000097          	auipc	ra,0x0
 3c6:	e1c080e7          	jalr	-484(ra) # 1de <load>
    *bytes /= 8;
 3ca:	41f5579b          	sraiw	a5,a0,0x1f
 3ce:	01d7d79b          	srliw	a5,a5,0x1d
 3d2:	9d3d                	addw	a0,a0,a5
 3d4:	4035551b          	sraiw	a0,a0,0x3
 3d8:	c088                	sw	a0,0(s1)
}
 3da:	bff9                	j	3b8 <ringbuf_start_read+0x36>

00000000000003dc <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 3dc:	1141                	addi	sp,sp,-16
 3de:	e406                	sd	ra,8(sp)
 3e0:	e022                	sd	s0,0(sp)
 3e2:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 3e4:	00151793          	slli	a5,a0,0x1
 3e8:	97aa                	add	a5,a5,a0
 3ea:	078e                	slli	a5,a5,0x3
 3ec:	00000517          	auipc	a0,0x0
 3f0:	7fc50513          	addi	a0,a0,2044 # be8 <rings>
 3f4:	97aa                	add	a5,a5,a0
 3f6:	0035959b          	slliw	a1,a1,0x3
 3fa:	6788                	ld	a0,8(a5)
 3fc:	00000097          	auipc	ra,0x0
 400:	dce080e7          	jalr	-562(ra) # 1ca <store>
}
 404:	60a2                	ld	ra,8(sp)
 406:	6402                	ld	s0,0(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret

000000000000040c <strcpy>:



char*
strcpy(char *s, const char *t)
{
 40c:	1141                	addi	sp,sp,-16
 40e:	e422                	sd	s0,8(sp)
 410:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 412:	87aa                	mv	a5,a0
 414:	0585                	addi	a1,a1,1
 416:	0785                	addi	a5,a5,1
 418:	fff5c703          	lbu	a4,-1(a1)
 41c:	fee78fa3          	sb	a4,-1(a5)
 420:	fb75                	bnez	a4,414 <strcpy+0x8>
    ;
  return os;
}
 422:	6422                	ld	s0,8(sp)
 424:	0141                	addi	sp,sp,16
 426:	8082                	ret

0000000000000428 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 428:	1141                	addi	sp,sp,-16
 42a:	e422                	sd	s0,8(sp)
 42c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 42e:	00054783          	lbu	a5,0(a0)
 432:	cb91                	beqz	a5,446 <strcmp+0x1e>
 434:	0005c703          	lbu	a4,0(a1)
 438:	00f71763          	bne	a4,a5,446 <strcmp+0x1e>
    p++, q++;
 43c:	0505                	addi	a0,a0,1
 43e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 440:	00054783          	lbu	a5,0(a0)
 444:	fbe5                	bnez	a5,434 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 446:	0005c503          	lbu	a0,0(a1)
}
 44a:	40a7853b          	subw	a0,a5,a0
 44e:	6422                	ld	s0,8(sp)
 450:	0141                	addi	sp,sp,16
 452:	8082                	ret

0000000000000454 <strlen>:

uint
strlen(const char *s)
{
 454:	1141                	addi	sp,sp,-16
 456:	e422                	sd	s0,8(sp)
 458:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 45a:	00054783          	lbu	a5,0(a0)
 45e:	cf91                	beqz	a5,47a <strlen+0x26>
 460:	0505                	addi	a0,a0,1
 462:	87aa                	mv	a5,a0
 464:	4685                	li	a3,1
 466:	9e89                	subw	a3,a3,a0
 468:	00f6853b          	addw	a0,a3,a5
 46c:	0785                	addi	a5,a5,1
 46e:	fff7c703          	lbu	a4,-1(a5)
 472:	fb7d                	bnez	a4,468 <strlen+0x14>
    ;
  return n;
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
  for(n = 0; s[n]; n++)
 47a:	4501                	li	a0,0
 47c:	bfe5                	j	474 <strlen+0x20>

000000000000047e <memset>:

void*
memset(void *dst, int c, uint n)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 484:	ca19                	beqz	a2,49a <memset+0x1c>
 486:	87aa                	mv	a5,a0
 488:	1602                	slli	a2,a2,0x20
 48a:	9201                	srli	a2,a2,0x20
 48c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 490:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 494:	0785                	addi	a5,a5,1
 496:	fee79de3          	bne	a5,a4,490 <memset+0x12>
  }
  return dst;
}
 49a:	6422                	ld	s0,8(sp)
 49c:	0141                	addi	sp,sp,16
 49e:	8082                	ret

00000000000004a0 <strchr>:

char*
strchr(const char *s, char c)
{
 4a0:	1141                	addi	sp,sp,-16
 4a2:	e422                	sd	s0,8(sp)
 4a4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4a6:	00054783          	lbu	a5,0(a0)
 4aa:	cb99                	beqz	a5,4c0 <strchr+0x20>
    if(*s == c)
 4ac:	00f58763          	beq	a1,a5,4ba <strchr+0x1a>
  for(; *s; s++)
 4b0:	0505                	addi	a0,a0,1
 4b2:	00054783          	lbu	a5,0(a0)
 4b6:	fbfd                	bnez	a5,4ac <strchr+0xc>
      return (char*)s;
  return 0;
 4b8:	4501                	li	a0,0
}
 4ba:	6422                	ld	s0,8(sp)
 4bc:	0141                	addi	sp,sp,16
 4be:	8082                	ret
  return 0;
 4c0:	4501                	li	a0,0
 4c2:	bfe5                	j	4ba <strchr+0x1a>

00000000000004c4 <gets>:

char*
gets(char *buf, int max)
{
 4c4:	711d                	addi	sp,sp,-96
 4c6:	ec86                	sd	ra,88(sp)
 4c8:	e8a2                	sd	s0,80(sp)
 4ca:	e4a6                	sd	s1,72(sp)
 4cc:	e0ca                	sd	s2,64(sp)
 4ce:	fc4e                	sd	s3,56(sp)
 4d0:	f852                	sd	s4,48(sp)
 4d2:	f456                	sd	s5,40(sp)
 4d4:	f05a                	sd	s6,32(sp)
 4d6:	ec5e                	sd	s7,24(sp)
 4d8:	1080                	addi	s0,sp,96
 4da:	8baa                	mv	s7,a0
 4dc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4de:	892a                	mv	s2,a0
 4e0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4e2:	4aa9                	li	s5,10
 4e4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4e6:	89a6                	mv	s3,s1
 4e8:	2485                	addiw	s1,s1,1
 4ea:	0344d863          	bge	s1,s4,51a <gets+0x56>
    cc = read(0, &c, 1);
 4ee:	4605                	li	a2,1
 4f0:	faf40593          	addi	a1,s0,-81
 4f4:	4501                	li	a0,0
 4f6:	00000097          	auipc	ra,0x0
 4fa:	19c080e7          	jalr	412(ra) # 692 <read>
    if(cc < 1)
 4fe:	00a05e63          	blez	a0,51a <gets+0x56>
    buf[i++] = c;
 502:	faf44783          	lbu	a5,-81(s0)
 506:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 50a:	01578763          	beq	a5,s5,518 <gets+0x54>
 50e:	0905                	addi	s2,s2,1
 510:	fd679be3          	bne	a5,s6,4e6 <gets+0x22>
  for(i=0; i+1 < max; ){
 514:	89a6                	mv	s3,s1
 516:	a011                	j	51a <gets+0x56>
 518:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 51a:	99de                	add	s3,s3,s7
 51c:	00098023          	sb	zero,0(s3)
  return buf;
}
 520:	855e                	mv	a0,s7
 522:	60e6                	ld	ra,88(sp)
 524:	6446                	ld	s0,80(sp)
 526:	64a6                	ld	s1,72(sp)
 528:	6906                	ld	s2,64(sp)
 52a:	79e2                	ld	s3,56(sp)
 52c:	7a42                	ld	s4,48(sp)
 52e:	7aa2                	ld	s5,40(sp)
 530:	7b02                	ld	s6,32(sp)
 532:	6be2                	ld	s7,24(sp)
 534:	6125                	addi	sp,sp,96
 536:	8082                	ret

0000000000000538 <stat>:

int
stat(const char *n, struct stat *st)
{
 538:	1101                	addi	sp,sp,-32
 53a:	ec06                	sd	ra,24(sp)
 53c:	e822                	sd	s0,16(sp)
 53e:	e426                	sd	s1,8(sp)
 540:	e04a                	sd	s2,0(sp)
 542:	1000                	addi	s0,sp,32
 544:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 546:	4581                	li	a1,0
 548:	00000097          	auipc	ra,0x0
 54c:	172080e7          	jalr	370(ra) # 6ba <open>
  if(fd < 0)
 550:	02054563          	bltz	a0,57a <stat+0x42>
 554:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 556:	85ca                	mv	a1,s2
 558:	00000097          	auipc	ra,0x0
 55c:	17a080e7          	jalr	378(ra) # 6d2 <fstat>
 560:	892a                	mv	s2,a0
  close(fd);
 562:	8526                	mv	a0,s1
 564:	00000097          	auipc	ra,0x0
 568:	13e080e7          	jalr	318(ra) # 6a2 <close>
  return r;
}
 56c:	854a                	mv	a0,s2
 56e:	60e2                	ld	ra,24(sp)
 570:	6442                	ld	s0,16(sp)
 572:	64a2                	ld	s1,8(sp)
 574:	6902                	ld	s2,0(sp)
 576:	6105                	addi	sp,sp,32
 578:	8082                	ret
    return -1;
 57a:	597d                	li	s2,-1
 57c:	bfc5                	j	56c <stat+0x34>

000000000000057e <atoi>:

int
atoi(const char *s)
{
 57e:	1141                	addi	sp,sp,-16
 580:	e422                	sd	s0,8(sp)
 582:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 584:	00054603          	lbu	a2,0(a0)
 588:	fd06079b          	addiw	a5,a2,-48
 58c:	0ff7f793          	zext.b	a5,a5
 590:	4725                	li	a4,9
 592:	02f76963          	bltu	a4,a5,5c4 <atoi+0x46>
 596:	86aa                	mv	a3,a0
  n = 0;
 598:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 59a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 59c:	0685                	addi	a3,a3,1
 59e:	0025179b          	slliw	a5,a0,0x2
 5a2:	9fa9                	addw	a5,a5,a0
 5a4:	0017979b          	slliw	a5,a5,0x1
 5a8:	9fb1                	addw	a5,a5,a2
 5aa:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5ae:	0006c603          	lbu	a2,0(a3)
 5b2:	fd06071b          	addiw	a4,a2,-48
 5b6:	0ff77713          	zext.b	a4,a4
 5ba:	fee5f1e3          	bgeu	a1,a4,59c <atoi+0x1e>
  return n;
}
 5be:	6422                	ld	s0,8(sp)
 5c0:	0141                	addi	sp,sp,16
 5c2:	8082                	ret
  n = 0;
 5c4:	4501                	li	a0,0
 5c6:	bfe5                	j	5be <atoi+0x40>

00000000000005c8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5c8:	1141                	addi	sp,sp,-16
 5ca:	e422                	sd	s0,8(sp)
 5cc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5ce:	02b57463          	bgeu	a0,a1,5f6 <memmove+0x2e>
    while(n-- > 0)
 5d2:	00c05f63          	blez	a2,5f0 <memmove+0x28>
 5d6:	1602                	slli	a2,a2,0x20
 5d8:	9201                	srli	a2,a2,0x20
 5da:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5de:	872a                	mv	a4,a0
      *dst++ = *src++;
 5e0:	0585                	addi	a1,a1,1
 5e2:	0705                	addi	a4,a4,1
 5e4:	fff5c683          	lbu	a3,-1(a1)
 5e8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5ec:	fee79ae3          	bne	a5,a4,5e0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5f0:	6422                	ld	s0,8(sp)
 5f2:	0141                	addi	sp,sp,16
 5f4:	8082                	ret
    dst += n;
 5f6:	00c50733          	add	a4,a0,a2
    src += n;
 5fa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5fc:	fec05ae3          	blez	a2,5f0 <memmove+0x28>
 600:	fff6079b          	addiw	a5,a2,-1
 604:	1782                	slli	a5,a5,0x20
 606:	9381                	srli	a5,a5,0x20
 608:	fff7c793          	not	a5,a5
 60c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 60e:	15fd                	addi	a1,a1,-1
 610:	177d                	addi	a4,a4,-1
 612:	0005c683          	lbu	a3,0(a1)
 616:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 61a:	fee79ae3          	bne	a5,a4,60e <memmove+0x46>
 61e:	bfc9                	j	5f0 <memmove+0x28>

0000000000000620 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 620:	1141                	addi	sp,sp,-16
 622:	e422                	sd	s0,8(sp)
 624:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 626:	ca05                	beqz	a2,656 <memcmp+0x36>
 628:	fff6069b          	addiw	a3,a2,-1
 62c:	1682                	slli	a3,a3,0x20
 62e:	9281                	srli	a3,a3,0x20
 630:	0685                	addi	a3,a3,1
 632:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 634:	00054783          	lbu	a5,0(a0)
 638:	0005c703          	lbu	a4,0(a1)
 63c:	00e79863          	bne	a5,a4,64c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 640:	0505                	addi	a0,a0,1
    p2++;
 642:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 644:	fed518e3          	bne	a0,a3,634 <memcmp+0x14>
  }
  return 0;
 648:	4501                	li	a0,0
 64a:	a019                	j	650 <memcmp+0x30>
      return *p1 - *p2;
 64c:	40e7853b          	subw	a0,a5,a4
}
 650:	6422                	ld	s0,8(sp)
 652:	0141                	addi	sp,sp,16
 654:	8082                	ret
  return 0;
 656:	4501                	li	a0,0
 658:	bfe5                	j	650 <memcmp+0x30>

000000000000065a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 65a:	1141                	addi	sp,sp,-16
 65c:	e406                	sd	ra,8(sp)
 65e:	e022                	sd	s0,0(sp)
 660:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 662:	00000097          	auipc	ra,0x0
 666:	f66080e7          	jalr	-154(ra) # 5c8 <memmove>
}
 66a:	60a2                	ld	ra,8(sp)
 66c:	6402                	ld	s0,0(sp)
 66e:	0141                	addi	sp,sp,16
 670:	8082                	ret

0000000000000672 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 672:	4885                	li	a7,1
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <exit>:
.global exit
exit:
 li a7, SYS_exit
 67a:	4889                	li	a7,2
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <wait>:
.global wait
wait:
 li a7, SYS_wait
 682:	488d                	li	a7,3
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 68a:	4891                	li	a7,4
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <read>:
.global read
read:
 li a7, SYS_read
 692:	4895                	li	a7,5
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <write>:
.global write
write:
 li a7, SYS_write
 69a:	48c1                	li	a7,16
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <close>:
.global close
close:
 li a7, SYS_close
 6a2:	48d5                	li	a7,21
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <kill>:
.global kill
kill:
 li a7, SYS_kill
 6aa:	4899                	li	a7,6
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6b2:	489d                	li	a7,7
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <open>:
.global open
open:
 li a7, SYS_open
 6ba:	48bd                	li	a7,15
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6c2:	48c5                	li	a7,17
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6ca:	48c9                	li	a7,18
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6d2:	48a1                	li	a7,8
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <link>:
.global link
link:
 li a7, SYS_link
 6da:	48cd                	li	a7,19
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6e2:	48d1                	li	a7,20
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6ea:	48a5                	li	a7,9
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6f2:	48a9                	li	a7,10
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6fa:	48ad                	li	a7,11
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 702:	48b1                	li	a7,12
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 70a:	48b5                	li	a7,13
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 712:	48b9                	li	a7,14
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 71a:	48d9                	li	a7,22
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 722:	1101                	addi	sp,sp,-32
 724:	ec06                	sd	ra,24(sp)
 726:	e822                	sd	s0,16(sp)
 728:	1000                	addi	s0,sp,32
 72a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 72e:	4605                	li	a2,1
 730:	fef40593          	addi	a1,s0,-17
 734:	00000097          	auipc	ra,0x0
 738:	f66080e7          	jalr	-154(ra) # 69a <write>
}
 73c:	60e2                	ld	ra,24(sp)
 73e:	6442                	ld	s0,16(sp)
 740:	6105                	addi	sp,sp,32
 742:	8082                	ret

0000000000000744 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 744:	7139                	addi	sp,sp,-64
 746:	fc06                	sd	ra,56(sp)
 748:	f822                	sd	s0,48(sp)
 74a:	f426                	sd	s1,40(sp)
 74c:	f04a                	sd	s2,32(sp)
 74e:	ec4e                	sd	s3,24(sp)
 750:	0080                	addi	s0,sp,64
 752:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 754:	c299                	beqz	a3,75a <printint+0x16>
 756:	0805c863          	bltz	a1,7e6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 75a:	2581                	sext.w	a1,a1
  neg = 0;
 75c:	4881                	li	a7,0
 75e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 762:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 764:	2601                	sext.w	a2,a2
 766:	00000517          	auipc	a0,0x0
 76a:	45a50513          	addi	a0,a0,1114 # bc0 <digits>
 76e:	883a                	mv	a6,a4
 770:	2705                	addiw	a4,a4,1
 772:	02c5f7bb          	remuw	a5,a1,a2
 776:	1782                	slli	a5,a5,0x20
 778:	9381                	srli	a5,a5,0x20
 77a:	97aa                	add	a5,a5,a0
 77c:	0007c783          	lbu	a5,0(a5)
 780:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 784:	0005879b          	sext.w	a5,a1
 788:	02c5d5bb          	divuw	a1,a1,a2
 78c:	0685                	addi	a3,a3,1
 78e:	fec7f0e3          	bgeu	a5,a2,76e <printint+0x2a>
  if(neg)
 792:	00088b63          	beqz	a7,7a8 <printint+0x64>
    buf[i++] = '-';
 796:	fd040793          	addi	a5,s0,-48
 79a:	973e                	add	a4,a4,a5
 79c:	02d00793          	li	a5,45
 7a0:	fef70823          	sb	a5,-16(a4)
 7a4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7a8:	02e05863          	blez	a4,7d8 <printint+0x94>
 7ac:	fc040793          	addi	a5,s0,-64
 7b0:	00e78933          	add	s2,a5,a4
 7b4:	fff78993          	addi	s3,a5,-1
 7b8:	99ba                	add	s3,s3,a4
 7ba:	377d                	addiw	a4,a4,-1
 7bc:	1702                	slli	a4,a4,0x20
 7be:	9301                	srli	a4,a4,0x20
 7c0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7c4:	fff94583          	lbu	a1,-1(s2)
 7c8:	8526                	mv	a0,s1
 7ca:	00000097          	auipc	ra,0x0
 7ce:	f58080e7          	jalr	-168(ra) # 722 <putc>
  while(--i >= 0)
 7d2:	197d                	addi	s2,s2,-1
 7d4:	ff3918e3          	bne	s2,s3,7c4 <printint+0x80>
}
 7d8:	70e2                	ld	ra,56(sp)
 7da:	7442                	ld	s0,48(sp)
 7dc:	74a2                	ld	s1,40(sp)
 7de:	7902                	ld	s2,32(sp)
 7e0:	69e2                	ld	s3,24(sp)
 7e2:	6121                	addi	sp,sp,64
 7e4:	8082                	ret
    x = -xx;
 7e6:	40b005bb          	negw	a1,a1
    neg = 1;
 7ea:	4885                	li	a7,1
    x = -xx;
 7ec:	bf8d                	j	75e <printint+0x1a>

00000000000007ee <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7ee:	7119                	addi	sp,sp,-128
 7f0:	fc86                	sd	ra,120(sp)
 7f2:	f8a2                	sd	s0,112(sp)
 7f4:	f4a6                	sd	s1,104(sp)
 7f6:	f0ca                	sd	s2,96(sp)
 7f8:	ecce                	sd	s3,88(sp)
 7fa:	e8d2                	sd	s4,80(sp)
 7fc:	e4d6                	sd	s5,72(sp)
 7fe:	e0da                	sd	s6,64(sp)
 800:	fc5e                	sd	s7,56(sp)
 802:	f862                	sd	s8,48(sp)
 804:	f466                	sd	s9,40(sp)
 806:	f06a                	sd	s10,32(sp)
 808:	ec6e                	sd	s11,24(sp)
 80a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 80c:	0005c903          	lbu	s2,0(a1)
 810:	18090f63          	beqz	s2,9ae <vprintf+0x1c0>
 814:	8aaa                	mv	s5,a0
 816:	8b32                	mv	s6,a2
 818:	00158493          	addi	s1,a1,1
  state = 0;
 81c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 81e:	02500a13          	li	s4,37
      if(c == 'd'){
 822:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 826:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 82a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 82e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 832:	00000b97          	auipc	s7,0x0
 836:	38eb8b93          	addi	s7,s7,910 # bc0 <digits>
 83a:	a839                	j	858 <vprintf+0x6a>
        putc(fd, c);
 83c:	85ca                	mv	a1,s2
 83e:	8556                	mv	a0,s5
 840:	00000097          	auipc	ra,0x0
 844:	ee2080e7          	jalr	-286(ra) # 722 <putc>
 848:	a019                	j	84e <vprintf+0x60>
    } else if(state == '%'){
 84a:	01498f63          	beq	s3,s4,868 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 84e:	0485                	addi	s1,s1,1
 850:	fff4c903          	lbu	s2,-1(s1)
 854:	14090d63          	beqz	s2,9ae <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 858:	0009079b          	sext.w	a5,s2
    if(state == 0){
 85c:	fe0997e3          	bnez	s3,84a <vprintf+0x5c>
      if(c == '%'){
 860:	fd479ee3          	bne	a5,s4,83c <vprintf+0x4e>
        state = '%';
 864:	89be                	mv	s3,a5
 866:	b7e5                	j	84e <vprintf+0x60>
      if(c == 'd'){
 868:	05878063          	beq	a5,s8,8a8 <vprintf+0xba>
      } else if(c == 'l') {
 86c:	05978c63          	beq	a5,s9,8c4 <vprintf+0xd6>
      } else if(c == 'x') {
 870:	07a78863          	beq	a5,s10,8e0 <vprintf+0xf2>
      } else if(c == 'p') {
 874:	09b78463          	beq	a5,s11,8fc <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 878:	07300713          	li	a4,115
 87c:	0ce78663          	beq	a5,a4,948 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 880:	06300713          	li	a4,99
 884:	0ee78e63          	beq	a5,a4,980 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 888:	11478863          	beq	a5,s4,998 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 88c:	85d2                	mv	a1,s4
 88e:	8556                	mv	a0,s5
 890:	00000097          	auipc	ra,0x0
 894:	e92080e7          	jalr	-366(ra) # 722 <putc>
        putc(fd, c);
 898:	85ca                	mv	a1,s2
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	e86080e7          	jalr	-378(ra) # 722 <putc>
      }
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	b765                	j	84e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8a8:	008b0913          	addi	s2,s6,8
 8ac:	4685                	li	a3,1
 8ae:	4629                	li	a2,10
 8b0:	000b2583          	lw	a1,0(s6)
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	e8e080e7          	jalr	-370(ra) # 744 <printint>
 8be:	8b4a                	mv	s6,s2
      state = 0;
 8c0:	4981                	li	s3,0
 8c2:	b771                	j	84e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8c4:	008b0913          	addi	s2,s6,8
 8c8:	4681                	li	a3,0
 8ca:	4629                	li	a2,10
 8cc:	000b2583          	lw	a1,0(s6)
 8d0:	8556                	mv	a0,s5
 8d2:	00000097          	auipc	ra,0x0
 8d6:	e72080e7          	jalr	-398(ra) # 744 <printint>
 8da:	8b4a                	mv	s6,s2
      state = 0;
 8dc:	4981                	li	s3,0
 8de:	bf85                	j	84e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8e0:	008b0913          	addi	s2,s6,8
 8e4:	4681                	li	a3,0
 8e6:	4641                	li	a2,16
 8e8:	000b2583          	lw	a1,0(s6)
 8ec:	8556                	mv	a0,s5
 8ee:	00000097          	auipc	ra,0x0
 8f2:	e56080e7          	jalr	-426(ra) # 744 <printint>
 8f6:	8b4a                	mv	s6,s2
      state = 0;
 8f8:	4981                	li	s3,0
 8fa:	bf91                	j	84e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8fc:	008b0793          	addi	a5,s6,8
 900:	f8f43423          	sd	a5,-120(s0)
 904:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 908:	03000593          	li	a1,48
 90c:	8556                	mv	a0,s5
 90e:	00000097          	auipc	ra,0x0
 912:	e14080e7          	jalr	-492(ra) # 722 <putc>
  putc(fd, 'x');
 916:	85ea                	mv	a1,s10
 918:	8556                	mv	a0,s5
 91a:	00000097          	auipc	ra,0x0
 91e:	e08080e7          	jalr	-504(ra) # 722 <putc>
 922:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 924:	03c9d793          	srli	a5,s3,0x3c
 928:	97de                	add	a5,a5,s7
 92a:	0007c583          	lbu	a1,0(a5)
 92e:	8556                	mv	a0,s5
 930:	00000097          	auipc	ra,0x0
 934:	df2080e7          	jalr	-526(ra) # 722 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 938:	0992                	slli	s3,s3,0x4
 93a:	397d                	addiw	s2,s2,-1
 93c:	fe0914e3          	bnez	s2,924 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 940:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 944:	4981                	li	s3,0
 946:	b721                	j	84e <vprintf+0x60>
        s = va_arg(ap, char*);
 948:	008b0993          	addi	s3,s6,8
 94c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 950:	02090163          	beqz	s2,972 <vprintf+0x184>
        while(*s != 0){
 954:	00094583          	lbu	a1,0(s2)
 958:	c9a1                	beqz	a1,9a8 <vprintf+0x1ba>
          putc(fd, *s);
 95a:	8556                	mv	a0,s5
 95c:	00000097          	auipc	ra,0x0
 960:	dc6080e7          	jalr	-570(ra) # 722 <putc>
          s++;
 964:	0905                	addi	s2,s2,1
        while(*s != 0){
 966:	00094583          	lbu	a1,0(s2)
 96a:	f9e5                	bnez	a1,95a <vprintf+0x16c>
        s = va_arg(ap, char*);
 96c:	8b4e                	mv	s6,s3
      state = 0;
 96e:	4981                	li	s3,0
 970:	bdf9                	j	84e <vprintf+0x60>
          s = "(null)";
 972:	00000917          	auipc	s2,0x0
 976:	24690913          	addi	s2,s2,582 # bb8 <malloc+0x100>
        while(*s != 0){
 97a:	02800593          	li	a1,40
 97e:	bff1                	j	95a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 980:	008b0913          	addi	s2,s6,8
 984:	000b4583          	lbu	a1,0(s6)
 988:	8556                	mv	a0,s5
 98a:	00000097          	auipc	ra,0x0
 98e:	d98080e7          	jalr	-616(ra) # 722 <putc>
 992:	8b4a                	mv	s6,s2
      state = 0;
 994:	4981                	li	s3,0
 996:	bd65                	j	84e <vprintf+0x60>
        putc(fd, c);
 998:	85d2                	mv	a1,s4
 99a:	8556                	mv	a0,s5
 99c:	00000097          	auipc	ra,0x0
 9a0:	d86080e7          	jalr	-634(ra) # 722 <putc>
      state = 0;
 9a4:	4981                	li	s3,0
 9a6:	b565                	j	84e <vprintf+0x60>
        s = va_arg(ap, char*);
 9a8:	8b4e                	mv	s6,s3
      state = 0;
 9aa:	4981                	li	s3,0
 9ac:	b54d                	j	84e <vprintf+0x60>
    }
  }
}
 9ae:	70e6                	ld	ra,120(sp)
 9b0:	7446                	ld	s0,112(sp)
 9b2:	74a6                	ld	s1,104(sp)
 9b4:	7906                	ld	s2,96(sp)
 9b6:	69e6                	ld	s3,88(sp)
 9b8:	6a46                	ld	s4,80(sp)
 9ba:	6aa6                	ld	s5,72(sp)
 9bc:	6b06                	ld	s6,64(sp)
 9be:	7be2                	ld	s7,56(sp)
 9c0:	7c42                	ld	s8,48(sp)
 9c2:	7ca2                	ld	s9,40(sp)
 9c4:	7d02                	ld	s10,32(sp)
 9c6:	6de2                	ld	s11,24(sp)
 9c8:	6109                	addi	sp,sp,128
 9ca:	8082                	ret

00000000000009cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9cc:	715d                	addi	sp,sp,-80
 9ce:	ec06                	sd	ra,24(sp)
 9d0:	e822                	sd	s0,16(sp)
 9d2:	1000                	addi	s0,sp,32
 9d4:	e010                	sd	a2,0(s0)
 9d6:	e414                	sd	a3,8(s0)
 9d8:	e818                	sd	a4,16(s0)
 9da:	ec1c                	sd	a5,24(s0)
 9dc:	03043023          	sd	a6,32(s0)
 9e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9e4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9e8:	8622                	mv	a2,s0
 9ea:	00000097          	auipc	ra,0x0
 9ee:	e04080e7          	jalr	-508(ra) # 7ee <vprintf>
}
 9f2:	60e2                	ld	ra,24(sp)
 9f4:	6442                	ld	s0,16(sp)
 9f6:	6161                	addi	sp,sp,80
 9f8:	8082                	ret

00000000000009fa <printf>:

void
printf(const char *fmt, ...)
{
 9fa:	711d                	addi	sp,sp,-96
 9fc:	ec06                	sd	ra,24(sp)
 9fe:	e822                	sd	s0,16(sp)
 a00:	1000                	addi	s0,sp,32
 a02:	e40c                	sd	a1,8(s0)
 a04:	e810                	sd	a2,16(s0)
 a06:	ec14                	sd	a3,24(s0)
 a08:	f018                	sd	a4,32(s0)
 a0a:	f41c                	sd	a5,40(s0)
 a0c:	03043823          	sd	a6,48(s0)
 a10:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a14:	00840613          	addi	a2,s0,8
 a18:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a1c:	85aa                	mv	a1,a0
 a1e:	4505                	li	a0,1
 a20:	00000097          	auipc	ra,0x0
 a24:	dce080e7          	jalr	-562(ra) # 7ee <vprintf>
}
 a28:	60e2                	ld	ra,24(sp)
 a2a:	6442                	ld	s0,16(sp)
 a2c:	6125                	addi	sp,sp,96
 a2e:	8082                	ret

0000000000000a30 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a30:	1141                	addi	sp,sp,-16
 a32:	e422                	sd	s0,8(sp)
 a34:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a36:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a3a:	00000797          	auipc	a5,0x0
 a3e:	1a67b783          	ld	a5,422(a5) # be0 <freep>
 a42:	a805                	j	a72 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a44:	4618                	lw	a4,8(a2)
 a46:	9db9                	addw	a1,a1,a4
 a48:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a4c:	6398                	ld	a4,0(a5)
 a4e:	6318                	ld	a4,0(a4)
 a50:	fee53823          	sd	a4,-16(a0)
 a54:	a091                	j	a98 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a56:	ff852703          	lw	a4,-8(a0)
 a5a:	9e39                	addw	a2,a2,a4
 a5c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a5e:	ff053703          	ld	a4,-16(a0)
 a62:	e398                	sd	a4,0(a5)
 a64:	a099                	j	aaa <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a66:	6398                	ld	a4,0(a5)
 a68:	00e7e463          	bltu	a5,a4,a70 <free+0x40>
 a6c:	00e6ea63          	bltu	a3,a4,a80 <free+0x50>
{
 a70:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a72:	fed7fae3          	bgeu	a5,a3,a66 <free+0x36>
 a76:	6398                	ld	a4,0(a5)
 a78:	00e6e463          	bltu	a3,a4,a80 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a7c:	fee7eae3          	bltu	a5,a4,a70 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a80:	ff852583          	lw	a1,-8(a0)
 a84:	6390                	ld	a2,0(a5)
 a86:	02059813          	slli	a6,a1,0x20
 a8a:	01c85713          	srli	a4,a6,0x1c
 a8e:	9736                	add	a4,a4,a3
 a90:	fae60ae3          	beq	a2,a4,a44 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a94:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a98:	4790                	lw	a2,8(a5)
 a9a:	02061593          	slli	a1,a2,0x20
 a9e:	01c5d713          	srli	a4,a1,0x1c
 aa2:	973e                	add	a4,a4,a5
 aa4:	fae689e3          	beq	a3,a4,a56 <free+0x26>
  } else
    p->s.ptr = bp;
 aa8:	e394                	sd	a3,0(a5)
  freep = p;
 aaa:	00000717          	auipc	a4,0x0
 aae:	12f73b23          	sd	a5,310(a4) # be0 <freep>
}
 ab2:	6422                	ld	s0,8(sp)
 ab4:	0141                	addi	sp,sp,16
 ab6:	8082                	ret

0000000000000ab8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ab8:	7139                	addi	sp,sp,-64
 aba:	fc06                	sd	ra,56(sp)
 abc:	f822                	sd	s0,48(sp)
 abe:	f426                	sd	s1,40(sp)
 ac0:	f04a                	sd	s2,32(sp)
 ac2:	ec4e                	sd	s3,24(sp)
 ac4:	e852                	sd	s4,16(sp)
 ac6:	e456                	sd	s5,8(sp)
 ac8:	e05a                	sd	s6,0(sp)
 aca:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 acc:	02051493          	slli	s1,a0,0x20
 ad0:	9081                	srli	s1,s1,0x20
 ad2:	04bd                	addi	s1,s1,15
 ad4:	8091                	srli	s1,s1,0x4
 ad6:	0014899b          	addiw	s3,s1,1
 ada:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 adc:	00000517          	auipc	a0,0x0
 ae0:	10453503          	ld	a0,260(a0) # be0 <freep>
 ae4:	c515                	beqz	a0,b10 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae8:	4798                	lw	a4,8(a5)
 aea:	02977f63          	bgeu	a4,s1,b28 <malloc+0x70>
 aee:	8a4e                	mv	s4,s3
 af0:	0009871b          	sext.w	a4,s3
 af4:	6685                	lui	a3,0x1
 af6:	00d77363          	bgeu	a4,a3,afc <malloc+0x44>
 afa:	6a05                	lui	s4,0x1
 afc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b00:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b04:	00000917          	auipc	s2,0x0
 b08:	0dc90913          	addi	s2,s2,220 # be0 <freep>
  if(p == (char*)-1)
 b0c:	5afd                	li	s5,-1
 b0e:	a895                	j	b82 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b10:	00000797          	auipc	a5,0x0
 b14:	1c878793          	addi	a5,a5,456 # cd8 <base>
 b18:	00000717          	auipc	a4,0x0
 b1c:	0cf73423          	sd	a5,200(a4) # be0 <freep>
 b20:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b22:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b26:	b7e1                	j	aee <malloc+0x36>
      if(p->s.size == nunits)
 b28:	02e48c63          	beq	s1,a4,b60 <malloc+0xa8>
        p->s.size -= nunits;
 b2c:	4137073b          	subw	a4,a4,s3
 b30:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b32:	02071693          	slli	a3,a4,0x20
 b36:	01c6d713          	srli	a4,a3,0x1c
 b3a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b3c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b40:	00000717          	auipc	a4,0x0
 b44:	0aa73023          	sd	a0,160(a4) # be0 <freep>
      return (void*)(p + 1);
 b48:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b4c:	70e2                	ld	ra,56(sp)
 b4e:	7442                	ld	s0,48(sp)
 b50:	74a2                	ld	s1,40(sp)
 b52:	7902                	ld	s2,32(sp)
 b54:	69e2                	ld	s3,24(sp)
 b56:	6a42                	ld	s4,16(sp)
 b58:	6aa2                	ld	s5,8(sp)
 b5a:	6b02                	ld	s6,0(sp)
 b5c:	6121                	addi	sp,sp,64
 b5e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b60:	6398                	ld	a4,0(a5)
 b62:	e118                	sd	a4,0(a0)
 b64:	bff1                	j	b40 <malloc+0x88>
  hp->s.size = nu;
 b66:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b6a:	0541                	addi	a0,a0,16
 b6c:	00000097          	auipc	ra,0x0
 b70:	ec4080e7          	jalr	-316(ra) # a30 <free>
  return freep;
 b74:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b78:	d971                	beqz	a0,b4c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b7a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b7c:	4798                	lw	a4,8(a5)
 b7e:	fa9775e3          	bgeu	a4,s1,b28 <malloc+0x70>
    if(p == freep)
 b82:	00093703          	ld	a4,0(s2)
 b86:	853e                	mv	a0,a5
 b88:	fef719e3          	bne	a4,a5,b7a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 b8c:	8552                	mv	a0,s4
 b8e:	00000097          	auipc	ra,0x0
 b92:	b74080e7          	jalr	-1164(ra) # 702 <sbrk>
  if(p == (char*)-1)
 b96:	fd5518e3          	bne	a0,s5,b66 <malloc+0xae>
        return 0;
 b9a:	4501                	li	a0,0
 b9c:	bf45                	j	b4c <malloc+0x94>
