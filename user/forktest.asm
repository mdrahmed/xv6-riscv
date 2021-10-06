
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
  10:	39c080e7          	jalr	924(ra) # 3a8 <strlen>
  14:	0005061b          	sext.w	a2,a0
  18:	85a6                	mv	a1,s1
  1a:	4505                	li	a0,1
  1c:	00000097          	auipc	ra,0x0
  20:	5d2080e7          	jalr	1490(ra) # 5ee <write>
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
  3e:	63e50513          	addi	a0,a0,1598 # 678 <ringbuf+0xa>
  42:	00000097          	auipc	ra,0x0
  46:	fbe080e7          	jalr	-66(ra) # 0 <print>

  for(n=0; n<N; n++){
  4a:	4481                	li	s1,0
  4c:	3e800913          	li	s2,1000
    pid = fork();
  50:	00000097          	auipc	ra,0x0
  54:	576080e7          	jalr	1398(ra) # 5c6 <fork>
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
  68:	62450513          	addi	a0,a0,1572 # 688 <ringbuf+0x1a>
  6c:	00000097          	auipc	ra,0x0
  70:	f94080e7          	jalr	-108(ra) # 0 <print>
    exit(1);
  74:	4505                	li	a0,1
  76:	00000097          	auipc	ra,0x0
  7a:	558080e7          	jalr	1368(ra) # 5ce <exit>
      exit(0);
  7e:	00000097          	auipc	ra,0x0
  82:	550080e7          	jalr	1360(ra) # 5ce <exit>
  if(n == N){
  86:	3e800793          	li	a5,1000
  8a:	fcf48de3          	beq	s1,a5,64 <forktest+0x36>
  }

  for(; n > 0; n--){
  8e:	00905b63          	blez	s1,a4 <forktest+0x76>
    if(wait(0) < 0){
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	542080e7          	jalr	1346(ra) # 5d6 <wait>
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
  aa:	530080e7          	jalr	1328(ra) # 5d6 <wait>
  ae:	57fd                	li	a5,-1
  b0:	02f51d63          	bne	a0,a5,ea <forktest+0xbc>
    print("wait got too many\n");
    exit(1);
  }

  print("fork test OK\n");
  b4:	00000517          	auipc	a0,0x0
  b8:	62450513          	addi	a0,a0,1572 # 6d8 <ringbuf+0x6a>
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
  d4:	5d850513          	addi	a0,a0,1496 # 6a8 <ringbuf+0x3a>
  d8:	00000097          	auipc	ra,0x0
  dc:	f28080e7          	jalr	-216(ra) # 0 <print>
      exit(1);
  e0:	4505                	li	a0,1
  e2:	00000097          	auipc	ra,0x0
  e6:	4ec080e7          	jalr	1260(ra) # 5ce <exit>
    print("wait got too many\n");
  ea:	00000517          	auipc	a0,0x0
  ee:	5d650513          	addi	a0,a0,1494 # 6c0 <ringbuf+0x52>
  f2:	00000097          	auipc	ra,0x0
  f6:	f0e080e7          	jalr	-242(ra) # 0 <print>
    exit(1);
  fa:	4505                	li	a0,1
  fc:	00000097          	auipc	ra,0x0
 100:	4d2080e7          	jalr	1234(ra) # 5ce <exit>

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
 11a:	4b8080e7          	jalr	1208(ra) # 5ce <exit>

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
 164:	59848493          	addi	s1,s1,1432 # 6f8 <rings+0x10>
 168:	00000917          	auipc	s2,0x0
 16c:	68090913          	addi	s2,s2,1664 # 7e8 <__BSS_END__+0x10>
 170:	04f59563          	bne	a1,a5,1ba <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 174:	00000497          	auipc	s1,0x0
 178:	5844a483          	lw	s1,1412(s1) # 6f8 <rings+0x10>
 17c:	c099                	beqz	s1,182 <create_or_close_the_buffer_user+0x38>
 17e:	4481                	li	s1,0
 180:	a899                	j	1d6 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 182:	00000917          	auipc	s2,0x0
 186:	56690913          	addi	s2,s2,1382 # 6e8 <rings>
 18a:	00093603          	ld	a2,0(s2)
 18e:	4585                	li	a1,1
 190:	00000097          	auipc	ra,0x0
 194:	4de080e7          	jalr	1246(ra) # 66e <ringbuf>
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
 1ca:	4a8080e7          	jalr	1192(ra) # 66e <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 1e8:	1101                	addi	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e426                	sd	s1,8(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 1f4:	00151793          	slli	a5,a0,0x1
 1f8:	97aa                	add	a5,a5,a0
 1fa:	078e                	slli	a5,a5,0x3
 1fc:	00000717          	auipc	a4,0x0
 200:	4ec70713          	addi	a4,a4,1260 # 6e8 <rings>
 204:	97ba                	add	a5,a5,a4
 206:	6798                	ld	a4,8(a5)
 208:	671c                	ld	a5,8(a4)
 20a:	00178693          	addi	a3,a5,1
 20e:	e714                	sd	a3,8(a4)
 210:	17d2                	slli	a5,a5,0x34
 212:	93d1                	srli	a5,a5,0x34
 214:	6741                	lui	a4,0x10
 216:	40f707b3          	sub	a5,a4,a5
 21a:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 21c:	421c                	lw	a5,0(a2)
 21e:	e79d                	bnez	a5,24c <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 220:	00000697          	auipc	a3,0x0
 224:	4c868693          	addi	a3,a3,1224 # 6e8 <rings>
 228:	669c                	ld	a5,8(a3)
 22a:	6398                	ld	a4,0(a5)
 22c:	67c1                	lui	a5,0x10
 22e:	9fb9                	addw	a5,a5,a4
 230:	00151713          	slli	a4,a0,0x1
 234:	953a                	add	a0,a0,a4
 236:	050e                	slli	a0,a0,0x3
 238:	9536                	add	a0,a0,a3
 23a:	6518                	ld	a4,8(a0)
 23c:	6718                	ld	a4,8(a4)
 23e:	9f99                	subw	a5,a5,a4
 240:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 242:	60e2                	ld	ra,24(sp)
 244:	6442                	ld	s0,16(sp)
 246:	64a2                	ld	s1,8(sp)
 248:	6105                	addi	sp,sp,32
 24a:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 24c:	00151793          	slli	a5,a0,0x1
 250:	953e                	add	a0,a0,a5
 252:	050e                	slli	a0,a0,0x3
 254:	00000797          	auipc	a5,0x0
 258:	49478793          	addi	a5,a5,1172 # 6e8 <rings>
 25c:	953e                	add	a0,a0,a5
 25e:	6508                	ld	a0,8(a0)
 260:	0521                	addi	a0,a0,8
 262:	00000097          	auipc	ra,0x0
 266:	ed0080e7          	jalr	-304(ra) # 132 <load>
 26a:	c088                	sw	a0,0(s1)
}
 26c:	bfd9                	j	242 <ringbuf_start_write+0x5a>

000000000000026e <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 26e:	1141                	addi	sp,sp,-16
 270:	e406                	sd	ra,8(sp)
 272:	e022                	sd	s0,0(sp)
 274:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 276:	00151793          	slli	a5,a0,0x1
 27a:	97aa                	add	a5,a5,a0
 27c:	078e                	slli	a5,a5,0x3
 27e:	00000517          	auipc	a0,0x0
 282:	46a50513          	addi	a0,a0,1130 # 6e8 <rings>
 286:	97aa                	add	a5,a5,a0
 288:	6788                	ld	a0,8(a5)
 28a:	0035959b          	slliw	a1,a1,0x3
 28e:	0521                	addi	a0,a0,8
 290:	00000097          	auipc	ra,0x0
 294:	e8e080e7          	jalr	-370(ra) # 11e <store>
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret

00000000000002a0 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 2a0:	1101                	addi	sp,sp,-32
 2a2:	ec06                	sd	ra,24(sp)
 2a4:	e822                	sd	s0,16(sp)
 2a6:	e426                	sd	s1,8(sp)
 2a8:	1000                	addi	s0,sp,32
 2aa:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 2ac:	00151793          	slli	a5,a0,0x1
 2b0:	97aa                	add	a5,a5,a0
 2b2:	078e                	slli	a5,a5,0x3
 2b4:	00000517          	auipc	a0,0x0
 2b8:	43450513          	addi	a0,a0,1076 # 6e8 <rings>
 2bc:	97aa                	add	a5,a5,a0
 2be:	6788                	ld	a0,8(a5)
 2c0:	0521                	addi	a0,a0,8
 2c2:	00000097          	auipc	ra,0x0
 2c6:	e70080e7          	jalr	-400(ra) # 132 <load>
 2ca:	c088                	sw	a0,0(s1)
}
 2cc:	60e2                	ld	ra,24(sp)
 2ce:	6442                	ld	s0,16(sp)
 2d0:	64a2                	ld	s1,8(sp)
 2d2:	6105                	addi	sp,sp,32
 2d4:	8082                	ret

