
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
  42:	686080e7          	jalr	1670(ra) # 6c4 <pipe>
  46:	57fd                	li	a5,-1
  48:	04f50c63          	beq	a0,a5,a0 <main+0xa0>
    printf("An error ocurred");
    exit(1);
  }
  int cid = fork();
  4c:	00000097          	auipc	ra,0x0
  50:	660080e7          	jalr	1632(ra) # 6ac <fork>
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
  62:	67e080e7          	jalr	1662(ra) # 6dc <close>
    int data1[SIZE] = {0};
  66:	20000613          	li	a2,512
  6a:	4581                	li	a1,0
  6c:	d8840513          	addi	a0,s0,-632
  70:	00000097          	auipc	ra,0x0
  74:	448080e7          	jalr	1096(ra) # 4b8 <memset>
    current_time = uptime();
  78:	00000097          	auipc	ra,0x0
  7c:	6d4080e7          	jalr	1748(ra) # 74c <uptime>
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
  90:	bc4b8b93          	addi	s7,s7,-1084 # c50 <malloc+0x15e>
          check = 1;
  94:	4b05                	li	s6,1
    for(int i=0;i<(1024*20);i++){
  96:	00280cb7          	lui	s9,0x280
  9a:	080c8c93          	addi	s9,s9,128 # 280080 <__global_pointer$+0x27eb77>
  9e:	a0ed                	j	188 <main+0x188>
    printf("An error ocurred");
  a0:	00001517          	auipc	a0,0x1
  a4:	b3850513          	addi	a0,a0,-1224 # bd8 <malloc+0xe6>
  a8:	00001097          	auipc	ra,0x1
  ac:	98c080e7          	jalr	-1652(ra) # a34 <printf>
    exit(1);
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	602080e7          	jalr	1538(ra) # 6b4 <exit>
    close(fd[0]);
  ba:	f8842503          	lw	a0,-120(s0)
  be:	00000097          	auipc	ra,0x0
  c2:	61e080e7          	jalr	1566(ra) # 6dc <close>
    int data[SIZE] = {0};
  c6:	20000613          	li	a2,512
  ca:	4581                	li	a1,0
  cc:	d8840513          	addi	a0,s0,-632
  d0:	00000097          	auipc	ra,0x0
  d4:	3e8080e7          	jalr	1000(ra) # 4b8 <memset>
  d8:	08000493          	li	s1,128
      if(write(fd[1], data, 512) == -1){
  dc:	59fd                	li	s3,-1
    for(int i=0;i<(1024*20);i++){
  de:	00280937          	lui	s2,0x280
  e2:	08090913          	addi	s2,s2,128 # 280080 <__global_pointer$+0x27eb77>
  e6:	a00d                	j	108 <main+0x108>
      if(write(fd[1], data, 512) == -1){
  e8:	20000613          	li	a2,512
  ec:	d8840593          	addi	a1,s0,-632
  f0:	f8c42503          	lw	a0,-116(s0)
  f4:	00000097          	auipc	ra,0x0
  f8:	5e0080e7          	jalr	1504(ra) # 6d4 <write>
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
 124:	ad050513          	addi	a0,a0,-1328 # bf0 <malloc+0xfe>
 128:	00001097          	auipc	ra,0x1
 12c:	90c080e7          	jalr	-1780(ra) # a34 <printf>
        exit(1);
 130:	4505                	li	a0,1
 132:	00000097          	auipc	ra,0x0
 136:	582080e7          	jalr	1410(ra) # 6b4 <exit>
    close(fd[1]);
 13a:	f8c42503          	lw	a0,-116(s0)
 13e:	00000097          	auipc	ra,0x0
 142:	59e080e7          	jalr	1438(ra) # 6dc <close>
 146:	a84d                	j	1f8 <main+0x1f8>
        printf("An error occurred while reading the pipe\n");
 148:	00001517          	auipc	a0,0x1
 14c:	ad850513          	addi	a0,a0,-1320 # c20 <malloc+0x12e>
 150:	00001097          	auipc	ra,0x1
 154:	8e4080e7          	jalr	-1820(ra) # a34 <printf>
        exit(1);
 158:	4505                	li	a0,1
 15a:	00000097          	auipc	ra,0x0
 15e:	55a080e7          	jalr	1370(ra) # 6b4 <exit>
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
 178:	8c0080e7          	jalr	-1856(ra) # a34 <printf>
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
 198:	538080e7          	jalr	1336(ra) # 6cc <read>
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
 1b8:	508080e7          	jalr	1288(ra) # 6bc <wait>
    printf("Total byte data sent: %d and data perfection is %d\n",cnt, check);
 1bc:	8656                	mv	a2,s5
 1be:	85e2                	mv	a1,s8
 1c0:	00001517          	auipc	a0,0x1
 1c4:	ab850513          	addi	a0,a0,-1352 # c78 <malloc+0x186>
 1c8:	00001097          	auipc	ra,0x1
 1cc:	86c080e7          	jalr	-1940(ra) # a34 <printf>
    elasped_time = uptime()-current_time;
 1d0:	00000097          	auipc	ra,0x0
 1d4:	57c080e7          	jalr	1404(ra) # 74c <uptime>
    printf("The total ticks are %d\n",elasped_time);
 1d8:	41b505bb          	subw	a1,a0,s11
 1dc:	00001517          	auipc	a0,0x1
 1e0:	ad450513          	addi	a0,a0,-1324 # cb0 <malloc+0x1be>
 1e4:	00001097          	auipc	ra,0x1
 1e8:	850080e7          	jalr	-1968(ra) # a34 <printf>
    close(fd[0]);
 1ec:	f8842503          	lw	a0,-120(s0)
 1f0:	00000097          	auipc	ra,0x0
 1f4:	4ec080e7          	jalr	1260(ra) # 6dc <close>
  else{
    printf("An error occurred while forking.");
    exit(1);
  }

  exit(0); //Exiting with 0 error
 1f8:	4501                	li	a0,0
 1fa:	00000097          	auipc	ra,0x0
 1fe:	4ba080e7          	jalr	1210(ra) # 6b4 <exit>
    printf("An error occurred while forking.");
 202:	00001517          	auipc	a0,0x1
 206:	ac650513          	addi	a0,a0,-1338 # cc8 <malloc+0x1d6>
 20a:	00001097          	auipc	ra,0x1
 20e:	82a080e7          	jalr	-2006(ra) # a34 <printf>
    exit(1);
 212:	4505                	li	a0,1
 214:	00000097          	auipc	ra,0x0
 218:	4a0080e7          	jalr	1184(ra) # 6b4 <exit>

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
 262:	aca48493          	addi	s1,s1,-1334 # d28 <rings+0x10>
 266:	00001917          	auipc	s2,0x1
 26a:	bb290913          	addi	s2,s2,-1102 # e18 <__BSS_END__>
 26e:	04f59563          	bne	a1,a5,2b8 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 272:	00001497          	auipc	s1,0x1
 276:	ab64a483          	lw	s1,-1354(s1) # d28 <rings+0x10>
 27a:	c099                	beqz	s1,280 <create_or_close_the_buffer_user+0x38>
 27c:	4481                	li	s1,0
 27e:	a899                	j	2d4 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 280:	00001917          	auipc	s2,0x1
 284:	a9890913          	addi	s2,s2,-1384 # d18 <rings>
 288:	00093603          	ld	a2,0(s2)
 28c:	4585                	li	a1,1
 28e:	00000097          	auipc	ra,0x0
 292:	4c6080e7          	jalr	1222(ra) # 754 <ringbuf>
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
 2c8:	490080e7          	jalr	1168(ra) # 754 <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 2e6:	1101                	addi	sp,sp,-32
 2e8:	ec06                	sd	ra,24(sp)
 2ea:	e822                	sd	s0,16(sp)
 2ec:	e426                	sd	s1,8(sp)
 2ee:	1000                	addi	s0,sp,32
 2f0:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 2f2:	00151793          	slli	a5,a0,0x1
 2f6:	97aa                	add	a5,a5,a0
 2f8:	078e                	slli	a5,a5,0x3
 2fa:	00001717          	auipc	a4,0x1
 2fe:	a1e70713          	addi	a4,a4,-1506 # d18 <rings>
 302:	97ba                	add	a5,a5,a4
 304:	639c                	ld	a5,0(a5)
 306:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 308:	421c                	lw	a5,0(a2)
 30a:	e785                	bnez	a5,332 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 30c:	86ba                	mv	a3,a4
 30e:	671c                	ld	a5,8(a4)
 310:	6398                	ld	a4,0(a5)
 312:	67c1                	lui	a5,0x10
 314:	9fb9                	addw	a5,a5,a4
 316:	00151713          	slli	a4,a0,0x1
 31a:	953a                	add	a0,a0,a4
 31c:	050e                	slli	a0,a0,0x3
 31e:	9536                	add	a0,a0,a3
 320:	6518                	ld	a4,8(a0)
 322:	6718                	ld	a4,8(a4)
 324:	9f99                	subw	a5,a5,a4
 326:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 328:	60e2                	ld	ra,24(sp)
 32a:	6442                	ld	s0,16(sp)
 32c:	64a2                	ld	s1,8(sp)
 32e:	6105                	addi	sp,sp,32
 330:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 332:	00151793          	slli	a5,a0,0x1
 336:	953e                	add	a0,a0,a5
 338:	050e                	slli	a0,a0,0x3
 33a:	00001797          	auipc	a5,0x1
 33e:	9de78793          	addi	a5,a5,-1570 # d18 <rings>
 342:	953e                	add	a0,a0,a5
 344:	6508                	ld	a0,8(a0)
 346:	0521                	addi	a0,a0,8
 348:	00000097          	auipc	ra,0x0
 34c:	ee8080e7          	jalr	-280(ra) # 230 <load>
 350:	c088                	sw	a0,0(s1)
}
 352:	bfd9                	j	328 <ringbuf_start_write+0x42>

0000000000000354 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 354:	1141                	addi	sp,sp,-16
 356:	e406                	sd	ra,8(sp)
 358:	e022                	sd	s0,0(sp)
 35a:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 35c:	00151793          	slli	a5,a0,0x1
 360:	97aa                	add	a5,a5,a0
 362:	078e                	slli	a5,a5,0x3
 364:	00001517          	auipc	a0,0x1
 368:	9b450513          	addi	a0,a0,-1612 # d18 <rings>
 36c:	97aa                	add	a5,a5,a0
 36e:	6788                	ld	a0,8(a5)
 370:	0035959b          	slliw	a1,a1,0x3
 374:	0521                	addi	a0,a0,8
 376:	00000097          	auipc	ra,0x0
 37a:	ea6080e7          	jalr	-346(ra) # 21c <store>
}
 37e:	60a2                	ld	ra,8(sp)
 380:	6402                	ld	s0,0(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret

0000000000000386 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 386:	1101                	addi	sp,sp,-32
 388:	ec06                	sd	ra,24(sp)
 38a:	e822                	sd	s0,16(sp)
 38c:	e426                	sd	s1,8(sp)
 38e:	1000                	addi	s0,sp,32
 390:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 392:	00151793          	slli	a5,a0,0x1
 396:	97aa                	add	a5,a5,a0
 398:	078e                	slli	a5,a5,0x3
 39a:	00001517          	auipc	a0,0x1
 39e:	97e50513          	addi	a0,a0,-1666 # d18 <rings>
 3a2:	97aa                	add	a5,a5,a0
 3a4:	6788                	ld	a0,8(a5)
 3a6:	0521                	addi	a0,a0,8
 3a8:	00000097          	auipc	ra,0x0
 3ac:	e88080e7          	jalr	-376(ra) # 230 <load>
 3b0:	c088                	sw	a0,0(s1)
}
 3b2:	60e2                	ld	ra,24(sp)
 3b4:	6442                	ld	s0,16(sp)
 3b6:	64a2                	ld	s1,8(sp)
 3b8:	6105                	addi	sp,sp,32
 3ba:	8082                	ret

00000000000003bc <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 3bc:	1101                	addi	sp,sp,-32
 3be:	ec06                	sd	ra,24(sp)
 3c0:	e822                	sd	s0,16(sp)
 3c2:	e426                	sd	s1,8(sp)
 3c4:	1000                	addi	s0,sp,32
 3c6:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 3c8:	00151793          	slli	a5,a0,0x1
 3cc:	97aa                	add	a5,a5,a0
 3ce:	078e                	slli	a5,a5,0x3
 3d0:	00001517          	auipc	a0,0x1
 3d4:	94850513          	addi	a0,a0,-1720 # d18 <rings>
 3d8:	97aa                	add	a5,a5,a0
 3da:	6788                	ld	a0,8(a5)
 3dc:	611c                	ld	a5,0(a0)
 3de:	ef99                	bnez	a5,3fc <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 3e0:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 3e2:	41f7579b          	sraiw	a5,a4,0x1f
 3e6:	01d7d79b          	srliw	a5,a5,0x1d
 3ea:	9fb9                	addw	a5,a5,a4
 3ec:	4037d79b          	sraiw	a5,a5,0x3
 3f0:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 3f2:	60e2                	ld	ra,24(sp)
 3f4:	6442                	ld	s0,16(sp)
 3f6:	64a2                	ld	s1,8(sp)
 3f8:	6105                	addi	sp,sp,32
 3fa:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 3fc:	00000097          	auipc	ra,0x0
 400:	e34080e7          	jalr	-460(ra) # 230 <load>
    *bytes /= 8;
 404:	41f5579b          	sraiw	a5,a0,0x1f
 408:	01d7d79b          	srliw	a5,a5,0x1d
 40c:	9d3d                	addw	a0,a0,a5
 40e:	4035551b          	sraiw	a0,a0,0x3
 412:	c088                	sw	a0,0(s1)
}
 414:	bff9                	j	3f2 <ringbuf_start_read+0x36>

0000000000000416 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 416:	1141                	addi	sp,sp,-16
 418:	e406                	sd	ra,8(sp)
 41a:	e022                	sd	s0,0(sp)
 41c:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 41e:	00151793          	slli	a5,a0,0x1
 422:	97aa                	add	a5,a5,a0
 424:	078e                	slli	a5,a5,0x3
 426:	00001517          	auipc	a0,0x1
 42a:	8f250513          	addi	a0,a0,-1806 # d18 <rings>
 42e:	97aa                	add	a5,a5,a0
 430:	0035959b          	slliw	a1,a1,0x3
 434:	6788                	ld	a0,8(a5)
 436:	00000097          	auipc	ra,0x0
 43a:	de6080e7          	jalr	-538(ra) # 21c <store>
}
 43e:	60a2                	ld	ra,8(sp)
 440:	6402                	ld	s0,0(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret

0000000000000446 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 446:	1141                	addi	sp,sp,-16
 448:	e422                	sd	s0,8(sp)
 44a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 44c:	87aa                	mv	a5,a0
 44e:	0585                	addi	a1,a1,1
 450:	0785                	addi	a5,a5,1
 452:	fff5c703          	lbu	a4,-1(a1)
 456:	fee78fa3          	sb	a4,-1(a5)
 45a:	fb75                	bnez	a4,44e <strcpy+0x8>
    ;
  return os;
}
 45c:	6422                	ld	s0,8(sp)
 45e:	0141                	addi	sp,sp,16
 460:	8082                	ret

