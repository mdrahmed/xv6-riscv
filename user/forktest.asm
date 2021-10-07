
user/_forktest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <print>:

#define N  1000

void
print(const char *s)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
   a:	84aa                	mv	s1,a0
  write(1, s, strlen(s));
   c:	00000097          	auipc	ra,0x0
  10:	384080e7          	jalr	900(ra) # 390 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	5ba080e7          	jalr	1466(ra) # 5d6 <write>
}
  24:	60e2                	ld	ra,24(sp)
  26:	6442                	ld	s0,16(sp)
  28:	64a2                	ld	s1,8(sp)
  2a:	6105                	addi	sp,sp,32
  2c:	8082                	ret

000000000000002e <forktest>:

void
forktest(void)
{
  2e:	1101                	addi	sp,sp,-32
  30:	ec06                	sd	ra,24(sp)
  32:	e822                	sd	s0,16(sp)
  34:	e426                	sd	s1,8(sp)
  36:	e04a                	sd	s2,0(sp)
  38:	1000                	addi	s0,sp,32
  int n, pid;

  print("fork test\n");
  3a:	00000517          	auipc	a0,0x0
  3e:	62650513          	addi	a0,a0,1574 # 660 <ringbuf+0xa>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	55e080e7          	jalr	1374(ra) # 5ae <fork>
    if(pid < 0)
  58:	02054763          	bltz	a0,86 <forktest+0x58>
      break;
    if(pid == 0)
  5c:	c10d                	beqz	a0,7e <forktest+0x50>
  for(n=0; n<N; n++){
  5e:	2485                	addiw	s1,s1,1
  60:	ff2498e3          	bne	s1,s2,50 <forktest+0x22>
      exit(0);
  }

  if(n == N){
    print("fork claimed to work N times!\n");
  64:	00000517          	auipc	a0,0x0
  68:	60c50513          	addi	a0,a0,1548 # 670 <ringbuf+0x1a>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	540080e7          	jalr	1344(ra) # 5b6 <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	538080e7          	jalr	1336(ra) # 5b6 <exit>
  if(n == N){
  86:	3e800793          	li	a5,1000
  8a:	fcf48de3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  8e:	00905b63          	blez	s1,a4 <forktest+0x76>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	52a080e7          	jalr	1322(ra) # 5be <wait>
  9c:	02054a63          	bltz	a0,d0 <forktest+0xa2>
  for(; n > 0; n--){
  a0:	34fd                	addiw	s1,s1,-1
  a2:	f8e5                	bnez	s1,92 <forktest+0x64>
      print("wait stopped early\n");
      exit(1);
    }
  }

  if(wait(0) != -1){
  a4:	4501                	li	a0,0
  a6:	00000097          	auipc	ra,0x0
  aa:	518080e7          	jalr	1304(ra) # 5be <wait>
  ae:	57fd                	li	a5,-1
  b0:	02f51d63          	bne	a0,a5,ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  b4:	00000517          	auipc	a0,0x0
  b8:	60c50513          	addi	a0,a0,1548 # 6c0 <ringbuf+0x6a>
  bc:	00000097          	auipc	ra,0x0
  c0:	f44080e7          	jalr	-188(ra) # 0 <print>
}
  c4:	60e2                	ld	ra,24(sp)
  c6:	6442                	ld	s0,16(sp)
  c8:	64a2                	ld	s1,8(sp)
  ca:	6902                	ld	s2,0(sp)
  cc:	6105                	addi	sp,sp,32
  ce:	8082                	ret
      print("wait stopped early\n");
  d0:	00000517          	auipc	a0,0x0
  d4:	5c050513          	addi	a0,a0,1472 # 690 <ringbuf+0x3a>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <print>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	4d4080e7          	jalr	1236(ra) # 5b6 <exit>
    print("wait got too many\n");
  ea:	00000517          	auipc	a0,0x0
  ee:	5be50513          	addi	a0,a0,1470 # 6a8 <ringbuf+0x52>
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <print>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	4ba080e7          	jalr	1210(ra) # 5b6 <exit>

0000000000000104 <main>:

int
main(void)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  forktest();
 10c:	00000097          	auipc	ra,0x0
 110:	f22080e7          	jalr	-222(ra) # 2e <forktest>
  exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	4a0080e7          	jalr	1184(ra) # 5b6 <exit>

000000000000011e <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 124:	0f50000f          	fence	iorw,ow
 128:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <load>:

int load(uint64 *p) {
 132:	1141                	addi	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 138:	0ff0000f          	fence
 13c:	6108                	ld	a0,0(a0)
 13e:	0ff0000f          	fence
}
 142:	2501                	sext.w	a0,a0
 144:	6422                	ld	s0,8(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret

000000000000014a <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 14a:	7179                	addi	sp,sp,-48
 14c:	f406                	sd	ra,40(sp)
 14e:	f022                	sd	s0,32(sp)
 150:	ec26                	sd	s1,24(sp)
 152:	e84a                	sd	s2,16(sp)
 154:	e44e                	sd	s3,8(sp)
 156:	e052                	sd	s4,0(sp)
 158:	1800                	addi	s0,sp,48
 15a:	8a2a                	mv	s4,a0
 15c:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 15e:	4785                	li	a5,1
 160:	00000497          	auipc	s1,0x0
 164:	58048493          	addi	s1,s1,1408 # 6e0 <rings+0x10>
 168:	00000917          	auipc	s2,0x0
 16c:	66890913          	addi	s2,s2,1640 # 7d0 <__BSS_END__+0x10>
 170:	04f59563          	bne	a1,a5,1ba <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 174:	00000497          	auipc	s1,0x0
 178:	56c4a483          	lw	s1,1388(s1) # 6e0 <rings+0x10>
 17c:	c099                	beqz	s1,182 <create_or_close_the_buffer_user+0x38>
 17e:	4481                	li	s1,0
 180:	a899                	j	1d6 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 182:	00000917          	auipc	s2,0x0
 186:	54e90913          	addi	s2,s2,1358 # 6d0 <rings>
 18a:	00093603          	ld	a2,0(s2)
 18e:	4585                	li	a1,1
 190:	00000097          	auipc	ra,0x0
 194:	4c6080e7          	jalr	1222(ra) # 656 <ringbuf>
        rings[i].book->write_done = 0;
 198:	00893783          	ld	a5,8(s2)
 19c:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 1a0:	00893783          	ld	a5,8(s2)
 1a4:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 1a8:	01092783          	lw	a5,16(s2)
 1ac:	2785                	addiw	a5,a5,1
 1ae:	00f92823          	sw	a5,16(s2)
        break;
 1b2:	a015                	j	1d6 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 1b4:	04e1                	addi	s1,s1,24
 1b6:	01248f63          	beq	s1,s2,1d4 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 1ba:	409c                	lw	a5,0(s1)
 1bc:	dfe5                	beqz	a5,1b4 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 1be:	ff04b603          	ld	a2,-16(s1)
 1c2:	85ce                	mv	a1,s3
 1c4:	8552                	mv	a0,s4
 1c6:	00000097          	auipc	ra,0x0
 1ca:	490080e7          	jalr	1168(ra) # 656 <ringbuf>
        rings[i].exists = 0;
 1ce:	0004a023          	sw	zero,0(s1)
 1d2:	b7cd                	j	1b4 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 1d4:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 1d6:	8526                	mv	a0,s1
 1d8:	70a2                	ld	ra,40(sp)
 1da:	7402                	ld	s0,32(sp)
 1dc:	64e2                	ld	s1,24(sp)
 1de:	6942                	ld	s2,16(sp)
 1e0:	69a2                	ld	s3,8(sp)
 1e2:	6a02                	ld	s4,0(sp)
 1e4:	6145                	addi	sp,sp,48
 1e6:	8082                	ret

00000000000001e8 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 1e8:	1101                	addi	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e426                	sd	s1,8(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 1f4:	00151793          	slli	a5,a0,0x1
 1f8:	97aa                	add	a5,a5,a0
 1fa:	078e                	slli	a5,a5,0x3
 1fc:	00000717          	auipc	a4,0x0
 200:	4d470713          	addi	a4,a4,1236 # 6d0 <rings>
 204:	97ba                	add	a5,a5,a4
 206:	639c                	ld	a5,0(a5)
 208:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 20a:	421c                	lw	a5,0(a2)
 20c:	e785                	bnez	a5,234 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 20e:	86ba                	mv	a3,a4
 210:	671c                	ld	a5,8(a4)
 212:	6398                	ld	a4,0(a5)
 214:	67c1                	lui	a5,0x10
 216:	9fb9                	addw	a5,a5,a4
 218:	00151713          	slli	a4,a0,0x1
 21c:	953a                	add	a0,a0,a4
 21e:	050e                	slli	a0,a0,0x3
 220:	9536                	add	a0,a0,a3
 222:	6518                	ld	a4,8(a0)
 224:	6718                	ld	a4,8(a4)
 226:	9f99                	subw	a5,a5,a4
 228:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 22a:	60e2                	ld	ra,24(sp)
 22c:	6442                	ld	s0,16(sp)
 22e:	64a2                	ld	s1,8(sp)
 230:	6105                	addi	sp,sp,32
 232:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 234:	00151793          	slli	a5,a0,0x1
 238:	953e                	add	a0,a0,a5
 23a:	050e                	slli	a0,a0,0x3
 23c:	00000797          	auipc	a5,0x0
 240:	49478793          	addi	a5,a5,1172 # 6d0 <rings>
 244:	953e                	add	a0,a0,a5
 246:	6508                	ld	a0,8(a0)
 248:	0521                	addi	a0,a0,8
 24a:	00000097          	auipc	ra,0x0
 24e:	ee8080e7          	jalr	-280(ra) # 132 <load>
 252:	c088                	sw	a0,0(s1)
}
 254:	bfd9                	j	22a <ringbuf_start_write+0x42>

0000000000000256 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 256:	1141                	addi	sp,sp,-16
 258:	e406                	sd	ra,8(sp)
 25a:	e022                	sd	s0,0(sp)
 25c:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 25e:	00151793          	slli	a5,a0,0x1
 262:	97aa                	add	a5,a5,a0
 264:	078e                	slli	a5,a5,0x3
 266:	00000517          	auipc	a0,0x0
 26a:	46a50513          	addi	a0,a0,1130 # 6d0 <rings>
 26e:	97aa                	add	a5,a5,a0
 270:	6788                	ld	a0,8(a5)
 272:	0035959b          	slliw	a1,a1,0x3
 276:	0521                	addi	a0,a0,8
 278:	00000097          	auipc	ra,0x0
 27c:	ea6080e7          	jalr	-346(ra) # 11e <store>
}
 280:	60a2                	ld	ra,8(sp)
 282:	6402                	ld	s0,0(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 288:	1101                	addi	sp,sp,-32
 28a:	ec06                	sd	ra,24(sp)
 28c:	e822                	sd	s0,16(sp)
 28e:	e426                	sd	s1,8(sp)
 290:	1000                	addi	s0,sp,32
 292:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 294:	00151793          	slli	a5,a0,0x1
 298:	97aa                	add	a5,a5,a0
 29a:	078e                	slli	a5,a5,0x3
 29c:	00000517          	auipc	a0,0x0
 2a0:	43450513          	addi	a0,a0,1076 # 6d0 <rings>
 2a4:	97aa                	add	a5,a5,a0
 2a6:	6788                	ld	a0,8(a5)
 2a8:	0521                	addi	a0,a0,8
 2aa:	00000097          	auipc	ra,0x0
 2ae:	e88080e7          	jalr	-376(ra) # 132 <load>
 2b2:	c088                	sw	a0,0(s1)
}
 2b4:	60e2                	ld	ra,24(sp)
 2b6:	6442                	ld	s0,16(sp)
 2b8:	64a2                	ld	s1,8(sp)
 2ba:	6105                	addi	sp,sp,32
 2bc:	8082                	ret

00000000000002be <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e426                	sd	s1,8(sp)
 2c6:	1000                	addi	s0,sp,32
 2c8:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 2ca:	00151793          	slli	a5,a0,0x1
 2ce:	97aa                	add	a5,a5,a0
 2d0:	078e                	slli	a5,a5,0x3
 2d2:	00000517          	auipc	a0,0x0
 2d6:	3fe50513          	addi	a0,a0,1022 # 6d0 <rings>
 2da:	97aa                	add	a5,a5,a0
 2dc:	6788                	ld	a0,8(a5)
 2de:	611c                	ld	a5,0(a0)
 2e0:	ef99                	bnez	a5,2fe <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2e2:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2e4:	41f7579b          	sraiw	a5,a4,0x1f
 2e8:	01d7d79b          	srliw	a5,a5,0x1d
 2ec:	9fb9                	addw	a5,a5,a4
 2ee:	4037d79b          	sraiw	a5,a5,0x3
 2f2:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 2f4:	60e2                	ld	ra,24(sp)
 2f6:	6442                	ld	s0,16(sp)
 2f8:	64a2                	ld	s1,8(sp)
 2fa:	6105                	addi	sp,sp,32
 2fc:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 2fe:	00000097          	auipc	ra,0x0
 302:	e34080e7          	jalr	-460(ra) # 132 <load>
    *bytes /= 8;
 306:	41f5579b          	sraiw	a5,a0,0x1f
 30a:	01d7d79b          	srliw	a5,a5,0x1d
 30e:	9d3d                	addw	a0,a0,a5
 310:	4035551b          	sraiw	a0,a0,0x3
 314:	c088                	sw	a0,0(s1)
}
 316:	bff9                	j	2f4 <ringbuf_start_read+0x36>

0000000000000318 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 318:	1141                	addi	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 320:	00151793          	slli	a5,a0,0x1
 324:	97aa                	add	a5,a5,a0
 326:	078e                	slli	a5,a5,0x3
 328:	00000517          	auipc	a0,0x0
 32c:	3a850513          	addi	a0,a0,936 # 6d0 <rings>
 330:	97aa                	add	a5,a5,a0
 332:	0035959b          	slliw	a1,a1,0x3
 336:	6788                	ld	a0,8(a5)
 338:	00000097          	auipc	ra,0x0
 33c:	de6080e7          	jalr	-538(ra) # 11e <store>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 348:	1141                	addi	sp,sp,-16
 34a:	e422                	sd	s0,8(sp)
 34c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 34e:	87aa                	mv	a5,a0
 350:	0585                	addi	a1,a1,1
 352:	0785                	addi	a5,a5,1
 354:	fff5c703          	lbu	a4,-1(a1)
 358:	fee78fa3          	sb	a4,-1(a5)
 35c:	fb75                	bnez	a4,350 <strcpy+0x8>
    ;
  return os;
}
 35e:	6422                	ld	s0,8(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 364:	1141                	addi	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 36a:	00054783          	lbu	a5,0(a0)
 36e:	cb91                	beqz	a5,382 <strcmp+0x1e>
 370:	0005c703          	lbu	a4,0(a1)
 374:	00f71763          	bne	a4,a5,382 <strcmp+0x1e>
    p++, q++;
 378:	0505                	addi	a0,a0,1
 37a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 37c:	00054783          	lbu	a5,0(a0)
 380:	fbe5                	bnez	a5,370 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 382:	0005c503          	lbu	a0,0(a1)
}
 386:	40a7853b          	subw	a0,a5,a0
 38a:	6422                	ld	s0,8(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <strlen>:

uint
strlen(const char *s)
{
 390:	1141                	addi	sp,sp,-16
 392:	e422                	sd	s0,8(sp)
 394:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 396:	00054783          	lbu	a5,0(a0)
 39a:	cf91                	beqz	a5,3b6 <strlen+0x26>
 39c:	0505                	addi	a0,a0,1
 39e:	87aa                	mv	a5,a0
 3a0:	4685                	li	a3,1
 3a2:	9e89                	subw	a3,a3,a0
 3a4:	00f6853b          	addw	a0,a3,a5
 3a8:	0785                	addi	a5,a5,1
 3aa:	fff7c703          	lbu	a4,-1(a5)
 3ae:	fb7d                	bnez	a4,3a4 <strlen+0x14>
    ;
  return n;
}
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret
  for(n = 0; s[n]; n++)
 3b6:	4501                	li	a0,0
 3b8:	bfe5                	j	3b0 <strlen+0x20>

00000000000003ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 3ba:	1141                	addi	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3c0:	ca19                	beqz	a2,3d6 <memset+0x1c>
 3c2:	87aa                	mv	a5,a0
 3c4:	1602                	slli	a2,a2,0x20
 3c6:	9201                	srli	a2,a2,0x20
 3c8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3cc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3d0:	0785                	addi	a5,a5,1
 3d2:	fee79de3          	bne	a5,a4,3cc <memset+0x12>
  }
  return dst;
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret

00000000000003dc <strchr>:

char*
strchr(const char *s, char c)
{
 3dc:	1141                	addi	sp,sp,-16
 3de:	e422                	sd	s0,8(sp)
 3e0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3e2:	00054783          	lbu	a5,0(a0)
 3e6:	cb99                	beqz	a5,3fc <strchr+0x20>
    if(*s == c)
 3e8:	00f58763          	beq	a1,a5,3f6 <strchr+0x1a>
  for(; *s; s++)
 3ec:	0505                	addi	a0,a0,1
 3ee:	00054783          	lbu	a5,0(a0)
 3f2:	fbfd                	bnez	a5,3e8 <strchr+0xc>
      return (char*)s;
  return 0;
 3f4:	4501                	li	a0,0
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret
  return 0;
 3fc:	4501                	li	a0,0
 3fe:	bfe5                	j	3f6 <strchr+0x1a>

0000000000000400 <gets>:

char*
gets(char *buf, int max)
{
 400:	711d                	addi	sp,sp,-96
 402:	ec86                	sd	ra,88(sp)
 404:	e8a2                	sd	s0,80(sp)
 406:	e4a6                	sd	s1,72(sp)
 408:	e0ca                	sd	s2,64(sp)
 40a:	fc4e                	sd	s3,56(sp)
 40c:	f852                	sd	s4,48(sp)
 40e:	f456                	sd	s5,40(sp)
 410:	f05a                	sd	s6,32(sp)
 412:	ec5e                	sd	s7,24(sp)
 414:	1080                	addi	s0,sp,96
 416:	8baa                	mv	s7,a0
 418:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 41a:	892a                	mv	s2,a0
 41c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 41e:	4aa9                	li	s5,10
 420:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 422:	89a6                	mv	s3,s1
 424:	2485                	addiw	s1,s1,1
 426:	0344d863          	bge	s1,s4,456 <gets+0x56>
    cc = read(0, &c, 1);
 42a:	4605                	li	a2,1
 42c:	faf40593          	addi	a1,s0,-81
 430:	4501                	li	a0,0
 432:	00000097          	auipc	ra,0x0
 436:	19c080e7          	jalr	412(ra) # 5ce <read>
    if(cc < 1)
 43a:	00a05e63          	blez	a0,456 <gets+0x56>
    buf[i++] = c;
 43e:	faf44783          	lbu	a5,-81(s0)
 442:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 446:	01578763          	beq	a5,s5,454 <gets+0x54>
 44a:	0905                	addi	s2,s2,1
 44c:	fd679be3          	bne	a5,s6,422 <gets+0x22>
  for(i=0; i+1 < max; ){
 450:	89a6                	mv	s3,s1
 452:	a011                	j	456 <gets+0x56>
 454:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 456:	99de                	add	s3,s3,s7
 458:	00098023          	sb	zero,0(s3)
  return buf;
}
 45c:	855e                	mv	a0,s7
 45e:	60e6                	ld	ra,88(sp)
 460:	6446                	ld	s0,80(sp)
 462:	64a6                	ld	s1,72(sp)
 464:	6906                	ld	s2,64(sp)
 466:	79e2                	ld	s3,56(sp)
 468:	7a42                	ld	s4,48(sp)
 46a:	7aa2                	ld	s5,40(sp)
 46c:	7b02                	ld	s6,32(sp)
 46e:	6be2                	ld	s7,24(sp)
 470:	6125                	addi	sp,sp,96
 472:	8082                	ret

0000000000000474 <stat>:

int
stat(const char *n, struct stat *st)
{
 474:	1101                	addi	sp,sp,-32
 476:	ec06                	sd	ra,24(sp)
 478:	e822                	sd	s0,16(sp)
 47a:	e426                	sd	s1,8(sp)
 47c:	e04a                	sd	s2,0(sp)
 47e:	1000                	addi	s0,sp,32
 480:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 482:	4581                	li	a1,0
 484:	00000097          	auipc	ra,0x0
 488:	172080e7          	jalr	370(ra) # 5f6 <open>
  if(fd < 0)
 48c:	02054563          	bltz	a0,4b6 <stat+0x42>
 490:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 492:	85ca                	mv	a1,s2
 494:	00000097          	auipc	ra,0x0
 498:	17a080e7          	jalr	378(ra) # 60e <fstat>
 49c:	892a                	mv	s2,a0
  close(fd);
 49e:	8526                	mv	a0,s1
 4a0:	00000097          	auipc	ra,0x0
 4a4:	13e080e7          	jalr	318(ra) # 5de <close>
  return r;
}
 4a8:	854a                	mv	a0,s2
 4aa:	60e2                	ld	ra,24(sp)
 4ac:	6442                	ld	s0,16(sp)
 4ae:	64a2                	ld	s1,8(sp)
 4b0:	6902                	ld	s2,0(sp)
 4b2:	6105                	addi	sp,sp,32
 4b4:	8082                	ret
    return -1;
 4b6:	597d                	li	s2,-1
 4b8:	bfc5                	j	4a8 <stat+0x34>

00000000000004ba <atoi>:

int
atoi(const char *s)
{
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e422                	sd	s0,8(sp)
 4be:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c0:	00054603          	lbu	a2,0(a0)
 4c4:	fd06079b          	addiw	a5,a2,-48
 4c8:	0ff7f793          	zext.b	a5,a5
 4cc:	4725                	li	a4,9
 4ce:	02f76963          	bltu	a4,a5,500 <atoi+0x46>
 4d2:	86aa                	mv	a3,a0
  n = 0;
 4d4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4d6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4d8:	0685                	addi	a3,a3,1
 4da:	0025179b          	slliw	a5,a0,0x2
 4de:	9fa9                	addw	a5,a5,a0
 4e0:	0017979b          	slliw	a5,a5,0x1
 4e4:	9fb1                	addw	a5,a5,a2
 4e6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4ea:	0006c603          	lbu	a2,0(a3)
 4ee:	fd06071b          	addiw	a4,a2,-48
 4f2:	0ff77713          	zext.b	a4,a4
 4f6:	fee5f1e3          	bgeu	a1,a4,4d8 <atoi+0x1e>
  return n;
}
 4fa:	6422                	ld	s0,8(sp)
 4fc:	0141                	addi	sp,sp,16
 4fe:	8082                	ret
  n = 0;
 500:	4501                	li	a0,0
 502:	bfe5                	j	4fa <atoi+0x40>

0000000000000504 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 504:	1141                	addi	sp,sp,-16
 506:	e422                	sd	s0,8(sp)
 508:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 50a:	02b57463          	bgeu	a0,a1,532 <memmove+0x2e>
    while(n-- > 0)
 50e:	00c05f63          	blez	a2,52c <memmove+0x28>
 512:	1602                	slli	a2,a2,0x20
 514:	9201                	srli	a2,a2,0x20
 516:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 51a:	872a                	mv	a4,a0
      *dst++ = *src++;
 51c:	0585                	addi	a1,a1,1
 51e:	0705                	addi	a4,a4,1
 520:	fff5c683          	lbu	a3,-1(a1)
 524:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 528:	fee79ae3          	bne	a5,a4,51c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret
    dst += n;
 532:	00c50733          	add	a4,a0,a2
    src += n;
 536:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 538:	fec05ae3          	blez	a2,52c <memmove+0x28>
 53c:	fff6079b          	addiw	a5,a2,-1
 540:	1782                	slli	a5,a5,0x20
 542:	9381                	srli	a5,a5,0x20
 544:	fff7c793          	not	a5,a5
 548:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 54a:	15fd                	addi	a1,a1,-1
 54c:	177d                	addi	a4,a4,-1
 54e:	0005c683          	lbu	a3,0(a1)
 552:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 556:	fee79ae3          	bne	a5,a4,54a <memmove+0x46>
 55a:	bfc9                	j	52c <memmove+0x28>

000000000000055c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 55c:	1141                	addi	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 562:	ca05                	beqz	a2,592 <memcmp+0x36>
 564:	fff6069b          	addiw	a3,a2,-1
 568:	1682                	slli	a3,a3,0x20
 56a:	9281                	srli	a3,a3,0x20
 56c:	0685                	addi	a3,a3,1
 56e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 570:	00054783          	lbu	a5,0(a0)
 574:	0005c703          	lbu	a4,0(a1)
 578:	00e79863          	bne	a5,a4,588 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 57c:	0505                	addi	a0,a0,1
    p2++;
 57e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 580:	fed518e3          	bne	a0,a3,570 <memcmp+0x14>
  }
  return 0;
 584:	4501                	li	a0,0
 586:	a019                	j	58c <memcmp+0x30>
      return *p1 - *p2;
 588:	40e7853b          	subw	a0,a5,a4
}
 58c:	6422                	ld	s0,8(sp)
 58e:	0141                	addi	sp,sp,16
 590:	8082                	ret
  return 0;
 592:	4501                	li	a0,0
 594:	bfe5                	j	58c <memcmp+0x30>

