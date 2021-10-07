
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	ae278793          	addi	a5,a5,-1310 # af8 <malloc+0x116>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	a9c50513          	addi	a0,a0,-1380 # ac8 <malloc+0xe6>
  34:	00001097          	auipc	ra,0x1
  38:	8f0080e7          	jalr	-1808(ra) # 924 <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	360080e7          	jalr	864(ra) # 3a8 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	548080e7          	jalr	1352(ra) # 59c <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	a7850513          	addi	a0,a0,-1416 # ae0 <malloc+0xfe>
  70:	00001097          	auipc	ra,0x1
  74:	8b4080e7          	jalr	-1868(ra) # 924 <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9cbd                	addw	s1,s1,a5
  7e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	55a080e7          	jalr	1370(ra) # 5e4 <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	524080e7          	jalr	1316(ra) # 5c4 <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	51e080e7          	jalr	1310(ra) # 5cc <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	a3a50513          	addi	a0,a0,-1478 # af0 <malloc+0x10e>
  be:	00001097          	auipc	ra,0x1
  c2:	866080e7          	jalr	-1946(ra) # 924 <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	518080e7          	jalr	1304(ra) # 5e4 <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	4da080e7          	jalr	1242(ra) # 5bc <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	4dc080e7          	jalr	1244(ra) # 5cc <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	4b2080e7          	jalr	1202(ra) # 5ac <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	4a0080e7          	jalr	1184(ra) # 5a4 <exit>

000000000000010c <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 112:	0f50000f          	fence	iorw,ow
 116:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret

0000000000000120 <load>:

int load(uint64 *p) {
 120:	1141                	addi	sp,sp,-16
 122:	e422                	sd	s0,8(sp)
 124:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 126:	0ff0000f          	fence
 12a:	6108                	ld	a0,0(a0)
 12c:	0ff0000f          	fence
}
 130:	2501                	sext.w	a0,a0
 132:	6422                	ld	s0,8(sp)
 134:	0141                	addi	sp,sp,16
 136:	8082                	ret

0000000000000138 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 138:	7179                	addi	sp,sp,-48
 13a:	f406                	sd	ra,40(sp)
 13c:	f022                	sd	s0,32(sp)
 13e:	ec26                	sd	s1,24(sp)
 140:	e84a                	sd	s2,16(sp)
 142:	e44e                	sd	s3,8(sp)
 144:	e052                	sd	s4,0(sp)
 146:	1800                	addi	s0,sp,48
 148:	8a2a                	mv	s4,a0
 14a:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 14c:	4785                	li	a5,1
 14e:	00001497          	auipc	s1,0x1
 152:	9f248493          	addi	s1,s1,-1550 # b40 <rings+0x10>
 156:	00001917          	auipc	s2,0x1
 15a:	ada90913          	addi	s2,s2,-1318 # c30 <__BSS_END__>
 15e:	04f59563          	bne	a1,a5,1a8 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 162:	00001497          	auipc	s1,0x1
 166:	9de4a483          	lw	s1,-1570(s1) # b40 <rings+0x10>
 16a:	c099                	beqz	s1,170 <create_or_close_the_buffer_user+0x38>
 16c:	4481                	li	s1,0
 16e:	a899                	j	1c4 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 170:	00001917          	auipc	s2,0x1
 174:	9c090913          	addi	s2,s2,-1600 # b30 <rings>
 178:	00093603          	ld	a2,0(s2)
 17c:	4585                	li	a1,1
 17e:	00000097          	auipc	ra,0x0
 182:	4c6080e7          	jalr	1222(ra) # 644 <ringbuf>
        rings[i].book->write_done = 0;
 186:	00893783          	ld	a5,8(s2)
 18a:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 18e:	00893783          	ld	a5,8(s2)
 192:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 196:	01092783          	lw	a5,16(s2)
 19a:	2785                	addiw	a5,a5,1
 19c:	00f92823          	sw	a5,16(s2)
        break;
 1a0:	a015                	j	1c4 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 1a2:	04e1                	addi	s1,s1,24
 1a4:	01248f63          	beq	s1,s2,1c2 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 1a8:	409c                	lw	a5,0(s1)
 1aa:	dfe5                	beqz	a5,1a2 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 1ac:	ff04b603          	ld	a2,-16(s1)
 1b0:	85ce                	mv	a1,s3
 1b2:	8552                	mv	a0,s4
 1b4:	00000097          	auipc	ra,0x0
 1b8:	490080e7          	jalr	1168(ra) # 644 <ringbuf>
        rings[i].exists = 0;
 1bc:	0004a023          	sw	zero,0(s1)
 1c0:	b7cd                	j	1a2 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 1c2:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 1c4:	8526                	mv	a0,s1
 1c6:	70a2                	ld	ra,40(sp)
 1c8:	7402                	ld	s0,32(sp)
 1ca:	64e2                	ld	s1,24(sp)
 1cc:	6942                	ld	s2,16(sp)
 1ce:	69a2                	ld	s3,8(sp)
 1d0:	6a02                	ld	s4,0(sp)
 1d2:	6145                	addi	sp,sp,48
 1d4:	8082                	ret

