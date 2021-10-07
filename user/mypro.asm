
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
  10:	554080e7          	jalr	1364(ra) # 560 <pipe>
  14:	57fd                	li	a5,-1
  16:	04f50463          	beq	a0,a5,5e <main+0x5e>
		printf("An error ocurred");
                exit(1);
	}
        int cid = fork();
  1a:	00000097          	auipc	ra,0x0
  1e:	52e080e7          	jalr	1326(ra) # 548 <fork>
        if(cid == 0){
  22:	e939                	bnez	a0,78 <main+0x78>
          close(fd[0]);
  24:	fe842503          	lw	a0,-24(s0)
  28:	00000097          	auipc	ra,0x0
  2c:	550080e7          	jalr	1360(ra) # 578 <close>
          int x=11;
  30:	47ad                	li	a5,11
  32:	fef42223          	sw	a5,-28(s0)
          write(fd[1], &x, sizeof(int));
  36:	4611                	li	a2,4
  38:	fe440593          	addi	a1,s0,-28
  3c:	fec42503          	lw	a0,-20(s0)
  40:	00000097          	auipc	ra,0x0
  44:	530080e7          	jalr	1328(ra) # 570 <write>
          close(fd[1]);
  48:	fec42503          	lw	a0,-20(s0)
  4c:	00000097          	auipc	ra,0x0
  50:	52c080e7          	jalr	1324(ra) # 578 <close>
          int y;
          read(fd[0], &y, sizeof(int));
          close(fd[0]);
          printf("Child process send: %d\n", y);
        }
    exit(0);
  54:	4501                	li	a0,0
  56:	00000097          	auipc	ra,0x0
  5a:	4fa080e7          	jalr	1274(ra) # 550 <exit>
		printf("An error ocurred");
  5e:	00001517          	auipc	a0,0x1
  62:	a1a50513          	addi	a0,a0,-1510 # a78 <malloc+0xea>
  66:	00001097          	auipc	ra,0x1
  6a:	86a080e7          	jalr	-1942(ra) # 8d0 <printf>
                exit(1);
  6e:	4505                	li	a0,1
  70:	00000097          	auipc	ra,0x0
  74:	4e0080e7          	jalr	1248(ra) # 550 <exit>
          close(fd[1]);
  78:	fec42503          	lw	a0,-20(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	4fc080e7          	jalr	1276(ra) # 578 <close>
          read(fd[0], &y, sizeof(int));
  84:	4611                	li	a2,4
  86:	fe440593          	addi	a1,s0,-28
  8a:	fe842503          	lw	a0,-24(s0)
  8e:	00000097          	auipc	ra,0x0
  92:	4da080e7          	jalr	1242(ra) # 568 <read>
          close(fd[0]);
  96:	fe842503          	lw	a0,-24(s0)
  9a:	00000097          	auipc	ra,0x0
  9e:	4de080e7          	jalr	1246(ra) # 578 <close>
          printf("Child process send: %d\n", y);
  a2:	fe442583          	lw	a1,-28(s0)
  a6:	00001517          	auipc	a0,0x1
  aa:	9ea50513          	addi	a0,a0,-1558 # a90 <malloc+0x102>
  ae:	00001097          	auipc	ra,0x1
  b2:	822080e7          	jalr	-2014(ra) # 8d0 <printf>
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

int create_or_close_the_buffer_user(char name[16], int open_close){
  e4:	7179                	addi	sp,sp,-48
  e6:	f406                	sd	ra,40(sp)
  e8:	f022                	sd	s0,32(sp)
  ea:	ec26                	sd	s1,24(sp)
  ec:	e84a                	sd	s2,16(sp)
  ee:	e44e                	sd	s3,8(sp)
  f0:	e052                	sd	s4,0(sp)
  f2:	1800                	addi	s0,sp,48
  f4:	8a2a                	mv	s4,a0
  f6:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  f8:	4785                	li	a5,1
  fa:	00001497          	auipc	s1,0x1
  fe:	9e648493          	addi	s1,s1,-1562 # ae0 <rings+0x10>
 102:	00001917          	auipc	s2,0x1
 106:	ace90913          	addi	s2,s2,-1330 # bd0 <__BSS_END__>
 10a:	04f59563          	bne	a1,a5,154 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 10e:	00001497          	auipc	s1,0x1
 112:	9d24a483          	lw	s1,-1582(s1) # ae0 <rings+0x10>
 116:	c099                	beqz	s1,11c <create_or_close_the_buffer_user+0x38>
 118:	4481                	li	s1,0
 11a:	a899                	j	170 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 11c:	00001917          	auipc	s2,0x1
 120:	9b490913          	addi	s2,s2,-1612 # ad0 <rings>
 124:	00093603          	ld	a2,0(s2)
 128:	4585                	li	a1,1
 12a:	00000097          	auipc	ra,0x0
 12e:	4c6080e7          	jalr	1222(ra) # 5f0 <ringbuf>
        rings[i].book->write_done = 0;
 132:	00893783          	ld	a5,8(s2)
 136:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 13a:	00893783          	ld	a5,8(s2)
 13e:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 142:	01092783          	lw	a5,16(s2)
 146:	2785                	addiw	a5,a5,1
 148:	00f92823          	sw	a5,16(s2)
        break;
 14c:	a015                	j	170 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 14e:	04e1                	addi	s1,s1,24
 150:	01248f63          	beq	s1,s2,16e <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 154:	409c                	lw	a5,0(s1)
 156:	dfe5                	beqz	a5,14e <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 158:	ff04b603          	ld	a2,-16(s1)
 15c:	85ce                	mv	a1,s3
 15e:	8552                	mv	a0,s4
 160:	00000097          	auipc	ra,0x0
 164:	490080e7          	jalr	1168(ra) # 5f0 <ringbuf>
        rings[i].exists = 0;
 168:	0004a023          	sw	zero,0(s1)
 16c:	b7cd                	j	14e <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 16e:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 170:	8526                	mv	a0,s1
 172:	70a2                	ld	ra,40(sp)
 174:	7402                	ld	s0,32(sp)
 176:	64e2                	ld	s1,24(sp)
 178:	6942                	ld	s2,16(sp)
 17a:	69a2                	ld	s3,8(sp)
 17c:	6a02                	ld	s4,0(sp)
 17e:	6145                	addi	sp,sp,48
 180:	8082                	ret

0000000000000182 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 182:	1101                	addi	sp,sp,-32
 184:	ec06                	sd	ra,24(sp)
 186:	e822                	sd	s0,16(sp)
 188:	e426                	sd	s1,8(sp)
 18a:	1000                	addi	s0,sp,32
 18c:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 18e:	00151793          	slli	a5,a0,0x1
 192:	97aa                	add	a5,a5,a0
 194:	078e                	slli	a5,a5,0x3
 196:	00001717          	auipc	a4,0x1
 19a:	93a70713          	addi	a4,a4,-1734 # ad0 <rings>
 19e:	97ba                	add	a5,a5,a4
 1a0:	639c                	ld	a5,0(a5)
 1a2:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 1a4:	421c                	lw	a5,0(a2)
 1a6:	e785                	bnez	a5,1ce <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 1a8:	86ba                	mv	a3,a4
 1aa:	671c                	ld	a5,8(a4)
 1ac:	6398                	ld	a4,0(a5)
 1ae:	67c1                	lui	a5,0x10
 1b0:	9fb9                	addw	a5,a5,a4
 1b2:	00151713          	slli	a4,a0,0x1
 1b6:	953a                	add	a0,a0,a4
 1b8:	050e                	slli	a0,a0,0x3
 1ba:	9536                	add	a0,a0,a3
 1bc:	6518                	ld	a4,8(a0)
 1be:	6718                	ld	a4,8(a4)
 1c0:	9f99                	subw	a5,a5,a4
 1c2:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 1c4:	60e2                	ld	ra,24(sp)
 1c6:	6442                	ld	s0,16(sp)
 1c8:	64a2                	ld	s1,8(sp)
 1ca:	6105                	addi	sp,sp,32
 1cc:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 1ce:	00151793          	slli	a5,a0,0x1
 1d2:	953e                	add	a0,a0,a5
 1d4:	050e                	slli	a0,a0,0x3
 1d6:	00001797          	auipc	a5,0x1
 1da:	8fa78793          	addi	a5,a5,-1798 # ad0 <rings>
 1de:	953e                	add	a0,a0,a5
 1e0:	6508                	ld	a0,8(a0)
 1e2:	0521                	addi	a0,a0,8
 1e4:	00000097          	auipc	ra,0x0
 1e8:	ee8080e7          	jalr	-280(ra) # cc <load>
 1ec:	c088                	sw	a0,0(s1)
}
 1ee:	bfd9                	j	1c4 <ringbuf_start_write+0x42>

00000000000001f0 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e406                	sd	ra,8(sp)
 1f4:	e022                	sd	s0,0(sp)
 1f6:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1f8:	00151793          	slli	a5,a0,0x1
 1fc:	97aa                	add	a5,a5,a0
 1fe:	078e                	slli	a5,a5,0x3
 200:	00001517          	auipc	a0,0x1
 204:	8d050513          	addi	a0,a0,-1840 # ad0 <rings>
 208:	97aa                	add	a5,a5,a0
 20a:	6788                	ld	a0,8(a5)
 20c:	0035959b          	slliw	a1,a1,0x3
 210:	0521                	addi	a0,a0,8
 212:	00000097          	auipc	ra,0x0
 216:	ea6080e7          	jalr	-346(ra) # b8 <store>
}
 21a:	60a2                	ld	ra,8(sp)
 21c:	6402                	ld	s0,0(sp)
 21e:	0141                	addi	sp,sp,16
 220:	8082                	ret

0000000000000222 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 222:	1101                	addi	sp,sp,-32
 224:	ec06                	sd	ra,24(sp)
 226:	e822                	sd	s0,16(sp)
 228:	e426                	sd	s1,8(sp)
 22a:	1000                	addi	s0,sp,32
 22c:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 22e:	00151793          	slli	a5,a0,0x1
 232:	97aa                	add	a5,a5,a0
 234:	078e                	slli	a5,a5,0x3
 236:	00001517          	auipc	a0,0x1
 23a:	89a50513          	addi	a0,a0,-1894 # ad0 <rings>
 23e:	97aa                	add	a5,a5,a0
 240:	6788                	ld	a0,8(a5)
 242:	0521                	addi	a0,a0,8
 244:	00000097          	auipc	ra,0x0
 248:	e88080e7          	jalr	-376(ra) # cc <load>
 24c:	c088                	sw	a0,0(s1)
}
 24e:	60e2                	ld	ra,24(sp)
 250:	6442                	ld	s0,16(sp)
 252:	64a2                	ld	s1,8(sp)
 254:	6105                	addi	sp,sp,32
 256:	8082                	ret

0000000000000258 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 258:	1101                	addi	sp,sp,-32
 25a:	ec06                	sd	ra,24(sp)
 25c:	e822                	sd	s0,16(sp)
 25e:	e426                	sd	s1,8(sp)
 260:	1000                	addi	s0,sp,32
 262:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 264:	00151793          	slli	a5,a0,0x1
 268:	97aa                	add	a5,a5,a0
 26a:	078e                	slli	a5,a5,0x3
 26c:	00001517          	auipc	a0,0x1
 270:	86450513          	addi	a0,a0,-1948 # ad0 <rings>
 274:	97aa                	add	a5,a5,a0
 276:	6788                	ld	a0,8(a5)
 278:	611c                	ld	a5,0(a0)
 27a:	ef99                	bnez	a5,298 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 27c:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 27e:	41f7579b          	sraiw	a5,a4,0x1f
 282:	01d7d79b          	srliw	a5,a5,0x1d
 286:	9fb9                	addw	a5,a5,a4
 288:	4037d79b          	sraiw	a5,a5,0x3
 28c:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 28e:	60e2                	ld	ra,24(sp)
 290:	6442                	ld	s0,16(sp)
 292:	64a2                	ld	s1,8(sp)
 294:	6105                	addi	sp,sp,32
 296:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 298:	00000097          	auipc	ra,0x0
 29c:	e34080e7          	jalr	-460(ra) # cc <load>
    *bytes /= 8;
 2a0:	41f5579b          	sraiw	a5,a0,0x1f
 2a4:	01d7d79b          	srliw	a5,a5,0x1d
 2a8:	9d3d                	addw	a0,a0,a5
 2aa:	4035551b          	sraiw	a0,a0,0x3
 2ae:	c088                	sw	a0,0(s1)
}
 2b0:	bff9                	j	28e <ringbuf_start_read+0x36>

00000000000002b2 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 2ba:	00151793          	slli	a5,a0,0x1
 2be:	97aa                	add	a5,a5,a0
 2c0:	078e                	slli	a5,a5,0x3
 2c2:	00001517          	auipc	a0,0x1
 2c6:	80e50513          	addi	a0,a0,-2034 # ad0 <rings>
 2ca:	97aa                	add	a5,a5,a0
 2cc:	0035959b          	slliw	a1,a1,0x3
 2d0:	6788                	ld	a0,8(a5)
 2d2:	00000097          	auipc	ra,0x0
 2d6:	de6080e7          	jalr	-538(ra) # b8 <store>
}
 2da:	60a2                	ld	ra,8(sp)
 2dc:	6402                	ld	s0,0(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret

00000000000002e2 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e8:	87aa                	mv	a5,a0
 2ea:	0585                	addi	a1,a1,1
 2ec:	0785                	addi	a5,a5,1
 2ee:	fff5c703          	lbu	a4,-1(a1)
 2f2:	fee78fa3          	sb	a4,-1(a5)
 2f6:	fb75                	bnez	a4,2ea <strcpy+0x8>
    ;
  return os;
}
 2f8:	6422                	ld	s0,8(sp)
 2fa:	0141                	addi	sp,sp,16
 2fc:	8082                	ret

00000000000002fe <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 304:	00054783          	lbu	a5,0(a0)
 308:	cb91                	beqz	a5,31c <strcmp+0x1e>
 30a:	0005c703          	lbu	a4,0(a1)
 30e:	00f71763          	bne	a4,a5,31c <strcmp+0x1e>
    p++, q++;
 312:	0505                	addi	a0,a0,1
 314:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 316:	00054783          	lbu	a5,0(a0)
 31a:	fbe5                	bnez	a5,30a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 31c:	0005c503          	lbu	a0,0(a1)
}
 320:	40a7853b          	subw	a0,a5,a0
 324:	6422                	ld	s0,8(sp)
 326:	0141                	addi	sp,sp,16
 328:	8082                	ret

000000000000032a <strlen>:

