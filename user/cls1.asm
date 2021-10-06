
user/_cls1:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"

#define SIZE 128

int main()
{
   0:	d8010113          	addi	sp,sp,-640
   4:	26113c23          	sd	ra,632(sp)
   8:	26813823          	sd	s0,624(sp)
   c:	26913423          	sd	s1,616(sp)
  10:	27213023          	sd	s2,608(sp)
  14:	25313c23          	sd	s3,600(sp)
  18:	25413823          	sd	s4,592(sp)
  1c:	25513423          	sd	s5,584(sp)
  20:	25613023          	sd	s6,576(sp)
  24:	23713c23          	sd	s7,568(sp)
  28:	23813823          	sd	s8,560(sp)
  2c:	23913423          	sd	s9,552(sp)
  30:	23a13023          	sd	s10,544(sp)
  34:	21b13c23          	sd	s11,536(sp)
  38:	0500                	addi	s0,sp,640
  int fd[2], current_time=0,elasped_time;
  int cnt=0,check=0;

  if(pipe(fd)==-1){
  3a:	f8840513          	addi	a0,s0,-120
  3e:	00000097          	auipc	ra,0x0
  42:	69e080e7          	jalr	1694(ra) # 6dc <pipe>
  46:	57fd                	li	a5,-1
  48:	04f50c63          	beq	a0,a5,a0 <main+0xa0>
    printf("An error ocurred");
    exit(1);
  }
  int cid = fork();
  4c:	00000097          	auipc	ra,0x0
  50:	678080e7          	jalr	1656(ra) # 6c4 <fork>
  if(cid == 0){
  54:	c13d                	beqz	a0,ba <main+0xba>
        exit(1);
      }
    }
    close(fd[1]);
  }
  else if(cid > 0){
  56:	1aa05663          	blez	a0,202 <main+0x202>
    close(fd[1]);
  5a:	f8c42503          	lw	a0,-116(s0)
  5e:	00000097          	auipc	ra,0x0
  62:	696080e7          	jalr	1686(ra) # 6f4 <close>
    int data1[SIZE] = {0};
  66:	20000613          	li	a2,512
  6a:	4581                	li	a1,0
  6c:	d8840513          	addi	a0,s0,-632
  70:	00000097          	auipc	ra,0x0
  74:	460080e7          	jalr	1120(ra) # 4d0 <memset>
    current_time = uptime();
  78:	00000097          	auipc	ra,0x0
  7c:	6ec080e7          	jalr	1772(ra) # 764 <uptime>
  80:	8daa                	mv	s11,a0
  82:	08000a13          	li	s4,128
  int cnt=0,check=0;
  86:	4a81                	li	s5,0
  88:	4c01                	li	s8,0
    for(int i=0;i<(1024*20);i++){
      int rd = read(fd[0],data1, 512);
      cnt = cnt+rd;
      
      if(rd == -1){
  8a:	5d7d                	li	s10,-1
      }
      int k=0;
      for(int j=(i*128);j<((i+1)*128);j++){
        if(j != data1[k]){
          check = 1;
          printf("An error occured while receiving byte");
  8c:	00001b97          	auipc	s7,0x1
  90:	bdcb8b93          	addi	s7,s7,-1060 # c68 <malloc+0x15e>
          check = 1;
  94:	4b05                	li	s6,1
    for(int i=0;i<(1024*20);i++){
  96:	00280cb7          	lui	s9,0x280
  9a:	080c8c93          	addi	s9,s9,128 # 280080 <__global_pointer$+0x27eb5f>
  9e:	a0ed                	j	188 <main+0x188>
    printf("An error ocurred");
  a0:	00001517          	auipc	a0,0x1
  a4:	b5050513          	addi	a0,a0,-1200 # bf0 <malloc+0xe6>
  a8:	00001097          	auipc	ra,0x1
  ac:	9a4080e7          	jalr	-1628(ra) # a4c <printf>
    exit(1);
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	61a080e7          	jalr	1562(ra) # 6cc <exit>
    close(fd[0]);
  ba:	f8842503          	lw	a0,-120(s0)
  be:	00000097          	auipc	ra,0x0
  c2:	636080e7          	jalr	1590(ra) # 6f4 <close>
    int data[SIZE] = {0};
  c6:	20000613          	li	a2,512
  ca:	4581                	li	a1,0
  cc:	d8840513          	addi	a0,s0,-632
  d0:	00000097          	auipc	ra,0x0
  d4:	400080e7          	jalr	1024(ra) # 4d0 <memset>
  d8:	08000493          	li	s1,128
      if(write(fd[1], data, 512) == -1){
  dc:	59fd                	li	s3,-1
    for(int i=0;i<(1024*20);i++){
  de:	00280937          	lui	s2,0x280
  e2:	08090913          	addi	s2,s2,128 # 280080 <__global_pointer$+0x27eb5f>
  e6:	a00d                	j	108 <main+0x108>
      if(write(fd[1], data, 512) == -1){
  e8:	20000613          	li	a2,512
  ec:	d8840593          	addi	a1,s0,-632
  f0:	f8c42503          	lw	a0,-116(s0)
  f4:	00000097          	auipc	ra,0x0
  f8:	5f8080e7          	jalr	1528(ra) # 6ec <write>
  fc:	03350263          	beq	a0,s3,120 <main+0x120>
    for(int i=0;i<(1024*20);i++){
 100:	0804849b          	addiw	s1,s1,128
 104:	03248b63          	beq	s1,s2,13a <main+0x13a>
      for(int j=(i*128);j<((i+1)*128);j++){
 108:	f804879b          	addiw	a5,s1,-128
 10c:	d8840713          	addi	a4,s0,-632
 110:	0004869b          	sext.w	a3,s1
        data[k] = j;
 114:	c31c                	sw	a5,0(a4)
      for(int j=(i*128);j<((i+1)*128);j++){
 116:	2785                	addiw	a5,a5,1
 118:	0711                	addi	a4,a4,4
 11a:	fed7cde3          	blt	a5,a3,114 <main+0x114>
 11e:	b7e9                	j	e8 <main+0xe8>
        printf("An error occurred while writing the pipe\n");
 120:	00001517          	auipc	a0,0x1
 124:	ae850513          	addi	a0,a0,-1304 # c08 <malloc+0xfe>
 128:	00001097          	auipc	ra,0x1
 12c:	924080e7          	jalr	-1756(ra) # a4c <printf>
        exit(1);
 130:	4505                	li	a0,1
 132:	00000097          	auipc	ra,0x0
 136:	59a080e7          	jalr	1434(ra) # 6cc <exit>
    close(fd[1]);
 13a:	f8c42503          	lw	a0,-116(s0)
 13e:	00000097          	auipc	ra,0x0
 142:	5b6080e7          	jalr	1462(ra) # 6f4 <close>
 146:	a84d                	j	1f8 <main+0x1f8>
        printf("An error occurred while reading the pipe\n");
 148:	00001517          	auipc	a0,0x1
 14c:	af050513          	addi	a0,a0,-1296 # c38 <malloc+0x12e>
 150:	00001097          	auipc	ra,0x1
 154:	8fc080e7          	jalr	-1796(ra) # a4c <printf>
        exit(1);
 158:	4505                	li	a0,1
 15a:	00000097          	auipc	ra,0x0
 15e:	572080e7          	jalr	1394(ra) # 6cc <exit>
      for(int j=(i*128);j<((i+1)*128);j++){
 162:	2485                	addiw	s1,s1,1
 164:	0911                	addi	s2,s2,4
 166:	0134dd63          	bge	s1,s3,180 <main+0x180>
        if(j != data1[k]){
 16a:	00092783          	lw	a5,0(s2)
 16e:	fe978ae3          	beq	a5,s1,162 <main+0x162>
          printf("An error occured while receiving byte");
 172:	855e                	mv	a0,s7
 174:	00001097          	auipc	ra,0x1
 178:	8d8080e7          	jalr	-1832(ra) # a4c <printf>
          check = 1;
 17c:	8ada                	mv	s5,s6
 17e:	b7d5                	j	162 <main+0x162>
    for(int i=0;i<(1024*20);i++){
 180:	080a0a1b          	addiw	s4,s4,128
 184:	039a0763          	beq	s4,s9,1b2 <main+0x1b2>
      int rd = read(fd[0],data1, 512);
 188:	20000613          	li	a2,512
 18c:	d8840593          	addi	a1,s0,-632
 190:	f8842503          	lw	a0,-120(s0)
 194:	00000097          	auipc	ra,0x0
 198:	550080e7          	jalr	1360(ra) # 6e4 <read>
      cnt = cnt+rd;
 19c:	01850c3b          	addw	s8,a0,s8
      if(rd == -1){
 1a0:	fba504e3          	beq	a0,s10,148 <main+0x148>
      for(int j=(i*128);j<((i+1)*128);j++){
 1a4:	f80a049b          	addiw	s1,s4,-128
 1a8:	d8840913          	addi	s2,s0,-632
 1ac:	000a099b          	sext.w	s3,s4
 1b0:	bf6d                	j	16a <main+0x16a>
        }
        k++;
      }
    }
    cid = wait((int *)0);
 1b2:	4501                	li	a0,0
 1b4:	00000097          	auipc	ra,0x0
 1b8:	520080e7          	jalr	1312(ra) # 6d4 <wait>
    printf("Total byte data sent: %d and data perfection is %d\n",cnt, check);
 1bc:	8656                	mv	a2,s5
 1be:	85e2                	mv	a1,s8
 1c0:	00001517          	auipc	a0,0x1
 1c4:	ad050513          	addi	a0,a0,-1328 # c90 <malloc+0x186>
 1c8:	00001097          	auipc	ra,0x1
 1cc:	884080e7          	jalr	-1916(ra) # a4c <printf>
    elasped_time = uptime()-current_time;
 1d0:	00000097          	auipc	ra,0x0
 1d4:	594080e7          	jalr	1428(ra) # 764 <uptime>
    printf("The total ticks are %d\n",elasped_time);
 1d8:	41b505bb          	subw	a1,a0,s11
 1dc:	00001517          	auipc	a0,0x1
 1e0:	aec50513          	addi	a0,a0,-1300 # cc8 <malloc+0x1be>
 1e4:	00001097          	auipc	ra,0x1
 1e8:	868080e7          	jalr	-1944(ra) # a4c <printf>
    close(fd[0]);
 1ec:	f8842503          	lw	a0,-120(s0)
 1f0:	00000097          	auipc	ra,0x0
 1f4:	504080e7          	jalr	1284(ra) # 6f4 <close>
  else{
    printf("An error occurred while forking.");
    exit(1);
  }

  exit(0); //Exiting with 0 error
 1f8:	4501                	li	a0,0
 1fa:	00000097          	auipc	ra,0x0
 1fe:	4d2080e7          	jalr	1234(ra) # 6cc <exit>
    printf("An error occurred while forking.");
 202:	00001517          	auipc	a0,0x1
 206:	ade50513          	addi	a0,a0,-1314 # ce0 <malloc+0x1d6>
 20a:	00001097          	auipc	ra,0x1
 20e:	842080e7          	jalr	-1982(ra) # a4c <printf>
    exit(1);
 212:	4505                	li	a0,1
 214:	00000097          	auipc	ra,0x0
 218:	4b8080e7          	jalr	1208(ra) # 6cc <exit>

000000000000021c <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 21c:	1141                	addi	sp,sp,-16
 21e:	e422                	sd	s0,8(sp)
 220:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 222:	0f50000f          	fence	iorw,ow
 226:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret

0000000000000230 <load>:

int load(uint64 *p) {
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 236:	0ff0000f          	fence
 23a:	6108                	ld	a0,0(a0)
 23c:	0ff0000f          	fence
}
 240:	2501                	sext.w	a0,a0
 242:	6422                	ld	s0,8(sp)
 244:	0141                	addi	sp,sp,16
 246:	8082                	ret

0000000000000248 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 248:	7179                	addi	sp,sp,-48
 24a:	f406                	sd	ra,40(sp)
 24c:	f022                	sd	s0,32(sp)
 24e:	ec26                	sd	s1,24(sp)
 250:	e84a                	sd	s2,16(sp)
 252:	e44e                	sd	s3,8(sp)
 254:	e052                	sd	s4,0(sp)
 256:	1800                	addi	s0,sp,48
 258:	8a2a                	mv	s4,a0
 25a:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 25c:	4785                	li	a5,1
 25e:	00001497          	auipc	s1,0x1
 262:	ae248493          	addi	s1,s1,-1310 # d40 <rings+0x10>
 266:	00001917          	auipc	s2,0x1
 26a:	bca90913          	addi	s2,s2,-1078 # e30 <__BSS_END__>
 26e:	04f59563          	bne	a1,a5,2b8 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 272:	00001497          	auipc	s1,0x1
 276:	ace4a483          	lw	s1,-1330(s1) # d40 <rings+0x10>
 27a:	c099                	beqz	s1,280 <create_or_close_the_buffer_user+0x38>
 27c:	4481                	li	s1,0
 27e:	a899                	j	2d4 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 280:	00001917          	auipc	s2,0x1
 284:	ab090913          	addi	s2,s2,-1360 # d30 <rings>
 288:	00093603          	ld	a2,0(s2)
 28c:	4585                	li	a1,1
 28e:	00000097          	auipc	ra,0x0
 292:	4de080e7          	jalr	1246(ra) # 76c <ringbuf>
        rings[i].book->write_done = 0;
 296:	00893783          	ld	a5,8(s2)
 29a:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 29e:	00893783          	ld	a5,8(s2)
 2a2:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 2a6:	01092783          	lw	a5,16(s2)
 2aa:	2785                	addiw	a5,a5,1
 2ac:	00f92823          	sw	a5,16(s2)
        break;
 2b0:	a015                	j	2d4 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 2b2:	04e1                	addi	s1,s1,24
 2b4:	01248f63          	beq	s1,s2,2d2 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 2b8:	409c                	lw	a5,0(s1)
 2ba:	dfe5                	beqz	a5,2b2 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 2bc:	ff04b603          	ld	a2,-16(s1)
 2c0:	85ce                	mv	a1,s3
 2c2:	8552                	mv	a0,s4
 2c4:	00000097          	auipc	ra,0x0
 2c8:	4a8080e7          	jalr	1192(ra) # 76c <ringbuf>
        rings[i].exists = 0;
 2cc:	0004a023          	sw	zero,0(s1)
 2d0:	b7cd                	j	2b2 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 2d2:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 2d4:	8526                	mv	a0,s1
 2d6:	70a2                	ld	ra,40(sp)
 2d8:	7402                	ld	s0,32(sp)
 2da:	64e2                	ld	s1,24(sp)
 2dc:	6942                	ld	s2,16(sp)
 2de:	69a2                	ld	s3,8(sp)
 2e0:	6a02                	ld	s4,0(sp)
 2e2:	6145                	addi	sp,sp,48
 2e4:	8082                	ret

00000000000002e6 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2e6:	1101                	addi	sp,sp,-32
 2e8:	ec06                	sd	ra,24(sp)
 2ea:	e822                	sd	s0,16(sp)
 2ec:	e426                	sd	s1,8(sp)
 2ee:	1000                	addi	s0,sp,32
 2f0:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 2f2:	00151793          	slli	a5,a0,0x1
 2f6:	97aa                	add	a5,a5,a0
 2f8:	078e                	slli	a5,a5,0x3
 2fa:	00001717          	auipc	a4,0x1
 2fe:	a3670713          	addi	a4,a4,-1482 # d30 <rings>
 302:	97ba                	add	a5,a5,a4
 304:	6798                	ld	a4,8(a5)
 306:	671c                	ld	a5,8(a4)
 308:	00178693          	addi	a3,a5,1
 30c:	e714                	sd	a3,8(a4)
 30e:	17d2                	slli	a5,a5,0x34
 310:	93d1                	srli	a5,a5,0x34
 312:	6741                	lui	a4,0x10
 314:	40f707b3          	sub	a5,a4,a5
 318:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 31a:	421c                	lw	a5,0(a2)
 31c:	e79d                	bnez	a5,34a <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 31e:	00001697          	auipc	a3,0x1
 322:	a1268693          	addi	a3,a3,-1518 # d30 <rings>
 326:	669c                	ld	a5,8(a3)
 328:	6398                	ld	a4,0(a5)
 32a:	67c1                	lui	a5,0x10
 32c:	9fb9                	addw	a5,a5,a4
 32e:	00151713          	slli	a4,a0,0x1
 332:	953a                	add	a0,a0,a4
 334:	050e                	slli	a0,a0,0x3
 336:	9536                	add	a0,a0,a3
 338:	6518                	ld	a4,8(a0)
 33a:	6718                	ld	a4,8(a4)
 33c:	9f99                	subw	a5,a5,a4
 33e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 340:	60e2                	ld	ra,24(sp)
 342:	6442                	ld	s0,16(sp)
 344:	64a2                	ld	s1,8(sp)
 346:	6105                	addi	sp,sp,32
 348:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 34a:	00151793          	slli	a5,a0,0x1
 34e:	953e                	add	a0,a0,a5
 350:	050e                	slli	a0,a0,0x3
 352:	00001797          	auipc	a5,0x1
 356:	9de78793          	addi	a5,a5,-1570 # d30 <rings>
 35a:	953e                	add	a0,a0,a5
 35c:	6508                	ld	a0,8(a0)
 35e:	0521                	addi	a0,a0,8
 360:	00000097          	auipc	ra,0x0
 364:	ed0080e7          	jalr	-304(ra) # 230 <load>
 368:	c088                	sw	a0,0(s1)
}
 36a:	bfd9                	j	340 <ringbuf_start_write+0x5a>

000000000000036c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 36c:	1141                	addi	sp,sp,-16
 36e:	e406                	sd	ra,8(sp)
 370:	e022                	sd	s0,0(sp)
 372:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 374:	00151793          	slli	a5,a0,0x1
 378:	97aa                	add	a5,a5,a0
 37a:	078e                	slli	a5,a5,0x3
 37c:	00001517          	auipc	a0,0x1
 380:	9b450513          	addi	a0,a0,-1612 # d30 <rings>
 384:	97aa                	add	a5,a5,a0
 386:	6788                	ld	a0,8(a5)
 388:	0035959b          	slliw	a1,a1,0x3
 38c:	0521                	addi	a0,a0,8
 38e:	00000097          	auipc	ra,0x0
 392:	e8e080e7          	jalr	-370(ra) # 21c <store>
}
 396:	60a2                	ld	ra,8(sp)
 398:	6402                	ld	s0,0(sp)
 39a:	0141                	addi	sp,sp,16
 39c:	8082                	ret

000000000000039e <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 39e:	1101                	addi	sp,sp,-32
 3a0:	ec06                	sd	ra,24(sp)
 3a2:	e822                	sd	s0,16(sp)
 3a4:	e426                	sd	s1,8(sp)
 3a6:	1000                	addi	s0,sp,32
 3a8:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 3aa:	00151793          	slli	a5,a0,0x1
 3ae:	97aa                	add	a5,a5,a0
 3b0:	078e                	slli	a5,a5,0x3
 3b2:	00001517          	auipc	a0,0x1
 3b6:	97e50513          	addi	a0,a0,-1666 # d30 <rings>
 3ba:	97aa                	add	a5,a5,a0
 3bc:	6788                	ld	a0,8(a5)
 3be:	0521                	addi	a0,a0,8
 3c0:	00000097          	auipc	ra,0x0
 3c4:	e70080e7          	jalr	-400(ra) # 230 <load>
 3c8:	c088                	sw	a0,0(s1)
}
 3ca:	60e2                	ld	ra,24(sp)
 3cc:	6442                	ld	s0,16(sp)
 3ce:	64a2                	ld	s1,8(sp)
 3d0:	6105                	addi	sp,sp,32
 3d2:	8082                	ret

00000000000003d4 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 3d4:	1101                	addi	sp,sp,-32
 3d6:	ec06                	sd	ra,24(sp)
 3d8:	e822                	sd	s0,16(sp)
 3da:	e426                	sd	s1,8(sp)
 3dc:	1000                	addi	s0,sp,32
 3de:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 3e0:	00151793          	slli	a5,a0,0x1
 3e4:	97aa                	add	a5,a5,a0
 3e6:	078e                	slli	a5,a5,0x3
 3e8:	00001517          	auipc	a0,0x1
 3ec:	94850513          	addi	a0,a0,-1720 # d30 <rings>
 3f0:	97aa                	add	a5,a5,a0
 3f2:	6788                	ld	a0,8(a5)
 3f4:	611c                	ld	a5,0(a0)
 3f6:	ef99                	bnez	a5,414 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 3f8:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 3fa:	41f7579b          	sraiw	a5,a4,0x1f
 3fe:	01d7d79b          	srliw	a5,a5,0x1d
 402:	9fb9                	addw	a5,a5,a4
 404:	4037d79b          	sraiw	a5,a5,0x3
 408:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 40a:	60e2                	ld	ra,24(sp)
 40c:	6442                	ld	s0,16(sp)
 40e:	64a2                	ld	s1,8(sp)
 410:	6105                	addi	sp,sp,32
 412:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 414:	00000097          	auipc	ra,0x0
 418:	e1c080e7          	jalr	-484(ra) # 230 <load>
    *bytes /= 8;
 41c:	41f5579b          	sraiw	a5,a0,0x1f
 420:	01d7d79b          	srliw	a5,a5,0x1d
 424:	9d3d                	addw	a0,a0,a5
 426:	4035551b          	sraiw	a0,a0,0x3
 42a:	c088                	sw	a0,0(s1)
}
 42c:	bff9                	j	40a <ringbuf_start_read+0x36>

000000000000042e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 42e:	1141                	addi	sp,sp,-16
 430:	e406                	sd	ra,8(sp)
 432:	e022                	sd	s0,0(sp)
 434:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 436:	00151793          	slli	a5,a0,0x1
 43a:	97aa                	add	a5,a5,a0
 43c:	078e                	slli	a5,a5,0x3
 43e:	00001517          	auipc	a0,0x1
 442:	8f250513          	addi	a0,a0,-1806 # d30 <rings>
 446:	97aa                	add	a5,a5,a0
 448:	0035959b          	slliw	a1,a1,0x3
 44c:	6788                	ld	a0,8(a5)
 44e:	00000097          	auipc	ra,0x0
 452:	dce080e7          	jalr	-562(ra) # 21c <store>
}
 456:	60a2                	ld	ra,8(sp)
 458:	6402                	ld	s0,0(sp)
 45a:	0141                	addi	sp,sp,16
 45c:	8082                	ret

000000000000045e <strcpy>:



char*
strcpy(char *s, const char *t)
{
 45e:	1141                	addi	sp,sp,-16
 460:	e422                	sd	s0,8(sp)
 462:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 464:	87aa                	mv	a5,a0
 466:	0585                	addi	a1,a1,1
 468:	0785                	addi	a5,a5,1
 46a:	fff5c703          	lbu	a4,-1(a1)
 46e:	fee78fa3          	sb	a4,-1(a5)
 472:	fb75                	bnez	a4,466 <strcpy+0x8>
    ;
  return os;
}
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret

000000000000047a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 480:	00054783          	lbu	a5,0(a0)
 484:	cb91                	beqz	a5,498 <strcmp+0x1e>
 486:	0005c703          	lbu	a4,0(a1)
 48a:	00f71763          	bne	a4,a5,498 <strcmp+0x1e>
    p++, q++;
 48e:	0505                	addi	a0,a0,1
 490:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 492:	00054783          	lbu	a5,0(a0)
 496:	fbe5                	bnez	a5,486 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 498:	0005c503          	lbu	a0,0(a1)
}
 49c:	40a7853b          	subw	a0,a5,a0
 4a0:	6422                	ld	s0,8(sp)
 4a2:	0141                	addi	sp,sp,16
 4a4:	8082                	ret

00000000000004a6 <strlen>:

uint
strlen(const char *s)
{
 4a6:	1141                	addi	sp,sp,-16
 4a8:	e422                	sd	s0,8(sp)
 4aa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4ac:	00054783          	lbu	a5,0(a0)
 4b0:	cf91                	beqz	a5,4cc <strlen+0x26>
 4b2:	0505                	addi	a0,a0,1
 4b4:	87aa                	mv	a5,a0
 4b6:	4685                	li	a3,1
 4b8:	9e89                	subw	a3,a3,a0
 4ba:	00f6853b          	addw	a0,a3,a5
 4be:	0785                	addi	a5,a5,1
 4c0:	fff7c703          	lbu	a4,-1(a5)
 4c4:	fb7d                	bnez	a4,4ba <strlen+0x14>
    ;
  return n;
}
 4c6:	6422                	ld	s0,8(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret
  for(n = 0; s[n]; n++)
 4cc:	4501                	li	a0,0
 4ce:	bfe5                	j	4c6 <strlen+0x20>

00000000000004d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4d0:	1141                	addi	sp,sp,-16
 4d2:	e422                	sd	s0,8(sp)
 4d4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4d6:	ca19                	beqz	a2,4ec <memset+0x1c>
 4d8:	87aa                	mv	a5,a0
 4da:	1602                	slli	a2,a2,0x20
 4dc:	9201                	srli	a2,a2,0x20
 4de:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4e2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4e6:	0785                	addi	a5,a5,1
 4e8:	fee79de3          	bne	a5,a4,4e2 <memset+0x12>
  }
  return dst;
}
 4ec:	6422                	ld	s0,8(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret

00000000000004f2 <strchr>:

char*
strchr(const char *s, char c)
{
 4f2:	1141                	addi	sp,sp,-16
 4f4:	e422                	sd	s0,8(sp)
 4f6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4f8:	00054783          	lbu	a5,0(a0)
 4fc:	cb99                	beqz	a5,512 <strchr+0x20>
    if(*s == c)
 4fe:	00f58763          	beq	a1,a5,50c <strchr+0x1a>
  for(; *s; s++)
 502:	0505                	addi	a0,a0,1
 504:	00054783          	lbu	a5,0(a0)
 508:	fbfd                	bnez	a5,4fe <strchr+0xc>
      return (char*)s;
  return 0;
 50a:	4501                	li	a0,0
}
 50c:	6422                	ld	s0,8(sp)
 50e:	0141                	addi	sp,sp,16
 510:	8082                	ret
  return 0;
 512:	4501                	li	a0,0
 514:	bfe5                	j	50c <strchr+0x1a>

0000000000000516 <gets>:

char*
gets(char *buf, int max)
{
 516:	711d                	addi	sp,sp,-96
 518:	ec86                	sd	ra,88(sp)
 51a:	e8a2                	sd	s0,80(sp)
 51c:	e4a6                	sd	s1,72(sp)
 51e:	e0ca                	sd	s2,64(sp)
 520:	fc4e                	sd	s3,56(sp)
 522:	f852                	sd	s4,48(sp)
 524:	f456                	sd	s5,40(sp)
 526:	f05a                	sd	s6,32(sp)
 528:	ec5e                	sd	s7,24(sp)
 52a:	1080                	addi	s0,sp,96
 52c:	8baa                	mv	s7,a0
 52e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 530:	892a                	mv	s2,a0
 532:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 534:	4aa9                	li	s5,10
 536:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 538:	89a6                	mv	s3,s1
 53a:	2485                	addiw	s1,s1,1
 53c:	0344d863          	bge	s1,s4,56c <gets+0x56>
    cc = read(0, &c, 1);
 540:	4605                	li	a2,1
 542:	faf40593          	addi	a1,s0,-81
 546:	4501                	li	a0,0
 548:	00000097          	auipc	ra,0x0
 54c:	19c080e7          	jalr	412(ra) # 6e4 <read>
    if(cc < 1)
 550:	00a05e63          	blez	a0,56c <gets+0x56>
    buf[i++] = c;
 554:	faf44783          	lbu	a5,-81(s0)
 558:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 55c:	01578763          	beq	a5,s5,56a <gets+0x54>
 560:	0905                	addi	s2,s2,1
 562:	fd679be3          	bne	a5,s6,538 <gets+0x22>
  for(i=0; i+1 < max; ){
 566:	89a6                	mv	s3,s1
 568:	a011                	j	56c <gets+0x56>
 56a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 56c:	99de                	add	s3,s3,s7
 56e:	00098023          	sb	zero,0(s3)
  return buf;
}
 572:	855e                	mv	a0,s7
 574:	60e6                	ld	ra,88(sp)
 576:	6446                	ld	s0,80(sp)
 578:	64a6                	ld	s1,72(sp)
 57a:	6906                	ld	s2,64(sp)
 57c:	79e2                	ld	s3,56(sp)
 57e:	7a42                	ld	s4,48(sp)
 580:	7aa2                	ld	s5,40(sp)
 582:	7b02                	ld	s6,32(sp)
 584:	6be2                	ld	s7,24(sp)
 586:	6125                	addi	sp,sp,96
 588:	8082                	ret

000000000000058a <stat>:

int
stat(const char *n, struct stat *st)
{
 58a:	1101                	addi	sp,sp,-32
 58c:	ec06                	sd	ra,24(sp)
 58e:	e822                	sd	s0,16(sp)
 590:	e426                	sd	s1,8(sp)
 592:	e04a                	sd	s2,0(sp)
 594:	1000                	addi	s0,sp,32
 596:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 598:	4581                	li	a1,0
 59a:	00000097          	auipc	ra,0x0
 59e:	172080e7          	jalr	370(ra) # 70c <open>
  if(fd < 0)
 5a2:	02054563          	bltz	a0,5cc <stat+0x42>
 5a6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 5a8:	85ca                	mv	a1,s2
 5aa:	00000097          	auipc	ra,0x0
 5ae:	17a080e7          	jalr	378(ra) # 724 <fstat>
 5b2:	892a                	mv	s2,a0
  close(fd);
 5b4:	8526                	mv	a0,s1
 5b6:	00000097          	auipc	ra,0x0
 5ba:	13e080e7          	jalr	318(ra) # 6f4 <close>
  return r;
}
 5be:	854a                	mv	a0,s2
 5c0:	60e2                	ld	ra,24(sp)
 5c2:	6442                	ld	s0,16(sp)
 5c4:	64a2                	ld	s1,8(sp)
 5c6:	6902                	ld	s2,0(sp)
 5c8:	6105                	addi	sp,sp,32
 5ca:	8082                	ret
    return -1;
 5cc:	597d                	li	s2,-1
 5ce:	bfc5                	j	5be <stat+0x34>

00000000000005d0 <atoi>:

int
atoi(const char *s)
{
 5d0:	1141                	addi	sp,sp,-16
 5d2:	e422                	sd	s0,8(sp)
 5d4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5d6:	00054603          	lbu	a2,0(a0)
 5da:	fd06079b          	addiw	a5,a2,-48
 5de:	0ff7f793          	zext.b	a5,a5
 5e2:	4725                	li	a4,9
 5e4:	02f76963          	bltu	a4,a5,616 <atoi+0x46>
 5e8:	86aa                	mv	a3,a0
  n = 0;
 5ea:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 5ec:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 5ee:	0685                	addi	a3,a3,1
 5f0:	0025179b          	slliw	a5,a0,0x2
 5f4:	9fa9                	addw	a5,a5,a0
 5f6:	0017979b          	slliw	a5,a5,0x1
 5fa:	9fb1                	addw	a5,a5,a2
 5fc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 600:	0006c603          	lbu	a2,0(a3)
 604:	fd06071b          	addiw	a4,a2,-48
 608:	0ff77713          	zext.b	a4,a4
 60c:	fee5f1e3          	bgeu	a1,a4,5ee <atoi+0x1e>
  return n;
}
 610:	6422                	ld	s0,8(sp)
 612:	0141                	addi	sp,sp,16
 614:	8082                	ret
  n = 0;
 616:	4501                	li	a0,0
 618:	bfe5                	j	610 <atoi+0x40>

000000000000061a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 61a:	1141                	addi	sp,sp,-16
 61c:	e422                	sd	s0,8(sp)
 61e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 620:	02b57463          	bgeu	a0,a1,648 <memmove+0x2e>
    while(n-- > 0)
 624:	00c05f63          	blez	a2,642 <memmove+0x28>
 628:	1602                	slli	a2,a2,0x20
 62a:	9201                	srli	a2,a2,0x20
 62c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 630:	872a                	mv	a4,a0
      *dst++ = *src++;
 632:	0585                	addi	a1,a1,1
 634:	0705                	addi	a4,a4,1
 636:	fff5c683          	lbu	a3,-1(a1)
 63a:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xeade>
    while(n-- > 0)
 63e:	fee79ae3          	bne	a5,a4,632 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 642:	6422                	ld	s0,8(sp)
 644:	0141                	addi	sp,sp,16
 646:	8082                	ret
    dst += n;
 648:	00c50733          	add	a4,a0,a2
    src += n;
 64c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 64e:	fec05ae3          	blez	a2,642 <memmove+0x28>
 652:	fff6079b          	addiw	a5,a2,-1
 656:	1782                	slli	a5,a5,0x20
 658:	9381                	srli	a5,a5,0x20
 65a:	fff7c793          	not	a5,a5
 65e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 660:	15fd                	addi	a1,a1,-1
 662:	177d                	addi	a4,a4,-1
 664:	0005c683          	lbu	a3,0(a1)
 668:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 66c:	fee79ae3          	bne	a5,a4,660 <memmove+0x46>
 670:	bfc9                	j	642 <memmove+0x28>

0000000000000672 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 672:	1141                	addi	sp,sp,-16
 674:	e422                	sd	s0,8(sp)
 676:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 678:	ca05                	beqz	a2,6a8 <memcmp+0x36>
 67a:	fff6069b          	addiw	a3,a2,-1
 67e:	1682                	slli	a3,a3,0x20
 680:	9281                	srli	a3,a3,0x20
 682:	0685                	addi	a3,a3,1
 684:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 686:	00054783          	lbu	a5,0(a0)
 68a:	0005c703          	lbu	a4,0(a1)
 68e:	00e79863          	bne	a5,a4,69e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 692:	0505                	addi	a0,a0,1
    p2++;
 694:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 696:	fed518e3          	bne	a0,a3,686 <memcmp+0x14>
  }
  return 0;
 69a:	4501                	li	a0,0
 69c:	a019                	j	6a2 <memcmp+0x30>
      return *p1 - *p2;
 69e:	40e7853b          	subw	a0,a5,a4
}
 6a2:	6422                	ld	s0,8(sp)
 6a4:	0141                	addi	sp,sp,16
 6a6:	8082                	ret
  return 0;
 6a8:	4501                	li	a0,0
 6aa:	bfe5                	j	6a2 <memcmp+0x30>

00000000000006ac <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6ac:	1141                	addi	sp,sp,-16
 6ae:	e406                	sd	ra,8(sp)
 6b0:	e022                	sd	s0,0(sp)
 6b2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 6b4:	00000097          	auipc	ra,0x0
 6b8:	f66080e7          	jalr	-154(ra) # 61a <memmove>
}
 6bc:	60a2                	ld	ra,8(sp)
 6be:	6402                	ld	s0,0(sp)
 6c0:	0141                	addi	sp,sp,16
 6c2:	8082                	ret

00000000000006c4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6c4:	4885                	li	a7,1
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 6cc:	4889                	li	a7,2
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6d4:	488d                	li	a7,3
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6dc:	4891                	li	a7,4
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <read>:
.global read
read:
 li a7, SYS_read
 6e4:	4895                	li	a7,5
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <write>:
.global write
write:
 li a7, SYS_write
 6ec:	48c1                	li	a7,16
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <close>:
.global close
close:
 li a7, SYS_close
 6f4:	48d5                	li	a7,21
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <kill>:
.global kill
kill:
 li a7, SYS_kill
 6fc:	4899                	li	a7,6
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <exec>:
.global exec
exec:
 li a7, SYS_exec
 704:	489d                	li	a7,7
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <open>:
.global open
open:
 li a7, SYS_open
 70c:	48bd                	li	a7,15
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 714:	48c5                	li	a7,17
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 71c:	48c9                	li	a7,18
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 724:	48a1                	li	a7,8
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <link>:
.global link
link:
 li a7, SYS_link
 72c:	48cd                	li	a7,19
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 734:	48d1                	li	a7,20
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 73c:	48a5                	li	a7,9
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <dup>:
.global dup
dup:
 li a7, SYS_dup
 744:	48a9                	li	a7,10
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 74c:	48ad                	li	a7,11
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 754:	48b1                	li	a7,12
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 75c:	48b5                	li	a7,13
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 764:	48b9                	li	a7,14
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 76c:	48d9                	li	a7,22
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 774:	1101                	addi	sp,sp,-32
 776:	ec06                	sd	ra,24(sp)
 778:	e822                	sd	s0,16(sp)
 77a:	1000                	addi	s0,sp,32
 77c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 780:	4605                	li	a2,1
 782:	fef40593          	addi	a1,s0,-17
 786:	00000097          	auipc	ra,0x0
 78a:	f66080e7          	jalr	-154(ra) # 6ec <write>
}
 78e:	60e2                	ld	ra,24(sp)
 790:	6442                	ld	s0,16(sp)
 792:	6105                	addi	sp,sp,32
 794:	8082                	ret

0000000000000796 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 796:	7139                	addi	sp,sp,-64
 798:	fc06                	sd	ra,56(sp)
 79a:	f822                	sd	s0,48(sp)
 79c:	f426                	sd	s1,40(sp)
 79e:	f04a                	sd	s2,32(sp)
 7a0:	ec4e                	sd	s3,24(sp)
 7a2:	0080                	addi	s0,sp,64
 7a4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7a6:	c299                	beqz	a3,7ac <printint+0x16>
 7a8:	0805c863          	bltz	a1,838 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7ac:	2581                	sext.w	a1,a1
  neg = 0;
 7ae:	4881                	li	a7,0
 7b0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7b4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7b6:	2601                	sext.w	a2,a2
 7b8:	00000517          	auipc	a0,0x0
 7bc:	55850513          	addi	a0,a0,1368 # d10 <digits>
 7c0:	883a                	mv	a6,a4
 7c2:	2705                	addiw	a4,a4,1
 7c4:	02c5f7bb          	remuw	a5,a1,a2
 7c8:	1782                	slli	a5,a5,0x20
 7ca:	9381                	srli	a5,a5,0x20
 7cc:	97aa                	add	a5,a5,a0
 7ce:	0007c783          	lbu	a5,0(a5)
 7d2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7d6:	0005879b          	sext.w	a5,a1
 7da:	02c5d5bb          	divuw	a1,a1,a2
 7de:	0685                	addi	a3,a3,1
 7e0:	fec7f0e3          	bgeu	a5,a2,7c0 <printint+0x2a>
  if(neg)
 7e4:	00088b63          	beqz	a7,7fa <printint+0x64>
    buf[i++] = '-';
 7e8:	fd040793          	addi	a5,s0,-48
 7ec:	973e                	add	a4,a4,a5
 7ee:	02d00793          	li	a5,45
 7f2:	fef70823          	sb	a5,-16(a4)
 7f6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7fa:	02e05863          	blez	a4,82a <printint+0x94>
 7fe:	fc040793          	addi	a5,s0,-64
 802:	00e78933          	add	s2,a5,a4
 806:	fff78993          	addi	s3,a5,-1
 80a:	99ba                	add	s3,s3,a4
 80c:	377d                	addiw	a4,a4,-1
 80e:	1702                	slli	a4,a4,0x20
 810:	9301                	srli	a4,a4,0x20
 812:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 816:	fff94583          	lbu	a1,-1(s2)
 81a:	8526                	mv	a0,s1
 81c:	00000097          	auipc	ra,0x0
 820:	f58080e7          	jalr	-168(ra) # 774 <putc>
  while(--i >= 0)
 824:	197d                	addi	s2,s2,-1
 826:	ff3918e3          	bne	s2,s3,816 <printint+0x80>
}
 82a:	70e2                	ld	ra,56(sp)
 82c:	7442                	ld	s0,48(sp)
 82e:	74a2                	ld	s1,40(sp)
 830:	7902                	ld	s2,32(sp)
 832:	69e2                	ld	s3,24(sp)
 834:	6121                	addi	sp,sp,64
 836:	8082                	ret
    x = -xx;
 838:	40b005bb          	negw	a1,a1
    neg = 1;
 83c:	4885                	li	a7,1
    x = -xx;
 83e:	bf8d                	j	7b0 <printint+0x1a>

0000000000000840 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 840:	7119                	addi	sp,sp,-128
 842:	fc86                	sd	ra,120(sp)
 844:	f8a2                	sd	s0,112(sp)
 846:	f4a6                	sd	s1,104(sp)
 848:	f0ca                	sd	s2,96(sp)
 84a:	ecce                	sd	s3,88(sp)
 84c:	e8d2                	sd	s4,80(sp)
 84e:	e4d6                	sd	s5,72(sp)
 850:	e0da                	sd	s6,64(sp)
 852:	fc5e                	sd	s7,56(sp)
 854:	f862                	sd	s8,48(sp)
 856:	f466                	sd	s9,40(sp)
 858:	f06a                	sd	s10,32(sp)
 85a:	ec6e                	sd	s11,24(sp)
 85c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 85e:	0005c903          	lbu	s2,0(a1)
 862:	18090f63          	beqz	s2,a00 <vprintf+0x1c0>
 866:	8aaa                	mv	s5,a0
 868:	8b32                	mv	s6,a2
 86a:	00158493          	addi	s1,a1,1
  state = 0;
 86e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 870:	02500a13          	li	s4,37
      if(c == 'd'){
 874:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 878:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 87c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 880:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 884:	00000b97          	auipc	s7,0x0
 888:	48cb8b93          	addi	s7,s7,1164 # d10 <digits>
 88c:	a839                	j	8aa <vprintf+0x6a>
        putc(fd, c);
 88e:	85ca                	mv	a1,s2
 890:	8556                	mv	a0,s5
 892:	00000097          	auipc	ra,0x0
 896:	ee2080e7          	jalr	-286(ra) # 774 <putc>
 89a:	a019                	j	8a0 <vprintf+0x60>
    } else if(state == '%'){
 89c:	01498f63          	beq	s3,s4,8ba <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 8a0:	0485                	addi	s1,s1,1
 8a2:	fff4c903          	lbu	s2,-1(s1)
 8a6:	14090d63          	beqz	s2,a00 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 8aa:	0009079b          	sext.w	a5,s2
    if(state == 0){
 8ae:	fe0997e3          	bnez	s3,89c <vprintf+0x5c>
      if(c == '%'){
 8b2:	fd479ee3          	bne	a5,s4,88e <vprintf+0x4e>
        state = '%';
 8b6:	89be                	mv	s3,a5
 8b8:	b7e5                	j	8a0 <vprintf+0x60>
      if(c == 'd'){
 8ba:	05878063          	beq	a5,s8,8fa <vprintf+0xba>
      } else if(c == 'l') {
 8be:	05978c63          	beq	a5,s9,916 <vprintf+0xd6>
      } else if(c == 'x') {
 8c2:	07a78863          	beq	a5,s10,932 <vprintf+0xf2>
      } else if(c == 'p') {
 8c6:	09b78463          	beq	a5,s11,94e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8ca:	07300713          	li	a4,115
 8ce:	0ce78663          	beq	a5,a4,99a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8d2:	06300713          	li	a4,99
 8d6:	0ee78e63          	beq	a5,a4,9d2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8da:	11478863          	beq	a5,s4,9ea <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8de:	85d2                	mv	a1,s4
 8e0:	8556                	mv	a0,s5
 8e2:	00000097          	auipc	ra,0x0
 8e6:	e92080e7          	jalr	-366(ra) # 774 <putc>
        putc(fd, c);
 8ea:	85ca                	mv	a1,s2
 8ec:	8556                	mv	a0,s5
 8ee:	00000097          	auipc	ra,0x0
 8f2:	e86080e7          	jalr	-378(ra) # 774 <putc>
      }
      state = 0;
 8f6:	4981                	li	s3,0
 8f8:	b765                	j	8a0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8fa:	008b0913          	addi	s2,s6,8
 8fe:	4685                	li	a3,1
 900:	4629                	li	a2,10
 902:	000b2583          	lw	a1,0(s6)
 906:	8556                	mv	a0,s5
 908:	00000097          	auipc	ra,0x0
 90c:	e8e080e7          	jalr	-370(ra) # 796 <printint>
 910:	8b4a                	mv	s6,s2
      state = 0;
 912:	4981                	li	s3,0
 914:	b771                	j	8a0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 916:	008b0913          	addi	s2,s6,8
 91a:	4681                	li	a3,0
 91c:	4629                	li	a2,10
 91e:	000b2583          	lw	a1,0(s6)
 922:	8556                	mv	a0,s5
 924:	00000097          	auipc	ra,0x0
 928:	e72080e7          	jalr	-398(ra) # 796 <printint>
 92c:	8b4a                	mv	s6,s2
      state = 0;
 92e:	4981                	li	s3,0
 930:	bf85                	j	8a0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 932:	008b0913          	addi	s2,s6,8
 936:	4681                	li	a3,0
 938:	4641                	li	a2,16
 93a:	000b2583          	lw	a1,0(s6)
 93e:	8556                	mv	a0,s5
 940:	00000097          	auipc	ra,0x0
 944:	e56080e7          	jalr	-426(ra) # 796 <printint>
 948:	8b4a                	mv	s6,s2
      state = 0;
 94a:	4981                	li	s3,0
 94c:	bf91                	j	8a0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 94e:	008b0793          	addi	a5,s6,8
 952:	f8f43423          	sd	a5,-120(s0)
 956:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 95a:	03000593          	li	a1,48
 95e:	8556                	mv	a0,s5
 960:	00000097          	auipc	ra,0x0
 964:	e14080e7          	jalr	-492(ra) # 774 <putc>
  putc(fd, 'x');
 968:	85ea                	mv	a1,s10
 96a:	8556                	mv	a0,s5
 96c:	00000097          	auipc	ra,0x0
 970:	e08080e7          	jalr	-504(ra) # 774 <putc>
 974:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 976:	03c9d793          	srli	a5,s3,0x3c
 97a:	97de                	add	a5,a5,s7
 97c:	0007c583          	lbu	a1,0(a5)
 980:	8556                	mv	a0,s5
 982:	00000097          	auipc	ra,0x0
 986:	df2080e7          	jalr	-526(ra) # 774 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 98a:	0992                	slli	s3,s3,0x4
 98c:	397d                	addiw	s2,s2,-1
 98e:	fe0914e3          	bnez	s2,976 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 992:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 996:	4981                	li	s3,0
 998:	b721                	j	8a0 <vprintf+0x60>
        s = va_arg(ap, char*);
 99a:	008b0993          	addi	s3,s6,8
 99e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 9a2:	02090163          	beqz	s2,9c4 <vprintf+0x184>
        while(*s != 0){
 9a6:	00094583          	lbu	a1,0(s2)
 9aa:	c9a1                	beqz	a1,9fa <vprintf+0x1ba>
          putc(fd, *s);
 9ac:	8556                	mv	a0,s5
 9ae:	00000097          	auipc	ra,0x0
 9b2:	dc6080e7          	jalr	-570(ra) # 774 <putc>
          s++;
 9b6:	0905                	addi	s2,s2,1
        while(*s != 0){
 9b8:	00094583          	lbu	a1,0(s2)
 9bc:	f9e5                	bnez	a1,9ac <vprintf+0x16c>
        s = va_arg(ap, char*);
 9be:	8b4e                	mv	s6,s3
      state = 0;
 9c0:	4981                	li	s3,0
 9c2:	bdf9                	j	8a0 <vprintf+0x60>
          s = "(null)";
 9c4:	00000917          	auipc	s2,0x0
 9c8:	34490913          	addi	s2,s2,836 # d08 <malloc+0x1fe>
        while(*s != 0){
 9cc:	02800593          	li	a1,40
 9d0:	bff1                	j	9ac <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 9d2:	008b0913          	addi	s2,s6,8
 9d6:	000b4583          	lbu	a1,0(s6)
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	d98080e7          	jalr	-616(ra) # 774 <putc>
 9e4:	8b4a                	mv	s6,s2
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	bd65                	j	8a0 <vprintf+0x60>
        putc(fd, c);
 9ea:	85d2                	mv	a1,s4
 9ec:	8556                	mv	a0,s5
 9ee:	00000097          	auipc	ra,0x0
 9f2:	d86080e7          	jalr	-634(ra) # 774 <putc>
      state = 0;
 9f6:	4981                	li	s3,0
 9f8:	b565                	j	8a0 <vprintf+0x60>
        s = va_arg(ap, char*);
 9fa:	8b4e                	mv	s6,s3
      state = 0;
 9fc:	4981                	li	s3,0
 9fe:	b54d                	j	8a0 <vprintf+0x60>
    }
  }
}
 a00:	70e6                	ld	ra,120(sp)
 a02:	7446                	ld	s0,112(sp)
 a04:	74a6                	ld	s1,104(sp)
 a06:	7906                	ld	s2,96(sp)
 a08:	69e6                	ld	s3,88(sp)
 a0a:	6a46                	ld	s4,80(sp)
 a0c:	6aa6                	ld	s5,72(sp)
 a0e:	6b06                	ld	s6,64(sp)
 a10:	7be2                	ld	s7,56(sp)
 a12:	7c42                	ld	s8,48(sp)
 a14:	7ca2                	ld	s9,40(sp)
 a16:	7d02                	ld	s10,32(sp)
 a18:	6de2                	ld	s11,24(sp)
 a1a:	6109                	addi	sp,sp,128
 a1c:	8082                	ret

0000000000000a1e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a1e:	715d                	addi	sp,sp,-80
 a20:	ec06                	sd	ra,24(sp)
 a22:	e822                	sd	s0,16(sp)
 a24:	1000                	addi	s0,sp,32
 a26:	e010                	sd	a2,0(s0)
 a28:	e414                	sd	a3,8(s0)
 a2a:	e818                	sd	a4,16(s0)
 a2c:	ec1c                	sd	a5,24(s0)
 a2e:	03043023          	sd	a6,32(s0)
 a32:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a36:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a3a:	8622                	mv	a2,s0
 a3c:	00000097          	auipc	ra,0x0
 a40:	e04080e7          	jalr	-508(ra) # 840 <vprintf>
}
 a44:	60e2                	ld	ra,24(sp)
 a46:	6442                	ld	s0,16(sp)
 a48:	6161                	addi	sp,sp,80
 a4a:	8082                	ret

0000000000000a4c <printf>:

void
printf(const char *fmt, ...)
{
 a4c:	711d                	addi	sp,sp,-96
 a4e:	ec06                	sd	ra,24(sp)
 a50:	e822                	sd	s0,16(sp)
 a52:	1000                	addi	s0,sp,32
 a54:	e40c                	sd	a1,8(s0)
 a56:	e810                	sd	a2,16(s0)
 a58:	ec14                	sd	a3,24(s0)
 a5a:	f018                	sd	a4,32(s0)
 a5c:	f41c                	sd	a5,40(s0)
 a5e:	03043823          	sd	a6,48(s0)
 a62:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a66:	00840613          	addi	a2,s0,8
 a6a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a6e:	85aa                	mv	a1,a0
 a70:	4505                	li	a0,1
 a72:	00000097          	auipc	ra,0x0
 a76:	dce080e7          	jalr	-562(ra) # 840 <vprintf>
}
 a7a:	60e2                	ld	ra,24(sp)
 a7c:	6442                	ld	s0,16(sp)
 a7e:	6125                	addi	sp,sp,96
 a80:	8082                	ret

0000000000000a82 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a82:	1141                	addi	sp,sp,-16
 a84:	e422                	sd	s0,8(sp)
 a86:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a88:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a8c:	00000797          	auipc	a5,0x0
 a90:	29c7b783          	ld	a5,668(a5) # d28 <freep>
 a94:	a805                	j	ac4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a96:	4618                	lw	a4,8(a2)
 a98:	9db9                	addw	a1,a1,a4
 a9a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a9e:	6398                	ld	a4,0(a5)
 aa0:	6318                	ld	a4,0(a4)
 aa2:	fee53823          	sd	a4,-16(a0)
 aa6:	a091                	j	aea <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 aa8:	ff852703          	lw	a4,-8(a0)
 aac:	9e39                	addw	a2,a2,a4
 aae:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 ab0:	ff053703          	ld	a4,-16(a0)
 ab4:	e398                	sd	a4,0(a5)
 ab6:	a099                	j	afc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab8:	6398                	ld	a4,0(a5)
 aba:	00e7e463          	bltu	a5,a4,ac2 <free+0x40>
 abe:	00e6ea63          	bltu	a3,a4,ad2 <free+0x50>
{
 ac2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac4:	fed7fae3          	bgeu	a5,a3,ab8 <free+0x36>
 ac8:	6398                	ld	a4,0(a5)
 aca:	00e6e463          	bltu	a3,a4,ad2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ace:	fee7eae3          	bltu	a5,a4,ac2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 ad2:	ff852583          	lw	a1,-8(a0)
 ad6:	6390                	ld	a2,0(a5)
 ad8:	02059813          	slli	a6,a1,0x20
 adc:	01c85713          	srli	a4,a6,0x1c
 ae0:	9736                	add	a4,a4,a3
 ae2:	fae60ae3          	beq	a2,a4,a96 <free+0x14>
    bp->s.ptr = p->s.ptr;
 ae6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 aea:	4790                	lw	a2,8(a5)
 aec:	02061593          	slli	a1,a2,0x20
 af0:	01c5d713          	srli	a4,a1,0x1c
 af4:	973e                	add	a4,a4,a5
 af6:	fae689e3          	beq	a3,a4,aa8 <free+0x26>
  } else
    p->s.ptr = bp;
 afa:	e394                	sd	a3,0(a5)
  freep = p;
 afc:	00000717          	auipc	a4,0x0
 b00:	22f73623          	sd	a5,556(a4) # d28 <freep>
}
 b04:	6422                	ld	s0,8(sp)
 b06:	0141                	addi	sp,sp,16
 b08:	8082                	ret

0000000000000b0a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b0a:	7139                	addi	sp,sp,-64
 b0c:	fc06                	sd	ra,56(sp)
 b0e:	f822                	sd	s0,48(sp)
 b10:	f426                	sd	s1,40(sp)
 b12:	f04a                	sd	s2,32(sp)
 b14:	ec4e                	sd	s3,24(sp)
 b16:	e852                	sd	s4,16(sp)
 b18:	e456                	sd	s5,8(sp)
 b1a:	e05a                	sd	s6,0(sp)
 b1c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b1e:	02051493          	slli	s1,a0,0x20
 b22:	9081                	srli	s1,s1,0x20
 b24:	04bd                	addi	s1,s1,15
 b26:	8091                	srli	s1,s1,0x4
 b28:	0014899b          	addiw	s3,s1,1
 b2c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b2e:	00000517          	auipc	a0,0x0
 b32:	1fa53503          	ld	a0,506(a0) # d28 <freep>
 b36:	c515                	beqz	a0,b62 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b38:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b3a:	4798                	lw	a4,8(a5)
 b3c:	02977f63          	bgeu	a4,s1,b7a <malloc+0x70>
 b40:	8a4e                	mv	s4,s3
 b42:	0009871b          	sext.w	a4,s3
 b46:	6685                	lui	a3,0x1
 b48:	00d77363          	bgeu	a4,a3,b4e <malloc+0x44>
 b4c:	6a05                	lui	s4,0x1
 b4e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b52:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b56:	00000917          	auipc	s2,0x0
 b5a:	1d290913          	addi	s2,s2,466 # d28 <freep>
  if(p == (char*)-1)
 b5e:	5afd                	li	s5,-1
 b60:	a895                	j	bd4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b62:	00000797          	auipc	a5,0x0
 b66:	2be78793          	addi	a5,a5,702 # e20 <base>
 b6a:	00000717          	auipc	a4,0x0
 b6e:	1af73f23          	sd	a5,446(a4) # d28 <freep>
 b72:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b74:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b78:	b7e1                	j	b40 <malloc+0x36>
      if(p->s.size == nunits)
 b7a:	02e48c63          	beq	s1,a4,bb2 <malloc+0xa8>
        p->s.size -= nunits;
 b7e:	4137073b          	subw	a4,a4,s3
 b82:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b84:	02071693          	slli	a3,a4,0x20
 b88:	01c6d713          	srli	a4,a3,0x1c
 b8c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b8e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b92:	00000717          	auipc	a4,0x0
 b96:	18a73b23          	sd	a0,406(a4) # d28 <freep>
      return (void*)(p + 1);
 b9a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b9e:	70e2                	ld	ra,56(sp)
 ba0:	7442                	ld	s0,48(sp)
 ba2:	74a2                	ld	s1,40(sp)
 ba4:	7902                	ld	s2,32(sp)
 ba6:	69e2                	ld	s3,24(sp)
 ba8:	6a42                	ld	s4,16(sp)
 baa:	6aa2                	ld	s5,8(sp)
 bac:	6b02                	ld	s6,0(sp)
 bae:	6121                	addi	sp,sp,64
 bb0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 bb2:	6398                	ld	a4,0(a5)
 bb4:	e118                	sd	a4,0(a0)
 bb6:	bff1                	j	b92 <malloc+0x88>
  hp->s.size = nu;
 bb8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bbc:	0541                	addi	a0,a0,16
 bbe:	00000097          	auipc	ra,0x0
 bc2:	ec4080e7          	jalr	-316(ra) # a82 <free>
  return freep;
 bc6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bca:	d971                	beqz	a0,b9e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bcc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bce:	4798                	lw	a4,8(a5)
 bd0:	fa9775e3          	bgeu	a4,s1,b7a <malloc+0x70>
    if(p == freep)
 bd4:	00093703          	ld	a4,0(s2)
 bd8:	853e                	mv	a0,a5
 bda:	fef719e3          	bne	a4,a5,bcc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 bde:	8552                	mv	a0,s4
 be0:	00000097          	auipc	ra,0x0
 be4:	b74080e7          	jalr	-1164(ra) # 754 <sbrk>
  if(p == (char*)-1)
 be8:	fd5518e3          	bne	a0,s5,bb8 <malloc+0xae>
        return 0;
 bec:	4501                	li	a0,0
 bee:	bf45                	j	b9e <malloc+0x94>