0000000000000462 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 462:	1141                	addi	sp,sp,-16
 464:	e422                	sd	s0,8(sp)
 466:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 468:	00054783          	lbu	a5,0(a0)
 46c:	cb91                	beqz	a5,480 <strcmp+0x1e>
 46e:	0005c703          	lbu	a4,0(a1)
 472:	00f71763          	bne	a4,a5,480 <strcmp+0x1e>
    p++, q++;
 476:	0505                	addi	a0,a0,1
 478:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 47a:	00054783          	lbu	a5,0(a0)
 47e:	fbe5                	bnez	a5,46e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 480:	0005c503          	lbu	a0,0(a1)
}
 484:	40a7853b          	subw	a0,a5,a0
 488:	6422                	ld	s0,8(sp)
 48a:	0141                	addi	sp,sp,16
 48c:	8082                	ret

000000000000048e <strlen>:

uint
strlen(const char *s)
{
 48e:	1141                	addi	sp,sp,-16
 490:	e422                	sd	s0,8(sp)
 492:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 494:	00054783          	lbu	a5,0(a0)
 498:	cf91                	beqz	a5,4b4 <strlen+0x26>
 49a:	0505                	addi	a0,a0,1
 49c:	87aa                	mv	a5,a0
 49e:	4685                	li	a3,1
 4a0:	9e89                	subw	a3,a3,a0
 4a2:	00f6853b          	addw	a0,a3,a5
 4a6:	0785                	addi	a5,a5,1
 4a8:	fff7c703          	lbu	a4,-1(a5)
 4ac:	fb7d                	bnez	a4,4a2 <strlen+0x14>
    ;
  return n;
}
 4ae:	6422                	ld	s0,8(sp)
 4b0:	0141                	addi	sp,sp,16
 4b2:	8082                	ret
  for(n = 0; s[n]; n++)
 4b4:	4501                	li	a0,0
 4b6:	bfe5                	j	4ae <strlen+0x20>