0000000000000596 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 596:	1141                	addi	sp,sp,-16
 598:	e406                	sd	ra,8(sp)
 59a:	e022                	sd	s0,0(sp)
 59c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 59e:	00000097          	auipc	ra,0x0
 5a2:	f66080e7          	jalr	-154(ra) # 504 <memmove>
}
 5a6:	60a2                	ld	ra,8(sp)
 5a8:	6402                	ld	s0,0(sp)
 5aa:	0141                	addi	sp,sp,16
 5ac:	8082                	ret

00000000000005ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5ae:	4885                	li	a7,1
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b6:	4889                	li	a7,2
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <wait>:
.global wait
wait:
 li a7, SYS_wait
 5be:	488d                	li	a7,3
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c6:	4891                	li	a7,4
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <read>:
.global read
read:
 li a7, SYS_read
 5ce:	4895                	li	a7,5
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <write>:
.global write
write:
 li a7, SYS_write
 5d6:	48c1                	li	a7,16
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <close>:
.global close
close:
 li a7, SYS_close
 5de:	48d5                	li	a7,21
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e6:	4899                	li	a7,6
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ee:	489d                	li	a7,7
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <open>:
.global open
open:
 li a7, SYS_open
 5f6:	48bd                	li	a7,15
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5fe:	48c5                	li	a7,17
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 606:	48c9                	li	a7,18
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 60e:	48a1                	li	a7,8
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <link>:
.global link
link:
 li a7, SYS_link
 616:	48cd                	li	a7,19
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 61e:	48d1                	li	a7,20
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 626:	48a5                	li	a7,9
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <dup>:
.global dup
dup:
 li a7, SYS_dup
 62e:	48a9                	li	a7,10
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 636:	48ad                	li	a7,11
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 63e:	48b1                	li	a7,12
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 646:	48b5                	li	a7,13
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 64e:	48b9                	li	a7,14
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 656:	48d9                	li	a7,22
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret
