
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
 15c:	948080e7          	jalr	-1720(ra) # aa0 <malloc>
 160:	892a                	mv	s2,a0
  char *to = (char*)malloc(4096);
 162:	6505                	lui	a0,0x1
 164:	00001097          	auipc	ra,0x1
 168:	93c080e7          	jalr	-1732(ra) # aa0 <malloc>
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
 184:	57a080e7          	jalr	1402(ra) # 6fa <uptime>
 188:	8a2a                	mv	s4,a0
 18a:	000f44b7          	lui	s1,0xf4
 18e:	24048493          	addi	s1,s1,576 # f4240 <__global_pointer$+0xf2e87>
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
 1a8:	556080e7          	jalr	1366(ra) # 6fa <uptime>
  printf("Total ticks: %d\n", (end-start));
 1ac:	414505bb          	subw	a1,a0,s4
 1b0:	00001517          	auipc	a0,0x1
 1b4:	9d850513          	addi	a0,a0,-1576 # b88 <malloc+0xe8>
 1b8:	00001097          	auipc	ra,0x1
 1bc:	82a080e7          	jalr	-2006(ra) # 9e2 <printf>

  exit(0);
 1c0:	4501                	li	a0,0
 1c2:	00000097          	auipc	ra,0x0
 1c6:	4a0080e7          	jalr	1184(ra) # 662 <exit>

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

int create_or_close_the_buffer_user(char name[16], int open_close){
 1f6:	7179                	addi	sp,sp,-48
 1f8:	f406                	sd	ra,40(sp)
 1fa:	f022                	sd	s0,32(sp)
 1fc:	ec26                	sd	s1,24(sp)
 1fe:	e84a                	sd	s2,16(sp)
 200:	e44e                	sd	s3,8(sp)
 202:	e052                	sd	s4,0(sp)
 204:	1800                	addi	s0,sp,48
 206:	8a2a                	mv	s4,a0
 208:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 20a:	4785                	li	a5,1
 20c:	00001497          	auipc	s1,0x1
 210:	9cc48493          	addi	s1,s1,-1588 # bd8 <rings+0x10>
 214:	00001917          	auipc	s2,0x1
 218:	ab490913          	addi	s2,s2,-1356 # cc8 <__BSS_END__>
 21c:	04f59563          	bne	a1,a5,266 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 220:	00001497          	auipc	s1,0x1
 224:	9b84a483          	lw	s1,-1608(s1) # bd8 <rings+0x10>
 228:	c099                	beqz	s1,22e <create_or_close_the_buffer_user+0x38>
 22a:	4481                	li	s1,0
 22c:	a899                	j	282 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 22e:	00001917          	auipc	s2,0x1
 232:	99a90913          	addi	s2,s2,-1638 # bc8 <rings>
 236:	00093603          	ld	a2,0(s2)
 23a:	4585                	li	a1,1
 23c:	00000097          	auipc	ra,0x0
 240:	4c6080e7          	jalr	1222(ra) # 702 <ringbuf>
        rings[i].book->write_done = 0;
 244:	00893783          	ld	a5,8(s2)
 248:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 24c:	00893783          	ld	a5,8(s2)
 250:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 254:	01092783          	lw	a5,16(s2)
 258:	2785                	addiw	a5,a5,1
 25a:	00f92823          	sw	a5,16(s2)
        break;
 25e:	a015                	j	282 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 260:	04e1                	addi	s1,s1,24
 262:	01248f63          	beq	s1,s2,280 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 266:	409c                	lw	a5,0(s1)
 268:	dfe5                	beqz	a5,260 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 26a:	ff04b603          	ld	a2,-16(s1)
 26e:	85ce                	mv	a1,s3
 270:	8552                	mv	a0,s4
 272:	00000097          	auipc	ra,0x0
 276:	490080e7          	jalr	1168(ra) # 702 <ringbuf>
        rings[i].exists = 0;
 27a:	0004a023          	sw	zero,0(s1)
 27e:	b7cd                	j	260 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 280:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 282:	8526                	mv	a0,s1
 284:	70a2                	ld	ra,40(sp)
 286:	7402                	ld	s0,32(sp)
 288:	64e2                	ld	s1,24(sp)
 28a:	6942                	ld	s2,16(sp)
 28c:	69a2                	ld	s3,8(sp)
 28e:	6a02                	ld	s4,0(sp)
 290:	6145                	addi	sp,sp,48
 292:	8082                	ret

0000000000000294 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 294:	1101                	addi	sp,sp,-32
 296:	ec06                	sd	ra,24(sp)
 298:	e822                	sd	s0,16(sp)
 29a:	e426                	sd	s1,8(sp)
 29c:	1000                	addi	s0,sp,32
 29e:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 2a0:	00151793          	slli	a5,a0,0x1
 2a4:	97aa                	add	a5,a5,a0
 2a6:	078e                	slli	a5,a5,0x3
 2a8:	00001717          	auipc	a4,0x1
 2ac:	92070713          	addi	a4,a4,-1760 # bc8 <rings>
 2b0:	97ba                	add	a5,a5,a4
 2b2:	639c                	ld	a5,0(a5)
 2b4:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 2b6:	421c                	lw	a5,0(a2)
 2b8:	e785                	bnez	a5,2e0 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 2ba:	86ba                	mv	a3,a4
 2bc:	671c                	ld	a5,8(a4)
 2be:	6398                	ld	a4,0(a5)
 2c0:	67c1                	lui	a5,0x10
 2c2:	9fb9                	addw	a5,a5,a4
 2c4:	00151713          	slli	a4,a0,0x1
 2c8:	953a                	add	a0,a0,a4
 2ca:	050e                	slli	a0,a0,0x3
 2cc:	9536                	add	a0,a0,a3
 2ce:	6518                	ld	a4,8(a0)
 2d0:	6718                	ld	a4,8(a4)
 2d2:	9f99                	subw	a5,a5,a4
 2d4:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 2d6:	60e2                	ld	ra,24(sp)
 2d8:	6442                	ld	s0,16(sp)
 2da:	64a2                	ld	s1,8(sp)
 2dc:	6105                	addi	sp,sp,32
 2de:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 2e0:	00151793          	slli	a5,a0,0x1
 2e4:	953e                	add	a0,a0,a5
 2e6:	050e                	slli	a0,a0,0x3
 2e8:	00001797          	auipc	a5,0x1
 2ec:	8e078793          	addi	a5,a5,-1824 # bc8 <rings>
 2f0:	953e                	add	a0,a0,a5
 2f2:	6508                	ld	a0,8(a0)
 2f4:	0521                	addi	a0,a0,8
 2f6:	00000097          	auipc	ra,0x0
 2fa:	ee8080e7          	jalr	-280(ra) # 1de <load>
 2fe:	c088                	sw	a0,0(s1)
}
 300:	bfd9                	j	2d6 <ringbuf_start_write+0x42>

0000000000000302 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 302:	1141                	addi	sp,sp,-16
 304:	e406                	sd	ra,8(sp)
 306:	e022                	sd	s0,0(sp)
 308:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 30a:	00151793          	slli	a5,a0,0x1
 30e:	97aa                	add	a5,a5,a0
 310:	078e                	slli	a5,a5,0x3
 312:	00001517          	auipc	a0,0x1
 316:	8b650513          	addi	a0,a0,-1866 # bc8 <rings>
 31a:	97aa                	add	a5,a5,a0
 31c:	6788                	ld	a0,8(a5)
 31e:	0035959b          	slliw	a1,a1,0x3
 322:	0521                	addi	a0,a0,8
 324:	00000097          	auipc	ra,0x0
 328:	ea6080e7          	jalr	-346(ra) # 1ca <store>
}
 32c:	60a2                	ld	ra,8(sp)
 32e:	6402                	ld	s0,0(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret

0000000000000334 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 334:	1101                	addi	sp,sp,-32
 336:	ec06                	sd	ra,24(sp)
 338:	e822                	sd	s0,16(sp)
 33a:	e426                	sd	s1,8(sp)
 33c:	1000                	addi	s0,sp,32
 33e:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 340:	00151793          	slli	a5,a0,0x1
 344:	97aa                	add	a5,a5,a0
 346:	078e                	slli	a5,a5,0x3
 348:	00001517          	auipc	a0,0x1
 34c:	88050513          	addi	a0,a0,-1920 # bc8 <rings>
 350:	97aa                	add	a5,a5,a0
 352:	6788                	ld	a0,8(a5)
 354:	0521                	addi	a0,a0,8
 356:	00000097          	auipc	ra,0x0
 35a:	e88080e7          	jalr	-376(ra) # 1de <load>
 35e:	c088                	sw	a0,0(s1)
}
 360:	60e2                	ld	ra,24(sp)
 362:	6442                	ld	s0,16(sp)
 364:	64a2                	ld	s1,8(sp)
 366:	6105                	addi	sp,sp,32
 368:	8082                	ret

000000000000036a <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 36a:	1101                	addi	sp,sp,-32
 36c:	ec06                	sd	ra,24(sp)
 36e:	e822                	sd	s0,16(sp)
 370:	e426                	sd	s1,8(sp)
 372:	1000                	addi	s0,sp,32
 374:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 376:	00151793          	slli	a5,a0,0x1
 37a:	97aa                	add	a5,a5,a0
 37c:	078e                	slli	a5,a5,0x3
 37e:	00001517          	auipc	a0,0x1
 382:	84a50513          	addi	a0,a0,-1974 # bc8 <rings>
 386:	97aa                	add	a5,a5,a0
 388:	6788                	ld	a0,8(a5)
 38a:	611c                	ld	a5,0(a0)
 38c:	ef99                	bnez	a5,3aa <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 38e:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 390:	41f7579b          	sraiw	a5,a4,0x1f
 394:	01d7d79b          	srliw	a5,a5,0x1d
 398:	9fb9                	addw	a5,a5,a4
 39a:	4037d79b          	sraiw	a5,a5,0x3
 39e:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 3a0:	60e2                	ld	ra,24(sp)
 3a2:	6442                	ld	s0,16(sp)
 3a4:	64a2                	ld	s1,8(sp)
 3a6:	6105                	addi	sp,sp,32
 3a8:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 3aa:	00000097          	auipc	ra,0x0
 3ae:	e34080e7          	jalr	-460(ra) # 1de <load>
    *bytes /= 8;
 3b2:	41f5579b          	sraiw	a5,a0,0x1f
 3b6:	01d7d79b          	srliw	a5,a5,0x1d
 3ba:	9d3d                	addw	a0,a0,a5
 3bc:	4035551b          	sraiw	a0,a0,0x3
 3c0:	c088                	sw	a0,0(s1)
}
 3c2:	bff9                	j	3a0 <ringbuf_start_read+0x36>

00000000000003c4 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 3c4:	1141                	addi	sp,sp,-16
 3c6:	e406                	sd	ra,8(sp)
 3c8:	e022                	sd	s0,0(sp)
 3ca:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 3cc:	00151793          	slli	a5,a0,0x1
 3d0:	97aa                	add	a5,a5,a0
 3d2:	078e                	slli	a5,a5,0x3
 3d4:	00000517          	auipc	a0,0x0
 3d8:	7f450513          	addi	a0,a0,2036 # bc8 <rings>
 3dc:	97aa                	add	a5,a5,a0
 3de:	0035959b          	slliw	a1,a1,0x3
 3e2:	6788                	ld	a0,8(a5)
 3e4:	00000097          	auipc	ra,0x0
 3e8:	de6080e7          	jalr	-538(ra) # 1ca <store>
}
 3ec:	60a2                	ld	ra,8(sp)
 3ee:	6402                	ld	s0,0(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3fa:	87aa                	mv	a5,a0
 3fc:	0585                	addi	a1,a1,1
 3fe:	0785                	addi	a5,a5,1
 400:	fff5c703          	lbu	a4,-1(a1)
 404:	fee78fa3          	sb	a4,-1(a5)
 408:	fb75                	bnez	a4,3fc <strcpy+0x8>
    ;
  return os;
}
 40a:	6422                	ld	s0,8(sp)
 40c:	0141                	addi	sp,sp,16
 40e:	8082                	ret

0000000000000410 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 410:	1141                	addi	sp,sp,-16
 412:	e422                	sd	s0,8(sp)
 414:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 416:	00054783          	lbu	a5,0(a0)
 41a:	cb91                	beqz	a5,42e <strcmp+0x1e>
 41c:	0005c703          	lbu	a4,0(a1)
 420:	00f71763          	bne	a4,a5,42e <strcmp+0x1e>
    p++, q++;
 424:	0505                	addi	a0,a0,1
 426:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 428:	00054783          	lbu	a5,0(a0)
 42c:	fbe5                	bnez	a5,41c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 42e:	0005c503          	lbu	a0,0(a1)
}
 432:	40a7853b          	subw	a0,a5,a0
 436:	6422                	ld	s0,8(sp)
 438:	0141                	addi	sp,sp,16
 43a:	8082                	ret

000000000000043c <strlen>:

uint
strlen(const char *s)
{
 43c:	1141                	addi	sp,sp,-16
 43e:	e422                	sd	s0,8(sp)
 440:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 442:	00054783          	lbu	a5,0(a0)
 446:	cf91                	beqz	a5,462 <strlen+0x26>
 448:	0505                	addi	a0,a0,1
 44a:	87aa                	mv	a5,a0
 44c:	4685                	li	a3,1
 44e:	9e89                	subw	a3,a3,a0
 450:	00f6853b          	addw	a0,a3,a5
 454:	0785                	addi	a5,a5,1
 456:	fff7c703          	lbu	a4,-1(a5)
 45a:	fb7d                	bnez	a4,450 <strlen+0x14>
    ;
  return n;
}
 45c:	6422                	ld	s0,8(sp)
 45e:	0141                	addi	sp,sp,16
 460:	8082                	ret
  for(n = 0; s[n]; n++)
 462:	4501                	li	a0,0
 464:	bfe5                	j	45c <strlen+0x20>

0000000000000466 <memset>:

void*
memset(void *dst, int c, uint n)
{
 466:	1141                	addi	sp,sp,-16
 468:	e422                	sd	s0,8(sp)
 46a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 46c:	ca19                	beqz	a2,482 <memset+0x1c>
 46e:	87aa                	mv	a5,a0
 470:	1602                	slli	a2,a2,0x20
 472:	9201                	srli	a2,a2,0x20
 474:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 478:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 47c:	0785                	addi	a5,a5,1
 47e:	fee79de3          	bne	a5,a4,478 <memset+0x12>
  }
  return dst;
}
 482:	6422                	ld	s0,8(sp)
 484:	0141                	addi	sp,sp,16
 486:	8082                	ret

0000000000000488 <strchr>:

char*
strchr(const char *s, char c)
{
 488:	1141                	addi	sp,sp,-16
 48a:	e422                	sd	s0,8(sp)
 48c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 48e:	00054783          	lbu	a5,0(a0)
 492:	cb99                	beqz	a5,4a8 <strchr+0x20>
    if(*s == c)
 494:	00f58763          	beq	a1,a5,4a2 <strchr+0x1a>
  for(; *s; s++)
 498:	0505                	addi	a0,a0,1
 49a:	00054783          	lbu	a5,0(a0)
 49e:	fbfd                	bnez	a5,494 <strchr+0xc>
      return (char*)s;
  return 0;
 4a0:	4501                	li	a0,0
}
 4a2:	6422                	ld	s0,8(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret
  return 0;
 4a8:	4501                	li	a0,0
 4aa:	bfe5                	j	4a2 <strchr+0x1a>

00000000000004ac <gets>:

char*
gets(char *buf, int max)
{
 4ac:	711d                	addi	sp,sp,-96
 4ae:	ec86                	sd	ra,88(sp)
 4b0:	e8a2                	sd	s0,80(sp)
 4b2:	e4a6                	sd	s1,72(sp)
 4b4:	e0ca                	sd	s2,64(sp)
 4b6:	fc4e                	sd	s3,56(sp)
 4b8:	f852                	sd	s4,48(sp)
 4ba:	f456                	sd	s5,40(sp)
 4bc:	f05a                	sd	s6,32(sp)
 4be:	ec5e                	sd	s7,24(sp)
 4c0:	1080                	addi	s0,sp,96
 4c2:	8baa                	mv	s7,a0
 4c4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c6:	892a                	mv	s2,a0
 4c8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4ca:	4aa9                	li	s5,10
 4cc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4ce:	89a6                	mv	s3,s1
 4d0:	2485                	addiw	s1,s1,1
 4d2:	0344d863          	bge	s1,s4,502 <gets+0x56>
    cc = read(0, &c, 1);
 4d6:	4605                	li	a2,1
 4d8:	faf40593          	addi	a1,s0,-81
 4dc:	4501                	li	a0,0
 4de:	00000097          	auipc	ra,0x0
 4e2:	19c080e7          	jalr	412(ra) # 67a <read>
    if(cc < 1)
 4e6:	00a05e63          	blez	a0,502 <gets+0x56>
    buf[i++] = c;
 4ea:	faf44783          	lbu	a5,-81(s0)
 4ee:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4f2:	01578763          	beq	a5,s5,500 <gets+0x54>
 4f6:	0905                	addi	s2,s2,1
 4f8:	fd679be3          	bne	a5,s6,4ce <gets+0x22>
  for(i=0; i+1 < max; ){
 4fc:	89a6                	mv	s3,s1
 4fe:	a011                	j	502 <gets+0x56>
 500:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 502:	99de                	add	s3,s3,s7
 504:	00098023          	sb	zero,0(s3)
  return buf;
}
 508:	855e                	mv	a0,s7
 50a:	60e6                	ld	ra,88(sp)
 50c:	6446                	ld	s0,80(sp)
 50e:	64a6                	ld	s1,72(sp)
 510:	6906                	ld	s2,64(sp)
 512:	79e2                	ld	s3,56(sp)
 514:	7a42                	ld	s4,48(sp)
 516:	7aa2                	ld	s5,40(sp)
 518:	7b02                	ld	s6,32(sp)
 51a:	6be2                	ld	s7,24(sp)
 51c:	6125                	addi	sp,sp,96
 51e:	8082                	ret

0000000000000520 <stat>:

int
stat(const char *n, struct stat *st)
{
 520:	1101                	addi	sp,sp,-32
 522:	ec06                	sd	ra,24(sp)
 524:	e822                	sd	s0,16(sp)
 526:	e426                	sd	s1,8(sp)
 528:	e04a                	sd	s2,0(sp)
 52a:	1000                	addi	s0,sp,32
 52c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 52e:	4581                	li	a1,0
 530:	00000097          	auipc	ra,0x0
 534:	172080e7          	jalr	370(ra) # 6a2 <open>
  if(fd < 0)
 538:	02054563          	bltz	a0,562 <stat+0x42>
 53c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 53e:	85ca                	mv	a1,s2
 540:	00000097          	auipc	ra,0x0
 544:	17a080e7          	jalr	378(ra) # 6ba <fstat>
 548:	892a                	mv	s2,a0
  close(fd);
 54a:	8526                	mv	a0,s1
 54c:	00000097          	auipc	ra,0x0
 550:	13e080e7          	jalr	318(ra) # 68a <close>
  return r;
}
 554:	854a                	mv	a0,s2
 556:	60e2                	ld	ra,24(sp)
 558:	6442                	ld	s0,16(sp)
 55a:	64a2                	ld	s1,8(sp)
 55c:	6902                	ld	s2,0(sp)
 55e:	6105                	addi	sp,sp,32
 560:	8082                	ret
    return -1;
 562:	597d                	li	s2,-1
 564:	bfc5                	j	554 <stat+0x34>

0000000000000566 <atoi>:

int
atoi(const char *s)
{
 566:	1141                	addi	sp,sp,-16
 568:	e422                	sd	s0,8(sp)
 56a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 56c:	00054603          	lbu	a2,0(a0)
 570:	fd06079b          	addiw	a5,a2,-48
 574:	0ff7f793          	zext.b	a5,a5
 578:	4725                	li	a4,9
 57a:	02f76963          	bltu	a4,a5,5ac <atoi+0x46>
 57e:	86aa                	mv	a3,a0
  n = 0;
 580:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 582:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 584:	0685                	addi	a3,a3,1
 586:	0025179b          	slliw	a5,a0,0x2
 58a:	9fa9                	addw	a5,a5,a0
 58c:	0017979b          	slliw	a5,a5,0x1
 590:	9fb1                	addw	a5,a5,a2
 592:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 596:	0006c603          	lbu	a2,0(a3) # 1000 <__BSS_END__+0x338>
 59a:	fd06071b          	addiw	a4,a2,-48
 59e:	0ff77713          	zext.b	a4,a4
 5a2:	fee5f1e3          	bgeu	a1,a4,584 <atoi+0x1e>
  return n;
}
 5a6:	6422                	ld	s0,8(sp)
 5a8:	0141                	addi	sp,sp,16
 5aa:	8082                	ret
  n = 0;
 5ac:	4501                	li	a0,0
 5ae:	bfe5                	j	5a6 <atoi+0x40>

00000000000005b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5b0:	1141                	addi	sp,sp,-16
 5b2:	e422                	sd	s0,8(sp)
 5b4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5b6:	02b57463          	bgeu	a0,a1,5de <memmove+0x2e>
    while(n-- > 0)
 5ba:	00c05f63          	blez	a2,5d8 <memmove+0x28>
 5be:	1602                	slli	a2,a2,0x20
 5c0:	9201                	srli	a2,a2,0x20
 5c2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 5c8:	0585                	addi	a1,a1,1
 5ca:	0705                	addi	a4,a4,1
 5cc:	fff5c683          	lbu	a3,-1(a1)
 5d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5d4:	fee79ae3          	bne	a5,a4,5c8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5d8:	6422                	ld	s0,8(sp)
 5da:	0141                	addi	sp,sp,16
 5dc:	8082                	ret
    dst += n;
 5de:	00c50733          	add	a4,a0,a2
    src += n;
 5e2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5e4:	fec05ae3          	blez	a2,5d8 <memmove+0x28>
 5e8:	fff6079b          	addiw	a5,a2,-1
 5ec:	1782                	slli	a5,a5,0x20
 5ee:	9381                	srli	a5,a5,0x20
 5f0:	fff7c793          	not	a5,a5
 5f4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5f6:	15fd                	addi	a1,a1,-1
 5f8:	177d                	addi	a4,a4,-1
 5fa:	0005c683          	lbu	a3,0(a1)
 5fe:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 602:	fee79ae3          	bne	a5,a4,5f6 <memmove+0x46>
 606:	bfc9                	j	5d8 <memmove+0x28>

0000000000000608 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 608:	1141                	addi	sp,sp,-16
 60a:	e422                	sd	s0,8(sp)
 60c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 60e:	ca05                	beqz	a2,63e <memcmp+0x36>
 610:	fff6069b          	addiw	a3,a2,-1
 614:	1682                	slli	a3,a3,0x20
 616:	9281                	srli	a3,a3,0x20
 618:	0685                	addi	a3,a3,1
 61a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 61c:	00054783          	lbu	a5,0(a0)
 620:	0005c703          	lbu	a4,0(a1)
 624:	00e79863          	bne	a5,a4,634 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 628:	0505                	addi	a0,a0,1
    p2++;
 62a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 62c:	fed518e3          	bne	a0,a3,61c <memcmp+0x14>
  }
  return 0;
 630:	4501                	li	a0,0
 632:	a019                	j	638 <memcmp+0x30>
      return *p1 - *p2;
 634:	40e7853b          	subw	a0,a5,a4
}
 638:	6422                	ld	s0,8(sp)
 63a:	0141                	addi	sp,sp,16
 63c:	8082                	ret
  return 0;
 63e:	4501                	li	a0,0
 640:	bfe5                	j	638 <memcmp+0x30>

0000000000000642 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 642:	1141                	addi	sp,sp,-16
 644:	e406                	sd	ra,8(sp)
 646:	e022                	sd	s0,0(sp)
 648:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 64a:	00000097          	auipc	ra,0x0
 64e:	f66080e7          	jalr	-154(ra) # 5b0 <memmove>
}
 652:	60a2                	ld	ra,8(sp)
 654:	6402                	ld	s0,0(sp)
 656:	0141                	addi	sp,sp,16
 658:	8082                	ret

000000000000065a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 65a:	4885                	li	a7,1
 ecall
 65c:	00000073          	ecall
 ret
 660:	8082                	ret

0000000000000662 <exit>:
.global exit
exit:
 li a7, SYS_exit
 662:	4889                	li	a7,2
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <wait>:
.global wait
wait:
 li a7, SYS_wait
 66a:	488d                	li	a7,3
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 672:	4891                	li	a7,4
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <read>:
.global read
read:
 li a7, SYS_read
 67a:	4895                	li	a7,5
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <write>:
.global write
write:
 li a7, SYS_write
 682:	48c1                	li	a7,16
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <close>:
.global close
close:
 li a7, SYS_close
 68a:	48d5                	li	a7,21
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <kill>:
.global kill
kill:
 li a7, SYS_kill
 692:	4899                	li	a7,6
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <exec>:
.global exec
exec:
 li a7, SYS_exec
 69a:	489d                	li	a7,7
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <open>:
.global open
open:
 li a7, SYS_open
 6a2:	48bd                	li	a7,15
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6aa:	48c5                	li	a7,17
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6b2:	48c9                	li	a7,18
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6ba:	48a1                	li	a7,8
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <link>:
.global link
link:
 li a7, SYS_link
 6c2:	48cd                	li	a7,19
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6ca:	48d1                	li	a7,20
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6d2:	48a5                	li	a7,9
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <dup>:
.global dup
dup:
 li a7, SYS_dup
 6da:	48a9                	li	a7,10
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6e2:	48ad                	li	a7,11
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6ea:	48b1                	li	a7,12
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6f2:	48b5                	li	a7,13
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6fa:	48b9                	li	a7,14
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 702:	48d9                	li	a7,22
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 70a:	1101                	addi	sp,sp,-32
 70c:	ec06                	sd	ra,24(sp)
 70e:	e822                	sd	s0,16(sp)
 710:	1000                	addi	s0,sp,32
 712:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 716:	4605                	li	a2,1
 718:	fef40593          	addi	a1,s0,-17
 71c:	00000097          	auipc	ra,0x0
 720:	f66080e7          	jalr	-154(ra) # 682 <write>
}
 724:	60e2                	ld	ra,24(sp)
 726:	6442                	ld	s0,16(sp)
 728:	6105                	addi	sp,sp,32
 72a:	8082                	ret

000000000000072c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 72c:	7139                	addi	sp,sp,-64
 72e:	fc06                	sd	ra,56(sp)
 730:	f822                	sd	s0,48(sp)
 732:	f426                	sd	s1,40(sp)
 734:	f04a                	sd	s2,32(sp)
 736:	ec4e                	sd	s3,24(sp)
 738:	0080                	addi	s0,sp,64
 73a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 73c:	c299                	beqz	a3,742 <printint+0x16>
 73e:	0805c863          	bltz	a1,7ce <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 742:	2581                	sext.w	a1,a1
  neg = 0;
 744:	4881                	li	a7,0
 746:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 74a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 74c:	2601                	sext.w	a2,a2
 74e:	00000517          	auipc	a0,0x0
 752:	45a50513          	addi	a0,a0,1114 # ba8 <digits>
 756:	883a                	mv	a6,a4
 758:	2705                	addiw	a4,a4,1
 75a:	02c5f7bb          	remuw	a5,a1,a2
 75e:	1782                	slli	a5,a5,0x20
 760:	9381                	srli	a5,a5,0x20
 762:	97aa                	add	a5,a5,a0
 764:	0007c783          	lbu	a5,0(a5)
 768:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 76c:	0005879b          	sext.w	a5,a1
 770:	02c5d5bb          	divuw	a1,a1,a2
 774:	0685                	addi	a3,a3,1
 776:	fec7f0e3          	bgeu	a5,a2,756 <printint+0x2a>
  if(neg)
 77a:	00088b63          	beqz	a7,790 <printint+0x64>
    buf[i++] = '-';
 77e:	fd040793          	addi	a5,s0,-48
 782:	973e                	add	a4,a4,a5
 784:	02d00793          	li	a5,45
 788:	fef70823          	sb	a5,-16(a4)
 78c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 790:	02e05863          	blez	a4,7c0 <printint+0x94>
 794:	fc040793          	addi	a5,s0,-64
 798:	00e78933          	add	s2,a5,a4
 79c:	fff78993          	addi	s3,a5,-1
 7a0:	99ba                	add	s3,s3,a4
 7a2:	377d                	addiw	a4,a4,-1
 7a4:	1702                	slli	a4,a4,0x20
 7a6:	9301                	srli	a4,a4,0x20
 7a8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7ac:	fff94583          	lbu	a1,-1(s2)
 7b0:	8526                	mv	a0,s1
 7b2:	00000097          	auipc	ra,0x0
 7b6:	f58080e7          	jalr	-168(ra) # 70a <putc>
  while(--i >= 0)
 7ba:	197d                	addi	s2,s2,-1
 7bc:	ff3918e3          	bne	s2,s3,7ac <printint+0x80>
}
 7c0:	70e2                	ld	ra,56(sp)
 7c2:	7442                	ld	s0,48(sp)
 7c4:	74a2                	ld	s1,40(sp)
 7c6:	7902                	ld	s2,32(sp)
 7c8:	69e2                	ld	s3,24(sp)
 7ca:	6121                	addi	sp,sp,64
 7cc:	8082                	ret
    x = -xx;
 7ce:	40b005bb          	negw	a1,a1
    neg = 1;
 7d2:	4885                	li	a7,1
    x = -xx;
 7d4:	bf8d                	j	746 <printint+0x1a>

00000000000007d6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7d6:	7119                	addi	sp,sp,-128
 7d8:	fc86                	sd	ra,120(sp)
 7da:	f8a2                	sd	s0,112(sp)
 7dc:	f4a6                	sd	s1,104(sp)
 7de:	f0ca                	sd	s2,96(sp)
 7e0:	ecce                	sd	s3,88(sp)
 7e2:	e8d2                	sd	s4,80(sp)
 7e4:	e4d6                	sd	s5,72(sp)
 7e6:	e0da                	sd	s6,64(sp)
 7e8:	fc5e                	sd	s7,56(sp)
 7ea:	f862                	sd	s8,48(sp)
 7ec:	f466                	sd	s9,40(sp)
 7ee:	f06a                	sd	s10,32(sp)
 7f0:	ec6e                	sd	s11,24(sp)
 7f2:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7f4:	0005c903          	lbu	s2,0(a1)
 7f8:	18090f63          	beqz	s2,996 <vprintf+0x1c0>
 7fc:	8aaa                	mv	s5,a0
 7fe:	8b32                	mv	s6,a2
 800:	00158493          	addi	s1,a1,1
  state = 0;
 804:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 806:	02500a13          	li	s4,37
      if(c == 'd'){
 80a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 80e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 812:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 816:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 81a:	00000b97          	auipc	s7,0x0
 81e:	38eb8b93          	addi	s7,s7,910 # ba8 <digits>
 822:	a839                	j	840 <vprintf+0x6a>
        putc(fd, c);
 824:	85ca                	mv	a1,s2
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	ee2080e7          	jalr	-286(ra) # 70a <putc>
 830:	a019                	j	836 <vprintf+0x60>
    } else if(state == '%'){
 832:	01498f63          	beq	s3,s4,850 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 836:	0485                	addi	s1,s1,1
 838:	fff4c903          	lbu	s2,-1(s1)
 83c:	14090d63          	beqz	s2,996 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 840:	0009079b          	sext.w	a5,s2
    if(state == 0){
 844:	fe0997e3          	bnez	s3,832 <vprintf+0x5c>
      if(c == '%'){
 848:	fd479ee3          	bne	a5,s4,824 <vprintf+0x4e>
        state = '%';
 84c:	89be                	mv	s3,a5
 84e:	b7e5                	j	836 <vprintf+0x60>
      if(c == 'd'){
 850:	05878063          	beq	a5,s8,890 <vprintf+0xba>
      } else if(c == 'l') {
 854:	05978c63          	beq	a5,s9,8ac <vprintf+0xd6>
      } else if(c == 'x') {
 858:	07a78863          	beq	a5,s10,8c8 <vprintf+0xf2>
      } else if(c == 'p') {
 85c:	09b78463          	beq	a5,s11,8e4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 860:	07300713          	li	a4,115
 864:	0ce78663          	beq	a5,a4,930 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 868:	06300713          	li	a4,99
 86c:	0ee78e63          	beq	a5,a4,968 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 870:	11478863          	beq	a5,s4,980 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 874:	85d2                	mv	a1,s4
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	e92080e7          	jalr	-366(ra) # 70a <putc>
        putc(fd, c);
 880:	85ca                	mv	a1,s2
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	e86080e7          	jalr	-378(ra) # 70a <putc>
      }
      state = 0;
 88c:	4981                	li	s3,0
 88e:	b765                	j	836 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 890:	008b0913          	addi	s2,s6,8
 894:	4685                	li	a3,1
 896:	4629                	li	a2,10
 898:	000b2583          	lw	a1,0(s6)
 89c:	8556                	mv	a0,s5
 89e:	00000097          	auipc	ra,0x0
 8a2:	e8e080e7          	jalr	-370(ra) # 72c <printint>
 8a6:	8b4a                	mv	s6,s2
      state = 0;
 8a8:	4981                	li	s3,0
 8aa:	b771                	j	836 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8ac:	008b0913          	addi	s2,s6,8
 8b0:	4681                	li	a3,0
 8b2:	4629                	li	a2,10
 8b4:	000b2583          	lw	a1,0(s6)
 8b8:	8556                	mv	a0,s5
 8ba:	00000097          	auipc	ra,0x0
 8be:	e72080e7          	jalr	-398(ra) # 72c <printint>
 8c2:	8b4a                	mv	s6,s2
      state = 0;
 8c4:	4981                	li	s3,0
 8c6:	bf85                	j	836 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8c8:	008b0913          	addi	s2,s6,8
 8cc:	4681                	li	a3,0
 8ce:	4641                	li	a2,16
 8d0:	000b2583          	lw	a1,0(s6)
 8d4:	8556                	mv	a0,s5
 8d6:	00000097          	auipc	ra,0x0
 8da:	e56080e7          	jalr	-426(ra) # 72c <printint>
 8de:	8b4a                	mv	s6,s2
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	bf91                	j	836 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8e4:	008b0793          	addi	a5,s6,8
 8e8:	f8f43423          	sd	a5,-120(s0)
 8ec:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8f0:	03000593          	li	a1,48
 8f4:	8556                	mv	a0,s5
 8f6:	00000097          	auipc	ra,0x0
 8fa:	e14080e7          	jalr	-492(ra) # 70a <putc>
  putc(fd, 'x');
 8fe:	85ea                	mv	a1,s10
 900:	8556                	mv	a0,s5
 902:	00000097          	auipc	ra,0x0
 906:	e08080e7          	jalr	-504(ra) # 70a <putc>
 90a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 90c:	03c9d793          	srli	a5,s3,0x3c
 910:	97de                	add	a5,a5,s7
 912:	0007c583          	lbu	a1,0(a5)
 916:	8556                	mv	a0,s5
 918:	00000097          	auipc	ra,0x0
 91c:	df2080e7          	jalr	-526(ra) # 70a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 920:	0992                	slli	s3,s3,0x4
 922:	397d                	addiw	s2,s2,-1
 924:	fe0914e3          	bnez	s2,90c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 928:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 92c:	4981                	li	s3,0
 92e:	b721                	j	836 <vprintf+0x60>
        s = va_arg(ap, char*);
 930:	008b0993          	addi	s3,s6,8
 934:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 938:	02090163          	beqz	s2,95a <vprintf+0x184>
        while(*s != 0){
 93c:	00094583          	lbu	a1,0(s2)
 940:	c9a1                	beqz	a1,990 <vprintf+0x1ba>
          putc(fd, *s);
 942:	8556                	mv	a0,s5
 944:	00000097          	auipc	ra,0x0
 948:	dc6080e7          	jalr	-570(ra) # 70a <putc>
          s++;
 94c:	0905                	addi	s2,s2,1
        while(*s != 0){
 94e:	00094583          	lbu	a1,0(s2)
 952:	f9e5                	bnez	a1,942 <vprintf+0x16c>
        s = va_arg(ap, char*);
 954:	8b4e                	mv	s6,s3
      state = 0;
 956:	4981                	li	s3,0
 958:	bdf9                	j	836 <vprintf+0x60>
          s = "(null)";
 95a:	00000917          	auipc	s2,0x0
 95e:	24690913          	addi	s2,s2,582 # ba0 <malloc+0x100>
        while(*s != 0){
 962:	02800593          	li	a1,40
 966:	bff1                	j	942 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 968:	008b0913          	addi	s2,s6,8
 96c:	000b4583          	lbu	a1,0(s6)
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	d98080e7          	jalr	-616(ra) # 70a <putc>
 97a:	8b4a                	mv	s6,s2
      state = 0;
 97c:	4981                	li	s3,0
 97e:	bd65                	j	836 <vprintf+0x60>
        putc(fd, c);
 980:	85d2                	mv	a1,s4
 982:	8556                	mv	a0,s5
 984:	00000097          	auipc	ra,0x0
 988:	d86080e7          	jalr	-634(ra) # 70a <putc>
      state = 0;
 98c:	4981                	li	s3,0
 98e:	b565                	j	836 <vprintf+0x60>
        s = va_arg(ap, char*);
 990:	8b4e                	mv	s6,s3
      state = 0;
 992:	4981                	li	s3,0
 994:	b54d                	j	836 <vprintf+0x60>
    }
  }
}
 996:	70e6                	ld	ra,120(sp)
 998:	7446                	ld	s0,112(sp)
 99a:	74a6                	ld	s1,104(sp)
 99c:	7906                	ld	s2,96(sp)
 99e:	69e6                	ld	s3,88(sp)
 9a0:	6a46                	ld	s4,80(sp)
 9a2:	6aa6                	ld	s5,72(sp)
 9a4:	6b06                	ld	s6,64(sp)
 9a6:	7be2                	ld	s7,56(sp)
 9a8:	7c42                	ld	s8,48(sp)
 9aa:	7ca2                	ld	s9,40(sp)
 9ac:	7d02                	ld	s10,32(sp)
 9ae:	6de2                	ld	s11,24(sp)
 9b0:	6109                	addi	sp,sp,128
 9b2:	8082                	ret

00000000000009b4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9b4:	715d                	addi	sp,sp,-80
 9b6:	ec06                	sd	ra,24(sp)
 9b8:	e822                	sd	s0,16(sp)
 9ba:	1000                	addi	s0,sp,32
 9bc:	e010                	sd	a2,0(s0)
 9be:	e414                	sd	a3,8(s0)
 9c0:	e818                	sd	a4,16(s0)
 9c2:	ec1c                	sd	a5,24(s0)
 9c4:	03043023          	sd	a6,32(s0)
 9c8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9cc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9d0:	8622                	mv	a2,s0
 9d2:	00000097          	auipc	ra,0x0
 9d6:	e04080e7          	jalr	-508(ra) # 7d6 <vprintf>
}
 9da:	60e2                	ld	ra,24(sp)
 9dc:	6442                	ld	s0,16(sp)
 9de:	6161                	addi	sp,sp,80
 9e0:	8082                	ret

00000000000009e2 <printf>:

void
printf(const char *fmt, ...)
{
 9e2:	711d                	addi	sp,sp,-96
 9e4:	ec06                	sd	ra,24(sp)
 9e6:	e822                	sd	s0,16(sp)
 9e8:	1000                	addi	s0,sp,32
 9ea:	e40c                	sd	a1,8(s0)
 9ec:	e810                	sd	a2,16(s0)
 9ee:	ec14                	sd	a3,24(s0)
 9f0:	f018                	sd	a4,32(s0)
 9f2:	f41c                	sd	a5,40(s0)
 9f4:	03043823          	sd	a6,48(s0)
 9f8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9fc:	00840613          	addi	a2,s0,8
 a00:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a04:	85aa                	mv	a1,a0
 a06:	4505                	li	a0,1
 a08:	00000097          	auipc	ra,0x0
 a0c:	dce080e7          	jalr	-562(ra) # 7d6 <vprintf>
}
 a10:	60e2                	ld	ra,24(sp)
 a12:	6442                	ld	s0,16(sp)
 a14:	6125                	addi	sp,sp,96
 a16:	8082                	ret

0000000000000a18 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a18:	1141                	addi	sp,sp,-16
 a1a:	e422                	sd	s0,8(sp)
 a1c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a1e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a22:	00000797          	auipc	a5,0x0
 a26:	19e7b783          	ld	a5,414(a5) # bc0 <freep>
 a2a:	a805                	j	a5a <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a2c:	4618                	lw	a4,8(a2)
 a2e:	9db9                	addw	a1,a1,a4
 a30:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a34:	6398                	ld	a4,0(a5)
 a36:	6318                	ld	a4,0(a4)
 a38:	fee53823          	sd	a4,-16(a0)
 a3c:	a091                	j	a80 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a3e:	ff852703          	lw	a4,-8(a0)
 a42:	9e39                	addw	a2,a2,a4
 a44:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a46:	ff053703          	ld	a4,-16(a0)
 a4a:	e398                	sd	a4,0(a5)
 a4c:	a099                	j	a92 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a4e:	6398                	ld	a4,0(a5)
 a50:	00e7e463          	bltu	a5,a4,a58 <free+0x40>
 a54:	00e6ea63          	bltu	a3,a4,a68 <free+0x50>
{
 a58:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a5a:	fed7fae3          	bgeu	a5,a3,a4e <free+0x36>
 a5e:	6398                	ld	a4,0(a5)
 a60:	00e6e463          	bltu	a3,a4,a68 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a64:	fee7eae3          	bltu	a5,a4,a58 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a68:	ff852583          	lw	a1,-8(a0)
 a6c:	6390                	ld	a2,0(a5)
 a6e:	02059813          	slli	a6,a1,0x20
 a72:	01c85713          	srli	a4,a6,0x1c
 a76:	9736                	add	a4,a4,a3
 a78:	fae60ae3          	beq	a2,a4,a2c <free+0x14>
    bp->s.ptr = p->s.ptr;
 a7c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a80:	4790                	lw	a2,8(a5)
 a82:	02061593          	slli	a1,a2,0x20
 a86:	01c5d713          	srli	a4,a1,0x1c
 a8a:	973e                	add	a4,a4,a5
 a8c:	fae689e3          	beq	a3,a4,a3e <free+0x26>
  } else
    p->s.ptr = bp;
 a90:	e394                	sd	a3,0(a5)
  freep = p;
 a92:	00000717          	auipc	a4,0x0
 a96:	12f73723          	sd	a5,302(a4) # bc0 <freep>
}
 a9a:	6422                	ld	s0,8(sp)
 a9c:	0141                	addi	sp,sp,16
 a9e:	8082                	ret

0000000000000aa0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aa0:	7139                	addi	sp,sp,-64
 aa2:	fc06                	sd	ra,56(sp)
 aa4:	f822                	sd	s0,48(sp)
 aa6:	f426                	sd	s1,40(sp)
 aa8:	f04a                	sd	s2,32(sp)
 aaa:	ec4e                	sd	s3,24(sp)
 aac:	e852                	sd	s4,16(sp)
 aae:	e456                	sd	s5,8(sp)
 ab0:	e05a                	sd	s6,0(sp)
 ab2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ab4:	02051493          	slli	s1,a0,0x20
 ab8:	9081                	srli	s1,s1,0x20
 aba:	04bd                	addi	s1,s1,15
 abc:	8091                	srli	s1,s1,0x4
 abe:	0014899b          	addiw	s3,s1,1
 ac2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 ac4:	00000517          	auipc	a0,0x0
 ac8:	0fc53503          	ld	a0,252(a0) # bc0 <freep>
 acc:	c515                	beqz	a0,af8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ace:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ad0:	4798                	lw	a4,8(a5)
 ad2:	02977f63          	bgeu	a4,s1,b10 <malloc+0x70>
 ad6:	8a4e                	mv	s4,s3
 ad8:	0009871b          	sext.w	a4,s3
 adc:	6685                	lui	a3,0x1
 ade:	00d77363          	bgeu	a4,a3,ae4 <malloc+0x44>
 ae2:	6a05                	lui	s4,0x1
 ae4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ae8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aec:	00000917          	auipc	s2,0x0
 af0:	0d490913          	addi	s2,s2,212 # bc0 <freep>
  if(p == (char*)-1)
 af4:	5afd                	li	s5,-1
 af6:	a895                	j	b6a <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 af8:	00000797          	auipc	a5,0x0
 afc:	1c078793          	addi	a5,a5,448 # cb8 <base>
 b00:	00000717          	auipc	a4,0x0
 b04:	0cf73023          	sd	a5,192(a4) # bc0 <freep>
 b08:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b0a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b0e:	b7e1                	j	ad6 <malloc+0x36>
      if(p->s.size == nunits)
 b10:	02e48c63          	beq	s1,a4,b48 <malloc+0xa8>
        p->s.size -= nunits;
 b14:	4137073b          	subw	a4,a4,s3
 b18:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b1a:	02071693          	slli	a3,a4,0x20
 b1e:	01c6d713          	srli	a4,a3,0x1c
 b22:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b24:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b28:	00000717          	auipc	a4,0x0
 b2c:	08a73c23          	sd	a0,152(a4) # bc0 <freep>
      return (void*)(p + 1);
 b30:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b34:	70e2                	ld	ra,56(sp)
 b36:	7442                	ld	s0,48(sp)
 b38:	74a2                	ld	s1,40(sp)
 b3a:	7902                	ld	s2,32(sp)
 b3c:	69e2                	ld	s3,24(sp)
 b3e:	6a42                	ld	s4,16(sp)
 b40:	6aa2                	ld	s5,8(sp)
 b42:	6b02                	ld	s6,0(sp)
 b44:	6121                	addi	sp,sp,64
 b46:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b48:	6398                	ld	a4,0(a5)
 b4a:	e118                	sd	a4,0(a0)
 b4c:	bff1                	j	b28 <malloc+0x88>
  hp->s.size = nu;
 b4e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b52:	0541                	addi	a0,a0,16
 b54:	00000097          	auipc	ra,0x0
 b58:	ec4080e7          	jalr	-316(ra) # a18 <free>
  return freep;
 b5c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b60:	d971                	beqz	a0,b34 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b62:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b64:	4798                	lw	a4,8(a5)
 b66:	fa9775e3          	bgeu	a4,s1,b10 <malloc+0x70>
    if(p == freep)
 b6a:	00093703          	ld	a4,0(s2)
 b6e:	853e                	mv	a0,a5
 b70:	fef719e3          	bne	a4,a5,b62 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 b74:	8552                	mv	a0,s4
 b76:	00000097          	auipc	ra,0x0
 b7a:	b74080e7          	jalr	-1164(ra) # 6ea <sbrk>
  if(p == (char*)-1)
 b7e:	fd5518e3          	bne	a0,s5,b4e <malloc+0xae>
        return 0;
 b82:	4501                	li	a0,0
 b84:	bf45                	j	b34 <malloc+0x94>