00000000000004b8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4b8:	1141                	addi	sp,sp,-16
 4ba:	e422                	sd	s0,8(sp)
 4bc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4be:	ca19                	beqz	a2,4d4 <memset+0x1c>
 4c0:	87aa                	mv	a5,a0
 4c2:	1602                	slli	a2,a2,0x20
 4c4:	9201                	srli	a2,a2,0x20
 4c6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4ca:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4ce:	0785                	addi	a5,a5,1
 4d0:	fee79de3          	bne	a5,a4,4ca <memset+0x12>
  }
  return dst;
}
 4d4:	6422                	ld	s0,8(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret

00000000000004da <strchr>:

char*
strchr(const char *s, char c)
{
 4da:	1141                	addi	sp,sp,-16
 4dc:	e422                	sd	s0,8(sp)
 4de:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4e0:	00054783          	lbu	a5,0(a0)
 4e4:	cb99                	beqz	a5,4fa <strchr+0x20>
    if(*s == c)
 4e6:	00f58763          	beq	a1,a5,4f4 <strchr+0x1a>
  for(; *s; s++)
 4ea:	0505                	addi	a0,a0,1
 4ec:	00054783          	lbu	a5,0(a0)
 4f0:	fbfd                	bnez	a5,4e6 <strchr+0xc>
      return (char*)s;
  return 0;
 4f2:	4501                	li	a0,0
}
 4f4:	6422                	ld	s0,8(sp)
 4f6:	0141                	addi	sp,sp,16
 4f8:	8082                	ret
  return 0;
 4fa:	4501                	li	a0,0
 4fc:	bfe5                	j	4f4 <strchr+0x1a>

00000000000004fe <gets>:

char*
gets(char *buf, int max)
{
 4fe:	711d                	addi	sp,sp,-96
 500:	ec86                	sd	ra,88(sp)
 502:	e8a2                	sd	s0,80(sp)
 504:	e4a6                	sd	s1,72(sp)
 506:	e0ca                	sd	s2,64(sp)
 508:	fc4e                	sd	s3,56(sp)
 50a:	f852                	sd	s4,48(sp)
 50c:	f456                	sd	s5,40(sp)
 50e:	f05a                	sd	s6,32(sp)
 510:	ec5e                	sd	s7,24(sp)
 512:	1080                	addi	s0,sp,96
 514:	8baa                	mv	s7,a0
 516:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 518:	892a                	mv	s2,a0
 51a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 51c:	4aa9                	li	s5,10
 51e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 520:	89a6                	mv	s3,s1
 522:	2485                	addiw	s1,s1,1
 524:	0344d863          	bge	s1,s4,554 <gets+0x56>
    cc = read(0, &c, 1);
 528:	4605                	li	a2,1
 52a:	faf40593          	addi	a1,s0,-81
 52e:	4501                	li	a0,0
 530:	00000097          	auipc	ra,0x0
 534:	19c080e7          	jalr	412(ra) # 6cc <read>
    if(cc < 1)
 538:	00a05e63          	blez	a0,554 <gets+0x56>
    buf[i++] = c;
 53c:	faf44783          	lbu	a5,-81(s0)
 540:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 544:	01578763          	beq	a5,s5,552 <gets+0x54>
 548:	0905                	addi	s2,s2,1
 54a:	fd679be3          	bne	a5,s6,520 <gets+0x22>
  for(i=0; i+1 < max; ){
 54e:	89a6                	mv	s3,s1
 550:	a011                	j	554 <gets+0x56>
 552:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 554:	99de                	add	s3,s3,s7
 556:	00098023          	sb	zero,0(s3)
  return buf;
}
 55a:	855e                	mv	a0,s7
 55c:	60e6                	ld	ra,88(sp)
 55e:	6446                	ld	s0,80(sp)
 560:	64a6                	ld	s1,72(sp)
 562:	6906                	ld	s2,64(sp)
 564:	79e2                	ld	s3,56(sp)
 566:	7a42                	ld	s4,48(sp)
 568:	7aa2                	ld	s5,40(sp)
 56a:	7b02                	ld	s6,32(sp)
 56c:	6be2                	ld	s7,24(sp)
 56e:	6125                	addi	sp,sp,96
 570:	8082                	ret

0000000000000572 <stat>:

int
stat(const char *n, struct stat *st)
{
 572:	1101                	addi	sp,sp,-32
 574:	ec06                	sd	ra,24(sp)
 576:	e822                	sd	s0,16(sp)
 578:	e426                	sd	s1,8(sp)
 57a:	e04a                	sd	s2,0(sp)
 57c:	1000                	addi	s0,sp,32
 57e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 580:	4581                	li	a1,0
 582:	00000097          	auipc	ra,0x0
 586:	172080e7          	jalr	370(ra) # 6f4 <open>
  if(fd < 0)
 58a:	02054563          	bltz	a0,5b4 <stat+0x42>
 58e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 590:	85ca                	mv	a1,s2
 592:	00000097          	auipc	ra,0x0
 596:	17a080e7          	jalr	378(ra) # 70c <fstat>
 59a:	892a                	mv	s2,a0
  close(fd);
 59c:	8526                	mv	a0,s1
 59e:	00000097          	auipc	ra,0x0
 5a2:	13e080e7          	jalr	318(ra) # 6dc <close>
  return r;
}
 5a6:	854a                	mv	a0,s2
 5a8:	60e2                	ld	ra,24(sp)
 5aa:	6442                	ld	s0,16(sp)
 5ac:	64a2                	ld	s1,8(sp)
 5ae:	6902                	ld	s2,0(sp)
 5b0:	6105                	addi	sp,sp,32
 5b2:	8082                	ret
    return -1;
 5b4:	597d                	li	s2,-1
 5b6:	bfc5                	j	5a6 <stat+0x34>

00000000000005b8 <atoi>:

int
atoi(const char *s)
{
 5b8:	1141                	addi	sp,sp,-16
 5ba:	e422                	sd	s0,8(sp)
 5bc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5be:	00054603          	lbu	a2,0(a0)
 5c2:	fd06079b          	addiw	a5,a2,-48
 5c6:	0ff7f793          	zext.b	a5,a5
 5ca:	4725                	li	a4,9
 5cc:	02f76963          	bltu	a4,a5,5fe <atoi+0x46>
 5d0:	86aa                	mv	a3,a0
  n = 0;
 5d2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 5d4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 5d6:	0685                	addi	a3,a3,1
 5d8:	0025179b          	slliw	a5,a0,0x2
 5dc:	9fa9                	addw	a5,a5,a0
 5de:	0017979b          	slliw	a5,a5,0x1
 5e2:	9fb1                	addw	a5,a5,a2
 5e4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5e8:	0006c603          	lbu	a2,0(a3)
 5ec:	fd06071b          	addiw	a4,a2,-48
 5f0:	0ff77713          	zext.b	a4,a4
 5f4:	fee5f1e3          	bgeu	a1,a4,5d6 <atoi+0x1e>
  return n;
}
 5f8:	6422                	ld	s0,8(sp)
 5fa:	0141                	addi	sp,sp,16
 5fc:	8082                	ret
  n = 0;
 5fe:	4501                	li	a0,0
 600:	bfe5                	j	5f8 <atoi+0x40>

0000000000000602 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 602:	1141                	addi	sp,sp,-16
 604:	e422                	sd	s0,8(sp)
 606:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 608:	02b57463          	bgeu	a0,a1,630 <memmove+0x2e>
    while(n-- > 0)
 60c:	00c05f63          	blez	a2,62a <memmove+0x28>
 610:	1602                	slli	a2,a2,0x20
 612:	9201                	srli	a2,a2,0x20
 614:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 618:	872a                	mv	a4,a0
      *dst++ = *src++;
 61a:	0585                	addi	a1,a1,1
 61c:	0705                	addi	a4,a4,1
 61e:	fff5c683          	lbu	a3,-1(a1)
 622:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 626:	fee79ae3          	bne	a5,a4,61a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 62a:	6422                	ld	s0,8(sp)
 62c:	0141                	addi	sp,sp,16
 62e:	8082                	ret
    dst += n;
 630:	00c50733          	add	a4,a0,a2
    src += n;
 634:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 636:	fec05ae3          	blez	a2,62a <memmove+0x28>
 63a:	fff6079b          	addiw	a5,a2,-1
 63e:	1782                	slli	a5,a5,0x20
 640:	9381                	srli	a5,a5,0x20
 642:	fff7c793          	not	a5,a5
 646:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 648:	15fd                	addi	a1,a1,-1
 64a:	177d                	addi	a4,a4,-1
 64c:	0005c683          	lbu	a3,0(a1)
 650:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 654:	fee79ae3          	bne	a5,a4,648 <memmove+0x46>
 658:	bfc9                	j	62a <memmove+0x28>

000000000000065a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 65a:	1141                	addi	sp,sp,-16
 65c:	e422                	sd	s0,8(sp)
 65e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 660:	ca05                	beqz	a2,690 <memcmp+0x36>
 662:	fff6069b          	addiw	a3,a2,-1
 666:	1682                	slli	a3,a3,0x20
 668:	9281                	srli	a3,a3,0x20
 66a:	0685                	addi	a3,a3,1
 66c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 66e:	00054783          	lbu	a5,0(a0)
 672:	0005c703          	lbu	a4,0(a1)
 676:	00e79863          	bne	a5,a4,686 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 67a:	0505                	addi	a0,a0,1
    p2++;
 67c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 67e:	fed518e3          	bne	a0,a3,66e <memcmp+0x14>
  }
  return 0;
 682:	4501                	li	a0,0
 684:	a019                	j	68a <memcmp+0x30>
      return *p1 - *p2;
 686:	40e7853b          	subw	a0,a5,a4
}
 68a:	6422                	ld	s0,8(sp)
 68c:	0141                	addi	sp,sp,16
 68e:	8082                	ret
  return 0;
 690:	4501                	li	a0,0
 692:	bfe5                	j	68a <memcmp+0x30>