00000000000002d6 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2d6:	1101                	addi	sp,sp,-32
 2d8:	ec06                	sd	ra,24(sp)
 2da:	e822                	sd	s0,16(sp)
 2dc:	e426                	sd	s1,8(sp)
 2de:	1000                	addi	s0,sp,32
 2e0:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 2e2:	00151793          	slli	a5,a0,0x1
 2e6:	97aa                	add	a5,a5,a0
 2e8:	078e                	slli	a5,a5,0x3
 2ea:	00000517          	auipc	a0,0x0
 2ee:	3fe50513          	addi	a0,a0,1022 # 6e8 <rings>
 2f2:	97aa                	add	a5,a5,a0
 2f4:	6788                	ld	a0,8(a5)
 2f6:	611c                	ld	a5,0(a0)
 2f8:	ef99                	bnez	a5,316 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2fa:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2fc:	41f7579b          	sraiw	a5,a4,0x1f
 300:	01d7d79b          	srliw	a5,a5,0x1d
 304:	9fb9                	addw	a5,a5,a4
 306:	4037d79b          	sraiw	a5,a5,0x3
 30a:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 30c:	60e2                	ld	ra,24(sp)
 30e:	6442                	ld	s0,16(sp)
 310:	64a2                	ld	s1,8(sp)
 312:	6105                	addi	sp,sp,32
 314:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 316:	00000097          	auipc	ra,0x0
 31a:	e1c080e7          	jalr	-484(ra) # 132 <load>
    *bytes /= 8;
 31e:	41f5579b          	sraiw	a5,a0,0x1f
 322:	01d7d79b          	srliw	a5,a5,0x1d
 326:	9d3d                	addw	a0,a0,a5
 328:	4035551b          	sraiw	a0,a0,0x3
 32c:	c088                	sw	a0,0(s1)
}
 32e:	bff9                	j	30c <ringbuf_start_read+0x36>