00000000000001d6 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 1d6:	1101                	addi	sp,sp,-32
 1d8:	ec06                	sd	ra,24(sp)
 1da:	e822                	sd	s0,16(sp)
 1dc:	e426                	sd	s1,8(sp)
 1de:	1000                	addi	s0,sp,32
 1e0:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 1e2:	00151793          	slli	a5,a0,0x1
 1e6:	97aa                	add	a5,a5,a0
 1e8:	078e                	slli	a5,a5,0x3
 1ea:	00001717          	auipc	a4,0x1
 1ee:	94670713          	addi	a4,a4,-1722 # b30 <rings>
 1f2:	97ba                	add	a5,a5,a4
 1f4:	639c                	ld	a5,0(a5)
 1f6:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 1f8:	421c                	lw	a5,0(a2)
 1fa:	e785                	bnez	a5,222 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 1fc:	86ba                	mv	a3,a4
 1fe:	671c                	ld	a5,8(a4)
 200:	6398                	ld	a4,0(a5)
 202:	67c1                	lui	a5,0x10
 204:	9fb9                	addw	a5,a5,a4
 206:	00151713          	slli	a4,a0,0x1
 20a:	953a                	add	a0,a0,a4
 20c:	050e                	slli	a0,a0,0x3
 20e:	9536                	add	a0,a0,a3
 210:	6518                	ld	a4,8(a0)
 212:	6718                	ld	a4,8(a4)
 214:	9f99                	subw	a5,a5,a4
 216:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	64a2                	ld	s1,8(sp)
 21e:	6105                	addi	sp,sp,32
 220:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 222:	00151793          	slli	a5,a0,0x1
 226:	953e                	add	a0,a0,a5
 228:	050e                	slli	a0,a0,0x3
 22a:	00001797          	auipc	a5,0x1
 22e:	90678793          	addi	a5,a5,-1786 # b30 <rings>
 232:	953e                	add	a0,a0,a5
 234:	6508                	ld	a0,8(a0)
 236:	0521                	addi	a0,a0,8
 238:	00000097          	auipc	ra,0x0
 23c:	ee8080e7          	jalr	-280(ra) # 120 <load>
 240:	c088                	sw	a0,0(s1)
}
 242:	bfd9                	j	218 <ringbuf_start_write+0x42>

0000000000000244 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 244:	1141                	addi	sp,sp,-16
 246:	e406                	sd	ra,8(sp)
 248:	e022                	sd	s0,0(sp)
 24a:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 24c:	00151793          	slli	a5,a0,0x1
 250:	97aa                	add	a5,a5,a0
 252:	078e                	slli	a5,a5,0x3
 254:	00001517          	auipc	a0,0x1
 258:	8dc50513          	addi	a0,a0,-1828 # b30 <rings>
 25c:	97aa                	add	a5,a5,a0
 25e:	6788                	ld	a0,8(a5)
 260:	0035959b          	slliw	a1,a1,0x3
 264:	0521                	addi	a0,a0,8
 266:	00000097          	auipc	ra,0x0
 26a:	ea6080e7          	jalr	-346(ra) # 10c <store>
}
 26e:	60a2                	ld	ra,8(sp)
 270:	6402                	ld	s0,0(sp)
 272:	0141                	addi	sp,sp,16
 274:	8082                	ret

0000000000000276 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 276:	1101                	addi	sp,sp,-32
 278:	ec06                	sd	ra,24(sp)
 27a:	e822                	sd	s0,16(sp)
 27c:	e426                	sd	s1,8(sp)
 27e:	1000                	addi	s0,sp,32
 280:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 282:	00151793          	slli	a5,a0,0x1
 286:	97aa                	add	a5,a5,a0
 288:	078e                	slli	a5,a5,0x3
 28a:	00001517          	auipc	a0,0x1
 28e:	8a650513          	addi	a0,a0,-1882 # b30 <rings>
 292:	97aa                	add	a5,a5,a0
 294:	6788                	ld	a0,8(a5)
 296:	0521                	addi	a0,a0,8
 298:	00000097          	auipc	ra,0x0
 29c:	e88080e7          	jalr	-376(ra) # 120 <load>
 2a0:	c088                	sw	a0,0(s1)
}
 2a2:	60e2                	ld	ra,24(sp)
 2a4:	6442                	ld	s0,16(sp)
 2a6:	64a2                	ld	s1,8(sp)
 2a8:	6105                	addi	sp,sp,32
 2aa:	8082                	ret

00000000000002ac <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2ac:	1101                	addi	sp,sp,-32
 2ae:	ec06                	sd	ra,24(sp)
 2b0:	e822                	sd	s0,16(sp)
 2b2:	e426                	sd	s1,8(sp)
 2b4:	1000                	addi	s0,sp,32
 2b6:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 2b8:	00151793          	slli	a5,a0,0x1
 2bc:	97aa                	add	a5,a5,a0
 2be:	078e                	slli	a5,a5,0x3
 2c0:	00001517          	auipc	a0,0x1
 2c4:	87050513          	addi	a0,a0,-1936 # b30 <rings>
 2c8:	97aa                	add	a5,a5,a0
 2ca:	6788                	ld	a0,8(a5)
 2cc:	611c                	ld	a5,0(a0)
 2ce:	ef99                	bnez	a5,2ec <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2d0:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2d2:	41f7579b          	sraiw	a5,a4,0x1f
 2d6:	01d7d79b          	srliw	a5,a5,0x1d
 2da:	9fb9                	addw	a5,a5,a4
 2dc:	4037d79b          	sraiw	a5,a5,0x3
 2e0:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 2e2:	60e2                	ld	ra,24(sp)
 2e4:	6442                	ld	s0,16(sp)
 2e6:	64a2                	ld	s1,8(sp)
 2e8:	6105                	addi	sp,sp,32
 2ea:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 2ec:	00000097          	auipc	ra,0x0
 2f0:	e34080e7          	jalr	-460(ra) # 120 <load>
    *bytes /= 8;
 2f4:	41f5579b          	sraiw	a5,a0,0x1f
 2f8:	01d7d79b          	srliw	a5,a5,0x1d
 2fc:	9d3d                	addw	a0,a0,a5
 2fe:	4035551b          	sraiw	a0,a0,0x3
 302:	c088                	sw	a0,0(s1)
}
 304:	bff9                	j	2e2 <ringbuf_start_read+0x36>