0000000000000694 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 694:	1141                	addi	sp,sp,-16
 696:	e406                	sd	ra,8(sp)
 698:	e022                	sd	s0,0(sp)
 69a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 69c:	00000097          	auipc	ra,0x0
 6a0:	f66080e7          	jalr	-154(ra) # 602 <memmove>
}
 6a4:	60a2                	ld	ra,8(sp)
 6a6:	6402                	ld	s0,0(sp)
 6a8:	0141                	addi	sp,sp,16
 6aa:	8082                	ret

00000000000006ac <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6ac:	4885                	li	a7,1
 ecall
 6ae:	00000073          	ecall
 ret
 6b2:	8082                	ret

00000000000006b4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6b4:	4889                	li	a7,2
 ecall
 6b6:	00000073          	ecall
 ret
 6ba:	8082                	ret

00000000000006bc <wait>:
.global wait
wait:
 li a7, SYS_wait
 6bc:	488d                	li	a7,3
 ecall
 6be:	00000073          	ecall
 ret
 6c2:	8082                	ret

00000000000006c4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6c4:	4891                	li	a7,4
 ecall
 6c6:	00000073          	ecall
 ret
 6ca:	8082                	ret

00000000000006cc <read>:
.global read
read:
 li a7, SYS_read
 6cc:	4895                	li	a7,5
 ecall
 6ce:	00000073          	ecall
 ret
 6d2:	8082                	ret

00000000000006d4 <write>:
.global write
write:
 li a7, SYS_write
 6d4:	48c1                	li	a7,16
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <close>:
.global close
close:
 li a7, SYS_close
 6dc:	48d5                	li	a7,21
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6e4:	4899                	li	a7,6
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <exec>:
.global exec
exec:
 li a7, SYS_exec
 6ec:	489d                	li	a7,7
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <open>:
.global open
open:
 li a7, SYS_open
 6f4:	48bd                	li	a7,15
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6fc:	48c5                	li	a7,17
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 704:	48c9                	li	a7,18
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 70c:	48a1                	li	a7,8
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <link>:
.global link
link:
 li a7, SYS_link
 714:	48cd                	li	a7,19
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 71c:	48d1                	li	a7,20
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 724:	48a5                	li	a7,9
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <dup>:
.global dup
dup:
 li a7, SYS_dup
 72c:	48a9                	li	a7,10
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 734:	48ad                	li	a7,11
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 73c:	48b1                	li	a7,12
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 744:	48b5                	li	a7,13
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 74c:	48b9                	li	a7,14
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 754:	48d9                	li	a7,22
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 75c:	1101                	addi	sp,sp,-32
 75e:	ec06                	sd	ra,24(sp)
 760:	e822                	sd	s0,16(sp)
 762:	1000                	addi	s0,sp,32
 764:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 768:	4605                	li	a2,1
 76a:	fef40593          	addi	a1,s0,-17
 76e:	00000097          	auipc	ra,0x0
 772:	f66080e7          	jalr	-154(ra) # 6d4 <write>
}
 776:	60e2                	ld	ra,24(sp)
 778:	6442                	ld	s0,16(sp)
 77a:	6105                	addi	sp,sp,32
 77c:	8082                	ret

000000000000077e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 77e:	7139                	addi	sp,sp,-64
 780:	fc06                	sd	ra,56(sp)
 782:	f822                	sd	s0,48(sp)
 784:	f426                	sd	s1,40(sp)
 786:	f04a                	sd	s2,32(sp)
 788:	ec4e                	sd	s3,24(sp)
 78a:	0080                	addi	s0,sp,64
 78c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 78e:	c299                	beqz	a3,794 <printint+0x16>
 790:	0805c863          	bltz	a1,820 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 794:	2581                	sext.w	a1,a1
  neg = 0;
 796:	4881                	li	a7,0
 798:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 79c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 79e:	2601                	sext.w	a2,a2
 7a0:	00000517          	auipc	a0,0x0
 7a4:	55850513          	addi	a0,a0,1368 # cf8 <digits>
 7a8:	883a                	mv	a6,a4
 7aa:	2705                	addiw	a4,a4,1
 7ac:	02c5f7bb          	remuw	a5,a1,a2
 7b0:	1782                	slli	a5,a5,0x20
 7b2:	9381                	srli	a5,a5,0x20
 7b4:	97aa                	add	a5,a5,a0
 7b6:	0007c783          	lbu	a5,0(a5)
 7ba:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7be:	0005879b          	sext.w	a5,a1
 7c2:	02c5d5bb          	divuw	a1,a1,a2
 7c6:	0685                	addi	a3,a3,1
 7c8:	fec7f0e3          	bgeu	a5,a2,7a8 <printint+0x2a>
  if(neg)
 7cc:	00088b63          	beqz	a7,7e2 <printint+0x64>
    buf[i++] = '-';
 7d0:	fd040793          	addi	a5,s0,-48
 7d4:	973e                	add	a4,a4,a5
 7d6:	02d00793          	li	a5,45
 7da:	fef70823          	sb	a5,-16(a4)
 7de:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7e2:	02e05863          	blez	a4,812 <printint+0x94>
 7e6:	fc040793          	addi	a5,s0,-64
 7ea:	00e78933          	add	s2,a5,a4
 7ee:	fff78993          	addi	s3,a5,-1
 7f2:	99ba                	add	s3,s3,a4
 7f4:	377d                	addiw	a4,a4,-1
 7f6:	1702                	slli	a4,a4,0x20
 7f8:	9301                	srli	a4,a4,0x20
 7fa:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7fe:	fff94583          	lbu	a1,-1(s2)
 802:	8526                	mv	a0,s1
 804:	00000097          	auipc	ra,0x0
 808:	f58080e7          	jalr	-168(ra) # 75c <putc>
  while(--i >= 0)
 80c:	197d                	addi	s2,s2,-1
 80e:	ff3918e3          	bne	s2,s3,7fe <printint+0x80>
}
 812:	70e2                	ld	ra,56(sp)
 814:	7442                	ld	s0,48(sp)
 816:	74a2                	ld	s1,40(sp)
 818:	7902                	ld	s2,32(sp)
 81a:	69e2                	ld	s3,24(sp)
 81c:	6121                	addi	sp,sp,64
 81e:	8082                	ret
    x = -xx;
 820:	40b005bb          	negw	a1,a1
    neg = 1;
 824:	4885                	li	a7,1
    x = -xx;
 826:	bf8d                	j	798 <printint+0x1a>

0000000000000828 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 828:	7119                	addi	sp,sp,-128
 82a:	fc86                	sd	ra,120(sp)
 82c:	f8a2                	sd	s0,112(sp)
 82e:	f4a6                	sd	s1,104(sp)
 830:	f0ca                	sd	s2,96(sp)
 832:	ecce                	sd	s3,88(sp)
 834:	e8d2                	sd	s4,80(sp)
 836:	e4d6                	sd	s5,72(sp)
 838:	e0da                	sd	s6,64(sp)
 83a:	fc5e                	sd	s7,56(sp)
 83c:	f862                	sd	s8,48(sp)
 83e:	f466                	sd	s9,40(sp)
 840:	f06a                	sd	s10,32(sp)
 842:	ec6e                	sd	s11,24(sp)
 844:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 846:	0005c903          	lbu	s2,0(a1)
 84a:	18090f63          	beqz	s2,9e8 <vprintf+0x1c0>
 84e:	8aaa                	mv	s5,a0
 850:	8b32                	mv	s6,a2
 852:	00158493          	addi	s1,a1,1
  state = 0;
 856:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 858:	02500a13          	li	s4,37
      if(c == 'd'){
 85c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 860:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 864:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 868:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 86c:	00000b97          	auipc	s7,0x0
 870:	48cb8b93          	addi	s7,s7,1164 # cf8 <digits>
 874:	a839                	j	892 <vprintf+0x6a>
        putc(fd, c);
 876:	85ca                	mv	a1,s2
 878:	8556                	mv	a0,s5
 87a:	00000097          	auipc	ra,0x0
 87e:	ee2080e7          	jalr	-286(ra) # 75c <putc>
 882:	a019                	j	888 <vprintf+0x60>
    } else if(state == '%'){
 884:	01498f63          	beq	s3,s4,8a2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 888:	0485                	addi	s1,s1,1
 88a:	fff4c903          	lbu	s2,-1(s1)
 88e:	14090d63          	beqz	s2,9e8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 892:	0009079b          	sext.w	a5,s2
    if(state == 0){
 896:	fe0997e3          	bnez	s3,884 <vprintf+0x5c>
      if(c == '%'){
 89a:	fd479ee3          	bne	a5,s4,876 <vprintf+0x4e>
        state = '%';
 89e:	89be                	mv	s3,a5
 8a0:	b7e5                	j	888 <vprintf+0x60>
      if(c == 'd'){
 8a2:	05878063          	beq	a5,s8,8e2 <vprintf+0xba>
      } else if(c == 'l') {
 8a6:	05978c63          	beq	a5,s9,8fe <vprintf+0xd6>
      } else if(c == 'x') {
 8aa:	07a78863          	beq	a5,s10,91a <vprintf+0xf2>
      } else if(c == 'p') {
 8ae:	09b78463          	beq	a5,s11,936 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8b2:	07300713          	li	a4,115
 8b6:	0ce78663          	beq	a5,a4,982 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8ba:	06300713          	li	a4,99
 8be:	0ee78e63          	beq	a5,a4,9ba <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8c2:	11478863          	beq	a5,s4,9d2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8c6:	85d2                	mv	a1,s4
 8c8:	8556                	mv	a0,s5
 8ca:	00000097          	auipc	ra,0x0
 8ce:	e92080e7          	jalr	-366(ra) # 75c <putc>
        putc(fd, c);
 8d2:	85ca                	mv	a1,s2
 8d4:	8556                	mv	a0,s5
 8d6:	00000097          	auipc	ra,0x0
 8da:	e86080e7          	jalr	-378(ra) # 75c <putc>
      }
      state = 0;
 8de:	4981                	li	s3,0
 8e0:	b765                	j	888 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8e2:	008b0913          	addi	s2,s6,8
 8e6:	4685                	li	a3,1
 8e8:	4629                	li	a2,10
 8ea:	000b2583          	lw	a1,0(s6)
 8ee:	8556                	mv	a0,s5
 8f0:	00000097          	auipc	ra,0x0
 8f4:	e8e080e7          	jalr	-370(ra) # 77e <printint>
 8f8:	8b4a                	mv	s6,s2
      state = 0;
 8fa:	4981                	li	s3,0
 8fc:	b771                	j	888 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8fe:	008b0913          	addi	s2,s6,8
 902:	4681                	li	a3,0
 904:	4629                	li	a2,10
 906:	000b2583          	lw	a1,0(s6)
 90a:	8556                	mv	a0,s5
 90c:	00000097          	auipc	ra,0x0
 910:	e72080e7          	jalr	-398(ra) # 77e <printint>
 914:	8b4a                	mv	s6,s2
      state = 0;
 916:	4981                	li	s3,0
 918:	bf85                	j	888 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 91a:	008b0913          	addi	s2,s6,8
 91e:	4681                	li	a3,0
 920:	4641                	li	a2,16
 922:	000b2583          	lw	a1,0(s6)
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	e56080e7          	jalr	-426(ra) # 77e <printint>
 930:	8b4a                	mv	s6,s2
      state = 0;
 932:	4981                	li	s3,0
 934:	bf91                	j	888 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 936:	008b0793          	addi	a5,s6,8
 93a:	f8f43423          	sd	a5,-120(s0)
 93e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 942:	03000593          	li	a1,48
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	e14080e7          	jalr	-492(ra) # 75c <putc>
  putc(fd, 'x');
 950:	85ea                	mv	a1,s10
 952:	8556                	mv	a0,s5
 954:	00000097          	auipc	ra,0x0
 958:	e08080e7          	jalr	-504(ra) # 75c <putc>
 95c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 95e:	03c9d793          	srli	a5,s3,0x3c
 962:	97de                	add	a5,a5,s7
 964:	0007c583          	lbu	a1,0(a5)
 968:	8556                	mv	a0,s5
 96a:	00000097          	auipc	ra,0x0
 96e:	df2080e7          	jalr	-526(ra) # 75c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 972:	0992                	slli	s3,s3,0x4
 974:	397d                	addiw	s2,s2,-1
 976:	fe0914e3          	bnez	s2,95e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 97a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 97e:	4981                	li	s3,0
 980:	b721                	j	888 <vprintf+0x60>
        s = va_arg(ap, char*);
 982:	008b0993          	addi	s3,s6,8
 986:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 98a:	02090163          	beqz	s2,9ac <vprintf+0x184>
        while(*s != 0){
 98e:	00094583          	lbu	a1,0(s2)
 992:	c9a1                	beqz	a1,9e2 <vprintf+0x1ba>
          putc(fd, *s);
 994:	8556                	mv	a0,s5
 996:	00000097          	auipc	ra,0x0
 99a:	dc6080e7          	jalr	-570(ra) # 75c <putc>
          s++;
 99e:	0905                	addi	s2,s2,1
        while(*s != 0){
 9a0:	00094583          	lbu	a1,0(s2)
 9a4:	f9e5                	bnez	a1,994 <vprintf+0x16c>
        s = va_arg(ap, char*);
 9a6:	8b4e                	mv	s6,s3
      state = 0;
 9a8:	4981                	li	s3,0
 9aa:	bdf9                	j	888 <vprintf+0x60>
          s = "(null)";
 9ac:	00000917          	auipc	s2,0x0
 9b0:	34490913          	addi	s2,s2,836 # cf0 <malloc+0x1fe>
        while(*s != 0){
 9b4:	02800593          	li	a1,40
 9b8:	bff1                	j	994 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 9ba:	008b0913          	addi	s2,s6,8
 9be:	000b4583          	lbu	a1,0(s6)
 9c2:	8556                	mv	a0,s5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	d98080e7          	jalr	-616(ra) # 75c <putc>
 9cc:	8b4a                	mv	s6,s2
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	bd65                	j	888 <vprintf+0x60>
        putc(fd, c);
 9d2:	85d2                	mv	a1,s4
 9d4:	8556                	mv	a0,s5
 9d6:	00000097          	auipc	ra,0x0
 9da:	d86080e7          	jalr	-634(ra) # 75c <putc>
      state = 0;
 9de:	4981                	li	s3,0
 9e0:	b565                	j	888 <vprintf+0x60>
        s = va_arg(ap, char*);
 9e2:	8b4e                	mv	s6,s3
      state = 0;
 9e4:	4981                	li	s3,0
 9e6:	b54d                	j	888 <vprintf+0x60>
    }
  }
}
 9e8:	70e6                	ld	ra,120(sp)
 9ea:	7446                	ld	s0,112(sp)
 9ec:	74a6                	ld	s1,104(sp)
 9ee:	7906                	ld	s2,96(sp)
 9f0:	69e6                	ld	s3,88(sp)
 9f2:	6a46                	ld	s4,80(sp)
 9f4:	6aa6                	ld	s5,72(sp)
 9f6:	6b06                	ld	s6,64(sp)
 9f8:	7be2                	ld	s7,56(sp)
 9fa:	7c42                	ld	s8,48(sp)
 9fc:	7ca2                	ld	s9,40(sp)
 9fe:	7d02                	ld	s10,32(sp)
 a00:	6de2                	ld	s11,24(sp)
 a02:	6109                	addi	sp,sp,128
 a04:	8082                	ret

0000000000000a06 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a06:	715d                	addi	sp,sp,-80
 a08:	ec06                	sd	ra,24(sp)
 a0a:	e822                	sd	s0,16(sp)
 a0c:	1000                	addi	s0,sp,32
 a0e:	e010                	sd	a2,0(s0)
 a10:	e414                	sd	a3,8(s0)
 a12:	e818                	sd	a4,16(s0)
 a14:	ec1c                	sd	a5,24(s0)
 a16:	03043023          	sd	a6,32(s0)
 a1a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a1e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a22:	8622                	mv	a2,s0
 a24:	00000097          	auipc	ra,0x0
 a28:	e04080e7          	jalr	-508(ra) # 828 <vprintf>
}
 a2c:	60e2                	ld	ra,24(sp)
 a2e:	6442                	ld	s0,16(sp)
 a30:	6161                	addi	sp,sp,80
 a32:	8082                	ret

0000000000000a34 <printf>:

void
printf(const char *fmt, ...)
{
 a34:	711d                	addi	sp,sp,-96
 a36:	ec06                	sd	ra,24(sp)
 a38:	e822                	sd	s0,16(sp)
 a3a:	1000                	addi	s0,sp,32
 a3c:	e40c                	sd	a1,8(s0)
 a3e:	e810                	sd	a2,16(s0)
 a40:	ec14                	sd	a3,24(s0)
 a42:	f018                	sd	a4,32(s0)
 a44:	f41c                	sd	a5,40(s0)
 a46:	03043823          	sd	a6,48(s0)
 a4a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a4e:	00840613          	addi	a2,s0,8
 a52:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a56:	85aa                	mv	a1,a0
 a58:	4505                	li	a0,1
 a5a:	00000097          	auipc	ra,0x0
 a5e:	dce080e7          	jalr	-562(ra) # 828 <vprintf>
}
 a62:	60e2                	ld	ra,24(sp)
 a64:	6442                	ld	s0,16(sp)
 a66:	6125                	addi	sp,sp,96
 a68:	8082                	ret

0000000000000a6a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a6a:	1141                	addi	sp,sp,-16
 a6c:	e422                	sd	s0,8(sp)
 a6e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a70:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a74:	00000797          	auipc	a5,0x0
 a78:	29c7b783          	ld	a5,668(a5) # d10 <freep>
 a7c:	a805                	j	aac <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a7e:	4618                	lw	a4,8(a2)
 a80:	9db9                	addw	a1,a1,a4
 a82:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a86:	6398                	ld	a4,0(a5)
 a88:	6318                	ld	a4,0(a4)
 a8a:	fee53823          	sd	a4,-16(a0)
 a8e:	a091                	j	ad2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a90:	ff852703          	lw	a4,-8(a0)
 a94:	9e39                	addw	a2,a2,a4
 a96:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a98:	ff053703          	ld	a4,-16(a0)
 a9c:	e398                	sd	a4,0(a5)
 a9e:	a099                	j	ae4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa0:	6398                	ld	a4,0(a5)
 aa2:	00e7e463          	bltu	a5,a4,aaa <free+0x40>
 aa6:	00e6ea63          	bltu	a3,a4,aba <free+0x50>
{
 aaa:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aac:	fed7fae3          	bgeu	a5,a3,aa0 <free+0x36>
 ab0:	6398                	ld	a4,0(a5)
 ab2:	00e6e463          	bltu	a3,a4,aba <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab6:	fee7eae3          	bltu	a5,a4,aaa <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 aba:	ff852583          	lw	a1,-8(a0)
 abe:	6390                	ld	a2,0(a5)
 ac0:	02059813          	slli	a6,a1,0x20
 ac4:	01c85713          	srli	a4,a6,0x1c
 ac8:	9736                	add	a4,a4,a3
 aca:	fae60ae3          	beq	a2,a4,a7e <free+0x14>
    bp->s.ptr = p->s.ptr;
 ace:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ad2:	4790                	lw	a2,8(a5)
 ad4:	02061593          	slli	a1,a2,0x20
 ad8:	01c5d713          	srli	a4,a1,0x1c
 adc:	973e                	add	a4,a4,a5
 ade:	fae689e3          	beq	a3,a4,a90 <free+0x26>
  } else
    p->s.ptr = bp;
 ae2:	e394                	sd	a3,0(a5)
  freep = p;
 ae4:	00000717          	auipc	a4,0x0
 ae8:	22f73623          	sd	a5,556(a4) # d10 <freep>
}
 aec:	6422                	ld	s0,8(sp)
 aee:	0141                	addi	sp,sp,16
 af0:	8082                	ret

0000000000000af2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 af2:	7139                	addi	sp,sp,-64
 af4:	fc06                	sd	ra,56(sp)
 af6:	f822                	sd	s0,48(sp)
 af8:	f426                	sd	s1,40(sp)
 afa:	f04a                	sd	s2,32(sp)
 afc:	ec4e                	sd	s3,24(sp)
 afe:	e852                	sd	s4,16(sp)
 b00:	e456                	sd	s5,8(sp)
 b02:	e05a                	sd	s6,0(sp)
 b04:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b06:	02051493          	slli	s1,a0,0x20
 b0a:	9081                	srli	s1,s1,0x20
 b0c:	04bd                	addi	s1,s1,15
 b0e:	8091                	srli	s1,s1,0x4
 b10:	0014899b          	addiw	s3,s1,1
 b14:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b16:	00000517          	auipc	a0,0x0
 b1a:	1fa53503          	ld	a0,506(a0) # d10 <freep>
 b1e:	c515                	beqz	a0,b4a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b20:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b22:	4798                	lw	a4,8(a5)
 b24:	02977f63          	bgeu	a4,s1,b62 <malloc+0x70>
 b28:	8a4e                	mv	s4,s3
 b2a:	0009871b          	sext.w	a4,s3
 b2e:	6685                	lui	a3,0x1
 b30:	00d77363          	bgeu	a4,a3,b36 <malloc+0x44>
 b34:	6a05                	lui	s4,0x1
 b36:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b3a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b3e:	00000917          	auipc	s2,0x0
 b42:	1d290913          	addi	s2,s2,466 # d10 <freep>
  if(p == (char*)-1)
 b46:	5afd                	li	s5,-1
 b48:	a895                	j	bbc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b4a:	00000797          	auipc	a5,0x0
 b4e:	2be78793          	addi	a5,a5,702 # e08 <base>
 b52:	00000717          	auipc	a4,0x0
 b56:	1af73f23          	sd	a5,446(a4) # d10 <freep>
 b5a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b5c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b60:	b7e1                	j	b28 <malloc+0x36>
      if(p->s.size == nunits)
 b62:	02e48c63          	beq	s1,a4,b9a <malloc+0xa8>
        p->s.size -= nunits;
 b66:	4137073b          	subw	a4,a4,s3
 b6a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b6c:	02071693          	slli	a3,a4,0x20
 b70:	01c6d713          	srli	a4,a3,0x1c
 b74:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b76:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b7a:	00000717          	auipc	a4,0x0
 b7e:	18a73b23          	sd	a0,406(a4) # d10 <freep>
      return (void*)(p + 1);
 b82:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b86:	70e2                	ld	ra,56(sp)
 b88:	7442                	ld	s0,48(sp)
 b8a:	74a2                	ld	s1,40(sp)
 b8c:	7902                	ld	s2,32(sp)
 b8e:	69e2                	ld	s3,24(sp)
 b90:	6a42                	ld	s4,16(sp)
 b92:	6aa2                	ld	s5,8(sp)
 b94:	6b02                	ld	s6,0(sp)
 b96:	6121                	addi	sp,sp,64
 b98:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b9a:	6398                	ld	a4,0(a5)
 b9c:	e118                	sd	a4,0(a0)
 b9e:	bff1                	j	b7a <malloc+0x88>
  hp->s.size = nu;
 ba0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ba4:	0541                	addi	a0,a0,16
 ba6:	00000097          	auipc	ra,0x0
 baa:	ec4080e7          	jalr	-316(ra) # a6a <free>
  return freep;
 bae:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bb2:	d971                	beqz	a0,b86 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bb6:	4798                	lw	a4,8(a5)
 bb8:	fa9775e3          	bgeu	a4,s1,b62 <malloc+0x70>
    if(p == freep)
 bbc:	00093703          	ld	a4,0(s2)
 bc0:	853e                	mv	a0,a5
 bc2:	fef719e3          	bne	a4,a5,bb4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 bc6:	8552                	mv	a0,s4
 bc8:	00000097          	auipc	ra,0x0
 bcc:	b74080e7          	jalr	-1164(ra) # 73c <sbrk>
  if(p == (char*)-1)
 bd0:	fd5518e3          	bne	a0,s5,ba0 <malloc+0xae>
        return 0;
 bd4:	4501                	li	a0,0
 bd6:	bf45                	j	b86 <malloc+0x94>