0000000000000330 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 330:	1141                	addi	sp,sp,-16
 332:	e406                	sd	ra,8(sp)
 334:	e022                	sd	s0,0(sp)
 336:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 338:	00151793          	slli	a5,a0,0x1
 33c:	97aa                	add	a5,a5,a0
 33e:	078e                	slli	a5,a5,0x3
 340:	00000517          	auipc	a0,0x0
 344:	3a850513          	addi	a0,a0,936 # 6e8 <rings>
 348:	97aa                	add	a5,a5,a0
 34a:	0035959b          	slliw	a1,a1,0x3
 34e:	6788                	ld	a0,8(a5)
 350:	00000097          	auipc	ra,0x0
 354:	dce080e7          	jalr	-562(ra) # 11e <store>
}
 358:	60a2                	ld	ra,8(sp)
 35a:	6402                	ld	s0,0(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret

0000000000000360 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 360:	1141                	addi	sp,sp,-16
 362:	e422                	sd	s0,8(sp)
 364:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 366:	87aa                	mv	a5,a0
 368:	0585                	addi	a1,a1,1
 36a:	0785                	addi	a5,a5,1
 36c:	fff5c703          	lbu	a4,-1(a1)
 370:	fee78fa3          	sb	a4,-1(a5)
 374:	fb75                	bnez	a4,368 <strcpy+0x8>
    ;
  return os;
}
 376:	6422                	ld	s0,8(sp)
 378:	0141                	addi	sp,sp,16
 37a:	8082                	ret

000000000000037c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 382:	00054783          	lbu	a5,0(a0)
 386:	cb91                	beqz	a5,39a <strcmp+0x1e>
 388:	0005c703          	lbu	a4,0(a1)
 38c:	00f71763          	bne	a4,a5,39a <strcmp+0x1e>
    p++, q++;
 390:	0505                	addi	a0,a0,1
 392:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 394:	00054783          	lbu	a5,0(a0)
 398:	fbe5                	bnez	a5,388 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 39a:	0005c503          	lbu	a0,0(a1)
}
 39e:	40a7853b          	subw	a0,a5,a0
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <strlen>:

uint
strlen(const char *s)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3ae:	00054783          	lbu	a5,0(a0)
 3b2:	cf91                	beqz	a5,3ce <strlen+0x26>
 3b4:	0505                	addi	a0,a0,1
 3b6:	87aa                	mv	a5,a0
 3b8:	4685                	li	a3,1
 3ba:	9e89                	subw	a3,a3,a0
 3bc:	00f6853b          	addw	a0,a3,a5
 3c0:	0785                	addi	a5,a5,1
 3c2:	fff7c703          	lbu	a4,-1(a5)
 3c6:	fb7d                	bnez	a4,3bc <strlen+0x14>
    ;
  return n;
}
 3c8:	6422                	ld	s0,8(sp)
 3ca:	0141                	addi	sp,sp,16
 3cc:	8082                	ret
  for(n = 0; s[n]; n++)
 3ce:	4501                	li	a0,0
 3d0:	bfe5                	j	3c8 <strlen+0x20>

00000000000003d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d2:	1141                	addi	sp,sp,-16
 3d4:	e422                	sd	s0,8(sp)
 3d6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3d8:	ca19                	beqz	a2,3ee <memset+0x1c>
 3da:	87aa                	mv	a5,a0
 3dc:	1602                	slli	a2,a2,0x20
 3de:	9201                	srli	a2,a2,0x20
 3e0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3e4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3e8:	0785                	addi	a5,a5,1
 3ea:	fee79de3          	bne	a5,a4,3e4 <memset+0x12>
  }
  return dst;
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <strchr>:

char*
strchr(const char *s, char c)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	cb99                	beqz	a5,414 <strchr+0x20>
    if(*s == c)
 400:	00f58763          	beq	a1,a5,40e <strchr+0x1a>
  for(; *s; s++)
 404:	0505                	addi	a0,a0,1
 406:	00054783          	lbu	a5,0(a0)
 40a:	fbfd                	bnez	a5,400 <strchr+0xc>
      return (char*)s;
  return 0;
 40c:	4501                	li	a0,0
}
 40e:	6422                	ld	s0,8(sp)
 410:	0141                	addi	sp,sp,16
 412:	8082                	ret
  return 0;
 414:	4501                	li	a0,0
 416:	bfe5                	j	40e <strchr+0x1a>

0000000000000418 <gets>:

char*
gets(char *buf, int max)
{
 418:	711d                	addi	sp,sp,-96
 41a:	ec86                	sd	ra,88(sp)
 41c:	e8a2                	sd	s0,80(sp)
 41e:	e4a6                	sd	s1,72(sp)
 420:	e0ca                	sd	s2,64(sp)
 422:	fc4e                	sd	s3,56(sp)
 424:	f852                	sd	s4,48(sp)
 426:	f456                	sd	s5,40(sp)
 428:	f05a                	sd	s6,32(sp)
 42a:	ec5e                	sd	s7,24(sp)
 42c:	1080                	addi	s0,sp,96
 42e:	8baa                	mv	s7,a0
 430:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 432:	892a                	mv	s2,a0
 434:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 436:	4aa9                	li	s5,10
 438:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 43a:	89a6                	mv	s3,s1
 43c:	2485                	addiw	s1,s1,1
 43e:	0344d863          	bge	s1,s4,46e <gets+0x56>
    cc = read(0, &c, 1);
 442:	4605                	li	a2,1
 444:	faf40593          	addi	a1,s0,-81
 448:	4501                	li	a0,0
 44a:	00000097          	auipc	ra,0x0
 44e:	19c080e7          	jalr	412(ra) # 5e6 <read>
    if(cc < 1)
 452:	00a05e63          	blez	a0,46e <gets+0x56>
    buf[i++] = c;
 456:	faf44783          	lbu	a5,-81(s0)
 45a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 45e:	01578763          	beq	a5,s5,46c <gets+0x54>
 462:	0905                	addi	s2,s2,1
 464:	fd679be3          	bne	a5,s6,43a <gets+0x22>
  for(i=0; i+1 < max; ){
 468:	89a6                	mv	s3,s1
 46a:	a011                	j	46e <gets+0x56>
 46c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 46e:	99de                	add	s3,s3,s7
 470:	00098023          	sb	zero,0(s3)
  return buf;
}
 474:	855e                	mv	a0,s7
 476:	60e6                	ld	ra,88(sp)
 478:	6446                	ld	s0,80(sp)
 47a:	64a6                	ld	s1,72(sp)
 47c:	6906                	ld	s2,64(sp)
 47e:	79e2                	ld	s3,56(sp)
 480:	7a42                	ld	s4,48(sp)
 482:	7aa2                	ld	s5,40(sp)
 484:	7b02                	ld	s6,32(sp)
 486:	6be2                	ld	s7,24(sp)
 488:	6125                	addi	sp,sp,96
 48a:	8082                	ret

000000000000048c <stat>:

int
stat(const char *n, struct stat *st)
{
 48c:	1101                	addi	sp,sp,-32
 48e:	ec06                	sd	ra,24(sp)
 490:	e822                	sd	s0,16(sp)
 492:	e426                	sd	s1,8(sp)
 494:	e04a                	sd	s2,0(sp)
 496:	1000                	addi	s0,sp,32
 498:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 49a:	4581                	li	a1,0
 49c:	00000097          	auipc	ra,0x0
 4a0:	172080e7          	jalr	370(ra) # 60e <open>
  if(fd < 0)
 4a4:	02054563          	bltz	a0,4ce <stat+0x42>
 4a8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4aa:	85ca                	mv	a1,s2
 4ac:	00000097          	auipc	ra,0x0
 4b0:	17a080e7          	jalr	378(ra) # 626 <fstat>
 4b4:	892a                	mv	s2,a0
  close(fd);
 4b6:	8526                	mv	a0,s1
 4b8:	00000097          	auipc	ra,0x0
 4bc:	13e080e7          	jalr	318(ra) # 5f6 <close>
  return r;
}
 4c0:	854a                	mv	a0,s2
 4c2:	60e2                	ld	ra,24(sp)
 4c4:	6442                	ld	s0,16(sp)
 4c6:	64a2                	ld	s1,8(sp)
 4c8:	6902                	ld	s2,0(sp)
 4ca:	6105                	addi	sp,sp,32
 4cc:	8082                	ret
    return -1;
 4ce:	597d                	li	s2,-1
 4d0:	bfc5                	j	4c0 <stat+0x34>

00000000000004d2 <atoi>:

int
atoi(const char *s)
{
 4d2:	1141                	addi	sp,sp,-16
 4d4:	e422                	sd	s0,8(sp)
 4d6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4d8:	00054603          	lbu	a2,0(a0)
 4dc:	fd06079b          	addiw	a5,a2,-48
 4e0:	0ff7f793          	zext.b	a5,a5
 4e4:	4725                	li	a4,9
 4e6:	02f76963          	bltu	a4,a5,518 <atoi+0x46>
 4ea:	86aa                	mv	a3,a0
  n = 0;
 4ec:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4ee:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4f0:	0685                	addi	a3,a3,1
 4f2:	0025179b          	slliw	a5,a0,0x2
 4f6:	9fa9                	addw	a5,a5,a0
 4f8:	0017979b          	slliw	a5,a5,0x1
 4fc:	9fb1                	addw	a5,a5,a2
 4fe:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 502:	0006c603          	lbu	a2,0(a3)
 506:	fd06071b          	addiw	a4,a2,-48
 50a:	0ff77713          	zext.b	a4,a4
 50e:	fee5f1e3          	bgeu	a1,a4,4f0 <atoi+0x1e>
  return n;
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret
  n = 0;
 518:	4501                	li	a0,0
 51a:	bfe5                	j	512 <atoi+0x40>

000000000000051c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e422                	sd	s0,8(sp)
 520:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 522:	02b57463          	bgeu	a0,a1,54a <memmove+0x2e>
    while(n-- > 0)
 526:	00c05f63          	blez	a2,544 <memmove+0x28>
 52a:	1602                	slli	a2,a2,0x20
 52c:	9201                	srli	a2,a2,0x20
 52e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 532:	872a                	mv	a4,a0
      *dst++ = *src++;
 534:	0585                	addi	a1,a1,1
 536:	0705                	addi	a4,a4,1
 538:	fff5c683          	lbu	a3,-1(a1)
 53c:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xf119>
    while(n-- > 0)
 540:	fee79ae3          	bne	a5,a4,534 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 544:	6422                	ld	s0,8(sp)
 546:	0141                	addi	sp,sp,16
 548:	8082                	ret
    dst += n;
 54a:	00c50733          	add	a4,a0,a2
    src += n;
 54e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 550:	fec05ae3          	blez	a2,544 <memmove+0x28>
 554:	fff6079b          	addiw	a5,a2,-1
 558:	1782                	slli	a5,a5,0x20
 55a:	9381                	srli	a5,a5,0x20
 55c:	fff7c793          	not	a5,a5
 560:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 562:	15fd                	addi	a1,a1,-1
 564:	177d                	addi	a4,a4,-1
 566:	0005c683          	lbu	a3,0(a1)
 56a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 56e:	fee79ae3          	bne	a5,a4,562 <memmove+0x46>
 572:	bfc9                	j	544 <memmove+0x28>

0000000000000574 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 574:	1141                	addi	sp,sp,-16
 576:	e422                	sd	s0,8(sp)
 578:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 57a:	ca05                	beqz	a2,5aa <memcmp+0x36>
 57c:	fff6069b          	addiw	a3,a2,-1
 580:	1682                	slli	a3,a3,0x20
 582:	9281                	srli	a3,a3,0x20
 584:	0685                	addi	a3,a3,1
 586:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 588:	00054783          	lbu	a5,0(a0)
 58c:	0005c703          	lbu	a4,0(a1)
 590:	00e79863          	bne	a5,a4,5a0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 594:	0505                	addi	a0,a0,1
    p2++;
 596:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 598:	fed518e3          	bne	a0,a3,588 <memcmp+0x14>
  }
  return 0;
 59c:	4501                	li	a0,0
 59e:	a019                	j	5a4 <memcmp+0x30>
      return *p1 - *p2;
 5a0:	40e7853b          	subw	a0,a5,a4
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret
  return 0;
 5aa:	4501                	li	a0,0
 5ac:	bfe5                	j	5a4 <memcmp+0x30>

00000000000005ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5ae:	1141                	addi	sp,sp,-16
 5b0:	e406                	sd	ra,8(sp)
 5b2:	e022                	sd	s0,0(sp)
 5b4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5b6:	00000097          	auipc	ra,0x0
 5ba:	f66080e7          	jalr	-154(ra) # 51c <memmove>
}
 5be:	60a2                	ld	ra,8(sp)
 5c0:	6402                	ld	s0,0(sp)
 5c2:	0141                	addi	sp,sp,16
 5c4:	8082                	ret