uint
strlen(const char *s)
{
 32a:	1141                	addi	sp,sp,-16
 32c:	e422                	sd	s0,8(sp)
 32e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 330:	00054783          	lbu	a5,0(a0)
 334:	cf91                	beqz	a5,350 <strlen+0x26>
 336:	0505                	addi	a0,a0,1
 338:	87aa                	mv	a5,a0
 33a:	4685                	li	a3,1
 33c:	9e89                	subw	a3,a3,a0
 33e:	00f6853b          	addw	a0,a3,a5
 342:	0785                	addi	a5,a5,1
 344:	fff7c703          	lbu	a4,-1(a5)
 348:	fb7d                	bnez	a4,33e <strlen+0x14>
    ;
  return n;
}
 34a:	6422                	ld	s0,8(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret
  for(n = 0; s[n]; n++)
 350:	4501                	li	a0,0
 352:	bfe5                	j	34a <strlen+0x20>

0000000000000354 <memset>:

void*
memset(void *dst, int c, uint n)
{
 354:	1141                	addi	sp,sp,-16
 356:	e422                	sd	s0,8(sp)
 358:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 35a:	ca19                	beqz	a2,370 <memset+0x1c>
 35c:	87aa                	mv	a5,a0
 35e:	1602                	slli	a2,a2,0x20
 360:	9201                	srli	a2,a2,0x20
 362:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 366:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 36a:	0785                	addi	a5,a5,1
 36c:	fee79de3          	bne	a5,a4,366 <memset+0x12>
  }
  return dst;
}
 370:	6422                	ld	s0,8(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <strchr>:

char*
strchr(const char *s, char c)
{
 376:	1141                	addi	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 37c:	00054783          	lbu	a5,0(a0)
 380:	cb99                	beqz	a5,396 <strchr+0x20>
    if(*s == c)
 382:	00f58763          	beq	a1,a5,390 <strchr+0x1a>
  for(; *s; s++)
 386:	0505                	addi	a0,a0,1
 388:	00054783          	lbu	a5,0(a0)
 38c:	fbfd                	bnez	a5,382 <strchr+0xc>
      return (char*)s;
  return 0;
 38e:	4501                	li	a0,0
}
 390:	6422                	ld	s0,8(sp)
 392:	0141                	addi	sp,sp,16
 394:	8082                	ret
  return 0;
 396:	4501                	li	a0,0
 398:	bfe5                	j	390 <strchr+0x1a>

000000000000039a <gets>:

char*
gets(char *buf, int max)
{
 39a:	711d                	addi	sp,sp,-96
 39c:	ec86                	sd	ra,88(sp)
 39e:	e8a2                	sd	s0,80(sp)
 3a0:	e4a6                	sd	s1,72(sp)
 3a2:	e0ca                	sd	s2,64(sp)
 3a4:	fc4e                	sd	s3,56(sp)
 3a6:	f852                	sd	s4,48(sp)
 3a8:	f456                	sd	s5,40(sp)
 3aa:	f05a                	sd	s6,32(sp)
 3ac:	ec5e                	sd	s7,24(sp)
 3ae:	1080                	addi	s0,sp,96
 3b0:	8baa                	mv	s7,a0
 3b2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b4:	892a                	mv	s2,a0
 3b6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3b8:	4aa9                	li	s5,10
 3ba:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3bc:	89a6                	mv	s3,s1
 3be:	2485                	addiw	s1,s1,1
 3c0:	0344d863          	bge	s1,s4,3f0 <gets+0x56>
    cc = read(0, &c, 1);
 3c4:	4605                	li	a2,1
 3c6:	faf40593          	addi	a1,s0,-81
 3ca:	4501                	li	a0,0
 3cc:	00000097          	auipc	ra,0x0
 3d0:	19c080e7          	jalr	412(ra) # 568 <read>
    if(cc < 1)
 3d4:	00a05e63          	blez	a0,3f0 <gets+0x56>
    buf[i++] = c;
 3d8:	faf44783          	lbu	a5,-81(s0)
 3dc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3e0:	01578763          	beq	a5,s5,3ee <gets+0x54>
 3e4:	0905                	addi	s2,s2,1
 3e6:	fd679be3          	bne	a5,s6,3bc <gets+0x22>
  for(i=0; i+1 < max; ){
 3ea:	89a6                	mv	s3,s1
 3ec:	a011                	j	3f0 <gets+0x56>
 3ee:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3f0:	99de                	add	s3,s3,s7
 3f2:	00098023          	sb	zero,0(s3)
  return buf;
}
 3f6:	855e                	mv	a0,s7
 3f8:	60e6                	ld	ra,88(sp)
 3fa:	6446                	ld	s0,80(sp)
 3fc:	64a6                	ld	s1,72(sp)
 3fe:	6906                	ld	s2,64(sp)
 400:	79e2                	ld	s3,56(sp)
 402:	7a42                	ld	s4,48(sp)
 404:	7aa2                	ld	s5,40(sp)
 406:	7b02                	ld	s6,32(sp)
 408:	6be2                	ld	s7,24(sp)
 40a:	6125                	addi	sp,sp,96
 40c:	8082                	ret

000000000000040e <stat>:

int
stat(const char *n, struct stat *st)
{
 40e:	1101                	addi	sp,sp,-32
 410:	ec06                	sd	ra,24(sp)
 412:	e822                	sd	s0,16(sp)
 414:	e426                	sd	s1,8(sp)
 416:	e04a                	sd	s2,0(sp)
 418:	1000                	addi	s0,sp,32
 41a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 41c:	4581                	li	a1,0
 41e:	00000097          	auipc	ra,0x0
 422:	172080e7          	jalr	370(ra) # 590 <open>
  if(fd < 0)
 426:	02054563          	bltz	a0,450 <stat+0x42>
 42a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 42c:	85ca                	mv	a1,s2
 42e:	00000097          	auipc	ra,0x0
 432:	17a080e7          	jalr	378(ra) # 5a8 <fstat>
 436:	892a                	mv	s2,a0
  close(fd);
 438:	8526                	mv	a0,s1
 43a:	00000097          	auipc	ra,0x0
 43e:	13e080e7          	jalr	318(ra) # 578 <close>
  return r;
}
 442:	854a                	mv	a0,s2
 444:	60e2                	ld	ra,24(sp)
 446:	6442                	ld	s0,16(sp)
 448:	64a2                	ld	s1,8(sp)
 44a:	6902                	ld	s2,0(sp)
 44c:	6105                	addi	sp,sp,32
 44e:	8082                	ret
    return -1;
 450:	597d                	li	s2,-1
 452:	bfc5                	j	442 <stat+0x34>

0000000000000454 <atoi>:

int
atoi(const char *s)
{
 454:	1141                	addi	sp,sp,-16
 456:	e422                	sd	s0,8(sp)
 458:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 45a:	00054603          	lbu	a2,0(a0)
 45e:	fd06079b          	addiw	a5,a2,-48
 462:	0ff7f793          	zext.b	a5,a5
 466:	4725                	li	a4,9
 468:	02f76963          	bltu	a4,a5,49a <atoi+0x46>
 46c:	86aa                	mv	a3,a0
  n = 0;
 46e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 470:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 472:	0685                	addi	a3,a3,1
 474:	0025179b          	slliw	a5,a0,0x2
 478:	9fa9                	addw	a5,a5,a0
 47a:	0017979b          	slliw	a5,a5,0x1
 47e:	9fb1                	addw	a5,a5,a2
 480:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 484:	0006c603          	lbu	a2,0(a3)
 488:	fd06071b          	addiw	a4,a2,-48
 48c:	0ff77713          	zext.b	a4,a4
 490:	fee5f1e3          	bgeu	a1,a4,472 <atoi+0x1e>
  return n;
}
 494:	6422                	ld	s0,8(sp)
 496:	0141                	addi	sp,sp,16
 498:	8082                	ret
  n = 0;
 49a:	4501                	li	a0,0
 49c:	bfe5                	j	494 <atoi+0x40>

000000000000049e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 49e:	1141                	addi	sp,sp,-16
 4a0:	e422                	sd	s0,8(sp)
 4a2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4a4:	02b57463          	bgeu	a0,a1,4cc <memmove+0x2e>
    while(n-- > 0)
 4a8:	00c05f63          	blez	a2,4c6 <memmove+0x28>
 4ac:	1602                	slli	a2,a2,0x20
 4ae:	9201                	srli	a2,a2,0x20
 4b0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4b4:	872a                	mv	a4,a0
      *dst++ = *src++;
 4b6:	0585                	addi	a1,a1,1
 4b8:	0705                	addi	a4,a4,1
 4ba:	fff5c683          	lbu	a3,-1(a1)
 4be:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4c2:	fee79ae3          	bne	a5,a4,4b6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret
    dst += n;
 4cc:	00c50733          	add	a4,a0,a2
    src += n;
 4d0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4d2:	fec05ae3          	blez	a2,4c6 <memmove+0x28>
 4d6:	fff6079b          	addiw	a5,a2,-1
 4da:	1782                	slli	a5,a5,0x20
 4dc:	9381                	srli	a5,a5,0x20
 4de:	fff7c793          	not	a5,a5
 4e2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4e4:	15fd                	addi	a1,a1,-1
 4e6:	177d                	addi	a4,a4,-1
 4e8:	0005c683          	lbu	a3,0(a1)
 4ec:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4f0:	fee79ae3          	bne	a5,a4,4e4 <memmove+0x46>
 4f4:	bfc9                	j	4c6 <memmove+0x28>

00000000000004f6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e422                	sd	s0,8(sp)
 4fa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4fc:	ca05                	beqz	a2,52c <memcmp+0x36>
 4fe:	fff6069b          	addiw	a3,a2,-1
 502:	1682                	slli	a3,a3,0x20
 504:	9281                	srli	a3,a3,0x20
 506:	0685                	addi	a3,a3,1
 508:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 50a:	00054783          	lbu	a5,0(a0)
 50e:	0005c703          	lbu	a4,0(a1)
 512:	00e79863          	bne	a5,a4,522 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 516:	0505                	addi	a0,a0,1
    p2++;
 518:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 51a:	fed518e3          	bne	a0,a3,50a <memcmp+0x14>
  }
  return 0;
 51e:	4501                	li	a0,0
 520:	a019                	j	526 <memcmp+0x30>
      return *p1 - *p2;
 522:	40e7853b          	subw	a0,a5,a4
}
 526:	6422                	ld	s0,8(sp)
 528:	0141                	addi	sp,sp,16
 52a:	8082                	ret
  return 0;
 52c:	4501                	li	a0,0
 52e:	bfe5                	j	526 <memcmp+0x30>

0000000000000530 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 530:	1141                	addi	sp,sp,-16
 532:	e406                	sd	ra,8(sp)
 534:	e022                	sd	s0,0(sp)
 536:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 538:	00000097          	auipc	ra,0x0
 53c:	f66080e7          	jalr	-154(ra) # 49e <memmove>
}
 540:	60a2                	ld	ra,8(sp)
 542:	6402                	ld	s0,0(sp)
 544:	0141                	addi	sp,sp,16
 546:	8082                	ret

0000000000000548 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 548:	4885                	li	a7,1
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <exit>:
.global exit
exit:
 li a7, SYS_exit
 550:	4889                	li	a7,2
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <wait>:
.global wait
wait:
 li a7, SYS_wait
 558:	488d                	li	a7,3
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 560:	4891                	li	a7,4
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <read>:
.global read
read:
 li a7, SYS_read
 568:	4895                	li	a7,5
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <write>:
.global write
write:
 li a7, SYS_write
 570:	48c1                	li	a7,16
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <close>:
.global close
close:
 li a7, SYS_close
 578:	48d5                	li	a7,21
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <kill>:
.global kill
kill:
 li a7, SYS_kill
 580:	4899                	li	a7,6
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <exec>:
.global exec
exec:
 li a7, SYS_exec
 588:	489d                	li	a7,7
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <open>:
.global open
open:
 li a7, SYS_open
 590:	48bd                	li	a7,15
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 598:	48c5                	li	a7,17
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5a0:	48c9                	li	a7,18
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a8:	48a1                	li	a7,8
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <link>:
.global link
link:
 li a7, SYS_link
 5b0:	48cd                	li	a7,19
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b8:	48d1                	li	a7,20
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5c0:	48a5                	li	a7,9
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c8:	48a9                	li	a7,10
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5d0:	48ad                	li	a7,11
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d8:	48b1                	li	a7,12
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5e0:	48b5                	li	a7,13
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e8:	48b9                	li	a7,14
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5f0:	48d9                	li	a7,22
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f8:	1101                	addi	sp,sp,-32
 5fa:	ec06                	sd	ra,24(sp)
 5fc:	e822                	sd	s0,16(sp)
 5fe:	1000                	addi	s0,sp,32
 600:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 604:	4605                	li	a2,1
 606:	fef40593          	addi	a1,s0,-17
 60a:	00000097          	auipc	ra,0x0
 60e:	f66080e7          	jalr	-154(ra) # 570 <write>
}
 612:	60e2                	ld	ra,24(sp)
 614:	6442                	ld	s0,16(sp)
 616:	6105                	addi	sp,sp,32
 618:	8082                	ret

000000000000061a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 61a:	7139                	addi	sp,sp,-64
 61c:	fc06                	sd	ra,56(sp)
 61e:	f822                	sd	s0,48(sp)
 620:	f426                	sd	s1,40(sp)
 622:	f04a                	sd	s2,32(sp)
 624:	ec4e                	sd	s3,24(sp)
 626:	0080                	addi	s0,sp,64
 628:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 62a:	c299                	beqz	a3,630 <printint+0x16>
 62c:	0805c863          	bltz	a1,6bc <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 630:	2581                	sext.w	a1,a1
  neg = 0;
 632:	4881                	li	a7,0
 634:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 638:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 63a:	2601                	sext.w	a2,a2
 63c:	00000517          	auipc	a0,0x0
 640:	47450513          	addi	a0,a0,1140 # ab0 <digits>
 644:	883a                	mv	a6,a4
 646:	2705                	addiw	a4,a4,1
 648:	02c5f7bb          	remuw	a5,a1,a2
 64c:	1782                	slli	a5,a5,0x20
 64e:	9381                	srli	a5,a5,0x20
 650:	97aa                	add	a5,a5,a0
 652:	0007c783          	lbu	a5,0(a5)
 656:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 65a:	0005879b          	sext.w	a5,a1
 65e:	02c5d5bb          	divuw	a1,a1,a2
 662:	0685                	addi	a3,a3,1
 664:	fec7f0e3          	bgeu	a5,a2,644 <printint+0x2a>
  if(neg)
 668:	00088b63          	beqz	a7,67e <printint+0x64>
    buf[i++] = '-';
 66c:	fd040793          	addi	a5,s0,-48
 670:	973e                	add	a4,a4,a5
 672:	02d00793          	li	a5,45
 676:	fef70823          	sb	a5,-16(a4)
 67a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 67e:	02e05863          	blez	a4,6ae <printint+0x94>
 682:	fc040793          	addi	a5,s0,-64
 686:	00e78933          	add	s2,a5,a4
 68a:	fff78993          	addi	s3,a5,-1
 68e:	99ba                	add	s3,s3,a4
 690:	377d                	addiw	a4,a4,-1
 692:	1702                	slli	a4,a4,0x20
 694:	9301                	srli	a4,a4,0x20
 696:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 69a:	fff94583          	lbu	a1,-1(s2)
 69e:	8526                	mv	a0,s1
 6a0:	00000097          	auipc	ra,0x0
 6a4:	f58080e7          	jalr	-168(ra) # 5f8 <putc>
  while(--i >= 0)
 6a8:	197d                	addi	s2,s2,-1
 6aa:	ff3918e3          	bne	s2,s3,69a <printint+0x80>
}
 6ae:	70e2                	ld	ra,56(sp)
 6b0:	7442                	ld	s0,48(sp)
 6b2:	74a2                	ld	s1,40(sp)
 6b4:	7902                	ld	s2,32(sp)
 6b6:	69e2                	ld	s3,24(sp)
 6b8:	6121                	addi	sp,sp,64
 6ba:	8082                	ret
    x = -xx;
 6bc:	40b005bb          	negw	a1,a1
    neg = 1;
 6c0:	4885                	li	a7,1
    x = -xx;
 6c2:	bf8d                	j	634 <printint+0x1a>

00000000000006c4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6c4:	7119                	addi	sp,sp,-128
 6c6:	fc86                	sd	ra,120(sp)
 6c8:	f8a2                	sd	s0,112(sp)
 6ca:	f4a6                	sd	s1,104(sp)
 6cc:	f0ca                	sd	s2,96(sp)
 6ce:	ecce                	sd	s3,88(sp)
 6d0:	e8d2                	sd	s4,80(sp)
 6d2:	e4d6                	sd	s5,72(sp)
 6d4:	e0da                	sd	s6,64(sp)
 6d6:	fc5e                	sd	s7,56(sp)
 6d8:	f862                	sd	s8,48(sp)
 6da:	f466                	sd	s9,40(sp)
 6dc:	f06a                	sd	s10,32(sp)
 6de:	ec6e                	sd	s11,24(sp)
 6e0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6e2:	0005c903          	lbu	s2,0(a1)
 6e6:	18090f63          	beqz	s2,884 <vprintf+0x1c0>
 6ea:	8aaa                	mv	s5,a0
 6ec:	8b32                	mv	s6,a2
 6ee:	00158493          	addi	s1,a1,1
  state = 0;
 6f2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6f4:	02500a13          	li	s4,37
      if(c == 'd'){
 6f8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6fc:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 700:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 704:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 708:	00000b97          	auipc	s7,0x0
 70c:	3a8b8b93          	addi	s7,s7,936 # ab0 <digits>
 710:	a839                	j	72e <vprintf+0x6a>
        putc(fd, c);
 712:	85ca                	mv	a1,s2
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	ee2080e7          	jalr	-286(ra) # 5f8 <putc>
 71e:	a019                	j	724 <vprintf+0x60>
    } else if(state == '%'){
 720:	01498f63          	beq	s3,s4,73e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 724:	0485                	addi	s1,s1,1
 726:	fff4c903          	lbu	s2,-1(s1)
 72a:	14090d63          	beqz	s2,884 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 72e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 732:	fe0997e3          	bnez	s3,720 <vprintf+0x5c>
      if(c == '%'){
 736:	fd479ee3          	bne	a5,s4,712 <vprintf+0x4e>
        state = '%';
 73a:	89be                	mv	s3,a5
 73c:	b7e5                	j	724 <vprintf+0x60>
      if(c == 'd'){
 73e:	05878063          	beq	a5,s8,77e <vprintf+0xba>
      } else if(c == 'l') {
 742:	05978c63          	beq	a5,s9,79a <vprintf+0xd6>
      } else if(c == 'x') {
 746:	07a78863          	beq	a5,s10,7b6 <vprintf+0xf2>
      } else if(c == 'p') {
 74a:	09b78463          	beq	a5,s11,7d2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 74e:	07300713          	li	a4,115
 752:	0ce78663          	beq	a5,a4,81e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 756:	06300713          	li	a4,99
 75a:	0ee78e63          	beq	a5,a4,856 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 75e:	11478863          	beq	a5,s4,86e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 762:	85d2                	mv	a1,s4
 764:	8556                	mv	a0,s5
 766:	00000097          	auipc	ra,0x0
 76a:	e92080e7          	jalr	-366(ra) # 5f8 <putc>
        putc(fd, c);
 76e:	85ca                	mv	a1,s2
 770:	8556                	mv	a0,s5
 772:	00000097          	auipc	ra,0x0
 776:	e86080e7          	jalr	-378(ra) # 5f8 <putc>
      }
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b765                	j	724 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 77e:	008b0913          	addi	s2,s6,8
 782:	4685                	li	a3,1
 784:	4629                	li	a2,10
 786:	000b2583          	lw	a1,0(s6)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e8e080e7          	jalr	-370(ra) # 61a <printint>
 794:	8b4a                	mv	s6,s2
      state = 0;
 796:	4981                	li	s3,0
 798:	b771                	j	724 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 79a:	008b0913          	addi	s2,s6,8
 79e:	4681                	li	a3,0
 7a0:	4629                	li	a2,10
 7a2:	000b2583          	lw	a1,0(s6)
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e72080e7          	jalr	-398(ra) # 61a <printint>
 7b0:	8b4a                	mv	s6,s2
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	bf85                	j	724 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7b6:	008b0913          	addi	s2,s6,8
 7ba:	4681                	li	a3,0
 7bc:	4641                	li	a2,16
 7be:	000b2583          	lw	a1,0(s6)
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e56080e7          	jalr	-426(ra) # 61a <printint>
 7cc:	8b4a                	mv	s6,s2
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	bf91                	j	724 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7d2:	008b0793          	addi	a5,s6,8
 7d6:	f8f43423          	sd	a5,-120(s0)
 7da:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7de:	03000593          	li	a1,48
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	e14080e7          	jalr	-492(ra) # 5f8 <putc>
  putc(fd, 'x');
 7ec:	85ea                	mv	a1,s10
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	e08080e7          	jalr	-504(ra) # 5f8 <putc>
 7f8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7fa:	03c9d793          	srli	a5,s3,0x3c
 7fe:	97de                	add	a5,a5,s7
 800:	0007c583          	lbu	a1,0(a5)
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	df2080e7          	jalr	-526(ra) # 5f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 80e:	0992                	slli	s3,s3,0x4
 810:	397d                	addiw	s2,s2,-1
 812:	fe0914e3          	bnez	s2,7fa <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 816:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b721                	j	724 <vprintf+0x60>
        s = va_arg(ap, char*);
 81e:	008b0993          	addi	s3,s6,8
 822:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 826:	02090163          	beqz	s2,848 <vprintf+0x184>
        while(*s != 0){
 82a:	00094583          	lbu	a1,0(s2)
 82e:	c9a1                	beqz	a1,87e <vprintf+0x1ba>
          putc(fd, *s);
 830:	8556                	mv	a0,s5
 832:	00000097          	auipc	ra,0x0
 836:	dc6080e7          	jalr	-570(ra) # 5f8 <putc>
          s++;
 83a:	0905                	addi	s2,s2,1
        while(*s != 0){
 83c:	00094583          	lbu	a1,0(s2)
 840:	f9e5                	bnez	a1,830 <vprintf+0x16c>
        s = va_arg(ap, char*);
 842:	8b4e                	mv	s6,s3
      state = 0;
 844:	4981                	li	s3,0
 846:	bdf9                	j	724 <vprintf+0x60>
          s = "(null)";
 848:	00000917          	auipc	s2,0x0
 84c:	26090913          	addi	s2,s2,608 # aa8 <malloc+0x11a>
        while(*s != 0){
 850:	02800593          	li	a1,40
 854:	bff1                	j	830 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 856:	008b0913          	addi	s2,s6,8
 85a:	000b4583          	lbu	a1,0(s6)
 85e:	8556                	mv	a0,s5
 860:	00000097          	auipc	ra,0x0
 864:	d98080e7          	jalr	-616(ra) # 5f8 <putc>
 868:	8b4a                	mv	s6,s2
      state = 0;
 86a:	4981                	li	s3,0
 86c:	bd65                	j	724 <vprintf+0x60>
        putc(fd, c);
 86e:	85d2                	mv	a1,s4
 870:	8556                	mv	a0,s5
 872:	00000097          	auipc	ra,0x0
 876:	d86080e7          	jalr	-634(ra) # 5f8 <putc>
      state = 0;
 87a:	4981                	li	s3,0
 87c:	b565                	j	724 <vprintf+0x60>
        s = va_arg(ap, char*);
 87e:	8b4e                	mv	s6,s3
      state = 0;
 880:	4981                	li	s3,0
 882:	b54d                	j	724 <vprintf+0x60>
    }
  }
}
 884:	70e6                	ld	ra,120(sp)
 886:	7446                	ld	s0,112(sp)
 888:	74a6                	ld	s1,104(sp)
 88a:	7906                	ld	s2,96(sp)
 88c:	69e6                	ld	s3,88(sp)
 88e:	6a46                	ld	s4,80(sp)
 890:	6aa6                	ld	s5,72(sp)
 892:	6b06                	ld	s6,64(sp)
 894:	7be2                	ld	s7,56(sp)
 896:	7c42                	ld	s8,48(sp)
 898:	7ca2                	ld	s9,40(sp)
 89a:	7d02                	ld	s10,32(sp)
 89c:	6de2                	ld	s11,24(sp)
 89e:	6109                	addi	sp,sp,128
 8a0:	8082                	ret

00000000000008a2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8a2:	715d                	addi	sp,sp,-80
 8a4:	ec06                	sd	ra,24(sp)
 8a6:	e822                	sd	s0,16(sp)
 8a8:	1000                	addi	s0,sp,32
 8aa:	e010                	sd	a2,0(s0)
 8ac:	e414                	sd	a3,8(s0)
 8ae:	e818                	sd	a4,16(s0)
 8b0:	ec1c                	sd	a5,24(s0)
 8b2:	03043023          	sd	a6,32(s0)
 8b6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8ba:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8be:	8622                	mv	a2,s0
 8c0:	00000097          	auipc	ra,0x0
 8c4:	e04080e7          	jalr	-508(ra) # 6c4 <vprintf>
}
 8c8:	60e2                	ld	ra,24(sp)
 8ca:	6442                	ld	s0,16(sp)
 8cc:	6161                	addi	sp,sp,80
 8ce:	8082                	ret

00000000000008d0 <printf>:

void
printf(const char *fmt, ...)
{
 8d0:	711d                	addi	sp,sp,-96
 8d2:	ec06                	sd	ra,24(sp)
 8d4:	e822                	sd	s0,16(sp)
 8d6:	1000                	addi	s0,sp,32
 8d8:	e40c                	sd	a1,8(s0)
 8da:	e810                	sd	a2,16(s0)
 8dc:	ec14                	sd	a3,24(s0)
 8de:	f018                	sd	a4,32(s0)
 8e0:	f41c                	sd	a5,40(s0)
 8e2:	03043823          	sd	a6,48(s0)
 8e6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ea:	00840613          	addi	a2,s0,8
 8ee:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8f2:	85aa                	mv	a1,a0
 8f4:	4505                	li	a0,1
 8f6:	00000097          	auipc	ra,0x0
 8fa:	dce080e7          	jalr	-562(ra) # 6c4 <vprintf>
}
 8fe:	60e2                	ld	ra,24(sp)
 900:	6442                	ld	s0,16(sp)
 902:	6125                	addi	sp,sp,96
 904:	8082                	ret

0000000000000906 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 906:	1141                	addi	sp,sp,-16
 908:	e422                	sd	s0,8(sp)
 90a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 90c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 910:	00000797          	auipc	a5,0x0
 914:	1b87b783          	ld	a5,440(a5) # ac8 <freep>
 918:	a805                	j	948 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 91a:	4618                	lw	a4,8(a2)
 91c:	9db9                	addw	a1,a1,a4
 91e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 922:	6398                	ld	a4,0(a5)
 924:	6318                	ld	a4,0(a4)
 926:	fee53823          	sd	a4,-16(a0)
 92a:	a091                	j	96e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 92c:	ff852703          	lw	a4,-8(a0)
 930:	9e39                	addw	a2,a2,a4
 932:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 934:	ff053703          	ld	a4,-16(a0)
 938:	e398                	sd	a4,0(a5)
 93a:	a099                	j	980 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93c:	6398                	ld	a4,0(a5)
 93e:	00e7e463          	bltu	a5,a4,946 <free+0x40>
 942:	00e6ea63          	bltu	a3,a4,956 <free+0x50>
{
 946:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 948:	fed7fae3          	bgeu	a5,a3,93c <free+0x36>
 94c:	6398                	ld	a4,0(a5)
 94e:	00e6e463          	bltu	a3,a4,956 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 952:	fee7eae3          	bltu	a5,a4,946 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 956:	ff852583          	lw	a1,-8(a0)
 95a:	6390                	ld	a2,0(a5)
 95c:	02059813          	slli	a6,a1,0x20
 960:	01c85713          	srli	a4,a6,0x1c
 964:	9736                	add	a4,a4,a3
 966:	fae60ae3          	beq	a2,a4,91a <free+0x14>
    bp->s.ptr = p->s.ptr;
 96a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 96e:	4790                	lw	a2,8(a5)
 970:	02061593          	slli	a1,a2,0x20
 974:	01c5d713          	srli	a4,a1,0x1c
 978:	973e                	add	a4,a4,a5
 97a:	fae689e3          	beq	a3,a4,92c <free+0x26>
  } else
    p->s.ptr = bp;
 97e:	e394                	sd	a3,0(a5)
  freep = p;
 980:	00000717          	auipc	a4,0x0
 984:	14f73423          	sd	a5,328(a4) # ac8 <freep>
}
 988:	6422                	ld	s0,8(sp)
 98a:	0141                	addi	sp,sp,16
 98c:	8082                	ret

000000000000098e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 98e:	7139                	addi	sp,sp,-64
 990:	fc06                	sd	ra,56(sp)
 992:	f822                	sd	s0,48(sp)
 994:	f426                	sd	s1,40(sp)
 996:	f04a                	sd	s2,32(sp)
 998:	ec4e                	sd	s3,24(sp)
 99a:	e852                	sd	s4,16(sp)
 99c:	e456                	sd	s5,8(sp)
 99e:	e05a                	sd	s6,0(sp)
 9a0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9a2:	02051493          	slli	s1,a0,0x20
 9a6:	9081                	srli	s1,s1,0x20
 9a8:	04bd                	addi	s1,s1,15
 9aa:	8091                	srli	s1,s1,0x4
 9ac:	0014899b          	addiw	s3,s1,1
 9b0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9b2:	00000517          	auipc	a0,0x0
 9b6:	11653503          	ld	a0,278(a0) # ac8 <freep>
 9ba:	c515                	beqz	a0,9e6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9bc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9be:	4798                	lw	a4,8(a5)
 9c0:	02977f63          	bgeu	a4,s1,9fe <malloc+0x70>
 9c4:	8a4e                	mv	s4,s3
 9c6:	0009871b          	sext.w	a4,s3
 9ca:	6685                	lui	a3,0x1
 9cc:	00d77363          	bgeu	a4,a3,9d2 <malloc+0x44>
 9d0:	6a05                	lui	s4,0x1
 9d2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9d6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9da:	00000917          	auipc	s2,0x0
 9de:	0ee90913          	addi	s2,s2,238 # ac8 <freep>
  if(p == (char*)-1)
 9e2:	5afd                	li	s5,-1
 9e4:	a895                	j	a58 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9e6:	00000797          	auipc	a5,0x0
 9ea:	1da78793          	addi	a5,a5,474 # bc0 <base>
 9ee:	00000717          	auipc	a4,0x0
 9f2:	0cf73d23          	sd	a5,218(a4) # ac8 <freep>
 9f6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9f8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9fc:	b7e1                	j	9c4 <malloc+0x36>
      if(p->s.size == nunits)
 9fe:	02e48c63          	beq	s1,a4,a36 <malloc+0xa8>
        p->s.size -= nunits;
 a02:	4137073b          	subw	a4,a4,s3
 a06:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a08:	02071693          	slli	a3,a4,0x20
 a0c:	01c6d713          	srli	a4,a3,0x1c
 a10:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a12:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a16:	00000717          	auipc	a4,0x0
 a1a:	0aa73923          	sd	a0,178(a4) # ac8 <freep>
      return (void*)(p + 1);
 a1e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a22:	70e2                	ld	ra,56(sp)
 a24:	7442                	ld	s0,48(sp)
 a26:	74a2                	ld	s1,40(sp)
 a28:	7902                	ld	s2,32(sp)
 a2a:	69e2                	ld	s3,24(sp)
 a2c:	6a42                	ld	s4,16(sp)
 a2e:	6aa2                	ld	s5,8(sp)
 a30:	6b02                	ld	s6,0(sp)
 a32:	6121                	addi	sp,sp,64
 a34:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a36:	6398                	ld	a4,0(a5)
 a38:	e118                	sd	a4,0(a0)
 a3a:	bff1                	j	a16 <malloc+0x88>
  hp->s.size = nu;
 a3c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a40:	0541                	addi	a0,a0,16
 a42:	00000097          	auipc	ra,0x0
 a46:	ec4080e7          	jalr	-316(ra) # 906 <free>
  return freep;
 a4a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a4e:	d971                	beqz	a0,a22 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a50:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a52:	4798                	lw	a4,8(a5)
 a54:	fa9775e3          	bgeu	a4,s1,9fe <malloc+0x70>
    if(p == freep)
 a58:	00093703          	ld	a4,0(s2)
 a5c:	853e                	mv	a0,a5
 a5e:	fef719e3          	bne	a4,a5,a50 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a62:	8552                	mv	a0,s4
 a64:	00000097          	auipc	ra,0x0
 a68:	b74080e7          	jalr	-1164(ra) # 5d8 <sbrk>
  if(p == (char*)-1)
 a6c:	fd5518e3          	bne	a0,s5,a3c <malloc+0xae>
        return 0;
 a70:	4501                	li	a0,0
 a72:	bf45                	j	a22 <malloc+0x94>