0000000000000306 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 306:	1141                	addi	sp,sp,-16
 308:	e406                	sd	ra,8(sp)
 30a:	e022                	sd	s0,0(sp)
 30c:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 30e:	00151793          	slli	a5,a0,0x1
 312:	97aa                	add	a5,a5,a0
 314:	078e                	slli	a5,a5,0x3
 316:	00001517          	auipc	a0,0x1
 31a:	81a50513          	addi	a0,a0,-2022 # b30 <rings>
 31e:	97aa                	add	a5,a5,a0
 320:	0035959b          	slliw	a1,a1,0x3
 324:	6788                	ld	a0,8(a5)
 326:	00000097          	auipc	ra,0x0
 32a:	de6080e7          	jalr	-538(ra) # 10c <store>
}
 32e:	60a2                	ld	ra,8(sp)
 330:	6402                	ld	s0,0(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret

0000000000000336 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 336:	1141                	addi	sp,sp,-16
 338:	e422                	sd	s0,8(sp)
 33a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 33c:	87aa                	mv	a5,a0
 33e:	0585                	addi	a1,a1,1
 340:	0785                	addi	a5,a5,1
 342:	fff5c703          	lbu	a4,-1(a1)
 346:	fee78fa3          	sb	a4,-1(a5)
 34a:	fb75                	bnez	a4,33e <strcpy+0x8>
    ;
  return os;
}
 34c:	6422                	ld	s0,8(sp)
 34e:	0141                	addi	sp,sp,16
 350:	8082                	ret

0000000000000352 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 352:	1141                	addi	sp,sp,-16
 354:	e422                	sd	s0,8(sp)
 356:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 358:	00054783          	lbu	a5,0(a0)
 35c:	cb91                	beqz	a5,370 <strcmp+0x1e>
 35e:	0005c703          	lbu	a4,0(a1)
 362:	00f71763          	bne	a4,a5,370 <strcmp+0x1e>
    p++, q++;
 366:	0505                	addi	a0,a0,1
 368:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 36a:	00054783          	lbu	a5,0(a0)
 36e:	fbe5                	bnez	a5,35e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 370:	0005c503          	lbu	a0,0(a1)
}
 374:	40a7853b          	subw	a0,a5,a0
 378:	6422                	ld	s0,8(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret

000000000000037e <strlen>:

uint
strlen(const char *s)
{
 37e:	1141                	addi	sp,sp,-16
 380:	e422                	sd	s0,8(sp)
 382:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 384:	00054783          	lbu	a5,0(a0)
 388:	cf91                	beqz	a5,3a4 <strlen+0x26>
 38a:	0505                	addi	a0,a0,1
 38c:	87aa                	mv	a5,a0
 38e:	4685                	li	a3,1
 390:	9e89                	subw	a3,a3,a0
 392:	00f6853b          	addw	a0,a3,a5
 396:	0785                	addi	a5,a5,1
 398:	fff7c703          	lbu	a4,-1(a5)
 39c:	fb7d                	bnez	a4,392 <strlen+0x14>
    ;
  return n;
}
 39e:	6422                	ld	s0,8(sp)
 3a0:	0141                	addi	sp,sp,16
 3a2:	8082                	ret
  for(n = 0; s[n]; n++)
 3a4:	4501                	li	a0,0
 3a6:	bfe5                	j	39e <strlen+0x20>

00000000000003a8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3ae:	ca19                	beqz	a2,3c4 <memset+0x1c>
 3b0:	87aa                	mv	a5,a0
 3b2:	1602                	slli	a2,a2,0x20
 3b4:	9201                	srli	a2,a2,0x20
 3b6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3ba:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3be:	0785                	addi	a5,a5,1
 3c0:	fee79de3          	bne	a5,a4,3ba <memset+0x12>
  }
  return dst;
}
 3c4:	6422                	ld	s0,8(sp)
 3c6:	0141                	addi	sp,sp,16
 3c8:	8082                	ret

00000000000003ca <strchr>:

char*
strchr(const char *s, char c)
{
 3ca:	1141                	addi	sp,sp,-16
 3cc:	e422                	sd	s0,8(sp)
 3ce:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3d0:	00054783          	lbu	a5,0(a0)
 3d4:	cb99                	beqz	a5,3ea <strchr+0x20>
    if(*s == c)
 3d6:	00f58763          	beq	a1,a5,3e4 <strchr+0x1a>
  for(; *s; s++)
 3da:	0505                	addi	a0,a0,1
 3dc:	00054783          	lbu	a5,0(a0)
 3e0:	fbfd                	bnez	a5,3d6 <strchr+0xc>
      return (char*)s;
  return 0;
 3e2:	4501                	li	a0,0
}
 3e4:	6422                	ld	s0,8(sp)
 3e6:	0141                	addi	sp,sp,16
 3e8:	8082                	ret
  return 0;
 3ea:	4501                	li	a0,0
 3ec:	bfe5                	j	3e4 <strchr+0x1a>

00000000000003ee <gets>:

char*
gets(char *buf, int max)
{
 3ee:	711d                	addi	sp,sp,-96
 3f0:	ec86                	sd	ra,88(sp)
 3f2:	e8a2                	sd	s0,80(sp)
 3f4:	e4a6                	sd	s1,72(sp)
 3f6:	e0ca                	sd	s2,64(sp)
 3f8:	fc4e                	sd	s3,56(sp)
 3fa:	f852                	sd	s4,48(sp)
 3fc:	f456                	sd	s5,40(sp)
 3fe:	f05a                	sd	s6,32(sp)
 400:	ec5e                	sd	s7,24(sp)
 402:	1080                	addi	s0,sp,96
 404:	8baa                	mv	s7,a0
 406:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 408:	892a                	mv	s2,a0
 40a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 40c:	4aa9                	li	s5,10
 40e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 410:	89a6                	mv	s3,s1
 412:	2485                	addiw	s1,s1,1
 414:	0344d863          	bge	s1,s4,444 <gets+0x56>
    cc = read(0, &c, 1);
 418:	4605                	li	a2,1
 41a:	faf40593          	addi	a1,s0,-81
 41e:	4501                	li	a0,0
 420:	00000097          	auipc	ra,0x0
 424:	19c080e7          	jalr	412(ra) # 5bc <read>
    if(cc < 1)
 428:	00a05e63          	blez	a0,444 <gets+0x56>
    buf[i++] = c;
 42c:	faf44783          	lbu	a5,-81(s0)
 430:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 434:	01578763          	beq	a5,s5,442 <gets+0x54>
 438:	0905                	addi	s2,s2,1
 43a:	fd679be3          	bne	a5,s6,410 <gets+0x22>
  for(i=0; i+1 < max; ){
 43e:	89a6                	mv	s3,s1
 440:	a011                	j	444 <gets+0x56>
 442:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 444:	99de                	add	s3,s3,s7
 446:	00098023          	sb	zero,0(s3)
  return buf;
}
 44a:	855e                	mv	a0,s7
 44c:	60e6                	ld	ra,88(sp)
 44e:	6446                	ld	s0,80(sp)
 450:	64a6                	ld	s1,72(sp)
 452:	6906                	ld	s2,64(sp)
 454:	79e2                	ld	s3,56(sp)
 456:	7a42                	ld	s4,48(sp)
 458:	7aa2                	ld	s5,40(sp)
 45a:	7b02                	ld	s6,32(sp)
 45c:	6be2                	ld	s7,24(sp)
 45e:	6125                	addi	sp,sp,96
 460:	8082                	ret

0000000000000462 <stat>:

int
stat(const char *n, struct stat *st)
{
 462:	1101                	addi	sp,sp,-32
 464:	ec06                	sd	ra,24(sp)
 466:	e822                	sd	s0,16(sp)
 468:	e426                	sd	s1,8(sp)
 46a:	e04a                	sd	s2,0(sp)
 46c:	1000                	addi	s0,sp,32
 46e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 470:	4581                	li	a1,0
 472:	00000097          	auipc	ra,0x0
 476:	172080e7          	jalr	370(ra) # 5e4 <open>
  if(fd < 0)
 47a:	02054563          	bltz	a0,4a4 <stat+0x42>
 47e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 480:	85ca                	mv	a1,s2
 482:	00000097          	auipc	ra,0x0
 486:	17a080e7          	jalr	378(ra) # 5fc <fstat>
 48a:	892a                	mv	s2,a0
  close(fd);
 48c:	8526                	mv	a0,s1
 48e:	00000097          	auipc	ra,0x0
 492:	13e080e7          	jalr	318(ra) # 5cc <close>
  return r;
}
 496:	854a                	mv	a0,s2
 498:	60e2                	ld	ra,24(sp)
 49a:	6442                	ld	s0,16(sp)
 49c:	64a2                	ld	s1,8(sp)
 49e:	6902                	ld	s2,0(sp)
 4a0:	6105                	addi	sp,sp,32
 4a2:	8082                	ret
    return -1;
 4a4:	597d                	li	s2,-1
 4a6:	bfc5                	j	496 <stat+0x34>

00000000000004a8 <atoi>:

int
atoi(const char *s)
{
 4a8:	1141                	addi	sp,sp,-16
 4aa:	e422                	sd	s0,8(sp)
 4ac:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4ae:	00054603          	lbu	a2,0(a0)
 4b2:	fd06079b          	addiw	a5,a2,-48
 4b6:	0ff7f793          	zext.b	a5,a5
 4ba:	4725                	li	a4,9
 4bc:	02f76963          	bltu	a4,a5,4ee <atoi+0x46>
 4c0:	86aa                	mv	a3,a0
  n = 0;
 4c2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4c4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4c6:	0685                	addi	a3,a3,1
 4c8:	0025179b          	slliw	a5,a0,0x2
 4cc:	9fa9                	addw	a5,a5,a0
 4ce:	0017979b          	slliw	a5,a5,0x1
 4d2:	9fb1                	addw	a5,a5,a2
 4d4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4d8:	0006c603          	lbu	a2,0(a3)
 4dc:	fd06071b          	addiw	a4,a2,-48
 4e0:	0ff77713          	zext.b	a4,a4
 4e4:	fee5f1e3          	bgeu	a1,a4,4c6 <atoi+0x1e>
  return n;
}
 4e8:	6422                	ld	s0,8(sp)
 4ea:	0141                	addi	sp,sp,16
 4ec:	8082                	ret
  n = 0;
 4ee:	4501                	li	a0,0
 4f0:	bfe5                	j	4e8 <atoi+0x40>

00000000000004f2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4f2:	1141                	addi	sp,sp,-16
 4f4:	e422                	sd	s0,8(sp)
 4f6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4f8:	02b57463          	bgeu	a0,a1,520 <memmove+0x2e>
    while(n-- > 0)
 4fc:	00c05f63          	blez	a2,51a <memmove+0x28>
 500:	1602                	slli	a2,a2,0x20
 502:	9201                	srli	a2,a2,0x20
 504:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 508:	872a                	mv	a4,a0
      *dst++ = *src++;
 50a:	0585                	addi	a1,a1,1
 50c:	0705                	addi	a4,a4,1
 50e:	fff5c683          	lbu	a3,-1(a1)
 512:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 516:	fee79ae3          	bne	a5,a4,50a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 51a:	6422                	ld	s0,8(sp)
 51c:	0141                	addi	sp,sp,16
 51e:	8082                	ret
    dst += n;
 520:	00c50733          	add	a4,a0,a2
    src += n;
 524:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 526:	fec05ae3          	blez	a2,51a <memmove+0x28>
 52a:	fff6079b          	addiw	a5,a2,-1
 52e:	1782                	slli	a5,a5,0x20
 530:	9381                	srli	a5,a5,0x20
 532:	fff7c793          	not	a5,a5
 536:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 538:	15fd                	addi	a1,a1,-1
 53a:	177d                	addi	a4,a4,-1
 53c:	0005c683          	lbu	a3,0(a1)
 540:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 544:	fee79ae3          	bne	a5,a4,538 <memmove+0x46>
 548:	bfc9                	j	51a <memmove+0x28>

000000000000054a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 54a:	1141                	addi	sp,sp,-16
 54c:	e422                	sd	s0,8(sp)
 54e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 550:	ca05                	beqz	a2,580 <memcmp+0x36>
 552:	fff6069b          	addiw	a3,a2,-1
 556:	1682                	slli	a3,a3,0x20
 558:	9281                	srli	a3,a3,0x20
 55a:	0685                	addi	a3,a3,1
 55c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 55e:	00054783          	lbu	a5,0(a0)
 562:	0005c703          	lbu	a4,0(a1)
 566:	00e79863          	bne	a5,a4,576 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 56a:	0505                	addi	a0,a0,1
    p2++;
 56c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 56e:	fed518e3          	bne	a0,a3,55e <memcmp+0x14>
  }
  return 0;
 572:	4501                	li	a0,0
 574:	a019                	j	57a <memcmp+0x30>
      return *p1 - *p2;
 576:	40e7853b          	subw	a0,a5,a4
}
 57a:	6422                	ld	s0,8(sp)
 57c:	0141                	addi	sp,sp,16
 57e:	8082                	ret
  return 0;
 580:	4501                	li	a0,0
 582:	bfe5                	j	57a <memcmp+0x30>

0000000000000584 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 584:	1141                	addi	sp,sp,-16
 586:	e406                	sd	ra,8(sp)
 588:	e022                	sd	s0,0(sp)
 58a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 58c:	00000097          	auipc	ra,0x0
 590:	f66080e7          	jalr	-154(ra) # 4f2 <memmove>
}
 594:	60a2                	ld	ra,8(sp)
 596:	6402                	ld	s0,0(sp)
 598:	0141                	addi	sp,sp,16
 59a:	8082                	ret

000000000000059c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 59c:	4885                	li	a7,1
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a4:	4889                	li	a7,2
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ac:	488d                	li	a7,3
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b4:	4891                	li	a7,4
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <read>:
.global read
read:
 li a7, SYS_read
 5bc:	4895                	li	a7,5
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <write>:
.global write
write:
 li a7, SYS_write
 5c4:	48c1                	li	a7,16
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <close>:
.global close
close:
 li a7, SYS_close
 5cc:	48d5                	li	a7,21
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d4:	4899                	li	a7,6
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <exec>:
.global exec
exec:
 li a7, SYS_exec
 5dc:	489d                	li	a7,7
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <open>:
.global open
open:
 li a7, SYS_open
 5e4:	48bd                	li	a7,15
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5ec:	48c5                	li	a7,17
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f4:	48c9                	li	a7,18
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5fc:	48a1                	li	a7,8
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <link>:
.global link
link:
 li a7, SYS_link
 604:	48cd                	li	a7,19
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 60c:	48d1                	li	a7,20
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 614:	48a5                	li	a7,9
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <dup>:
.global dup
dup:
 li a7, SYS_dup
 61c:	48a9                	li	a7,10
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 624:	48ad                	li	a7,11
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 62c:	48b1                	li	a7,12
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 634:	48b5                	li	a7,13
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 63c:	48b9                	li	a7,14
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 644:	48d9                	li	a7,22
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 64c:	1101                	addi	sp,sp,-32
 64e:	ec06                	sd	ra,24(sp)
 650:	e822                	sd	s0,16(sp)
 652:	1000                	addi	s0,sp,32
 654:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 658:	4605                	li	a2,1
 65a:	fef40593          	addi	a1,s0,-17
 65e:	00000097          	auipc	ra,0x0
 662:	f66080e7          	jalr	-154(ra) # 5c4 <write>
}
 666:	60e2                	ld	ra,24(sp)
 668:	6442                	ld	s0,16(sp)
 66a:	6105                	addi	sp,sp,32
 66c:	8082                	ret

000000000000066e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 66e:	7139                	addi	sp,sp,-64
 670:	fc06                	sd	ra,56(sp)
 672:	f822                	sd	s0,48(sp)
 674:	f426                	sd	s1,40(sp)
 676:	f04a                	sd	s2,32(sp)
 678:	ec4e                	sd	s3,24(sp)
 67a:	0080                	addi	s0,sp,64
 67c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 67e:	c299                	beqz	a3,684 <printint+0x16>
 680:	0805c863          	bltz	a1,710 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 684:	2581                	sext.w	a1,a1
  neg = 0;
 686:	4881                	li	a7,0
 688:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 68c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 68e:	2601                	sext.w	a2,a2
 690:	00000517          	auipc	a0,0x0
 694:	48050513          	addi	a0,a0,1152 # b10 <digits>
 698:	883a                	mv	a6,a4
 69a:	2705                	addiw	a4,a4,1
 69c:	02c5f7bb          	remuw	a5,a1,a2
 6a0:	1782                	slli	a5,a5,0x20
 6a2:	9381                	srli	a5,a5,0x20
 6a4:	97aa                	add	a5,a5,a0
 6a6:	0007c783          	lbu	a5,0(a5)
 6aa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ae:	0005879b          	sext.w	a5,a1
 6b2:	02c5d5bb          	divuw	a1,a1,a2
 6b6:	0685                	addi	a3,a3,1
 6b8:	fec7f0e3          	bgeu	a5,a2,698 <printint+0x2a>
  if(neg)
 6bc:	00088b63          	beqz	a7,6d2 <printint+0x64>
    buf[i++] = '-';
 6c0:	fd040793          	addi	a5,s0,-48
 6c4:	973e                	add	a4,a4,a5
 6c6:	02d00793          	li	a5,45
 6ca:	fef70823          	sb	a5,-16(a4)
 6ce:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6d2:	02e05863          	blez	a4,702 <printint+0x94>
 6d6:	fc040793          	addi	a5,s0,-64
 6da:	00e78933          	add	s2,a5,a4
 6de:	fff78993          	addi	s3,a5,-1
 6e2:	99ba                	add	s3,s3,a4
 6e4:	377d                	addiw	a4,a4,-1
 6e6:	1702                	slli	a4,a4,0x20
 6e8:	9301                	srli	a4,a4,0x20
 6ea:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6ee:	fff94583          	lbu	a1,-1(s2)
 6f2:	8526                	mv	a0,s1
 6f4:	00000097          	auipc	ra,0x0
 6f8:	f58080e7          	jalr	-168(ra) # 64c <putc>
  while(--i >= 0)
 6fc:	197d                	addi	s2,s2,-1
 6fe:	ff3918e3          	bne	s2,s3,6ee <printint+0x80>
}
 702:	70e2                	ld	ra,56(sp)
 704:	7442                	ld	s0,48(sp)
 706:	74a2                	ld	s1,40(sp)
 708:	7902                	ld	s2,32(sp)
 70a:	69e2                	ld	s3,24(sp)
 70c:	6121                	addi	sp,sp,64
 70e:	8082                	ret
    x = -xx;
 710:	40b005bb          	negw	a1,a1
    neg = 1;
 714:	4885                	li	a7,1
    x = -xx;
 716:	bf8d                	j	688 <printint+0x1a>

0000000000000718 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 718:	7119                	addi	sp,sp,-128
 71a:	fc86                	sd	ra,120(sp)
 71c:	f8a2                	sd	s0,112(sp)
 71e:	f4a6                	sd	s1,104(sp)
 720:	f0ca                	sd	s2,96(sp)
 722:	ecce                	sd	s3,88(sp)
 724:	e8d2                	sd	s4,80(sp)
 726:	e4d6                	sd	s5,72(sp)
 728:	e0da                	sd	s6,64(sp)
 72a:	fc5e                	sd	s7,56(sp)
 72c:	f862                	sd	s8,48(sp)
 72e:	f466                	sd	s9,40(sp)
 730:	f06a                	sd	s10,32(sp)
 732:	ec6e                	sd	s11,24(sp)
 734:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 736:	0005c903          	lbu	s2,0(a1)
 73a:	18090f63          	beqz	s2,8d8 <vprintf+0x1c0>
 73e:	8aaa                	mv	s5,a0
 740:	8b32                	mv	s6,a2
 742:	00158493          	addi	s1,a1,1
  state = 0;
 746:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 748:	02500a13          	li	s4,37
      if(c == 'd'){
 74c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 750:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 754:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 758:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 75c:	00000b97          	auipc	s7,0x0
 760:	3b4b8b93          	addi	s7,s7,948 # b10 <digits>
 764:	a839                	j	782 <vprintf+0x6a>
        putc(fd, c);
 766:	85ca                	mv	a1,s2
 768:	8556                	mv	a0,s5
 76a:	00000097          	auipc	ra,0x0
 76e:	ee2080e7          	jalr	-286(ra) # 64c <putc>
 772:	a019                	j	778 <vprintf+0x60>
    } else if(state == '%'){
 774:	01498f63          	beq	s3,s4,792 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 778:	0485                	addi	s1,s1,1
 77a:	fff4c903          	lbu	s2,-1(s1)
 77e:	14090d63          	beqz	s2,8d8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 782:	0009079b          	sext.w	a5,s2
    if(state == 0){
 786:	fe0997e3          	bnez	s3,774 <vprintf+0x5c>
      if(c == '%'){
 78a:	fd479ee3          	bne	a5,s4,766 <vprintf+0x4e>
        state = '%';
 78e:	89be                	mv	s3,a5
 790:	b7e5                	j	778 <vprintf+0x60>
      if(c == 'd'){
 792:	05878063          	beq	a5,s8,7d2 <vprintf+0xba>
      } else if(c == 'l') {
 796:	05978c63          	beq	a5,s9,7ee <vprintf+0xd6>
      } else if(c == 'x') {
 79a:	07a78863          	beq	a5,s10,80a <vprintf+0xf2>
      } else if(c == 'p') {
 79e:	09b78463          	beq	a5,s11,826 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7a2:	07300713          	li	a4,115
 7a6:	0ce78663          	beq	a5,a4,872 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7aa:	06300713          	li	a4,99
 7ae:	0ee78e63          	beq	a5,a4,8aa <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7b2:	11478863          	beq	a5,s4,8c2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7b6:	85d2                	mv	a1,s4
 7b8:	8556                	mv	a0,s5
 7ba:	00000097          	auipc	ra,0x0
 7be:	e92080e7          	jalr	-366(ra) # 64c <putc>
        putc(fd, c);
 7c2:	85ca                	mv	a1,s2
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	e86080e7          	jalr	-378(ra) # 64c <putc>
      }
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	b765                	j	778 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7d2:	008b0913          	addi	s2,s6,8
 7d6:	4685                	li	a3,1
 7d8:	4629                	li	a2,10
 7da:	000b2583          	lw	a1,0(s6)
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e8e080e7          	jalr	-370(ra) # 66e <printint>
 7e8:	8b4a                	mv	s6,s2
      state = 0;
 7ea:	4981                	li	s3,0
 7ec:	b771                	j	778 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ee:	008b0913          	addi	s2,s6,8
 7f2:	4681                	li	a3,0
 7f4:	4629                	li	a2,10
 7f6:	000b2583          	lw	a1,0(s6)
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	e72080e7          	jalr	-398(ra) # 66e <printint>
 804:	8b4a                	mv	s6,s2
      state = 0;
 806:	4981                	li	s3,0
 808:	bf85                	j	778 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 80a:	008b0913          	addi	s2,s6,8
 80e:	4681                	li	a3,0
 810:	4641                	li	a2,16
 812:	000b2583          	lw	a1,0(s6)
 816:	8556                	mv	a0,s5
 818:	00000097          	auipc	ra,0x0
 81c:	e56080e7          	jalr	-426(ra) # 66e <printint>
 820:	8b4a                	mv	s6,s2
      state = 0;
 822:	4981                	li	s3,0
 824:	bf91                	j	778 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 826:	008b0793          	addi	a5,s6,8
 82a:	f8f43423          	sd	a5,-120(s0)
 82e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 832:	03000593          	li	a1,48
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	e14080e7          	jalr	-492(ra) # 64c <putc>
  putc(fd, 'x');
 840:	85ea                	mv	a1,s10
 842:	8556                	mv	a0,s5
 844:	00000097          	auipc	ra,0x0
 848:	e08080e7          	jalr	-504(ra) # 64c <putc>
 84c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 84e:	03c9d793          	srli	a5,s3,0x3c
 852:	97de                	add	a5,a5,s7
 854:	0007c583          	lbu	a1,0(a5)
 858:	8556                	mv	a0,s5
 85a:	00000097          	auipc	ra,0x0
 85e:	df2080e7          	jalr	-526(ra) # 64c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 862:	0992                	slli	s3,s3,0x4
 864:	397d                	addiw	s2,s2,-1
 866:	fe0914e3          	bnez	s2,84e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 86a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 86e:	4981                	li	s3,0
 870:	b721                	j	778 <vprintf+0x60>
        s = va_arg(ap, char*);
 872:	008b0993          	addi	s3,s6,8
 876:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 87a:	02090163          	beqz	s2,89c <vprintf+0x184>
        while(*s != 0){
 87e:	00094583          	lbu	a1,0(s2)
 882:	c9a1                	beqz	a1,8d2 <vprintf+0x1ba>
          putc(fd, *s);
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	dc6080e7          	jalr	-570(ra) # 64c <putc>
          s++;
 88e:	0905                	addi	s2,s2,1
        while(*s != 0){
 890:	00094583          	lbu	a1,0(s2)
 894:	f9e5                	bnez	a1,884 <vprintf+0x16c>
        s = va_arg(ap, char*);
 896:	8b4e                	mv	s6,s3
      state = 0;
 898:	4981                	li	s3,0
 89a:	bdf9                	j	778 <vprintf+0x60>
          s = "(null)";
 89c:	00000917          	auipc	s2,0x0
 8a0:	26c90913          	addi	s2,s2,620 # b08 <malloc+0x126>
        while(*s != 0){
 8a4:	02800593          	li	a1,40
 8a8:	bff1                	j	884 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8aa:	008b0913          	addi	s2,s6,8
 8ae:	000b4583          	lbu	a1,0(s6)
 8b2:	8556                	mv	a0,s5
 8b4:	00000097          	auipc	ra,0x0
 8b8:	d98080e7          	jalr	-616(ra) # 64c <putc>
 8bc:	8b4a                	mv	s6,s2
      state = 0;
 8be:	4981                	li	s3,0
 8c0:	bd65                	j	778 <vprintf+0x60>
        putc(fd, c);
 8c2:	85d2                	mv	a1,s4
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	d86080e7          	jalr	-634(ra) # 64c <putc>
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	b565                	j	778 <vprintf+0x60>
        s = va_arg(ap, char*);
 8d2:	8b4e                	mv	s6,s3
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	b54d                	j	778 <vprintf+0x60>
    }
  }
}
 8d8:	70e6                	ld	ra,120(sp)
 8da:	7446                	ld	s0,112(sp)
 8dc:	74a6                	ld	s1,104(sp)
 8de:	7906                	ld	s2,96(sp)
 8e0:	69e6                	ld	s3,88(sp)
 8e2:	6a46                	ld	s4,80(sp)
 8e4:	6aa6                	ld	s5,72(sp)
 8e6:	6b06                	ld	s6,64(sp)
 8e8:	7be2                	ld	s7,56(sp)
 8ea:	7c42                	ld	s8,48(sp)
 8ec:	7ca2                	ld	s9,40(sp)
 8ee:	7d02                	ld	s10,32(sp)
 8f0:	6de2                	ld	s11,24(sp)
 8f2:	6109                	addi	sp,sp,128
 8f4:	8082                	ret

00000000000008f6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8f6:	715d                	addi	sp,sp,-80
 8f8:	ec06                	sd	ra,24(sp)
 8fa:	e822                	sd	s0,16(sp)
 8fc:	1000                	addi	s0,sp,32
 8fe:	e010                	sd	a2,0(s0)
 900:	e414                	sd	a3,8(s0)
 902:	e818                	sd	a4,16(s0)
 904:	ec1c                	sd	a5,24(s0)
 906:	03043023          	sd	a6,32(s0)
 90a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 90e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 912:	8622                	mv	a2,s0
 914:	00000097          	auipc	ra,0x0
 918:	e04080e7          	jalr	-508(ra) # 718 <vprintf>
}
 91c:	60e2                	ld	ra,24(sp)
 91e:	6442                	ld	s0,16(sp)
 920:	6161                	addi	sp,sp,80
 922:	8082                	ret

0000000000000924 <printf>:

void
printf(const char *fmt, ...)
{
 924:	711d                	addi	sp,sp,-96
 926:	ec06                	sd	ra,24(sp)
 928:	e822                	sd	s0,16(sp)
 92a:	1000                	addi	s0,sp,32
 92c:	e40c                	sd	a1,8(s0)
 92e:	e810                	sd	a2,16(s0)
 930:	ec14                	sd	a3,24(s0)
 932:	f018                	sd	a4,32(s0)
 934:	f41c                	sd	a5,40(s0)
 936:	03043823          	sd	a6,48(s0)
 93a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 93e:	00840613          	addi	a2,s0,8
 942:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 946:	85aa                	mv	a1,a0
 948:	4505                	li	a0,1
 94a:	00000097          	auipc	ra,0x0
 94e:	dce080e7          	jalr	-562(ra) # 718 <vprintf>
}
 952:	60e2                	ld	ra,24(sp)
 954:	6442                	ld	s0,16(sp)
 956:	6125                	addi	sp,sp,96
 958:	8082                	ret

000000000000095a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 95a:	1141                	addi	sp,sp,-16
 95c:	e422                	sd	s0,8(sp)
 95e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 960:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 964:	00000797          	auipc	a5,0x0
 968:	1c47b783          	ld	a5,452(a5) # b28 <freep>
 96c:	a805                	j	99c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 96e:	4618                	lw	a4,8(a2)
 970:	9db9                	addw	a1,a1,a4
 972:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 976:	6398                	ld	a4,0(a5)
 978:	6318                	ld	a4,0(a4)
 97a:	fee53823          	sd	a4,-16(a0)
 97e:	a091                	j	9c2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 980:	ff852703          	lw	a4,-8(a0)
 984:	9e39                	addw	a2,a2,a4
 986:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 988:	ff053703          	ld	a4,-16(a0)
 98c:	e398                	sd	a4,0(a5)
 98e:	a099                	j	9d4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 990:	6398                	ld	a4,0(a5)
 992:	00e7e463          	bltu	a5,a4,99a <free+0x40>
 996:	00e6ea63          	bltu	a3,a4,9aa <free+0x50>
{
 99a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 99c:	fed7fae3          	bgeu	a5,a3,990 <free+0x36>
 9a0:	6398                	ld	a4,0(a5)
 9a2:	00e6e463          	bltu	a3,a4,9aa <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a6:	fee7eae3          	bltu	a5,a4,99a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9aa:	ff852583          	lw	a1,-8(a0)
 9ae:	6390                	ld	a2,0(a5)
 9b0:	02059813          	slli	a6,a1,0x20
 9b4:	01c85713          	srli	a4,a6,0x1c
 9b8:	9736                	add	a4,a4,a3
 9ba:	fae60ae3          	beq	a2,a4,96e <free+0x14>
    bp->s.ptr = p->s.ptr;
 9be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9c2:	4790                	lw	a2,8(a5)
 9c4:	02061593          	slli	a1,a2,0x20
 9c8:	01c5d713          	srli	a4,a1,0x1c
 9cc:	973e                	add	a4,a4,a5
 9ce:	fae689e3          	beq	a3,a4,980 <free+0x26>
  } else
    p->s.ptr = bp;
 9d2:	e394                	sd	a3,0(a5)
  freep = p;
 9d4:	00000717          	auipc	a4,0x0
 9d8:	14f73a23          	sd	a5,340(a4) # b28 <freep>
}
 9dc:	6422                	ld	s0,8(sp)
 9de:	0141                	addi	sp,sp,16
 9e0:	8082                	ret

00000000000009e2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e2:	7139                	addi	sp,sp,-64
 9e4:	fc06                	sd	ra,56(sp)
 9e6:	f822                	sd	s0,48(sp)
 9e8:	f426                	sd	s1,40(sp)
 9ea:	f04a                	sd	s2,32(sp)
 9ec:	ec4e                	sd	s3,24(sp)
 9ee:	e852                	sd	s4,16(sp)
 9f0:	e456                	sd	s5,8(sp)
 9f2:	e05a                	sd	s6,0(sp)
 9f4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9f6:	02051493          	slli	s1,a0,0x20
 9fa:	9081                	srli	s1,s1,0x20
 9fc:	04bd                	addi	s1,s1,15
 9fe:	8091                	srli	s1,s1,0x4
 a00:	0014899b          	addiw	s3,s1,1
 a04:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a06:	00000517          	auipc	a0,0x0
 a0a:	12253503          	ld	a0,290(a0) # b28 <freep>
 a0e:	c515                	beqz	a0,a3a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a10:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a12:	4798                	lw	a4,8(a5)
 a14:	02977f63          	bgeu	a4,s1,a52 <malloc+0x70>
 a18:	8a4e                	mv	s4,s3
 a1a:	0009871b          	sext.w	a4,s3
 a1e:	6685                	lui	a3,0x1
 a20:	00d77363          	bgeu	a4,a3,a26 <malloc+0x44>
 a24:	6a05                	lui	s4,0x1
 a26:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a2a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a2e:	00000917          	auipc	s2,0x0
 a32:	0fa90913          	addi	s2,s2,250 # b28 <freep>
  if(p == (char*)-1)
 a36:	5afd                	li	s5,-1
 a38:	a895                	j	aac <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a3a:	00000797          	auipc	a5,0x0
 a3e:	1e678793          	addi	a5,a5,486 # c20 <base>
 a42:	00000717          	auipc	a4,0x0
 a46:	0ef73323          	sd	a5,230(a4) # b28 <freep>
 a4a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a4c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a50:	b7e1                	j	a18 <malloc+0x36>
      if(p->s.size == nunits)
 a52:	02e48c63          	beq	s1,a4,a8a <malloc+0xa8>
        p->s.size -= nunits;
 a56:	4137073b          	subw	a4,a4,s3
 a5a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a5c:	02071693          	slli	a3,a4,0x20
 a60:	01c6d713          	srli	a4,a3,0x1c
 a64:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a66:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a6a:	00000717          	auipc	a4,0x0
 a6e:	0aa73f23          	sd	a0,190(a4) # b28 <freep>
      return (void*)(p + 1);
 a72:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a76:	70e2                	ld	ra,56(sp)
 a78:	7442                	ld	s0,48(sp)
 a7a:	74a2                	ld	s1,40(sp)
 a7c:	7902                	ld	s2,32(sp)
 a7e:	69e2                	ld	s3,24(sp)
 a80:	6a42                	ld	s4,16(sp)
 a82:	6aa2                	ld	s5,8(sp)
 a84:	6b02                	ld	s6,0(sp)
 a86:	6121                	addi	sp,sp,64
 a88:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a8a:	6398                	ld	a4,0(a5)
 a8c:	e118                	sd	a4,0(a0)
 a8e:	bff1                	j	a6a <malloc+0x88>
  hp->s.size = nu;
 a90:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a94:	0541                	addi	a0,a0,16
 a96:	00000097          	auipc	ra,0x0
 a9a:	ec4080e7          	jalr	-316(ra) # 95a <free>
  return freep;
 a9e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aa2:	d971                	beqz	a0,a76 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aa6:	4798                	lw	a4,8(a5)
 aa8:	fa9775e3          	bgeu	a4,s1,a52 <malloc+0x70>
    if(p == freep)
 aac:	00093703          	ld	a4,0(s2)
 ab0:	853e                	mv	a0,a5
 ab2:	fef719e3          	bne	a4,a5,aa4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ab6:	8552                	mv	a0,s4
 ab8:	00000097          	auipc	ra,0x0
 abc:	b74080e7          	jalr	-1164(ra) # 62c <sbrk>
  if(p == (char*)-1)
 ac0:	fd5518e3          	bne	a0,s5,a90 <malloc+0xae>
        return 0;
 ac4:	4501                	li	a0,0
 ac6:	bf45                	j	a76 <malloc+0x94>