00000000000005c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c6:	4885                	li	a7,1
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ce:	4889                	li	a7,2
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d6:	488d                	li	a7,3
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5de:	4891                	li	a7,4
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <read>:
.global read
read:
 li a7, SYS_read
 5e6:	4895                	li	a7,5
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <write>:
.global write
write:
 li a7, SYS_write
 5ee:	48c1                	li	a7,16
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <close>:
.global close
close:
 li a7, SYS_close
 5f6:	48d5                	li	a7,21
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 5fe:	4899                	li	a7,6
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <exec>:
.global exec
exec:
 li a7, SYS_exec
 606:	489d                	li	a7,7
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <open>:
.global open
open:
 li a7, SYS_open
 60e:	48bd                	li	a7,15
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 616:	48c5                	li	a7,17
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 61e:	48c9                	li	a7,18
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 626:	48a1                	li	a7,8
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <link>:
.global link
link:
 li a7, SYS_link
 62e:	48cd                	li	a7,19
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 636:	48d1                	li	a7,20
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 63e:	48a5                	li	a7,9
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <dup>:
.global dup
dup:
 li a7, SYS_dup
 646:	48a9                	li	a7,10
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 64e:	48ad                	li	a7,11
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 656:	48b1                	li	a7,12
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 65e:	48b5                	li	a7,13
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 666:	48b9                	li	a7,14
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 66e:	48d9                	li	a7,22
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret
