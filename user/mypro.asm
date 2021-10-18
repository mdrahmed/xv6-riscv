
user/_mypro:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"

#define SIZE 4096

int main()
{  
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
    //fprintf(1, "My 2nd xv6 program\n");  
	//char buffer[1024] = "dfhsafhkd asfhdkasdfhk";
	int fd[2];
	if(pipe(fd)==-1){
   8:	fe840513          	addi	a0,s0,-24
   c:	00000097          	auipc	ra,0x0
  10:	56c080e7          	jalr	1388(ra) # 578 <pipe>
  14:	57fd                	li	a5,-1
  16:	04f50463          	beq	a0,a5,5e <main+0x5e>
		printf("An error ocurred");
                exit(1);
	}
        int cid = fork();
  1a:	00000097          	auipc	ra,0x0
  1e:	546080e7          	jalr	1350(ra) # 560 <fork>
        if(cid == 0){
  22:	e939                	bnez	a0,78 <main+0x78>
          close(fd[0]);
  24:	fe842503          	lw	a0,-24(s0)
  28:	00000097          	auipc	ra,0x0
  2c:	568080e7          	jalr	1384(ra) # 590 <close>
          int x=11;
  30:	47ad                	li	a5,11
  32:	fef42223          	sw	a5,-28(s0)
          write(fd[1], &x, sizeof(int));
  36:	4611                	li	a2,4
  38:	fe440593          	addi	a1,s0,-28
  3c:	fec42503          	lw	a0,-20(s0)
  40:	00000097          	auipc	ra,0x0
  44:	548080e7          	jalr	1352(ra) # 588 <write>
          close(fd[1]);
  48:	fec42503          	lw	a0,-20(s0)
  4c:	00000097          	auipc	ra,0x0
  50:	544080e7          	jalr	1348(ra) # 590 <close>
          int y;
          read(fd[0], &y, sizeof(int));
          close(fd[0]);
          printf("Child process send: %d\n", y);
        }
    exit(0);
  54:	4501                	li	a0,0
  56:	00000097          	auipc	ra,0x0
  5a:	512080e7          	jalr	1298(ra) # 568 <exit>
		printf("An error ocurred");
  5e:	00001517          	auipc	a0,0x1
  62:	a3250513          	addi	a0,a0,-1486 # a90 <malloc+0xea>
  66:	00001097          	auipc	ra,0x1
  6a:	882080e7          	jalr	-1918(ra) # 8e8 <printf>
                exit(1);
  6e:	4505                	li	a0,1
  70:	00000097          	auipc	ra,0x0
  74:	4f8080e7          	jalr	1272(ra) # 568 <exit>
          close(fd[1]);
  78:	fec42503          	lw	a0,-20(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	514080e7          	jalr	1300(ra) # 590 <close>
          read(fd[0], &y, sizeof(int));
  84:	4611                	li	a2,4
  86:	fe440593          	addi	a1,s0,-28
  8a:	fe842503          	lw	a0,-24(s0)
  8e:	00000097          	auipc	ra,0x0
  92:	4f2080e7          	jalr	1266(ra) # 580 <read>
          close(fd[0]);
  96:	fe842503          	lw	a0,-24(s0)
  9a:	00000097          	auipc	ra,0x0
  9e:	4f6080e7          	jalr	1270(ra) # 590 <close>
          printf("Child process send: %d\n", y);
  a2:	fe442583          	lw	a1,-28(s0)
  a6:	00001517          	auipc	a0,0x1
  aa:	a0250513          	addi	a0,a0,-1534 # aa8 <malloc+0x102>
  ae:	00001097          	auipc	ra,0x1
  b2:	83a080e7          	jalr	-1990(ra) # 8e8 <printf>
  b6:	bf79                	j	54 <main+0x54>

00000000000000b8 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  b8:	1141                	addi	sp,sp,-16
  ba:	e422                	sd	s0,8(sp)
  bc:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  be:	0f50000f          	fence	iorw,ow
  c2:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret

00000000000000cc <load>:

int load(uint64 *p) {
  cc:	1141                	addi	sp,sp,-16
  ce:	e422                	sd	s0,8(sp)
  d0:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  d2:	0ff0000f          	fence
  d6:	6108                	ld	a0,0(a0)
  d8:	0ff0000f          	fence
}
  dc:	2501                	sext.w	a0,a0
  de:	6422                	ld	s0,8(sp)
  e0:	0141                	addi	sp,sp,16
  e2:	8082                	ret

00000000000000e4 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
  e4:	7139                	addi	sp,sp,-64
  e6:	fc06                	sd	ra,56(sp)
  e8:	f822                	sd	s0,48(sp)
  ea:	f426                	sd	s1,40(sp)
  ec:	f04a                	sd	s2,32(sp)
  ee:	ec4e                	sd	s3,24(sp)
  f0:	e852                	sd	s4,16(sp)
  f2:	e456                	sd	s5,8(sp)
  f4:	e05a                	sd	s6,0(sp)
  f6:	0080                	addi	s0,sp,64
  f8:	8a2a                	mv	s4,a0
  fa:	89ae                	mv	s3,a1
  fc:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
  fe:	4785                	li	a5,1
 100:	00001497          	auipc	s1,0x1
 104:	9f848493          	addi	s1,s1,-1544 # af8 <rings+0x8>
 108:	00001917          	auipc	s2,0x1
 10c:	ae090913          	addi	s2,s2,-1312 # be8 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 110:	00001b17          	auipc	s6,0x1
 114:	9d0b0b13          	addi	s6,s6,-1584 # ae0 <vm_addr>
  if(open_close == 1){
 118:	04f59063          	bne	a1,a5,158 <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 11c:	00001497          	auipc	s1,0x1
 120:	9e44a483          	lw	s1,-1564(s1) # b00 <rings+0x10>
 124:	c099                	beqz	s1,12a <create_or_close_the_buffer_user+0x46>
 126:	4481                	li	s1,0
 128:	a899                	j	17e <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 12a:	865a                	mv	a2,s6
 12c:	4585                	li	a1,1
 12e:	00000097          	auipc	ra,0x0
 132:	4da080e7          	jalr	1242(ra) # 608 <ringbuf>
        rings[i].book->write_done = 0;
 136:	00001797          	auipc	a5,0x1
 13a:	9ba78793          	addi	a5,a5,-1606 # af0 <rings>
 13e:	6798                	ld	a4,8(a5)
 140:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 144:	6798                	ld	a4,8(a5)
 146:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 14a:	4b98                	lw	a4,16(a5)
 14c:	2705                	addiw	a4,a4,1
 14e:	cb98                	sw	a4,16(a5)
        break;
 150:	a03d                	j	17e <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 152:	04e1                	addi	s1,s1,24
 154:	03248463          	beq	s1,s2,17c <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 158:	449c                	lw	a5,8(s1)
 15a:	dfe5                	beqz	a5,152 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 15c:	865a                	mv	a2,s6
 15e:	85ce                	mv	a1,s3
 160:	8552                	mv	a0,s4
 162:	00000097          	auipc	ra,0x0
 166:	4a6080e7          	jalr	1190(ra) # 608 <ringbuf>
        rings[i].book->write_done = 0;
 16a:	609c                	ld	a5,0(s1)
 16c:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 170:	609c                	ld	a5,0(s1)
 172:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 176:	0004a423          	sw	zero,8(s1)
 17a:	bfe1                	j	152 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 17c:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 17e:	00001797          	auipc	a5,0x1
 182:	9627b783          	ld	a5,-1694(a5) # ae0 <vm_addr>
 186:	00fab023          	sd	a5,0(s5)
  return i;
}
 18a:	8526                	mv	a0,s1
 18c:	70e2                	ld	ra,56(sp)
 18e:	7442                	ld	s0,48(sp)
 190:	74a2                	ld	s1,40(sp)
 192:	7902                	ld	s2,32(sp)
 194:	69e2                	ld	s3,24(sp)
 196:	6a42                	ld	s4,16(sp)
 198:	6aa2                	ld	s5,8(sp)
 19a:	6b02                	ld	s6,0(sp)
 19c:	6121                	addi	sp,sp,64
 19e:	8082                	ret

00000000000001a0 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 1a0:	1101                	addi	sp,sp,-32
 1a2:	ec06                	sd	ra,24(sp)
 1a4:	e822                	sd	s0,16(sp)
 1a6:	e426                	sd	s1,8(sp)
 1a8:	1000                	addi	s0,sp,32
 1aa:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 1ac:	00001797          	auipc	a5,0x1
 1b0:	9347b783          	ld	a5,-1740(a5) # ae0 <vm_addr>
 1b4:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 1b6:	421c                	lw	a5,0(a2)
 1b8:	e79d                	bnez	a5,1e6 <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 1ba:	00001697          	auipc	a3,0x1
 1be:	93668693          	addi	a3,a3,-1738 # af0 <rings>
 1c2:	669c                	ld	a5,8(a3)
 1c4:	6398                	ld	a4,0(a5)
 1c6:	67c1                	lui	a5,0x10
 1c8:	9fb9                	addw	a5,a5,a4
 1ca:	00151713          	slli	a4,a0,0x1
 1ce:	953a                	add	a0,a0,a4
 1d0:	050e                	slli	a0,a0,0x3
 1d2:	9536                	add	a0,a0,a3
 1d4:	6518                	ld	a4,8(a0)
 1d6:	6718                	ld	a4,8(a4)
 1d8:	9f99                	subw	a5,a5,a4
 1da:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 1dc:	60e2                	ld	ra,24(sp)
 1de:	6442                	ld	s0,16(sp)
 1e0:	64a2                	ld	s1,8(sp)
 1e2:	6105                	addi	sp,sp,32
 1e4:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 1e6:	00151793          	slli	a5,a0,0x1
 1ea:	953e                	add	a0,a0,a5
 1ec:	050e                	slli	a0,a0,0x3
 1ee:	00001797          	auipc	a5,0x1
 1f2:	90278793          	addi	a5,a5,-1790 # af0 <rings>
 1f6:	953e                	add	a0,a0,a5
 1f8:	6508                	ld	a0,8(a0)
 1fa:	0521                	addi	a0,a0,8
 1fc:	00000097          	auipc	ra,0x0
 200:	ed0080e7          	jalr	-304(ra) # cc <load>
 204:	c088                	sw	a0,0(s1)
}
 206:	bfd9                	j	1dc <ringbuf_start_write+0x3c>

0000000000000208 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 208:	1141                	addi	sp,sp,-16
 20a:	e406                	sd	ra,8(sp)
 20c:	e022                	sd	s0,0(sp)
 20e:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 210:	00151793          	slli	a5,a0,0x1
 214:	97aa                	add	a5,a5,a0
 216:	078e                	slli	a5,a5,0x3
 218:	00001517          	auipc	a0,0x1
 21c:	8d850513          	addi	a0,a0,-1832 # af0 <rings>
 220:	97aa                	add	a5,a5,a0
 222:	6788                	ld	a0,8(a5)
 224:	0035959b          	slliw	a1,a1,0x3
 228:	0521                	addi	a0,a0,8
 22a:	00000097          	auipc	ra,0x0
 22e:	e8e080e7          	jalr	-370(ra) # b8 <store>
}
 232:	60a2                	ld	ra,8(sp)
 234:	6402                	ld	s0,0(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret

000000000000023a <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 23a:	1101                	addi	sp,sp,-32
 23c:	ec06                	sd	ra,24(sp)
 23e:	e822                	sd	s0,16(sp)
 240:	e426                	sd	s1,8(sp)
 242:	1000                	addi	s0,sp,32
 244:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 246:	00151793          	slli	a5,a0,0x1
 24a:	97aa                	add	a5,a5,a0
 24c:	078e                	slli	a5,a5,0x3
 24e:	00001517          	auipc	a0,0x1
 252:	8a250513          	addi	a0,a0,-1886 # af0 <rings>
 256:	97aa                	add	a5,a5,a0
 258:	6788                	ld	a0,8(a5)
 25a:	0521                	addi	a0,a0,8
 25c:	00000097          	auipc	ra,0x0
 260:	e70080e7          	jalr	-400(ra) # cc <load>
 264:	c088                	sw	a0,0(s1)
}
 266:	60e2                	ld	ra,24(sp)
 268:	6442                	ld	s0,16(sp)
 26a:	64a2                	ld	s1,8(sp)
 26c:	6105                	addi	sp,sp,32
 26e:	8082                	ret

