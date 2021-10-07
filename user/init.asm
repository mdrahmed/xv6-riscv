
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	aaa50513          	addi	a0,a0,-1366 # ab8 <malloc+0xea>
  16:	00000097          	auipc	ra,0x0
  1a:	5ba080e7          	jalr	1466(ra) # 5d0 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	5e4080e7          	jalr	1508(ra) # 608 <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	5da080e7          	jalr	1498(ra) # 608 <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	a8a90913          	addi	s2,s2,-1398 # ac0 <malloc+0xf2>
  3e:	854a                	mv	a0,s2
  40:	00001097          	auipc	ra,0x1
  44:	8d0080e7          	jalr	-1840(ra) # 910 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	540080e7          	jalr	1344(ra) # 588 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	53e080e7          	jalr	1342(ra) # 598 <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	aa650513          	addi	a0,a0,-1370 # b10 <malloc+0x142>
  72:	00001097          	auipc	ra,0x1
  76:	89e080e7          	jalr	-1890(ra) # 910 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	514080e7          	jalr	1300(ra) # 590 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	a3050513          	addi	a0,a0,-1488 # ab8 <malloc+0xea>
  90:	00000097          	auipc	ra,0x0
  94:	548080e7          	jalr	1352(ra) # 5d8 <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	a1e50513          	addi	a0,a0,-1506 # ab8 <malloc+0xea>
  a2:	00000097          	auipc	ra,0x0
  a6:	52e080e7          	jalr	1326(ra) # 5d0 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	a2c50513          	addi	a0,a0,-1492 # ad8 <malloc+0x10a>
  b4:	00001097          	auipc	ra,0x1
  b8:	85c080e7          	jalr	-1956(ra) # 910 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	4d2080e7          	jalr	1234(ra) # 590 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	a8a58593          	addi	a1,a1,-1398 # b50 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	a2250513          	addi	a0,a0,-1502 # af0 <malloc+0x122>
  d6:	00000097          	auipc	ra,0x0
  da:	4f2080e7          	jalr	1266(ra) # 5c8 <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	a1a50513          	addi	a0,a0,-1510 # af8 <malloc+0x12a>
  e6:	00001097          	auipc	ra,0x1
  ea:	82a080e7          	jalr	-2006(ra) # 910 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	4a0080e7          	jalr	1184(ra) # 590 <exit>

00000000000000f8 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  fe:	0f50000f          	fence	iorw,ow
 102:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret

000000000000010c <load>:

int load(uint64 *p) {
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 112:	0ff0000f          	fence
 116:	6108                	ld	a0,0(a0)
 118:	0ff0000f          	fence
}
 11c:	2501                	sext.w	a0,a0
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	addi	sp,sp,16
 122:	8082                	ret

0000000000000124 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 124:	7179                	addi	sp,sp,-48
 126:	f406                	sd	ra,40(sp)
 128:	f022                	sd	s0,32(sp)
 12a:	ec26                	sd	s1,24(sp)
 12c:	e84a                	sd	s2,16(sp)
 12e:	e44e                	sd	s3,8(sp)
 130:	e052                	sd	s4,0(sp)
 132:	1800                	addi	s0,sp,48
 134:	8a2a                	mv	s4,a0
 136:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 138:	4785                	li	a5,1
 13a:	00001497          	auipc	s1,0x1
 13e:	a3e48493          	addi	s1,s1,-1474 # b78 <rings+0x10>
 142:	00001917          	auipc	s2,0x1
 146:	b2690913          	addi	s2,s2,-1242 # c68 <__BSS_END__>
 14a:	04f59563          	bne	a1,a5,194 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 14e:	00001497          	auipc	s1,0x1
 152:	a2a4a483          	lw	s1,-1494(s1) # b78 <rings+0x10>
 156:	c099                	beqz	s1,15c <create_or_close_the_buffer_user+0x38>
 158:	4481                	li	s1,0
 15a:	a899                	j	1b0 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 15c:	00001917          	auipc	s2,0x1
 160:	a0c90913          	addi	s2,s2,-1524 # b68 <rings>
 164:	00093603          	ld	a2,0(s2)
 168:	4585                	li	a1,1
 16a:	00000097          	auipc	ra,0x0
 16e:	4c6080e7          	jalr	1222(ra) # 630 <ringbuf>
        rings[i].book->write_done = 0;
 172:	00893783          	ld	a5,8(s2)
 176:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 17a:	00893783          	ld	a5,8(s2)
 17e:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 182:	01092783          	lw	a5,16(s2)
 186:	2785                	addiw	a5,a5,1
 188:	00f92823          	sw	a5,16(s2)
        break;
 18c:	a015                	j	1b0 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 18e:	04e1                	addi	s1,s1,24
 190:	01248f63          	beq	s1,s2,1ae <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 194:	409c                	lw	a5,0(s1)
 196:	dfe5                	beqz	a5,18e <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 198:	ff04b603          	ld	a2,-16(s1)
 19c:	85ce                	mv	a1,s3
 19e:	8552                	mv	a0,s4
 1a0:	00000097          	auipc	ra,0x0
 1a4:	490080e7          	jalr	1168(ra) # 630 <ringbuf>
        rings[i].exists = 0;
 1a8:	0004a023          	sw	zero,0(s1)
 1ac:	b7cd                	j	18e <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 1ae:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 1b0:	8526                	mv	a0,s1
 1b2:	70a2                	ld	ra,40(sp)
 1b4:	7402                	ld	s0,32(sp)
 1b6:	64e2                	ld	s1,24(sp)
 1b8:	6942                	ld	s2,16(sp)
 1ba:	69a2                	ld	s3,8(sp)
 1bc:	6a02                	ld	s4,0(sp)
 1be:	6145                	addi	sp,sp,48
 1c0:	8082                	ret

00000000000001c2 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 1c2:	1101                	addi	sp,sp,-32
 1c4:	ec06                	sd	ra,24(sp)
 1c6:	e822                	sd	s0,16(sp)
 1c8:	e426                	sd	s1,8(sp)
 1ca:	1000                	addi	s0,sp,32
 1cc:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 1ce:	00151793          	slli	a5,a0,0x1
 1d2:	97aa                	add	a5,a5,a0
 1d4:	078e                	slli	a5,a5,0x3
 1d6:	00001717          	auipc	a4,0x1
 1da:	99270713          	addi	a4,a4,-1646 # b68 <rings>
 1de:	97ba                	add	a5,a5,a4
 1e0:	639c                	ld	a5,0(a5)
 1e2:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 1e4:	421c                	lw	a5,0(a2)
 1e6:	e785                	bnez	a5,20e <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 1e8:	86ba                	mv	a3,a4
 1ea:	671c                	ld	a5,8(a4)
 1ec:	6398                	ld	a4,0(a5)
 1ee:	67c1                	lui	a5,0x10
 1f0:	9fb9                	addw	a5,a5,a4
 1f2:	00151713          	slli	a4,a0,0x1
 1f6:	953a                	add	a0,a0,a4
 1f8:	050e                	slli	a0,a0,0x3
 1fa:	9536                	add	a0,a0,a3
 1fc:	6518                	ld	a4,8(a0)
 1fe:	6718                	ld	a4,8(a4)
 200:	9f99                	subw	a5,a5,a4
 202:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 204:	60e2                	ld	ra,24(sp)
 206:	6442                	ld	s0,16(sp)
 208:	64a2                	ld	s1,8(sp)
 20a:	6105                	addi	sp,sp,32
 20c:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 20e:	00151793          	slli	a5,a0,0x1
 212:	953e                	add	a0,a0,a5
 214:	050e                	slli	a0,a0,0x3
 216:	00001797          	auipc	a5,0x1
 21a:	95278793          	addi	a5,a5,-1710 # b68 <rings>
 21e:	953e                	add	a0,a0,a5
 220:	6508                	ld	a0,8(a0)
 222:	0521                	addi	a0,a0,8
 224:	00000097          	auipc	ra,0x0
 228:	ee8080e7          	jalr	-280(ra) # 10c <load>
 22c:	c088                	sw	a0,0(s1)
}
 22e:	bfd9                	j	204 <ringbuf_start_write+0x42>

0000000000000230 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 230:	1141                	addi	sp,sp,-16
 232:	e406                	sd	ra,8(sp)
 234:	e022                	sd	s0,0(sp)
 236:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 238:	00151793          	slli	a5,a0,0x1
 23c:	97aa                	add	a5,a5,a0
 23e:	078e                	slli	a5,a5,0x3
 240:	00001517          	auipc	a0,0x1
 244:	92850513          	addi	a0,a0,-1752 # b68 <rings>
 248:	97aa                	add	a5,a5,a0
 24a:	6788                	ld	a0,8(a5)
 24c:	0035959b          	slliw	a1,a1,0x3
 250:	0521                	addi	a0,a0,8
 252:	00000097          	auipc	ra,0x0
 256:	ea6080e7          	jalr	-346(ra) # f8 <store>
}
 25a:	60a2                	ld	ra,8(sp)
 25c:	6402                	ld	s0,0(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret

0000000000000262 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 262:	1101                	addi	sp,sp,-32
 264:	ec06                	sd	ra,24(sp)
 266:	e822                	sd	s0,16(sp)
 268:	e426                	sd	s1,8(sp)
 26a:	1000                	addi	s0,sp,32
 26c:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 26e:	00151793          	slli	a5,a0,0x1
 272:	97aa                	add	a5,a5,a0
 274:	078e                	slli	a5,a5,0x3
 276:	00001517          	auipc	a0,0x1
 27a:	8f250513          	addi	a0,a0,-1806 # b68 <rings>
 27e:	97aa                	add	a5,a5,a0
 280:	6788                	ld	a0,8(a5)
 282:	0521                	addi	a0,a0,8
 284:	00000097          	auipc	ra,0x0
 288:	e88080e7          	jalr	-376(ra) # 10c <load>
 28c:	c088                	sw	a0,0(s1)
}
 28e:	60e2                	ld	ra,24(sp)
 290:	6442                	ld	s0,16(sp)
 292:	64a2                	ld	s1,8(sp)
 294:	6105                	addi	sp,sp,32
 296:	8082                	ret

0000000000000298 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 298:	1101                	addi	sp,sp,-32
 29a:	ec06                	sd	ra,24(sp)
 29c:	e822                	sd	s0,16(sp)
 29e:	e426                	sd	s1,8(sp)
 2a0:	1000                	addi	s0,sp,32
 2a2:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 2a4:	00151793          	slli	a5,a0,0x1
 2a8:	97aa                	add	a5,a5,a0
 2aa:	078e                	slli	a5,a5,0x3
 2ac:	00001517          	auipc	a0,0x1
 2b0:	8bc50513          	addi	a0,a0,-1860 # b68 <rings>
 2b4:	97aa                	add	a5,a5,a0
 2b6:	6788                	ld	a0,8(a5)
 2b8:	611c                	ld	a5,0(a0)
 2ba:	ef99                	bnez	a5,2d8 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2bc:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2be:	41f7579b          	sraiw	a5,a4,0x1f
 2c2:	01d7d79b          	srliw	a5,a5,0x1d
 2c6:	9fb9                	addw	a5,a5,a4
 2c8:	4037d79b          	sraiw	a5,a5,0x3
 2cc:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 2ce:	60e2                	ld	ra,24(sp)
 2d0:	6442                	ld	s0,16(sp)
 2d2:	64a2                	ld	s1,8(sp)
 2d4:	6105                	addi	sp,sp,32
 2d6:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 2d8:	00000097          	auipc	ra,0x0
 2dc:	e34080e7          	jalr	-460(ra) # 10c <load>
    *bytes /= 8;
 2e0:	41f5579b          	sraiw	a5,a0,0x1f
 2e4:	01d7d79b          	srliw	a5,a5,0x1d
 2e8:	9d3d                	addw	a0,a0,a5
 2ea:	4035551b          	sraiw	a0,a0,0x3
 2ee:	c088                	sw	a0,0(s1)
}
 2f0:	bff9                	j	2ce <ringbuf_start_read+0x36>

00000000000002f2 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e406                	sd	ra,8(sp)
 2f6:	e022                	sd	s0,0(sp)
 2f8:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 2fa:	00151793          	slli	a5,a0,0x1
 2fe:	97aa                	add	a5,a5,a0
 300:	078e                	slli	a5,a5,0x3
 302:	00001517          	auipc	a0,0x1
 306:	86650513          	addi	a0,a0,-1946 # b68 <rings>
 30a:	97aa                	add	a5,a5,a0
 30c:	0035959b          	slliw	a1,a1,0x3
 310:	6788                	ld	a0,8(a5)
 312:	00000097          	auipc	ra,0x0
 316:	de6080e7          	jalr	-538(ra) # f8 <store>
}
 31a:	60a2                	ld	ra,8(sp)
 31c:	6402                	ld	s0,0(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret

0000000000000322 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 322:	1141                	addi	sp,sp,-16
 324:	e422                	sd	s0,8(sp)
 326:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 328:	87aa                	mv	a5,a0
 32a:	0585                	addi	a1,a1,1
 32c:	0785                	addi	a5,a5,1
 32e:	fff5c703          	lbu	a4,-1(a1)
 332:	fee78fa3          	sb	a4,-1(a5)
 336:	fb75                	bnez	a4,32a <strcpy+0x8>
    ;
  return os;
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret

000000000000033e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 33e:	1141                	addi	sp,sp,-16
 340:	e422                	sd	s0,8(sp)
 342:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 344:	00054783          	lbu	a5,0(a0)
 348:	cb91                	beqz	a5,35c <strcmp+0x1e>
 34a:	0005c703          	lbu	a4,0(a1)
 34e:	00f71763          	bne	a4,a5,35c <strcmp+0x1e>
    p++, q++;
 352:	0505                	addi	a0,a0,1
 354:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 356:	00054783          	lbu	a5,0(a0)
 35a:	fbe5                	bnez	a5,34a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 35c:	0005c503          	lbu	a0,0(a1)
}
 360:	40a7853b          	subw	a0,a5,a0
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret

000000000000036a <strlen>:

uint
strlen(const char *s)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 370:	00054783          	lbu	a5,0(a0)
 374:	cf91                	beqz	a5,390 <strlen+0x26>
 376:	0505                	addi	a0,a0,1
 378:	87aa                	mv	a5,a0
 37a:	4685                	li	a3,1
 37c:	9e89                	subw	a3,a3,a0
 37e:	00f6853b          	addw	a0,a3,a5
 382:	0785                	addi	a5,a5,1
 384:	fff7c703          	lbu	a4,-1(a5)
 388:	fb7d                	bnez	a4,37e <strlen+0x14>
    ;
  return n;
}
 38a:	6422                	ld	s0,8(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret
  for(n = 0; s[n]; n++)
 390:	4501                	li	a0,0
 392:	bfe5                	j	38a <strlen+0x20>

0000000000000394 <memset>:

void*
memset(void *dst, int c, uint n)
{
 394:	1141                	addi	sp,sp,-16
 396:	e422                	sd	s0,8(sp)
 398:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 39a:	ca19                	beqz	a2,3b0 <memset+0x1c>
 39c:	87aa                	mv	a5,a0
 39e:	1602                	slli	a2,a2,0x20
 3a0:	9201                	srli	a2,a2,0x20
 3a2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3aa:	0785                	addi	a5,a5,1
 3ac:	fee79de3          	bne	a5,a4,3a6 <memset+0x12>
  }
  return dst;
}
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret

00000000000003b6 <strchr>:

char*
strchr(const char *s, char c)
{
 3b6:	1141                	addi	sp,sp,-16
 3b8:	e422                	sd	s0,8(sp)
 3ba:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3bc:	00054783          	lbu	a5,0(a0)
 3c0:	cb99                	beqz	a5,3d6 <strchr+0x20>
    if(*s == c)
 3c2:	00f58763          	beq	a1,a5,3d0 <strchr+0x1a>
  for(; *s; s++)
 3c6:	0505                	addi	a0,a0,1
 3c8:	00054783          	lbu	a5,0(a0)
 3cc:	fbfd                	bnez	a5,3c2 <strchr+0xc>
      return (char*)s;
  return 0;
 3ce:	4501                	li	a0,0
}
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	addi	sp,sp,16
 3d4:	8082                	ret
  return 0;
 3d6:	4501                	li	a0,0
 3d8:	bfe5                	j	3d0 <strchr+0x1a>

00000000000003da <gets>:

char*
gets(char *buf, int max)
{
 3da:	711d                	addi	sp,sp,-96
 3dc:	ec86                	sd	ra,88(sp)
 3de:	e8a2                	sd	s0,80(sp)
 3e0:	e4a6                	sd	s1,72(sp)
 3e2:	e0ca                	sd	s2,64(sp)
 3e4:	fc4e                	sd	s3,56(sp)
 3e6:	f852                	sd	s4,48(sp)
 3e8:	f456                	sd	s5,40(sp)
 3ea:	f05a                	sd	s6,32(sp)
 3ec:	ec5e                	sd	s7,24(sp)
 3ee:	1080                	addi	s0,sp,96
 3f0:	8baa                	mv	s7,a0
 3f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f4:	892a                	mv	s2,a0
 3f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3f8:	4aa9                	li	s5,10
 3fa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3fc:	89a6                	mv	s3,s1
 3fe:	2485                	addiw	s1,s1,1
 400:	0344d863          	bge	s1,s4,430 <gets+0x56>
    cc = read(0, &c, 1);
 404:	4605                	li	a2,1
 406:	faf40593          	addi	a1,s0,-81
 40a:	4501                	li	a0,0
 40c:	00000097          	auipc	ra,0x0
 410:	19c080e7          	jalr	412(ra) # 5a8 <read>
    if(cc < 1)
 414:	00a05e63          	blez	a0,430 <gets+0x56>
    buf[i++] = c;
 418:	faf44783          	lbu	a5,-81(s0)
 41c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 420:	01578763          	beq	a5,s5,42e <gets+0x54>
 424:	0905                	addi	s2,s2,1
 426:	fd679be3          	bne	a5,s6,3fc <gets+0x22>
  for(i=0; i+1 < max; ){
 42a:	89a6                	mv	s3,s1
 42c:	a011                	j	430 <gets+0x56>
 42e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 430:	99de                	add	s3,s3,s7
 432:	00098023          	sb	zero,0(s3)
  return buf;
}
 436:	855e                	mv	a0,s7
 438:	60e6                	ld	ra,88(sp)
 43a:	6446                	ld	s0,80(sp)
 43c:	64a6                	ld	s1,72(sp)
 43e:	6906                	ld	s2,64(sp)
 440:	79e2                	ld	s3,56(sp)
 442:	7a42                	ld	s4,48(sp)
 444:	7aa2                	ld	s5,40(sp)
 446:	7b02                	ld	s6,32(sp)
 448:	6be2                	ld	s7,24(sp)
 44a:	6125                	addi	sp,sp,96
 44c:	8082                	ret

000000000000044e <stat>:

int
stat(const char *n, struct stat *st)
{
 44e:	1101                	addi	sp,sp,-32
 450:	ec06                	sd	ra,24(sp)
 452:	e822                	sd	s0,16(sp)
 454:	e426                	sd	s1,8(sp)
 456:	e04a                	sd	s2,0(sp)
 458:	1000                	addi	s0,sp,32
 45a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 45c:	4581                	li	a1,0
 45e:	00000097          	auipc	ra,0x0
 462:	172080e7          	jalr	370(ra) # 5d0 <open>
  if(fd < 0)
 466:	02054563          	bltz	a0,490 <stat+0x42>
 46a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 46c:	85ca                	mv	a1,s2
 46e:	00000097          	auipc	ra,0x0
 472:	17a080e7          	jalr	378(ra) # 5e8 <fstat>
 476:	892a                	mv	s2,a0
  close(fd);
 478:	8526                	mv	a0,s1
 47a:	00000097          	auipc	ra,0x0
 47e:	13e080e7          	jalr	318(ra) # 5b8 <close>
  return r;
}
 482:	854a                	mv	a0,s2
 484:	60e2                	ld	ra,24(sp)
 486:	6442                	ld	s0,16(sp)
 488:	64a2                	ld	s1,8(sp)
 48a:	6902                	ld	s2,0(sp)
 48c:	6105                	addi	sp,sp,32
 48e:	8082                	ret
    return -1;
 490:	597d                	li	s2,-1
 492:	bfc5                	j	482 <stat+0x34>

0000000000000494 <atoi>:

int
atoi(const char *s)
{
 494:	1141                	addi	sp,sp,-16
 496:	e422                	sd	s0,8(sp)
 498:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 49a:	00054603          	lbu	a2,0(a0)
 49e:	fd06079b          	addiw	a5,a2,-48
 4a2:	0ff7f793          	zext.b	a5,a5
 4a6:	4725                	li	a4,9
 4a8:	02f76963          	bltu	a4,a5,4da <atoi+0x46>
 4ac:	86aa                	mv	a3,a0
  n = 0;
 4ae:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4b0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4b2:	0685                	addi	a3,a3,1
 4b4:	0025179b          	slliw	a5,a0,0x2
 4b8:	9fa9                	addw	a5,a5,a0
 4ba:	0017979b          	slliw	a5,a5,0x1
 4be:	9fb1                	addw	a5,a5,a2
 4c0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4c4:	0006c603          	lbu	a2,0(a3)
 4c8:	fd06071b          	addiw	a4,a2,-48
 4cc:	0ff77713          	zext.b	a4,a4
 4d0:	fee5f1e3          	bgeu	a1,a4,4b2 <atoi+0x1e>
  return n;
}
 4d4:	6422                	ld	s0,8(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
  n = 0;
 4da:	4501                	li	a0,0
 4dc:	bfe5                	j	4d4 <atoi+0x40>

00000000000004de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e422                	sd	s0,8(sp)
 4e2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4e4:	02b57463          	bgeu	a0,a1,50c <memmove+0x2e>
    while(n-- > 0)
 4e8:	00c05f63          	blez	a2,506 <memmove+0x28>
 4ec:	1602                	slli	a2,a2,0x20
 4ee:	9201                	srli	a2,a2,0x20
 4f0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4f4:	872a                	mv	a4,a0
      *dst++ = *src++;
 4f6:	0585                	addi	a1,a1,1
 4f8:	0705                	addi	a4,a4,1
 4fa:	fff5c683          	lbu	a3,-1(a1)
 4fe:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 502:	fee79ae3          	bne	a5,a4,4f6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 506:	6422                	ld	s0,8(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret
    dst += n;
 50c:	00c50733          	add	a4,a0,a2
    src += n;
 510:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 512:	fec05ae3          	blez	a2,506 <memmove+0x28>
 516:	fff6079b          	addiw	a5,a2,-1
 51a:	1782                	slli	a5,a5,0x20
 51c:	9381                	srli	a5,a5,0x20
 51e:	fff7c793          	not	a5,a5
 522:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 524:	15fd                	addi	a1,a1,-1
 526:	177d                	addi	a4,a4,-1
 528:	0005c683          	lbu	a3,0(a1)
 52c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 530:	fee79ae3          	bne	a5,a4,524 <memmove+0x46>
 534:	bfc9                	j	506 <memmove+0x28>

0000000000000536 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 536:	1141                	addi	sp,sp,-16
 538:	e422                	sd	s0,8(sp)
 53a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 53c:	ca05                	beqz	a2,56c <memcmp+0x36>
 53e:	fff6069b          	addiw	a3,a2,-1
 542:	1682                	slli	a3,a3,0x20
 544:	9281                	srli	a3,a3,0x20
 546:	0685                	addi	a3,a3,1
 548:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 54a:	00054783          	lbu	a5,0(a0)
 54e:	0005c703          	lbu	a4,0(a1)
 552:	00e79863          	bne	a5,a4,562 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 556:	0505                	addi	a0,a0,1
    p2++;
 558:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 55a:	fed518e3          	bne	a0,a3,54a <memcmp+0x14>
  }
  return 0;
 55e:	4501                	li	a0,0
 560:	a019                	j	566 <memcmp+0x30>
      return *p1 - *p2;
 562:	40e7853b          	subw	a0,a5,a4
}
 566:	6422                	ld	s0,8(sp)
 568:	0141                	addi	sp,sp,16
 56a:	8082                	ret
  return 0;
 56c:	4501                	li	a0,0
 56e:	bfe5                	j	566 <memcmp+0x30>

0000000000000570 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 570:	1141                	addi	sp,sp,-16
 572:	e406                	sd	ra,8(sp)
 574:	e022                	sd	s0,0(sp)
 576:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 578:	00000097          	auipc	ra,0x0
 57c:	f66080e7          	jalr	-154(ra) # 4de <memmove>
}
 580:	60a2                	ld	ra,8(sp)
 582:	6402                	ld	s0,0(sp)
 584:	0141                	addi	sp,sp,16
 586:	8082                	ret

0000000000000588 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 588:	4885                	li	a7,1
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <exit>:
.global exit
exit:
 li a7, SYS_exit
 590:	4889                	li	a7,2
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <wait>:
.global wait
wait:
 li a7, SYS_wait
 598:	488d                	li	a7,3
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5a0:	4891                	li	a7,4
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <read>:
.global read
read:
 li a7, SYS_read
 5a8:	4895                	li	a7,5
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <write>:
.global write
write:
 li a7, SYS_write
 5b0:	48c1                	li	a7,16
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <close>:
.global close
close:
 li a7, SYS_close
 5b8:	48d5                	li	a7,21
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5c0:	4899                	li	a7,6
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5c8:	489d                	li	a7,7
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <open>:
.global open
open:
 li a7, SYS_open
 5d0:	48bd                	li	a7,15
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5d8:	48c5                	li	a7,17
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5e0:	48c9                	li	a7,18
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5e8:	48a1                	li	a7,8
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <link>:
.global link
link:
 li a7, SYS_link
 5f0:	48cd                	li	a7,19
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5f8:	48d1                	li	a7,20
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 600:	48a5                	li	a7,9
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <dup>:
.global dup
dup:
 li a7, SYS_dup
 608:	48a9                	li	a7,10
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 610:	48ad                	li	a7,11
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 618:	48b1                	li	a7,12
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 620:	48b5                	li	a7,13
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 628:	48b9                	li	a7,14
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 630:	48d9                	li	a7,22
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 638:	1101                	addi	sp,sp,-32
 63a:	ec06                	sd	ra,24(sp)
 63c:	e822                	sd	s0,16(sp)
 63e:	1000                	addi	s0,sp,32
 640:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 644:	4605                	li	a2,1
 646:	fef40593          	addi	a1,s0,-17
 64a:	00000097          	auipc	ra,0x0
 64e:	f66080e7          	jalr	-154(ra) # 5b0 <write>
}
 652:	60e2                	ld	ra,24(sp)
 654:	6442                	ld	s0,16(sp)
 656:	6105                	addi	sp,sp,32
 658:	8082                	ret

000000000000065a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 65a:	7139                	addi	sp,sp,-64
 65c:	fc06                	sd	ra,56(sp)
 65e:	f822                	sd	s0,48(sp)
 660:	f426                	sd	s1,40(sp)
 662:	f04a                	sd	s2,32(sp)
 664:	ec4e                	sd	s3,24(sp)
 666:	0080                	addi	s0,sp,64
 668:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 66a:	c299                	beqz	a3,670 <printint+0x16>
 66c:	0805c863          	bltz	a1,6fc <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 670:	2581                	sext.w	a1,a1
  neg = 0;
 672:	4881                	li	a7,0
 674:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 678:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 67a:	2601                	sext.w	a2,a2
 67c:	00000517          	auipc	a0,0x0
 680:	4bc50513          	addi	a0,a0,1212 # b38 <digits>
 684:	883a                	mv	a6,a4
 686:	2705                	addiw	a4,a4,1
 688:	02c5f7bb          	remuw	a5,a1,a2
 68c:	1782                	slli	a5,a5,0x20
 68e:	9381                	srli	a5,a5,0x20
 690:	97aa                	add	a5,a5,a0
 692:	0007c783          	lbu	a5,0(a5)
 696:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 69a:	0005879b          	sext.w	a5,a1
 69e:	02c5d5bb          	divuw	a1,a1,a2
 6a2:	0685                	addi	a3,a3,1
 6a4:	fec7f0e3          	bgeu	a5,a2,684 <printint+0x2a>
  if(neg)
 6a8:	00088b63          	beqz	a7,6be <printint+0x64>
    buf[i++] = '-';
 6ac:	fd040793          	addi	a5,s0,-48
 6b0:	973e                	add	a4,a4,a5
 6b2:	02d00793          	li	a5,45
 6b6:	fef70823          	sb	a5,-16(a4)
 6ba:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6be:	02e05863          	blez	a4,6ee <printint+0x94>
 6c2:	fc040793          	addi	a5,s0,-64
 6c6:	00e78933          	add	s2,a5,a4
 6ca:	fff78993          	addi	s3,a5,-1
 6ce:	99ba                	add	s3,s3,a4
 6d0:	377d                	addiw	a4,a4,-1
 6d2:	1702                	slli	a4,a4,0x20
 6d4:	9301                	srli	a4,a4,0x20
 6d6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6da:	fff94583          	lbu	a1,-1(s2)
 6de:	8526                	mv	a0,s1
 6e0:	00000097          	auipc	ra,0x0
 6e4:	f58080e7          	jalr	-168(ra) # 638 <putc>
  while(--i >= 0)
 6e8:	197d                	addi	s2,s2,-1
 6ea:	ff3918e3          	bne	s2,s3,6da <printint+0x80>
}
 6ee:	70e2                	ld	ra,56(sp)
 6f0:	7442                	ld	s0,48(sp)
 6f2:	74a2                	ld	s1,40(sp)
 6f4:	7902                	ld	s2,32(sp)
 6f6:	69e2                	ld	s3,24(sp)
 6f8:	6121                	addi	sp,sp,64
 6fa:	8082                	ret
    x = -xx;
 6fc:	40b005bb          	negw	a1,a1
    neg = 1;
 700:	4885                	li	a7,1
    x = -xx;
 702:	bf8d                	j	674 <printint+0x1a>

0000000000000704 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 704:	7119                	addi	sp,sp,-128
 706:	fc86                	sd	ra,120(sp)
 708:	f8a2                	sd	s0,112(sp)
 70a:	f4a6                	sd	s1,104(sp)
 70c:	f0ca                	sd	s2,96(sp)
 70e:	ecce                	sd	s3,88(sp)
 710:	e8d2                	sd	s4,80(sp)
 712:	e4d6                	sd	s5,72(sp)
 714:	e0da                	sd	s6,64(sp)
 716:	fc5e                	sd	s7,56(sp)
 718:	f862                	sd	s8,48(sp)
 71a:	f466                	sd	s9,40(sp)
 71c:	f06a                	sd	s10,32(sp)
 71e:	ec6e                	sd	s11,24(sp)
 720:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 722:	0005c903          	lbu	s2,0(a1)
 726:	18090f63          	beqz	s2,8c4 <vprintf+0x1c0>
 72a:	8aaa                	mv	s5,a0
 72c:	8b32                	mv	s6,a2
 72e:	00158493          	addi	s1,a1,1
  state = 0;
 732:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 734:	02500a13          	li	s4,37
      if(c == 'd'){
 738:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 73c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 740:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 744:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 748:	00000b97          	auipc	s7,0x0
 74c:	3f0b8b93          	addi	s7,s7,1008 # b38 <digits>
 750:	a839                	j	76e <vprintf+0x6a>
        putc(fd, c);
 752:	85ca                	mv	a1,s2
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	ee2080e7          	jalr	-286(ra) # 638 <putc>
 75e:	a019                	j	764 <vprintf+0x60>
    } else if(state == '%'){
 760:	01498f63          	beq	s3,s4,77e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 764:	0485                	addi	s1,s1,1
 766:	fff4c903          	lbu	s2,-1(s1)
 76a:	14090d63          	beqz	s2,8c4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 76e:	0009079b          	sext.w	a5,s2
    if(state == 0){
 772:	fe0997e3          	bnez	s3,760 <vprintf+0x5c>
      if(c == '%'){
 776:	fd479ee3          	bne	a5,s4,752 <vprintf+0x4e>
        state = '%';
 77a:	89be                	mv	s3,a5
 77c:	b7e5                	j	764 <vprintf+0x60>
      if(c == 'd'){
 77e:	05878063          	beq	a5,s8,7be <vprintf+0xba>
      } else if(c == 'l') {
 782:	05978c63          	beq	a5,s9,7da <vprintf+0xd6>
      } else if(c == 'x') {
 786:	07a78863          	beq	a5,s10,7f6 <vprintf+0xf2>
      } else if(c == 'p') {
 78a:	09b78463          	beq	a5,s11,812 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 78e:	07300713          	li	a4,115
 792:	0ce78663          	beq	a5,a4,85e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 796:	06300713          	li	a4,99
 79a:	0ee78e63          	beq	a5,a4,896 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 79e:	11478863          	beq	a5,s4,8ae <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7a2:	85d2                	mv	a1,s4
 7a4:	8556                	mv	a0,s5
 7a6:	00000097          	auipc	ra,0x0
 7aa:	e92080e7          	jalr	-366(ra) # 638 <putc>
        putc(fd, c);
 7ae:	85ca                	mv	a1,s2
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	e86080e7          	jalr	-378(ra) # 638 <putc>
      }
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	b765                	j	764 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7be:	008b0913          	addi	s2,s6,8
 7c2:	4685                	li	a3,1
 7c4:	4629                	li	a2,10
 7c6:	000b2583          	lw	a1,0(s6)
 7ca:	8556                	mv	a0,s5
 7cc:	00000097          	auipc	ra,0x0
 7d0:	e8e080e7          	jalr	-370(ra) # 65a <printint>
 7d4:	8b4a                	mv	s6,s2
      state = 0;
 7d6:	4981                	li	s3,0
 7d8:	b771                	j	764 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7da:	008b0913          	addi	s2,s6,8
 7de:	4681                	li	a3,0
 7e0:	4629                	li	a2,10
 7e2:	000b2583          	lw	a1,0(s6)
 7e6:	8556                	mv	a0,s5
 7e8:	00000097          	auipc	ra,0x0
 7ec:	e72080e7          	jalr	-398(ra) # 65a <printint>
 7f0:	8b4a                	mv	s6,s2
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	bf85                	j	764 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7f6:	008b0913          	addi	s2,s6,8
 7fa:	4681                	li	a3,0
 7fc:	4641                	li	a2,16
 7fe:	000b2583          	lw	a1,0(s6)
 802:	8556                	mv	a0,s5
 804:	00000097          	auipc	ra,0x0
 808:	e56080e7          	jalr	-426(ra) # 65a <printint>
 80c:	8b4a                	mv	s6,s2
      state = 0;
 80e:	4981                	li	s3,0
 810:	bf91                	j	764 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 812:	008b0793          	addi	a5,s6,8
 816:	f8f43423          	sd	a5,-120(s0)
 81a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 81e:	03000593          	li	a1,48
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	e14080e7          	jalr	-492(ra) # 638 <putc>
  putc(fd, 'x');
 82c:	85ea                	mv	a1,s10
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	e08080e7          	jalr	-504(ra) # 638 <putc>
 838:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 83a:	03c9d793          	srli	a5,s3,0x3c
 83e:	97de                	add	a5,a5,s7
 840:	0007c583          	lbu	a1,0(a5)
 844:	8556                	mv	a0,s5
 846:	00000097          	auipc	ra,0x0
 84a:	df2080e7          	jalr	-526(ra) # 638 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 84e:	0992                	slli	s3,s3,0x4
 850:	397d                	addiw	s2,s2,-1
 852:	fe0914e3          	bnez	s2,83a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 856:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 85a:	4981                	li	s3,0
 85c:	b721                	j	764 <vprintf+0x60>
        s = va_arg(ap, char*);
 85e:	008b0993          	addi	s3,s6,8
 862:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 866:	02090163          	beqz	s2,888 <vprintf+0x184>
        while(*s != 0){
 86a:	00094583          	lbu	a1,0(s2)
 86e:	c9a1                	beqz	a1,8be <vprintf+0x1ba>
          putc(fd, *s);
 870:	8556                	mv	a0,s5
 872:	00000097          	auipc	ra,0x0
 876:	dc6080e7          	jalr	-570(ra) # 638 <putc>
          s++;
 87a:	0905                	addi	s2,s2,1
        while(*s != 0){
 87c:	00094583          	lbu	a1,0(s2)
 880:	f9e5                	bnez	a1,870 <vprintf+0x16c>
        s = va_arg(ap, char*);
 882:	8b4e                	mv	s6,s3
      state = 0;
 884:	4981                	li	s3,0
 886:	bdf9                	j	764 <vprintf+0x60>
          s = "(null)";
 888:	00000917          	auipc	s2,0x0
 88c:	2a890913          	addi	s2,s2,680 # b30 <malloc+0x162>
        while(*s != 0){
 890:	02800593          	li	a1,40
 894:	bff1                	j	870 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 896:	008b0913          	addi	s2,s6,8
 89a:	000b4583          	lbu	a1,0(s6)
 89e:	8556                	mv	a0,s5
 8a0:	00000097          	auipc	ra,0x0
 8a4:	d98080e7          	jalr	-616(ra) # 638 <putc>
 8a8:	8b4a                	mv	s6,s2
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	bd65                	j	764 <vprintf+0x60>
        putc(fd, c);
 8ae:	85d2                	mv	a1,s4
 8b0:	8556                	mv	a0,s5
 8b2:	00000097          	auipc	ra,0x0
 8b6:	d86080e7          	jalr	-634(ra) # 638 <putc>
      state = 0;
 8ba:	4981                	li	s3,0
 8bc:	b565                	j	764 <vprintf+0x60>
        s = va_arg(ap, char*);
 8be:	8b4e                	mv	s6,s3
      state = 0;
 8c0:	4981                	li	s3,0
 8c2:	b54d                	j	764 <vprintf+0x60>
    }
  }
}
 8c4:	70e6                	ld	ra,120(sp)
 8c6:	7446                	ld	s0,112(sp)
 8c8:	74a6                	ld	s1,104(sp)
 8ca:	7906                	ld	s2,96(sp)
 8cc:	69e6                	ld	s3,88(sp)
 8ce:	6a46                	ld	s4,80(sp)
 8d0:	6aa6                	ld	s5,72(sp)
 8d2:	6b06                	ld	s6,64(sp)
 8d4:	7be2                	ld	s7,56(sp)
 8d6:	7c42                	ld	s8,48(sp)
 8d8:	7ca2                	ld	s9,40(sp)
 8da:	7d02                	ld	s10,32(sp)
 8dc:	6de2                	ld	s11,24(sp)
 8de:	6109                	addi	sp,sp,128
 8e0:	8082                	ret

00000000000008e2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8e2:	715d                	addi	sp,sp,-80
 8e4:	ec06                	sd	ra,24(sp)
 8e6:	e822                	sd	s0,16(sp)
 8e8:	1000                	addi	s0,sp,32
 8ea:	e010                	sd	a2,0(s0)
 8ec:	e414                	sd	a3,8(s0)
 8ee:	e818                	sd	a4,16(s0)
 8f0:	ec1c                	sd	a5,24(s0)
 8f2:	03043023          	sd	a6,32(s0)
 8f6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8fa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8fe:	8622                	mv	a2,s0
 900:	00000097          	auipc	ra,0x0
 904:	e04080e7          	jalr	-508(ra) # 704 <vprintf>
}
 908:	60e2                	ld	ra,24(sp)
 90a:	6442                	ld	s0,16(sp)
 90c:	6161                	addi	sp,sp,80
 90e:	8082                	ret

0000000000000910 <printf>:

void
printf(const char *fmt, ...)
{
 910:	711d                	addi	sp,sp,-96
 912:	ec06                	sd	ra,24(sp)
 914:	e822                	sd	s0,16(sp)
 916:	1000                	addi	s0,sp,32
 918:	e40c                	sd	a1,8(s0)
 91a:	e810                	sd	a2,16(s0)
 91c:	ec14                	sd	a3,24(s0)
 91e:	f018                	sd	a4,32(s0)
 920:	f41c                	sd	a5,40(s0)
 922:	03043823          	sd	a6,48(s0)
 926:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 92a:	00840613          	addi	a2,s0,8
 92e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 932:	85aa                	mv	a1,a0
 934:	4505                	li	a0,1
 936:	00000097          	auipc	ra,0x0
 93a:	dce080e7          	jalr	-562(ra) # 704 <vprintf>
}
 93e:	60e2                	ld	ra,24(sp)
 940:	6442                	ld	s0,16(sp)
 942:	6125                	addi	sp,sp,96
 944:	8082                	ret

0000000000000946 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 946:	1141                	addi	sp,sp,-16
 948:	e422                	sd	s0,8(sp)
 94a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 94c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 950:	00000797          	auipc	a5,0x0
 954:	2107b783          	ld	a5,528(a5) # b60 <freep>
 958:	a805                	j	988 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 95a:	4618                	lw	a4,8(a2)
 95c:	9db9                	addw	a1,a1,a4
 95e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 962:	6398                	ld	a4,0(a5)
 964:	6318                	ld	a4,0(a4)
 966:	fee53823          	sd	a4,-16(a0)
 96a:	a091                	j	9ae <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 96c:	ff852703          	lw	a4,-8(a0)
 970:	9e39                	addw	a2,a2,a4
 972:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 974:	ff053703          	ld	a4,-16(a0)
 978:	e398                	sd	a4,0(a5)
 97a:	a099                	j	9c0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 97c:	6398                	ld	a4,0(a5)
 97e:	00e7e463          	bltu	a5,a4,986 <free+0x40>
 982:	00e6ea63          	bltu	a3,a4,996 <free+0x50>
{
 986:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 988:	fed7fae3          	bgeu	a5,a3,97c <free+0x36>
 98c:	6398                	ld	a4,0(a5)
 98e:	00e6e463          	bltu	a3,a4,996 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 992:	fee7eae3          	bltu	a5,a4,986 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 996:	ff852583          	lw	a1,-8(a0)
 99a:	6390                	ld	a2,0(a5)
 99c:	02059813          	slli	a6,a1,0x20
 9a0:	01c85713          	srli	a4,a6,0x1c
 9a4:	9736                	add	a4,a4,a3
 9a6:	fae60ae3          	beq	a2,a4,95a <free+0x14>
    bp->s.ptr = p->s.ptr;
 9aa:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9ae:	4790                	lw	a2,8(a5)
 9b0:	02061593          	slli	a1,a2,0x20
 9b4:	01c5d713          	srli	a4,a1,0x1c
 9b8:	973e                	add	a4,a4,a5
 9ba:	fae689e3          	beq	a3,a4,96c <free+0x26>
  } else
    p->s.ptr = bp;
 9be:	e394                	sd	a3,0(a5)
  freep = p;
 9c0:	00000717          	auipc	a4,0x0
 9c4:	1af73023          	sd	a5,416(a4) # b60 <freep>
}
 9c8:	6422                	ld	s0,8(sp)
 9ca:	0141                	addi	sp,sp,16
 9cc:	8082                	ret

00000000000009ce <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9ce:	7139                	addi	sp,sp,-64
 9d0:	fc06                	sd	ra,56(sp)
 9d2:	f822                	sd	s0,48(sp)
 9d4:	f426                	sd	s1,40(sp)
 9d6:	f04a                	sd	s2,32(sp)
 9d8:	ec4e                	sd	s3,24(sp)
 9da:	e852                	sd	s4,16(sp)
 9dc:	e456                	sd	s5,8(sp)
 9de:	e05a                	sd	s6,0(sp)
 9e0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9e2:	02051493          	slli	s1,a0,0x20
 9e6:	9081                	srli	s1,s1,0x20
 9e8:	04bd                	addi	s1,s1,15
 9ea:	8091                	srli	s1,s1,0x4
 9ec:	0014899b          	addiw	s3,s1,1
 9f0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9f2:	00000517          	auipc	a0,0x0
 9f6:	16e53503          	ld	a0,366(a0) # b60 <freep>
 9fa:	c515                	beqz	a0,a26 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9fe:	4798                	lw	a4,8(a5)
 a00:	02977f63          	bgeu	a4,s1,a3e <malloc+0x70>
 a04:	8a4e                	mv	s4,s3
 a06:	0009871b          	sext.w	a4,s3
 a0a:	6685                	lui	a3,0x1
 a0c:	00d77363          	bgeu	a4,a3,a12 <malloc+0x44>
 a10:	6a05                	lui	s4,0x1
 a12:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a16:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a1a:	00000917          	auipc	s2,0x0
 a1e:	14690913          	addi	s2,s2,326 # b60 <freep>
  if(p == (char*)-1)
 a22:	5afd                	li	s5,-1
 a24:	a895                	j	a98 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a26:	00000797          	auipc	a5,0x0
 a2a:	23278793          	addi	a5,a5,562 # c58 <base>
 a2e:	00000717          	auipc	a4,0x0
 a32:	12f73923          	sd	a5,306(a4) # b60 <freep>
 a36:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a38:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a3c:	b7e1                	j	a04 <malloc+0x36>
      if(p->s.size == nunits)
 a3e:	02e48c63          	beq	s1,a4,a76 <malloc+0xa8>
        p->s.size -= nunits;
 a42:	4137073b          	subw	a4,a4,s3
 a46:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a48:	02071693          	slli	a3,a4,0x20
 a4c:	01c6d713          	srli	a4,a3,0x1c
 a50:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a52:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a56:	00000717          	auipc	a4,0x0
 a5a:	10a73523          	sd	a0,266(a4) # b60 <freep>
      return (void*)(p + 1);
 a5e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a62:	70e2                	ld	ra,56(sp)
 a64:	7442                	ld	s0,48(sp)
 a66:	74a2                	ld	s1,40(sp)
 a68:	7902                	ld	s2,32(sp)
 a6a:	69e2                	ld	s3,24(sp)
 a6c:	6a42                	ld	s4,16(sp)
 a6e:	6aa2                	ld	s5,8(sp)
 a70:	6b02                	ld	s6,0(sp)
 a72:	6121                	addi	sp,sp,64
 a74:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a76:	6398                	ld	a4,0(a5)
 a78:	e118                	sd	a4,0(a0)
 a7a:	bff1                	j	a56 <malloc+0x88>
  hp->s.size = nu;
 a7c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a80:	0541                	addi	a0,a0,16
 a82:	00000097          	auipc	ra,0x0
 a86:	ec4080e7          	jalr	-316(ra) # 946 <free>
  return freep;
 a8a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a8e:	d971                	beqz	a0,a62 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a90:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a92:	4798                	lw	a4,8(a5)
 a94:	fa9775e3          	bgeu	a4,s1,a3e <malloc+0x70>
    if(p == freep)
 a98:	00093703          	ld	a4,0(s2)
 a9c:	853e                	mv	a0,a5
 a9e:	fef719e3          	bne	a4,a5,a90 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 aa2:	8552                	mv	a0,s4
 aa4:	00000097          	auipc	ra,0x0
 aa8:	b74080e7          	jalr	-1164(ra) # 618 <sbrk>
  if(p == (char*)-1)
 aac:	fd5518e3          	bne	a0,s5,a7c <malloc+0xae>
        return 0;
 ab0:	4501                	li	a0,0
 ab2:	bf45                	j	a62 <malloc+0x94>