0000000000000270 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 270:	1101                	addi	sp,sp,-32
 272:	ec06                	sd	ra,24(sp)
 274:	e822                	sd	s0,16(sp)
 276:	e426                	sd	s1,8(sp)
 278:	1000                	addi	s0,sp,32
 27a:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 27c:	00151793          	slli	a5,a0,0x1
 280:	97aa                	add	a5,a5,a0
 282:	078e                	slli	a5,a5,0x3
 284:	00001517          	auipc	a0,0x1
 288:	86c50513          	addi	a0,a0,-1940 # af0 <rings>
 28c:	97aa                	add	a5,a5,a0
 28e:	6788                	ld	a0,8(a5)
 290:	611c                	ld	a5,0(a0)
 292:	ef99                	bnez	a5,2b0 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 294:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 296:	41f7579b          	sraiw	a5,a4,0x1f
 29a:	01d7d79b          	srliw	a5,a5,0x1d
 29e:	9fb9                	addw	a5,a5,a4
 2a0:	4037d79b          	sraiw	a5,a5,0x3
 2a4:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 2a6:	60e2                	ld	ra,24(sp)
 2a8:	6442                	ld	s0,16(sp)
 2aa:	64a2                	ld	s1,8(sp)
 2ac:	6105                	addi	sp,sp,32
 2ae:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 2b0:	00000097          	auipc	ra,0x0
 2b4:	e1c080e7          	jalr	-484(ra) # cc <load>
    *bytes /= 8;
 2b8:	41f5579b          	sraiw	a5,a0,0x1f
 2bc:	01d7d79b          	srliw	a5,a5,0x1d
 2c0:	9d3d                	addw	a0,a0,a5
 2c2:	4035551b          	sraiw	a0,a0,0x3
 2c6:	c088                	sw	a0,0(s1)
}
 2c8:	bff9                	j	2a6 <ringbuf_start_read+0x36>

00000000000002ca <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e406                	sd	ra,8(sp)
 2ce:	e022                	sd	s0,0(sp)
 2d0:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 2d2:	00151793          	slli	a5,a0,0x1
 2d6:	97aa                	add	a5,a5,a0
 2d8:	078e                	slli	a5,a5,0x3
 2da:	00001517          	auipc	a0,0x1
 2de:	81650513          	addi	a0,a0,-2026 # af0 <rings>
 2e2:	97aa                	add	a5,a5,a0
 2e4:	0035959b          	slliw	a1,a1,0x3
 2e8:	6788                	ld	a0,8(a5)
 2ea:	00000097          	auipc	ra,0x0
 2ee:	dce080e7          	jalr	-562(ra) # b8 <store>
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 300:	87aa                	mv	a5,a0
 302:	0585                	addi	a1,a1,1
 304:	0785                	addi	a5,a5,1
 306:	fff5c703          	lbu	a4,-1(a1)
 30a:	fee78fa3          	sb	a4,-1(a5)
 30e:	fb75                	bnez	a4,302 <strcpy+0x8>
    ;
  return os;
}
 310:	6422                	ld	s0,8(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 316:	1141                	addi	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 31c:	00054783          	lbu	a5,0(a0)
 320:	cb91                	beqz	a5,334 <strcmp+0x1e>
 322:	0005c703          	lbu	a4,0(a1)
 326:	00f71763          	bne	a4,a5,334 <strcmp+0x1e>
    p++, q++;
 32a:	0505                	addi	a0,a0,1
 32c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 32e:	00054783          	lbu	a5,0(a0)
 332:	fbe5                	bnez	a5,322 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 334:	0005c503          	lbu	a0,0(a1)
}
 338:	40a7853b          	subw	a0,a5,a0
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <strlen>:

uint
strlen(const char *s)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 348:	00054783          	lbu	a5,0(a0)
 34c:	cf91                	beqz	a5,368 <strlen+0x26>
 34e:	0505                	addi	a0,a0,1
 350:	87aa                	mv	a5,a0
 352:	4685                	li	a3,1
 354:	9e89                	subw	a3,a3,a0
 356:	00f6853b          	addw	a0,a3,a5
 35a:	0785                	addi	a5,a5,1
 35c:	fff7c703          	lbu	a4,-1(a5)
 360:	fb7d                	bnez	a4,356 <strlen+0x14>
    ;
  return n;
}
 362:	6422                	ld	s0,8(sp)
 364:	0141                	addi	sp,sp,16
 366:	8082                	ret
  for(n = 0; s[n]; n++)
 368:	4501                	li	a0,0
 36a:	bfe5                	j	362 <strlen+0x20>

000000000000036c <memset>:

void*
memset(void *dst, int c, uint n)
{
 36c:	1141                	addi	sp,sp,-16
 36e:	e422                	sd	s0,8(sp)
 370:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 372:	ca19                	beqz	a2,388 <memset+0x1c>
 374:	87aa                	mv	a5,a0
 376:	1602                	slli	a2,a2,0x20
 378:	9201                	srli	a2,a2,0x20
 37a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 37e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 382:	0785                	addi	a5,a5,1
 384:	fee79de3          	bne	a5,a4,37e <memset+0x12>
  }
  return dst;
}
 388:	6422                	ld	s0,8(sp)
 38a:	0141                	addi	sp,sp,16
 38c:	8082                	ret

000000000000038e <strchr>:

char*
strchr(const char *s, char c)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e422                	sd	s0,8(sp)
 392:	0800                	addi	s0,sp,16
  for(; *s; s++)
 394:	00054783          	lbu	a5,0(a0)
 398:	cb99                	beqz	a5,3ae <strchr+0x20>
    if(*s == c)
 39a:	00f58763          	beq	a1,a5,3a8 <strchr+0x1a>
  for(; *s; s++)
 39e:	0505                	addi	a0,a0,1
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	fbfd                	bnez	a5,39a <strchr+0xc>
      return (char*)s;
  return 0;
 3a6:	4501                	li	a0,0
}
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret
  return 0;
 3ae:	4501                	li	a0,0
 3b0:	bfe5                	j	3a8 <strchr+0x1a>

00000000000003b2 <gets>:

char*
gets(char *buf, int max)
{
 3b2:	711d                	addi	sp,sp,-96
 3b4:	ec86                	sd	ra,88(sp)
 3b6:	e8a2                	sd	s0,80(sp)
 3b8:	e4a6                	sd	s1,72(sp)
 3ba:	e0ca                	sd	s2,64(sp)
 3bc:	fc4e                	sd	s3,56(sp)
 3be:	f852                	sd	s4,48(sp)
 3c0:	f456                	sd	s5,40(sp)
 3c2:	f05a                	sd	s6,32(sp)
 3c4:	ec5e                	sd	s7,24(sp)
 3c6:	1080                	addi	s0,sp,96
 3c8:	8baa                	mv	s7,a0
 3ca:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3cc:	892a                	mv	s2,a0
 3ce:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3d0:	4aa9                	li	s5,10
 3d2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3d4:	89a6                	mv	s3,s1
 3d6:	2485                	addiw	s1,s1,1
 3d8:	0344d863          	bge	s1,s4,408 <gets+0x56>
    cc = read(0, &c, 1);
 3dc:	4605                	li	a2,1
 3de:	faf40593          	addi	a1,s0,-81
 3e2:	4501                	li	a0,0
 3e4:	00000097          	auipc	ra,0x0
 3e8:	19c080e7          	jalr	412(ra) # 580 <read>
    if(cc < 1)
 3ec:	00a05e63          	blez	a0,408 <gets+0x56>
    buf[i++] = c;
 3f0:	faf44783          	lbu	a5,-81(s0)
 3f4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3f8:	01578763          	beq	a5,s5,406 <gets+0x54>
 3fc:	0905                	addi	s2,s2,1
 3fe:	fd679be3          	bne	a5,s6,3d4 <gets+0x22>
  for(i=0; i+1 < max; ){
 402:	89a6                	mv	s3,s1
 404:	a011                	j	408 <gets+0x56>
 406:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 408:	99de                	add	s3,s3,s7
 40a:	00098023          	sb	zero,0(s3)
  return buf;
}
 40e:	855e                	mv	a0,s7
 410:	60e6                	ld	ra,88(sp)
 412:	6446                	ld	s0,80(sp)
 414:	64a6                	ld	s1,72(sp)
 416:	6906                	ld	s2,64(sp)
 418:	79e2                	ld	s3,56(sp)
 41a:	7a42                	ld	s4,48(sp)
 41c:	7aa2                	ld	s5,40(sp)
 41e:	7b02                	ld	s6,32(sp)
 420:	6be2                	ld	s7,24(sp)
 422:	6125                	addi	sp,sp,96
 424:	8082                	ret

0000000000000426 <stat>:

int
stat(const char *n, struct stat *st)
{
 426:	1101                	addi	sp,sp,-32
 428:	ec06                	sd	ra,24(sp)
 42a:	e822                	sd	s0,16(sp)
 42c:	e426                	sd	s1,8(sp)
 42e:	e04a                	sd	s2,0(sp)
 430:	1000                	addi	s0,sp,32
 432:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 434:	4581                	li	a1,0
 436:	00000097          	auipc	ra,0x0
 43a:	172080e7          	jalr	370(ra) # 5a8 <open>
  if(fd < 0)
 43e:	02054563          	bltz	a0,468 <stat+0x42>
 442:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 444:	85ca                	mv	a1,s2
 446:	00000097          	auipc	ra,0x0
 44a:	17a080e7          	jalr	378(ra) # 5c0 <fstat>
 44e:	892a                	mv	s2,a0
  close(fd);
 450:	8526                	mv	a0,s1
 452:	00000097          	auipc	ra,0x0
 456:	13e080e7          	jalr	318(ra) # 590 <close>
  return r;
}
 45a:	854a                	mv	a0,s2
 45c:	60e2                	ld	ra,24(sp)
 45e:	6442                	ld	s0,16(sp)
 460:	64a2                	ld	s1,8(sp)
 462:	6902                	ld	s2,0(sp)
 464:	6105                	addi	sp,sp,32
 466:	8082                	ret
    return -1;
 468:	597d                	li	s2,-1
 46a:	bfc5                	j	45a <stat+0x34>

000000000000046c <atoi>:

int
atoi(const char *s)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 472:	00054603          	lbu	a2,0(a0)
 476:	fd06079b          	addiw	a5,a2,-48
 47a:	0ff7f793          	zext.b	a5,a5
 47e:	4725                	li	a4,9
 480:	02f76963          	bltu	a4,a5,4b2 <atoi+0x46>
 484:	86aa                	mv	a3,a0
  n = 0;
 486:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 488:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 48a:	0685                	addi	a3,a3,1
 48c:	0025179b          	slliw	a5,a0,0x2
 490:	9fa9                	addw	a5,a5,a0
 492:	0017979b          	slliw	a5,a5,0x1
 496:	9fb1                	addw	a5,a5,a2
 498:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 49c:	0006c603          	lbu	a2,0(a3)
 4a0:	fd06071b          	addiw	a4,a2,-48
 4a4:	0ff77713          	zext.b	a4,a4
 4a8:	fee5f1e3          	bgeu	a1,a4,48a <atoi+0x1e>
  return n;
}
 4ac:	6422                	ld	s0,8(sp)
 4ae:	0141                	addi	sp,sp,16
 4b0:	8082                	ret
  n = 0;
 4b2:	4501                	li	a0,0
 4b4:	bfe5                	j	4ac <atoi+0x40>

00000000000004b6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4b6:	1141                	addi	sp,sp,-16
 4b8:	e422                	sd	s0,8(sp)
 4ba:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4bc:	02b57463          	bgeu	a0,a1,4e4 <memmove+0x2e>
    while(n-- > 0)
 4c0:	00c05f63          	blez	a2,4de <memmove+0x28>
 4c4:	1602                	slli	a2,a2,0x20
 4c6:	9201                	srli	a2,a2,0x20
 4c8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4cc:	872a                	mv	a4,a0
      *dst++ = *src++;
 4ce:	0585                	addi	a1,a1,1
 4d0:	0705                	addi	a4,a4,1
 4d2:	fff5c683          	lbu	a3,-1(a1)
 4d6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4da:	fee79ae3          	bne	a5,a4,4ce <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4de:	6422                	ld	s0,8(sp)
 4e0:	0141                	addi	sp,sp,16
 4e2:	8082                	ret
    dst += n;
 4e4:	00c50733          	add	a4,a0,a2
    src += n;
 4e8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4ea:	fec05ae3          	blez	a2,4de <memmove+0x28>
 4ee:	fff6079b          	addiw	a5,a2,-1
 4f2:	1782                	slli	a5,a5,0x20
 4f4:	9381                	srli	a5,a5,0x20
 4f6:	fff7c793          	not	a5,a5
 4fa:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4fc:	15fd                	addi	a1,a1,-1
 4fe:	177d                	addi	a4,a4,-1
 500:	0005c683          	lbu	a3,0(a1)
 504:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 508:	fee79ae3          	bne	a5,a4,4fc <memmove+0x46>
 50c:	bfc9                	j	4de <memmove+0x28>

000000000000050e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 50e:	1141                	addi	sp,sp,-16
 510:	e422                	sd	s0,8(sp)
 512:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 514:	ca05                	beqz	a2,544 <memcmp+0x36>
 516:	fff6069b          	addiw	a3,a2,-1
 51a:	1682                	slli	a3,a3,0x20
 51c:	9281                	srli	a3,a3,0x20
 51e:	0685                	addi	a3,a3,1
 520:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 522:	00054783          	lbu	a5,0(a0)
 526:	0005c703          	lbu	a4,0(a1)
 52a:	00e79863          	bne	a5,a4,53a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 52e:	0505                	addi	a0,a0,1
    p2++;
 530:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 532:	fed518e3          	bne	a0,a3,522 <memcmp+0x14>
  }
  return 0;
 536:	4501                	li	a0,0
 538:	a019                	j	53e <memcmp+0x30>
      return *p1 - *p2;
 53a:	40e7853b          	subw	a0,a5,a4
}
 53e:	6422                	ld	s0,8(sp)
 540:	0141                	addi	sp,sp,16
 542:	8082                	ret
  return 0;
 544:	4501                	li	a0,0
 546:	bfe5                	j	53e <memcmp+0x30>

0000000000000548 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 548:	1141                	addi	sp,sp,-16
 54a:	e406                	sd	ra,8(sp)
 54c:	e022                	sd	s0,0(sp)
 54e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 550:	00000097          	auipc	ra,0x0
 554:	f66080e7          	jalr	-154(ra) # 4b6 <memmove>
}
 558:	60a2                	ld	ra,8(sp)
 55a:	6402                	ld	s0,0(sp)
 55c:	0141                	addi	sp,sp,16
 55e:	8082                	ret

0000000000000560 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 560:	4885                	li	a7,1
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <exit>:
.global exit
exit:
 li a7, SYS_exit
 568:	4889                	li	a7,2
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <wait>:
.global wait
wait:
 li a7, SYS_wait
 570:	488d                	li	a7,3
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 578:	4891                	li	a7,4
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <read>:
.global read
read:
 li a7, SYS_read
 580:	4895                	li	a7,5
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <write>:
.global write
write:
 li a7, SYS_write
 588:	48c1                	li	a7,16
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <close>:
.global close
close:
 li a7, SYS_close
 590:	48d5                	li	a7,21
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <kill>:
.global kill
kill:
 li a7, SYS_kill
 598:	4899                	li	a7,6
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5a0:	489d                	li	a7,7
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <open>:
.global open
open:
 li a7, SYS_open
 5a8:	48bd                	li	a7,15
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5b0:	48c5                	li	a7,17
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5b8:	48c9                	li	a7,18
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5c0:	48a1                	li	a7,8
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <link>:
.global link
link:
 li a7, SYS_link
 5c8:	48cd                	li	a7,19
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5d0:	48d1                	li	a7,20
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5d8:	48a5                	li	a7,9
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5e0:	48a9                	li	a7,10
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5e8:	48ad                	li	a7,11
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5f0:	48b1                	li	a7,12
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5f8:	48b5                	li	a7,13
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 600:	48b9                	li	a7,14
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 608:	48d9                	li	a7,22
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 610:	1101                	addi	sp,sp,-32
 612:	ec06                	sd	ra,24(sp)
 614:	e822                	sd	s0,16(sp)
 616:	1000                	addi	s0,sp,32
 618:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 61c:	4605                	li	a2,1
 61e:	fef40593          	addi	a1,s0,-17
 622:	00000097          	auipc	ra,0x0
 626:	f66080e7          	jalr	-154(ra) # 588 <write>
}
 62a:	60e2                	ld	ra,24(sp)
 62c:	6442                	ld	s0,16(sp)
 62e:	6105                	addi	sp,sp,32
 630:	8082                	ret

0000000000000632 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 632:	7139                	addi	sp,sp,-64
 634:	fc06                	sd	ra,56(sp)
 636:	f822                	sd	s0,48(sp)
 638:	f426                	sd	s1,40(sp)
 63a:	f04a                	sd	s2,32(sp)
 63c:	ec4e                	sd	s3,24(sp)
 63e:	0080                	addi	s0,sp,64
 640:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 642:	c299                	beqz	a3,648 <printint+0x16>
 644:	0805c863          	bltz	a1,6d4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 648:	2581                	sext.w	a1,a1
  neg = 0;
 64a:	4881                	li	a7,0
 64c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 650:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 652:	2601                	sext.w	a2,a2
 654:	00000517          	auipc	a0,0x0
 658:	47450513          	addi	a0,a0,1140 # ac8 <digits>
 65c:	883a                	mv	a6,a4
 65e:	2705                	addiw	a4,a4,1
 660:	02c5f7bb          	remuw	a5,a1,a2
 664:	1782                	slli	a5,a5,0x20
 666:	9381                	srli	a5,a5,0x20
 668:	97aa                	add	a5,a5,a0
 66a:	0007c783          	lbu	a5,0(a5)
 66e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 672:	0005879b          	sext.w	a5,a1
 676:	02c5d5bb          	divuw	a1,a1,a2
 67a:	0685                	addi	a3,a3,1
 67c:	fec7f0e3          	bgeu	a5,a2,65c <printint+0x2a>
  if(neg)
 680:	00088b63          	beqz	a7,696 <printint+0x64>
    buf[i++] = '-';
 684:	fd040793          	addi	a5,s0,-48
 688:	973e                	add	a4,a4,a5
 68a:	02d00793          	li	a5,45
 68e:	fef70823          	sb	a5,-16(a4)
 692:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 696:	02e05863          	blez	a4,6c6 <printint+0x94>
 69a:	fc040793          	addi	a5,s0,-64
 69e:	00e78933          	add	s2,a5,a4
 6a2:	fff78993          	addi	s3,a5,-1
 6a6:	99ba                	add	s3,s3,a4
 6a8:	377d                	addiw	a4,a4,-1
 6aa:	1702                	slli	a4,a4,0x20
 6ac:	9301                	srli	a4,a4,0x20
 6ae:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6b2:	fff94583          	lbu	a1,-1(s2)
 6b6:	8526                	mv	a0,s1
 6b8:	00000097          	auipc	ra,0x0
 6bc:	f58080e7          	jalr	-168(ra) # 610 <putc>
  while(--i >= 0)
 6c0:	197d                	addi	s2,s2,-1
 6c2:	ff3918e3          	bne	s2,s3,6b2 <printint+0x80>
}
 6c6:	70e2                	ld	ra,56(sp)
 6c8:	7442                	ld	s0,48(sp)
 6ca:	74a2                	ld	s1,40(sp)
 6cc:	7902                	ld	s2,32(sp)
 6ce:	69e2                	ld	s3,24(sp)
 6d0:	6121                	addi	sp,sp,64
 6d2:	8082                	ret
    x = -xx;
 6d4:	40b005bb          	negw	a1,a1
    neg = 1;
 6d8:	4885                	li	a7,1
    x = -xx;
 6da:	bf8d                	j	64c <printint+0x1a>

00000000000006dc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6dc:	7119                	addi	sp,sp,-128
 6de:	fc86                	sd	ra,120(sp)
 6e0:	f8a2                	sd	s0,112(sp)
 6e2:	f4a6                	sd	s1,104(sp)
 6e4:	f0ca                	sd	s2,96(sp)
 6e6:	ecce                	sd	s3,88(sp)
 6e8:	e8d2                	sd	s4,80(sp)
 6ea:	e4d6                	sd	s5,72(sp)
 6ec:	e0da                	sd	s6,64(sp)
 6ee:	fc5e                	sd	s7,56(sp)
 6f0:	f862                	sd	s8,48(sp)
 6f2:	f466                	sd	s9,40(sp)
 6f4:	f06a                	sd	s10,32(sp)
 6f6:	ec6e                	sd	s11,24(sp)
 6f8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6fa:	0005c903          	lbu	s2,0(a1)
 6fe:	18090f63          	beqz	s2,89c <vprintf+0x1c0>
 702:	8aaa                	mv	s5,a0
 704:	8b32                	mv	s6,a2
 706:	00158493          	addi	s1,a1,1
  state = 0;
 70a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 70c:	02500a13          	li	s4,37
      if(c == 'd'){
 710:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 714:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 718:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 71c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 720:	00000b97          	auipc	s7,0x0
 724:	3a8b8b93          	addi	s7,s7,936 # ac8 <digits>
 728:	a839                	j	746 <vprintf+0x6a>
        putc(fd, c);
 72a:	85ca                	mv	a1,s2
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	ee2080e7          	jalr	-286(ra) # 610 <putc>
 736:	a019                	j	73c <vprintf+0x60>
    } else if(state == '%'){
 738:	01498f63          	beq	s3,s4,756 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 73c:	0485                	addi	s1,s1,1
 73e:	fff4c903          	lbu	s2,-1(s1)
 742:	14090d63          	beqz	s2,89c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 746:	0009079b          	sext.w	a5,s2
    if(state == 0){
 74a:	fe0997e3          	bnez	s3,738 <vprintf+0x5c>
      if(c == '%'){
 74e:	fd479ee3          	bne	a5,s4,72a <vprintf+0x4e>
        state = '%';
 752:	89be                	mv	s3,a5
 754:	b7e5                	j	73c <vprintf+0x60>
      if(c == 'd'){
 756:	05878063          	beq	a5,s8,796 <vprintf+0xba>
      } else if(c == 'l') {
 75a:	05978c63          	beq	a5,s9,7b2 <vprintf+0xd6>
      } else if(c == 'x') {
 75e:	07a78863          	beq	a5,s10,7ce <vprintf+0xf2>
      } else if(c == 'p') {
 762:	09b78463          	beq	a5,s11,7ea <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 766:	07300713          	li	a4,115
 76a:	0ce78663          	beq	a5,a4,836 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 76e:	06300713          	li	a4,99
 772:	0ee78e63          	beq	a5,a4,86e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 776:	11478863          	beq	a5,s4,886 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 77a:	85d2                	mv	a1,s4
 77c:	8556                	mv	a0,s5
 77e:	00000097          	auipc	ra,0x0
 782:	e92080e7          	jalr	-366(ra) # 610 <putc>
        putc(fd, c);
 786:	85ca                	mv	a1,s2
 788:	8556                	mv	a0,s5
 78a:	00000097          	auipc	ra,0x0
 78e:	e86080e7          	jalr	-378(ra) # 610 <putc>
      }
      state = 0;
 792:	4981                	li	s3,0
 794:	b765                	j	73c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 796:	008b0913          	addi	s2,s6,8
 79a:	4685                	li	a3,1
 79c:	4629                	li	a2,10
 79e:	000b2583          	lw	a1,0(s6)
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	e8e080e7          	jalr	-370(ra) # 632 <printint>
 7ac:	8b4a                	mv	s6,s2
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b771                	j	73c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7b2:	008b0913          	addi	s2,s6,8
 7b6:	4681                	li	a3,0
 7b8:	4629                	li	a2,10
 7ba:	000b2583          	lw	a1,0(s6)
 7be:	8556                	mv	a0,s5
 7c0:	00000097          	auipc	ra,0x0
 7c4:	e72080e7          	jalr	-398(ra) # 632 <printint>
 7c8:	8b4a                	mv	s6,s2
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	bf85                	j	73c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7ce:	008b0913          	addi	s2,s6,8
 7d2:	4681                	li	a3,0
 7d4:	4641                	li	a2,16
 7d6:	000b2583          	lw	a1,0(s6)
 7da:	8556                	mv	a0,s5
 7dc:	00000097          	auipc	ra,0x0
 7e0:	e56080e7          	jalr	-426(ra) # 632 <printint>
 7e4:	8b4a                	mv	s6,s2
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	bf91                	j	73c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7ea:	008b0793          	addi	a5,s6,8
 7ee:	f8f43423          	sd	a5,-120(s0)
 7f2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7f6:	03000593          	li	a1,48
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	e14080e7          	jalr	-492(ra) # 610 <putc>
  putc(fd, 'x');
 804:	85ea                	mv	a1,s10
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	e08080e7          	jalr	-504(ra) # 610 <putc>
 810:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 812:	03c9d793          	srli	a5,s3,0x3c
 816:	97de                	add	a5,a5,s7
 818:	0007c583          	lbu	a1,0(a5)
 81c:	8556                	mv	a0,s5
 81e:	00000097          	auipc	ra,0x0
 822:	df2080e7          	jalr	-526(ra) # 610 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 826:	0992                	slli	s3,s3,0x4
 828:	397d                	addiw	s2,s2,-1
 82a:	fe0914e3          	bnez	s2,812 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 82e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 832:	4981                	li	s3,0
 834:	b721                	j	73c <vprintf+0x60>
        s = va_arg(ap, char*);
 836:	008b0993          	addi	s3,s6,8
 83a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 83e:	02090163          	beqz	s2,860 <vprintf+0x184>
        while(*s != 0){
 842:	00094583          	lbu	a1,0(s2)
 846:	c9a1                	beqz	a1,896 <vprintf+0x1ba>
          putc(fd, *s);
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	dc6080e7          	jalr	-570(ra) # 610 <putc>
          s++;
 852:	0905                	addi	s2,s2,1
        while(*s != 0){
 854:	00094583          	lbu	a1,0(s2)
 858:	f9e5                	bnez	a1,848 <vprintf+0x16c>
        s = va_arg(ap, char*);
 85a:	8b4e                	mv	s6,s3
      state = 0;
 85c:	4981                	li	s3,0
 85e:	bdf9                	j	73c <vprintf+0x60>
          s = "(null)";
 860:	00000917          	auipc	s2,0x0
 864:	26090913          	addi	s2,s2,608 # ac0 <malloc+0x11a>
        while(*s != 0){
 868:	02800593          	li	a1,40
 86c:	bff1                	j	848 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 86e:	008b0913          	addi	s2,s6,8
 872:	000b4583          	lbu	a1,0(s6)
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	d98080e7          	jalr	-616(ra) # 610 <putc>
 880:	8b4a                	mv	s6,s2
      state = 0;
 882:	4981                	li	s3,0
 884:	bd65                	j	73c <vprintf+0x60>
        putc(fd, c);
 886:	85d2                	mv	a1,s4
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	d86080e7          	jalr	-634(ra) # 610 <putc>
      state = 0;
 892:	4981                	li	s3,0
 894:	b565                	j	73c <vprintf+0x60>
        s = va_arg(ap, char*);
 896:	8b4e                	mv	s6,s3
      state = 0;
 898:	4981                	li	s3,0
 89a:	b54d                	j	73c <vprintf+0x60>
    }
  }
}
 89c:	70e6                	ld	ra,120(sp)
 89e:	7446                	ld	s0,112(sp)
 8a0:	74a6                	ld	s1,104(sp)
 8a2:	7906                	ld	s2,96(sp)
 8a4:	69e6                	ld	s3,88(sp)
 8a6:	6a46                	ld	s4,80(sp)
 8a8:	6aa6                	ld	s5,72(sp)
 8aa:	6b06                	ld	s6,64(sp)
 8ac:	7be2                	ld	s7,56(sp)
 8ae:	7c42                	ld	s8,48(sp)
 8b0:	7ca2                	ld	s9,40(sp)
 8b2:	7d02                	ld	s10,32(sp)
 8b4:	6de2                	ld	s11,24(sp)
 8b6:	6109                	addi	sp,sp,128
 8b8:	8082                	ret

00000000000008ba <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8ba:	715d                	addi	sp,sp,-80
 8bc:	ec06                	sd	ra,24(sp)
 8be:	e822                	sd	s0,16(sp)
 8c0:	1000                	addi	s0,sp,32
 8c2:	e010                	sd	a2,0(s0)
 8c4:	e414                	sd	a3,8(s0)
 8c6:	e818                	sd	a4,16(s0)
 8c8:	ec1c                	sd	a5,24(s0)
 8ca:	03043023          	sd	a6,32(s0)
 8ce:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8d6:	8622                	mv	a2,s0
 8d8:	00000097          	auipc	ra,0x0
 8dc:	e04080e7          	jalr	-508(ra) # 6dc <vprintf>
}
 8e0:	60e2                	ld	ra,24(sp)
 8e2:	6442                	ld	s0,16(sp)
 8e4:	6161                	addi	sp,sp,80
 8e6:	8082                	ret

00000000000008e8 <printf>:

void
printf(const char *fmt, ...)
{
 8e8:	711d                	addi	sp,sp,-96
 8ea:	ec06                	sd	ra,24(sp)
 8ec:	e822                	sd	s0,16(sp)
 8ee:	1000                	addi	s0,sp,32
 8f0:	e40c                	sd	a1,8(s0)
 8f2:	e810                	sd	a2,16(s0)
 8f4:	ec14                	sd	a3,24(s0)
 8f6:	f018                	sd	a4,32(s0)
 8f8:	f41c                	sd	a5,40(s0)
 8fa:	03043823          	sd	a6,48(s0)
 8fe:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 902:	00840613          	addi	a2,s0,8
 906:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 90a:	85aa                	mv	a1,a0
 90c:	4505                	li	a0,1
 90e:	00000097          	auipc	ra,0x0
 912:	dce080e7          	jalr	-562(ra) # 6dc <vprintf>
}
 916:	60e2                	ld	ra,24(sp)
 918:	6442                	ld	s0,16(sp)
 91a:	6125                	addi	sp,sp,96
 91c:	8082                	ret

000000000000091e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 91e:	1141                	addi	sp,sp,-16
 920:	e422                	sd	s0,8(sp)
 922:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 924:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 928:	00000797          	auipc	a5,0x0
 92c:	1c07b783          	ld	a5,448(a5) # ae8 <freep>
 930:	a805                	j	960 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 932:	4618                	lw	a4,8(a2)
 934:	9db9                	addw	a1,a1,a4
 936:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 93a:	6398                	ld	a4,0(a5)
 93c:	6318                	ld	a4,0(a4)
 93e:	fee53823          	sd	a4,-16(a0)
 942:	a091                	j	986 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 944:	ff852703          	lw	a4,-8(a0)
 948:	9e39                	addw	a2,a2,a4
 94a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 94c:	ff053703          	ld	a4,-16(a0)
 950:	e398                	sd	a4,0(a5)
 952:	a099                	j	998 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 954:	6398                	ld	a4,0(a5)
 956:	00e7e463          	bltu	a5,a4,95e <free+0x40>
 95a:	00e6ea63          	bltu	a3,a4,96e <free+0x50>
{
 95e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 960:	fed7fae3          	bgeu	a5,a3,954 <free+0x36>
 964:	6398                	ld	a4,0(a5)
 966:	00e6e463          	bltu	a3,a4,96e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 96a:	fee7eae3          	bltu	a5,a4,95e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 96e:	ff852583          	lw	a1,-8(a0)
 972:	6390                	ld	a2,0(a5)
 974:	02059813          	slli	a6,a1,0x20
 978:	01c85713          	srli	a4,a6,0x1c
 97c:	9736                	add	a4,a4,a3
 97e:	fae60ae3          	beq	a2,a4,932 <free+0x14>
    bp->s.ptr = p->s.ptr;
 982:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 986:	4790                	lw	a2,8(a5)
 988:	02061593          	slli	a1,a2,0x20
 98c:	01c5d713          	srli	a4,a1,0x1c
 990:	973e                	add	a4,a4,a5
 992:	fae689e3          	beq	a3,a4,944 <free+0x26>
  } else
    p->s.ptr = bp;
 996:	e394                	sd	a3,0(a5)
  freep = p;
 998:	00000717          	auipc	a4,0x0
 99c:	14f73823          	sd	a5,336(a4) # ae8 <freep>
}
 9a0:	6422                	ld	s0,8(sp)
 9a2:	0141                	addi	sp,sp,16
 9a4:	8082                	ret

00000000000009a6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9a6:	7139                	addi	sp,sp,-64
 9a8:	fc06                	sd	ra,56(sp)
 9aa:	f822                	sd	s0,48(sp)
 9ac:	f426                	sd	s1,40(sp)
 9ae:	f04a                	sd	s2,32(sp)
 9b0:	ec4e                	sd	s3,24(sp)
 9b2:	e852                	sd	s4,16(sp)
 9b4:	e456                	sd	s5,8(sp)
 9b6:	e05a                	sd	s6,0(sp)
 9b8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9ba:	02051493          	slli	s1,a0,0x20
 9be:	9081                	srli	s1,s1,0x20
 9c0:	04bd                	addi	s1,s1,15
 9c2:	8091                	srli	s1,s1,0x4
 9c4:	0014899b          	addiw	s3,s1,1
 9c8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9ca:	00000517          	auipc	a0,0x0
 9ce:	11e53503          	ld	a0,286(a0) # ae8 <freep>
 9d2:	c515                	beqz	a0,9fe <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d6:	4798                	lw	a4,8(a5)
 9d8:	02977f63          	bgeu	a4,s1,a16 <malloc+0x70>
 9dc:	8a4e                	mv	s4,s3
 9de:	0009871b          	sext.w	a4,s3
 9e2:	6685                	lui	a3,0x1
 9e4:	00d77363          	bgeu	a4,a3,9ea <malloc+0x44>
 9e8:	6a05                	lui	s4,0x1
 9ea:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9ee:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9f2:	00000917          	auipc	s2,0x0
 9f6:	0f690913          	addi	s2,s2,246 # ae8 <freep>
  if(p == (char*)-1)
 9fa:	5afd                	li	s5,-1
 9fc:	a895                	j	a70 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9fe:	00000797          	auipc	a5,0x0
 a02:	1e278793          	addi	a5,a5,482 # be0 <base>
 a06:	00000717          	auipc	a4,0x0
 a0a:	0ef73123          	sd	a5,226(a4) # ae8 <freep>
 a0e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a10:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a14:	b7e1                	j	9dc <malloc+0x36>
      if(p->s.size == nunits)
 a16:	02e48c63          	beq	s1,a4,a4e <malloc+0xa8>
        p->s.size -= nunits;
 a1a:	4137073b          	subw	a4,a4,s3
 a1e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a20:	02071693          	slli	a3,a4,0x20
 a24:	01c6d713          	srli	a4,a3,0x1c
 a28:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a2a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a2e:	00000717          	auipc	a4,0x0
 a32:	0aa73d23          	sd	a0,186(a4) # ae8 <freep>
      return (void*)(p + 1);
 a36:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a3a:	70e2                	ld	ra,56(sp)
 a3c:	7442                	ld	s0,48(sp)
 a3e:	74a2                	ld	s1,40(sp)
 a40:	7902                	ld	s2,32(sp)
 a42:	69e2                	ld	s3,24(sp)
 a44:	6a42                	ld	s4,16(sp)
 a46:	6aa2                	ld	s5,8(sp)
 a48:	6b02                	ld	s6,0(sp)
 a4a:	6121                	addi	sp,sp,64
 a4c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a4e:	6398                	ld	a4,0(a5)
 a50:	e118                	sd	a4,0(a0)
 a52:	bff1                	j	a2e <malloc+0x88>
  hp->s.size = nu;
 a54:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a58:	0541                	addi	a0,a0,16
 a5a:	00000097          	auipc	ra,0x0
 a5e:	ec4080e7          	jalr	-316(ra) # 91e <free>
  return freep;
 a62:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a66:	d971                	beqz	a0,a3a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a68:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a6a:	4798                	lw	a4,8(a5)
 a6c:	fa9775e3          	bgeu	a4,s1,a16 <malloc+0x70>
    if(p == freep)
 a70:	00093703          	ld	a4,0(s2)
 a74:	853e                	mv	a0,a5
 a76:	fef719e3          	bne	a4,a5,a68 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a7a:	8552                	mv	a0,s4
 a7c:	00000097          	auipc	ra,0x0
 a80:	b74080e7          	jalr	-1164(ra) # 5f0 <sbrk>
  if(p == (char*)-1)
 a84:	fd5518e3          	bne	a0,s5,a54 <malloc+0xae>
        return 0;
 a88:	4501                	li	a0,0
 a8a:	bf45                	j	a3a <malloc+0x94>
