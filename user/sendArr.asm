
user/_sendArr:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
//#include <unistd.h>

#define SIZE 4096

int main()
{  
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	0080                	addi	s0,sp,64
  10:	737d                	lui	t1,0xfffff
  12:	911a                	add	sp,sp,t1
    int fd[2],i;
    pipe(fd);
  14:	fc840513          	addi	a0,s0,-56
  18:	00000097          	auipc	ra,0x0
  1c:	5e4080e7          	jalr	1508(ra) # 5fc <pipe>
    int pid = fork();
  20:	00000097          	auipc	ra,0x0
  24:	5c4080e7          	jalr	1476(ra) # 5e4 <fork>

    if(pid > 0){
  28:	04a04e63          	bgtz	a0,84 <main+0x84>
        for(i=0;i<n/4;i++){
            printf("%d ",arr[i]);
        }
        printf("\n");
    }
    else if(pid == 0){
  2c:	ed7d                	bnez	a0,12a <main+0x12a>
  2e:	77fd                	lui	a5,0xfffff
  30:	17e1                	addi	a5,a5,-8
  32:	fd040713          	addi	a4,s0,-48
  36:	97ba                	add	a5,a5,a4
        int arr[1024];
        for(int i=0;i<10;i++){
  38:	46a9                	li	a3,10
            arr[i] = i+1;
  3a:	0015071b          	addiw	a4,a0,1
  3e:	0007051b          	sext.w	a0,a4
  42:	c398                	sw	a4,0(a5)
        for(int i=0;i<10;i++){
  44:	0791                	addi	a5,a5,4
  46:	fed51ae3          	bne	a0,a3,3a <main+0x3a>
        }
        close(fd[0]);
  4a:	fc842503          	lw	a0,-56(s0)
  4e:	00000097          	auipc	ra,0x0
  52:	5c6080e7          	jalr	1478(ra) # 614 <close>
        close(1);
  56:	4505                	li	a0,1
  58:	00000097          	auipc	ra,0x0
  5c:	5bc080e7          	jalr	1468(ra) # 614 <close>
        dup(fd[1]);
  60:	fcc42503          	lw	a0,-52(s0)
  64:	00000097          	auipc	ra,0x0
  68:	600080e7          	jalr	1536(ra) # 664 <dup>
        write(1,arr,sizeof(arr));
  6c:	6605                	lui	a2,0x1
  6e:	75fd                	lui	a1,0xfffff
  70:	15e1                	addi	a1,a1,-8
  72:	fd040793          	addi	a5,s0,-48
  76:	95be                	add	a1,a1,a5
  78:	4505                	li	a0,1
  7a:	00000097          	auipc	ra,0x0
  7e:	592080e7          	jalr	1426(ra) # 60c <write>
  82:	a879                	j	120 <main+0x120>
        wait(NULL);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	56e080e7          	jalr	1390(ra) # 5f4 <wait>
        close(0);
  8e:	4501                	li	a0,0
  90:	00000097          	auipc	ra,0x0
  94:	584080e7          	jalr	1412(ra) # 614 <close>
        close(fd[1]);
  98:	fcc42503          	lw	a0,-52(s0)
  9c:	00000097          	auipc	ra,0x0
  a0:	578080e7          	jalr	1400(ra) # 614 <close>
        dup(fd[1]);
  a4:	fcc42503          	lw	a0,-52(s0)
  a8:	00000097          	auipc	ra,0x0
  ac:	5bc080e7          	jalr	1468(ra) # 664 <dup>
        int n=read(fd[0],arr,sizeof(arr));
  b0:	6605                	lui	a2,0x1
  b2:	75fd                	lui	a1,0xfffff
  b4:	15e1                	addi	a1,a1,-8
  b6:	fd040793          	addi	a5,s0,-48
  ba:	95be                	add	a1,a1,a5
  bc:	fc842503          	lw	a0,-56(s0)
  c0:	00000097          	auipc	ra,0x0
  c4:	544080e7          	jalr	1348(ra) # 604 <read>
  c8:	84aa                	mv	s1,a0
        printf("%d\n",n);
  ca:	85aa                	mv	a1,a0
  cc:	00001517          	auipc	a0,0x1
  d0:	a4450513          	addi	a0,a0,-1468 # b10 <malloc+0xe6>
  d4:	00001097          	auipc	ra,0x1
  d8:	898080e7          	jalr	-1896(ra) # 96c <printf>
        for(i=0;i<n/4;i++){
  dc:	4991                	li	s3,4
  de:	0334c9bb          	divw	s3,s1,s3
  e2:	478d                	li	a5,3
  e4:	0297d663          	bge	a5,s1,110 <main+0x110>
  e8:	74fd                	lui	s1,0xfffff
  ea:	14e1                	addi	s1,s1,-8
  ec:	fd040793          	addi	a5,s0,-48
  f0:	94be                	add	s1,s1,a5
  f2:	4901                	li	s2,0
            printf("%d ",arr[i]);
  f4:	00001a17          	auipc	s4,0x1
  f8:	a24a0a13          	addi	s4,s4,-1500 # b18 <malloc+0xee>
  fc:	408c                	lw	a1,0(s1)
  fe:	8552                	mv	a0,s4
 100:	00001097          	auipc	ra,0x1
 104:	86c080e7          	jalr	-1940(ra) # 96c <printf>
        for(i=0;i<n/4;i++){
 108:	2905                	addiw	s2,s2,1
 10a:	0491                	addi	s1,s1,4
 10c:	ff3948e3          	blt	s2,s3,fc <main+0xfc>
        printf("\n");
 110:	00001517          	auipc	a0,0x1
 114:	a1050513          	addi	a0,a0,-1520 # b20 <malloc+0xf6>
 118:	00001097          	auipc	ra,0x1
 11c:	854080e7          	jalr	-1964(ra) # 96c <printf>
    }
    else{
        printf("error");
    }
    exit(0);
 120:	4501                	li	a0,0
 122:	00000097          	auipc	ra,0x0
 126:	4ca080e7          	jalr	1226(ra) # 5ec <exit>
        printf("error");
 12a:	00001517          	auipc	a0,0x1
 12e:	9fe50513          	addi	a0,a0,-1538 # b28 <malloc+0xfe>
 132:	00001097          	auipc	ra,0x1
 136:	83a080e7          	jalr	-1990(ra) # 96c <printf>
 13a:	b7dd                	j	120 <main+0x120>

000000000000013c <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 13c:	1141                	addi	sp,sp,-16
 13e:	e422                	sd	s0,8(sp)
 140:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 142:	0f50000f          	fence	iorw,ow
 146:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 14a:	6422                	ld	s0,8(sp)
 14c:	0141                	addi	sp,sp,16
 14e:	8082                	ret

0000000000000150 <load>:

int load(uint64 *p) {
 150:	1141                	addi	sp,sp,-16
 152:	e422                	sd	s0,8(sp)
 154:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 156:	0ff0000f          	fence
 15a:	6108                	ld	a0,0(a0)
 15c:	0ff0000f          	fence
}
 160:	2501                	sext.w	a0,a0
 162:	6422                	ld	s0,8(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret

0000000000000168 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 168:	7179                	addi	sp,sp,-48
 16a:	f406                	sd	ra,40(sp)
 16c:	f022                	sd	s0,32(sp)
 16e:	ec26                	sd	s1,24(sp)
 170:	e84a                	sd	s2,16(sp)
 172:	e44e                	sd	s3,8(sp)
 174:	e052                	sd	s4,0(sp)
 176:	1800                	addi	s0,sp,48
 178:	8a2a                	mv	s4,a0
 17a:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 17c:	4785                	li	a5,1
 17e:	00001497          	auipc	s1,0x1
 182:	9ea48493          	addi	s1,s1,-1558 # b68 <rings+0x10>
 186:	00001917          	auipc	s2,0x1
 18a:	ad290913          	addi	s2,s2,-1326 # c58 <__BSS_END__>
 18e:	04f59563          	bne	a1,a5,1d8 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 192:	00001497          	auipc	s1,0x1
 196:	9d64a483          	lw	s1,-1578(s1) # b68 <rings+0x10>
 19a:	c099                	beqz	s1,1a0 <create_or_close_the_buffer_user+0x38>
 19c:	4481                	li	s1,0
 19e:	a899                	j	1f4 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 1a0:	00001917          	auipc	s2,0x1
 1a4:	9b890913          	addi	s2,s2,-1608 # b58 <rings>
 1a8:	00093603          	ld	a2,0(s2)
 1ac:	4585                	li	a1,1
 1ae:	00000097          	auipc	ra,0x0
 1b2:	4de080e7          	jalr	1246(ra) # 68c <ringbuf>
        rings[i].book->write_done = 0;
 1b6:	00893783          	ld	a5,8(s2)
 1ba:	0007b423          	sd	zero,8(a5) # fffffffffffff008 <__global_pointer$+0xffffffffffffdcbf>
        rings[i].book->read_done = 0;
 1be:	00893783          	ld	a5,8(s2)
 1c2:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 1c6:	01092783          	lw	a5,16(s2)
 1ca:	2785                	addiw	a5,a5,1
 1cc:	00f92823          	sw	a5,16(s2)
        break;
 1d0:	a015                	j	1f4 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 1d2:	04e1                	addi	s1,s1,24
 1d4:	01248f63          	beq	s1,s2,1f2 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 1d8:	409c                	lw	a5,0(s1)
 1da:	dfe5                	beqz	a5,1d2 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 1dc:	ff04b603          	ld	a2,-16(s1)
 1e0:	85ce                	mv	a1,s3
 1e2:	8552                	mv	a0,s4
 1e4:	00000097          	auipc	ra,0x0
 1e8:	4a8080e7          	jalr	1192(ra) # 68c <ringbuf>
        rings[i].exists = 0;
 1ec:	0004a023          	sw	zero,0(s1)
 1f0:	b7cd                	j	1d2 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 1f2:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 1f4:	8526                	mv	a0,s1
 1f6:	70a2                	ld	ra,40(sp)
 1f8:	7402                	ld	s0,32(sp)
 1fa:	64e2                	ld	s1,24(sp)
 1fc:	6942                	ld	s2,16(sp)
 1fe:	69a2                	ld	s3,8(sp)
 200:	6a02                	ld	s4,0(sp)
 202:	6145                	addi	sp,sp,48
 204:	8082                	ret

0000000000000206 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 206:	1101                	addi	sp,sp,-32
 208:	ec06                	sd	ra,24(sp)
 20a:	e822                	sd	s0,16(sp)
 20c:	e426                	sd	s1,8(sp)
 20e:	1000                	addi	s0,sp,32
 210:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 212:	00151793          	slli	a5,a0,0x1
 216:	97aa                	add	a5,a5,a0
 218:	078e                	slli	a5,a5,0x3
 21a:	00001717          	auipc	a4,0x1
 21e:	93e70713          	addi	a4,a4,-1730 # b58 <rings>
 222:	97ba                	add	a5,a5,a4
 224:	6798                	ld	a4,8(a5)
 226:	671c                	ld	a5,8(a4)
 228:	00178693          	addi	a3,a5,1
 22c:	e714                	sd	a3,8(a4)
 22e:	17d2                	slli	a5,a5,0x34
 230:	93d1                	srli	a5,a5,0x34
 232:	6741                	lui	a4,0x10
 234:	40f707b3          	sub	a5,a4,a5
 238:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 23a:	421c                	lw	a5,0(a2)
 23c:	e79d                	bnez	a5,26a <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 23e:	00001697          	auipc	a3,0x1
 242:	91a68693          	addi	a3,a3,-1766 # b58 <rings>
 246:	669c                	ld	a5,8(a3)
 248:	6398                	ld	a4,0(a5)
 24a:	67c1                	lui	a5,0x10
 24c:	9fb9                	addw	a5,a5,a4
 24e:	00151713          	slli	a4,a0,0x1
 252:	953a                	add	a0,a0,a4
 254:	050e                	slli	a0,a0,0x3
 256:	9536                	add	a0,a0,a3
 258:	6518                	ld	a4,8(a0)
 25a:	6718                	ld	a4,8(a4)
 25c:	9f99                	subw	a5,a5,a4
 25e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 260:	60e2                	ld	ra,24(sp)
 262:	6442                	ld	s0,16(sp)
 264:	64a2                	ld	s1,8(sp)
 266:	6105                	addi	sp,sp,32
 268:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 26a:	00151793          	slli	a5,a0,0x1
 26e:	953e                	add	a0,a0,a5
 270:	050e                	slli	a0,a0,0x3
 272:	00001797          	auipc	a5,0x1
 276:	8e678793          	addi	a5,a5,-1818 # b58 <rings>
 27a:	953e                	add	a0,a0,a5
 27c:	6508                	ld	a0,8(a0)
 27e:	0521                	addi	a0,a0,8
 280:	00000097          	auipc	ra,0x0
 284:	ed0080e7          	jalr	-304(ra) # 150 <load>
 288:	c088                	sw	a0,0(s1)
}
 28a:	bfd9                	j	260 <ringbuf_start_write+0x5a>

000000000000028c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 28c:	1141                	addi	sp,sp,-16
 28e:	e406                	sd	ra,8(sp)
 290:	e022                	sd	s0,0(sp)
 292:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 294:	00151793          	slli	a5,a0,0x1
 298:	97aa                	add	a5,a5,a0
 29a:	078e                	slli	a5,a5,0x3
 29c:	00001517          	auipc	a0,0x1
 2a0:	8bc50513          	addi	a0,a0,-1860 # b58 <rings>
 2a4:	97aa                	add	a5,a5,a0
 2a6:	6788                	ld	a0,8(a5)
 2a8:	0035959b          	slliw	a1,a1,0x3
 2ac:	0521                	addi	a0,a0,8
 2ae:	00000097          	auipc	ra,0x0
 2b2:	e8e080e7          	jalr	-370(ra) # 13c <store>
}
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e426                	sd	s1,8(sp)
 2c6:	1000                	addi	s0,sp,32
 2c8:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 2ca:	00151793          	slli	a5,a0,0x1
 2ce:	97aa                	add	a5,a5,a0
 2d0:	078e                	slli	a5,a5,0x3
 2d2:	00001517          	auipc	a0,0x1
 2d6:	88650513          	addi	a0,a0,-1914 # b58 <rings>
 2da:	97aa                	add	a5,a5,a0
 2dc:	6788                	ld	a0,8(a5)
 2de:	0521                	addi	a0,a0,8
 2e0:	00000097          	auipc	ra,0x0
 2e4:	e70080e7          	jalr	-400(ra) # 150 <load>
 2e8:	c088                	sw	a0,0(s1)
}
 2ea:	60e2                	ld	ra,24(sp)
 2ec:	6442                	ld	s0,16(sp)
 2ee:	64a2                	ld	s1,8(sp)
 2f0:	6105                	addi	sp,sp,32
 2f2:	8082                	ret

00000000000002f4 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2f4:	1101                	addi	sp,sp,-32
 2f6:	ec06                	sd	ra,24(sp)
 2f8:	e822                	sd	s0,16(sp)
 2fa:	e426                	sd	s1,8(sp)
 2fc:	1000                	addi	s0,sp,32
 2fe:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 300:	00151793          	slli	a5,a0,0x1
 304:	97aa                	add	a5,a5,a0
 306:	078e                	slli	a5,a5,0x3
 308:	00001517          	auipc	a0,0x1
 30c:	85050513          	addi	a0,a0,-1968 # b58 <rings>
 310:	97aa                	add	a5,a5,a0
 312:	6788                	ld	a0,8(a5)
 314:	611c                	ld	a5,0(a0)
 316:	ef99                	bnez	a5,334 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 318:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 31a:	41f7579b          	sraiw	a5,a4,0x1f
 31e:	01d7d79b          	srliw	a5,a5,0x1d
 322:	9fb9                	addw	a5,a5,a4
 324:	4037d79b          	sraiw	a5,a5,0x3
 328:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 32a:	60e2                	ld	ra,24(sp)
 32c:	6442                	ld	s0,16(sp)
 32e:	64a2                	ld	s1,8(sp)
 330:	6105                	addi	sp,sp,32
 332:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 334:	00000097          	auipc	ra,0x0
 338:	e1c080e7          	jalr	-484(ra) # 150 <load>
    *bytes /= 8;
 33c:	41f5579b          	sraiw	a5,a0,0x1f
 340:	01d7d79b          	srliw	a5,a5,0x1d
 344:	9d3d                	addw	a0,a0,a5
 346:	4035551b          	sraiw	a0,a0,0x3
 34a:	c088                	sw	a0,0(s1)
}
 34c:	bff9                	j	32a <ringbuf_start_read+0x36>

000000000000034e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 356:	00151793          	slli	a5,a0,0x1
 35a:	97aa                	add	a5,a5,a0
 35c:	078e                	slli	a5,a5,0x3
 35e:	00000517          	auipc	a0,0x0
 362:	7fa50513          	addi	a0,a0,2042 # b58 <rings>
 366:	97aa                	add	a5,a5,a0
 368:	0035959b          	slliw	a1,a1,0x3
 36c:	6788                	ld	a0,8(a5)
 36e:	00000097          	auipc	ra,0x0
 372:	dce080e7          	jalr	-562(ra) # 13c <store>
}
 376:	60a2                	ld	ra,8(sp)
 378:	6402                	ld	s0,0(sp)
 37a:	0141                	addi	sp,sp,16
 37c:	8082                	ret

000000000000037e <strcpy>:



char*
strcpy(char *s, const char *t)
{
 37e:	1141                	addi	sp,sp,-16
 380:	e422                	sd	s0,8(sp)
 382:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 384:	87aa                	mv	a5,a0
 386:	0585                	addi	a1,a1,1
 388:	0785                	addi	a5,a5,1
 38a:	fff5c703          	lbu	a4,-1(a1) # ffffffffffffefff <__global_pointer$+0xffffffffffffdcb6>
 38e:	fee78fa3          	sb	a4,-1(a5)
 392:	fb75                	bnez	a4,386 <strcpy+0x8>
    ;
  return os;
}
 394:	6422                	ld	s0,8(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret

000000000000039a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3a0:	00054783          	lbu	a5,0(a0)
 3a4:	cb91                	beqz	a5,3b8 <strcmp+0x1e>
 3a6:	0005c703          	lbu	a4,0(a1)
 3aa:	00f71763          	bne	a4,a5,3b8 <strcmp+0x1e>
    p++, q++;
 3ae:	0505                	addi	a0,a0,1
 3b0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3b2:	00054783          	lbu	a5,0(a0)
 3b6:	fbe5                	bnez	a5,3a6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3b8:	0005c503          	lbu	a0,0(a1)
}
 3bc:	40a7853b          	subw	a0,a5,a0
 3c0:	6422                	ld	s0,8(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <strlen>:

uint
strlen(const char *s)
{
 3c6:	1141                	addi	sp,sp,-16
 3c8:	e422                	sd	s0,8(sp)
 3ca:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3cc:	00054783          	lbu	a5,0(a0)
 3d0:	cf91                	beqz	a5,3ec <strlen+0x26>
 3d2:	0505                	addi	a0,a0,1
 3d4:	87aa                	mv	a5,a0
 3d6:	4685                	li	a3,1
 3d8:	9e89                	subw	a3,a3,a0
 3da:	00f6853b          	addw	a0,a3,a5
 3de:	0785                	addi	a5,a5,1
 3e0:	fff7c703          	lbu	a4,-1(a5)
 3e4:	fb7d                	bnez	a4,3da <strlen+0x14>
    ;
  return n;
}
 3e6:	6422                	ld	s0,8(sp)
 3e8:	0141                	addi	sp,sp,16
 3ea:	8082                	ret
  for(n = 0; s[n]; n++)
 3ec:	4501                	li	a0,0
 3ee:	bfe5                	j	3e6 <strlen+0x20>

00000000000003f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f0:	1141                	addi	sp,sp,-16
 3f2:	e422                	sd	s0,8(sp)
 3f4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3f6:	ca19                	beqz	a2,40c <memset+0x1c>
 3f8:	87aa                	mv	a5,a0
 3fa:	1602                	slli	a2,a2,0x20
 3fc:	9201                	srli	a2,a2,0x20
 3fe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 402:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 406:	0785                	addi	a5,a5,1
 408:	fee79de3          	bne	a5,a4,402 <memset+0x12>
  }
  return dst;
}
 40c:	6422                	ld	s0,8(sp)
 40e:	0141                	addi	sp,sp,16
 410:	8082                	ret

0000000000000412 <strchr>:

char*
strchr(const char *s, char c)
{
 412:	1141                	addi	sp,sp,-16
 414:	e422                	sd	s0,8(sp)
 416:	0800                	addi	s0,sp,16
  for(; *s; s++)
 418:	00054783          	lbu	a5,0(a0)
 41c:	cb99                	beqz	a5,432 <strchr+0x20>
    if(*s == c)
 41e:	00f58763          	beq	a1,a5,42c <strchr+0x1a>
  for(; *s; s++)
 422:	0505                	addi	a0,a0,1
 424:	00054783          	lbu	a5,0(a0)
 428:	fbfd                	bnez	a5,41e <strchr+0xc>
      return (char*)s;
  return 0;
 42a:	4501                	li	a0,0
}
 42c:	6422                	ld	s0,8(sp)
 42e:	0141                	addi	sp,sp,16
 430:	8082                	ret
  return 0;
 432:	4501                	li	a0,0
 434:	bfe5                	j	42c <strchr+0x1a>

0000000000000436 <gets>:

char*
gets(char *buf, int max)
{
 436:	711d                	addi	sp,sp,-96
 438:	ec86                	sd	ra,88(sp)
 43a:	e8a2                	sd	s0,80(sp)
 43c:	e4a6                	sd	s1,72(sp)
 43e:	e0ca                	sd	s2,64(sp)
 440:	fc4e                	sd	s3,56(sp)
 442:	f852                	sd	s4,48(sp)
 444:	f456                	sd	s5,40(sp)
 446:	f05a                	sd	s6,32(sp)
 448:	ec5e                	sd	s7,24(sp)
 44a:	1080                	addi	s0,sp,96
 44c:	8baa                	mv	s7,a0
 44e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 450:	892a                	mv	s2,a0
 452:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 454:	4aa9                	li	s5,10
 456:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 458:	89a6                	mv	s3,s1
 45a:	2485                	addiw	s1,s1,1
 45c:	0344d863          	bge	s1,s4,48c <gets+0x56>
    cc = read(0, &c, 1);
 460:	4605                	li	a2,1
 462:	faf40593          	addi	a1,s0,-81
 466:	4501                	li	a0,0
 468:	00000097          	auipc	ra,0x0
 46c:	19c080e7          	jalr	412(ra) # 604 <read>
    if(cc < 1)
 470:	00a05e63          	blez	a0,48c <gets+0x56>
    buf[i++] = c;
 474:	faf44783          	lbu	a5,-81(s0)
 478:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 47c:	01578763          	beq	a5,s5,48a <gets+0x54>
 480:	0905                	addi	s2,s2,1
 482:	fd679be3          	bne	a5,s6,458 <gets+0x22>
  for(i=0; i+1 < max; ){
 486:	89a6                	mv	s3,s1
 488:	a011                	j	48c <gets+0x56>
 48a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 48c:	99de                	add	s3,s3,s7
 48e:	00098023          	sb	zero,0(s3)
  return buf;
}
 492:	855e                	mv	a0,s7
 494:	60e6                	ld	ra,88(sp)
 496:	6446                	ld	s0,80(sp)
 498:	64a6                	ld	s1,72(sp)
 49a:	6906                	ld	s2,64(sp)
 49c:	79e2                	ld	s3,56(sp)
 49e:	7a42                	ld	s4,48(sp)
 4a0:	7aa2                	ld	s5,40(sp)
 4a2:	7b02                	ld	s6,32(sp)
 4a4:	6be2                	ld	s7,24(sp)
 4a6:	6125                	addi	sp,sp,96
 4a8:	8082                	ret

00000000000004aa <stat>:

int
stat(const char *n, struct stat *st)
{
 4aa:	1101                	addi	sp,sp,-32
 4ac:	ec06                	sd	ra,24(sp)
 4ae:	e822                	sd	s0,16(sp)
 4b0:	e426                	sd	s1,8(sp)
 4b2:	e04a                	sd	s2,0(sp)
 4b4:	1000                	addi	s0,sp,32
 4b6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b8:	4581                	li	a1,0
 4ba:	00000097          	auipc	ra,0x0
 4be:	172080e7          	jalr	370(ra) # 62c <open>
  if(fd < 0)
 4c2:	02054563          	bltz	a0,4ec <stat+0x42>
 4c6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4c8:	85ca                	mv	a1,s2
 4ca:	00000097          	auipc	ra,0x0
 4ce:	17a080e7          	jalr	378(ra) # 644 <fstat>
 4d2:	892a                	mv	s2,a0
  close(fd);
 4d4:	8526                	mv	a0,s1
 4d6:	00000097          	auipc	ra,0x0
 4da:	13e080e7          	jalr	318(ra) # 614 <close>
  return r;
}
 4de:	854a                	mv	a0,s2
 4e0:	60e2                	ld	ra,24(sp)
 4e2:	6442                	ld	s0,16(sp)
 4e4:	64a2                	ld	s1,8(sp)
 4e6:	6902                	ld	s2,0(sp)
 4e8:	6105                	addi	sp,sp,32
 4ea:	8082                	ret
    return -1;
 4ec:	597d                	li	s2,-1
 4ee:	bfc5                	j	4de <stat+0x34>

00000000000004f0 <atoi>:

int
atoi(const char *s)
{
 4f0:	1141                	addi	sp,sp,-16
 4f2:	e422                	sd	s0,8(sp)
 4f4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4f6:	00054603          	lbu	a2,0(a0)
 4fa:	fd06079b          	addiw	a5,a2,-48
 4fe:	0ff7f793          	zext.b	a5,a5
 502:	4725                	li	a4,9
 504:	02f76963          	bltu	a4,a5,536 <atoi+0x46>
 508:	86aa                	mv	a3,a0
  n = 0;
 50a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 50c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 50e:	0685                	addi	a3,a3,1
 510:	0025179b          	slliw	a5,a0,0x2
 514:	9fa9                	addw	a5,a5,a0
 516:	0017979b          	slliw	a5,a5,0x1
 51a:	9fb1                	addw	a5,a5,a2
 51c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 520:	0006c603          	lbu	a2,0(a3)
 524:	fd06071b          	addiw	a4,a2,-48
 528:	0ff77713          	zext.b	a4,a4
 52c:	fee5f1e3          	bgeu	a1,a4,50e <atoi+0x1e>
  return n;
}
 530:	6422                	ld	s0,8(sp)
 532:	0141                	addi	sp,sp,16
 534:	8082                	ret
  n = 0;
 536:	4501                	li	a0,0
 538:	bfe5                	j	530 <atoi+0x40>

000000000000053a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 53a:	1141                	addi	sp,sp,-16
 53c:	e422                	sd	s0,8(sp)
 53e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 540:	02b57463          	bgeu	a0,a1,568 <memmove+0x2e>
    while(n-- > 0)
 544:	00c05f63          	blez	a2,562 <memmove+0x28>
 548:	1602                	slli	a2,a2,0x20
 54a:	9201                	srli	a2,a2,0x20
 54c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 550:	872a                	mv	a4,a0
      *dst++ = *src++;
 552:	0585                	addi	a1,a1,1
 554:	0705                	addi	a4,a4,1
 556:	fff5c683          	lbu	a3,-1(a1)
 55a:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xecb6>
    while(n-- > 0)
 55e:	fee79ae3          	bne	a5,a4,552 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 562:	6422                	ld	s0,8(sp)
 564:	0141                	addi	sp,sp,16
 566:	8082                	ret
    dst += n;
 568:	00c50733          	add	a4,a0,a2
    src += n;
 56c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 56e:	fec05ae3          	blez	a2,562 <memmove+0x28>
 572:	fff6079b          	addiw	a5,a2,-1
 576:	1782                	slli	a5,a5,0x20
 578:	9381                	srli	a5,a5,0x20
 57a:	fff7c793          	not	a5,a5
 57e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 580:	15fd                	addi	a1,a1,-1
 582:	177d                	addi	a4,a4,-1
 584:	0005c683          	lbu	a3,0(a1)
 588:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 58c:	fee79ae3          	bne	a5,a4,580 <memmove+0x46>
 590:	bfc9                	j	562 <memmove+0x28>

0000000000000592 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 592:	1141                	addi	sp,sp,-16
 594:	e422                	sd	s0,8(sp)
 596:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 598:	ca05                	beqz	a2,5c8 <memcmp+0x36>
 59a:	fff6069b          	addiw	a3,a2,-1
 59e:	1682                	slli	a3,a3,0x20
 5a0:	9281                	srli	a3,a3,0x20
 5a2:	0685                	addi	a3,a3,1
 5a4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5a6:	00054783          	lbu	a5,0(a0)
 5aa:	0005c703          	lbu	a4,0(a1)
 5ae:	00e79863          	bne	a5,a4,5be <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5b2:	0505                	addi	a0,a0,1
    p2++;
 5b4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5b6:	fed518e3          	bne	a0,a3,5a6 <memcmp+0x14>
  }
  return 0;
 5ba:	4501                	li	a0,0
 5bc:	a019                	j	5c2 <memcmp+0x30>
      return *p1 - *p2;
 5be:	40e7853b          	subw	a0,a5,a4
}
 5c2:	6422                	ld	s0,8(sp)
 5c4:	0141                	addi	sp,sp,16
 5c6:	8082                	ret
  return 0;
 5c8:	4501                	li	a0,0
 5ca:	bfe5                	j	5c2 <memcmp+0x30>

00000000000005cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5cc:	1141                	addi	sp,sp,-16
 5ce:	e406                	sd	ra,8(sp)
 5d0:	e022                	sd	s0,0(sp)
 5d2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5d4:	00000097          	auipc	ra,0x0
 5d8:	f66080e7          	jalr	-154(ra) # 53a <memmove>
}
 5dc:	60a2                	ld	ra,8(sp)
 5de:	6402                	ld	s0,0(sp)
 5e0:	0141                	addi	sp,sp,16
 5e2:	8082                	ret

00000000000005e4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5e4:	4885                	li	a7,1
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ec:	4889                	li	a7,2
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5f4:	488d                	li	a7,3
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5fc:	4891                	li	a7,4
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <read>:
.global read
read:
 li a7, SYS_read
 604:	4895                	li	a7,5
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <write>:
.global write
write:
 li a7, SYS_write
 60c:	48c1                	li	a7,16
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <close>:
.global close
close:
 li a7, SYS_close
 614:	48d5                	li	a7,21
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <kill>:
.global kill
kill:
 li a7, SYS_kill
 61c:	4899                	li	a7,6
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <exec>:
.global exec
exec:
 li a7, SYS_exec
 624:	489d                	li	a7,7
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <open>:
.global open
open:
 li a7, SYS_open
 62c:	48bd                	li	a7,15
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 634:	48c5                	li	a7,17
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 63c:	48c9                	li	a7,18
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 644:	48a1                	li	a7,8
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <link>:
.global link
link:
 li a7, SYS_link
 64c:	48cd                	li	a7,19
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 654:	48d1                	li	a7,20
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 65c:	48a5                	li	a7,9
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <dup>:
.global dup
dup:
 li a7, SYS_dup
 664:	48a9                	li	a7,10
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 66c:	48ad                	li	a7,11
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 674:	48b1                	li	a7,12
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 67c:	48b5                	li	a7,13
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 684:	48b9                	li	a7,14
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 68c:	48d9                	li	a7,22
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 694:	1101                	addi	sp,sp,-32
 696:	ec06                	sd	ra,24(sp)
 698:	e822                	sd	s0,16(sp)
 69a:	1000                	addi	s0,sp,32
 69c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6a0:	4605                	li	a2,1
 6a2:	fef40593          	addi	a1,s0,-17
 6a6:	00000097          	auipc	ra,0x0
 6aa:	f66080e7          	jalr	-154(ra) # 60c <write>
}
 6ae:	60e2                	ld	ra,24(sp)
 6b0:	6442                	ld	s0,16(sp)
 6b2:	6105                	addi	sp,sp,32
 6b4:	8082                	ret

00000000000006b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b6:	7139                	addi	sp,sp,-64
 6b8:	fc06                	sd	ra,56(sp)
 6ba:	f822                	sd	s0,48(sp)
 6bc:	f426                	sd	s1,40(sp)
 6be:	f04a                	sd	s2,32(sp)
 6c0:	ec4e                	sd	s3,24(sp)
 6c2:	0080                	addi	s0,sp,64
 6c4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6c6:	c299                	beqz	a3,6cc <printint+0x16>
 6c8:	0805c863          	bltz	a1,758 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6cc:	2581                	sext.w	a1,a1
  neg = 0;
 6ce:	4881                	li	a7,0
 6d0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6d4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6d6:	2601                	sext.w	a2,a2
 6d8:	00000517          	auipc	a0,0x0
 6dc:	46050513          	addi	a0,a0,1120 # b38 <digits>
 6e0:	883a                	mv	a6,a4
 6e2:	2705                	addiw	a4,a4,1
 6e4:	02c5f7bb          	remuw	a5,a1,a2
 6e8:	1782                	slli	a5,a5,0x20
 6ea:	9381                	srli	a5,a5,0x20
 6ec:	97aa                	add	a5,a5,a0
 6ee:	0007c783          	lbu	a5,0(a5)
 6f2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6f6:	0005879b          	sext.w	a5,a1
 6fa:	02c5d5bb          	divuw	a1,a1,a2
 6fe:	0685                	addi	a3,a3,1
 700:	fec7f0e3          	bgeu	a5,a2,6e0 <printint+0x2a>
  if(neg)
 704:	00088b63          	beqz	a7,71a <printint+0x64>
    buf[i++] = '-';
 708:	fd040793          	addi	a5,s0,-48
 70c:	973e                	add	a4,a4,a5
 70e:	02d00793          	li	a5,45
 712:	fef70823          	sb	a5,-16(a4)
 716:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 71a:	02e05863          	blez	a4,74a <printint+0x94>
 71e:	fc040793          	addi	a5,s0,-64
 722:	00e78933          	add	s2,a5,a4
 726:	fff78993          	addi	s3,a5,-1
 72a:	99ba                	add	s3,s3,a4
 72c:	377d                	addiw	a4,a4,-1
 72e:	1702                	slli	a4,a4,0x20
 730:	9301                	srli	a4,a4,0x20
 732:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 736:	fff94583          	lbu	a1,-1(s2)
 73a:	8526                	mv	a0,s1
 73c:	00000097          	auipc	ra,0x0
 740:	f58080e7          	jalr	-168(ra) # 694 <putc>
  while(--i >= 0)
 744:	197d                	addi	s2,s2,-1
 746:	ff3918e3          	bne	s2,s3,736 <printint+0x80>
}
 74a:	70e2                	ld	ra,56(sp)
 74c:	7442                	ld	s0,48(sp)
 74e:	74a2                	ld	s1,40(sp)
 750:	7902                	ld	s2,32(sp)
 752:	69e2                	ld	s3,24(sp)
 754:	6121                	addi	sp,sp,64
 756:	8082                	ret
    x = -xx;
 758:	40b005bb          	negw	a1,a1
    neg = 1;
 75c:	4885                	li	a7,1
    x = -xx;
 75e:	bf8d                	j	6d0 <printint+0x1a>

0000000000000760 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 760:	7119                	addi	sp,sp,-128
 762:	fc86                	sd	ra,120(sp)
 764:	f8a2                	sd	s0,112(sp)
 766:	f4a6                	sd	s1,104(sp)
 768:	f0ca                	sd	s2,96(sp)
 76a:	ecce                	sd	s3,88(sp)
 76c:	e8d2                	sd	s4,80(sp)
 76e:	e4d6                	sd	s5,72(sp)
 770:	e0da                	sd	s6,64(sp)
 772:	fc5e                	sd	s7,56(sp)
 774:	f862                	sd	s8,48(sp)
 776:	f466                	sd	s9,40(sp)
 778:	f06a                	sd	s10,32(sp)
 77a:	ec6e                	sd	s11,24(sp)
 77c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 77e:	0005c903          	lbu	s2,0(a1)
 782:	18090f63          	beqz	s2,920 <vprintf+0x1c0>
 786:	8aaa                	mv	s5,a0
 788:	8b32                	mv	s6,a2
 78a:	00158493          	addi	s1,a1,1
  state = 0;
 78e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 790:	02500a13          	li	s4,37
      if(c == 'd'){
 794:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 798:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 79c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 7a0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a4:	00000b97          	auipc	s7,0x0
 7a8:	394b8b93          	addi	s7,s7,916 # b38 <digits>
 7ac:	a839                	j	7ca <vprintf+0x6a>
        putc(fd, c);
 7ae:	85ca                	mv	a1,s2
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	ee2080e7          	jalr	-286(ra) # 694 <putc>
 7ba:	a019                	j	7c0 <vprintf+0x60>
    } else if(state == '%'){
 7bc:	01498f63          	beq	s3,s4,7da <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7c0:	0485                	addi	s1,s1,1
 7c2:	fff4c903          	lbu	s2,-1(s1)
 7c6:	14090d63          	beqz	s2,920 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7ca:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7ce:	fe0997e3          	bnez	s3,7bc <vprintf+0x5c>
      if(c == '%'){
 7d2:	fd479ee3          	bne	a5,s4,7ae <vprintf+0x4e>
        state = '%';
 7d6:	89be                	mv	s3,a5
 7d8:	b7e5                	j	7c0 <vprintf+0x60>
      if(c == 'd'){
 7da:	05878063          	beq	a5,s8,81a <vprintf+0xba>
      } else if(c == 'l') {
 7de:	05978c63          	beq	a5,s9,836 <vprintf+0xd6>
      } else if(c == 'x') {
 7e2:	07a78863          	beq	a5,s10,852 <vprintf+0xf2>
      } else if(c == 'p') {
 7e6:	09b78463          	beq	a5,s11,86e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7ea:	07300713          	li	a4,115
 7ee:	0ce78663          	beq	a5,a4,8ba <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7f2:	06300713          	li	a4,99
 7f6:	0ee78e63          	beq	a5,a4,8f2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7fa:	11478863          	beq	a5,s4,90a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7fe:	85d2                	mv	a1,s4
 800:	8556                	mv	a0,s5
 802:	00000097          	auipc	ra,0x0
 806:	e92080e7          	jalr	-366(ra) # 694 <putc>
        putc(fd, c);
 80a:	85ca                	mv	a1,s2
 80c:	8556                	mv	a0,s5
 80e:	00000097          	auipc	ra,0x0
 812:	e86080e7          	jalr	-378(ra) # 694 <putc>
      }
      state = 0;
 816:	4981                	li	s3,0
 818:	b765                	j	7c0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 81a:	008b0913          	addi	s2,s6,8
 81e:	4685                	li	a3,1
 820:	4629                	li	a2,10
 822:	000b2583          	lw	a1,0(s6)
 826:	8556                	mv	a0,s5
 828:	00000097          	auipc	ra,0x0
 82c:	e8e080e7          	jalr	-370(ra) # 6b6 <printint>
 830:	8b4a                	mv	s6,s2
      state = 0;
 832:	4981                	li	s3,0
 834:	b771                	j	7c0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 836:	008b0913          	addi	s2,s6,8
 83a:	4681                	li	a3,0
 83c:	4629                	li	a2,10
 83e:	000b2583          	lw	a1,0(s6)
 842:	8556                	mv	a0,s5
 844:	00000097          	auipc	ra,0x0
 848:	e72080e7          	jalr	-398(ra) # 6b6 <printint>
 84c:	8b4a                	mv	s6,s2
      state = 0;
 84e:	4981                	li	s3,0
 850:	bf85                	j	7c0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 852:	008b0913          	addi	s2,s6,8
 856:	4681                	li	a3,0
 858:	4641                	li	a2,16
 85a:	000b2583          	lw	a1,0(s6)
 85e:	8556                	mv	a0,s5
 860:	00000097          	auipc	ra,0x0
 864:	e56080e7          	jalr	-426(ra) # 6b6 <printint>
 868:	8b4a                	mv	s6,s2
      state = 0;
 86a:	4981                	li	s3,0
 86c:	bf91                	j	7c0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 86e:	008b0793          	addi	a5,s6,8
 872:	f8f43423          	sd	a5,-120(s0)
 876:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 87a:	03000593          	li	a1,48
 87e:	8556                	mv	a0,s5
 880:	00000097          	auipc	ra,0x0
 884:	e14080e7          	jalr	-492(ra) # 694 <putc>
  putc(fd, 'x');
 888:	85ea                	mv	a1,s10
 88a:	8556                	mv	a0,s5
 88c:	00000097          	auipc	ra,0x0
 890:	e08080e7          	jalr	-504(ra) # 694 <putc>
 894:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 896:	03c9d793          	srli	a5,s3,0x3c
 89a:	97de                	add	a5,a5,s7
 89c:	0007c583          	lbu	a1,0(a5)
 8a0:	8556                	mv	a0,s5
 8a2:	00000097          	auipc	ra,0x0
 8a6:	df2080e7          	jalr	-526(ra) # 694 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8aa:	0992                	slli	s3,s3,0x4
 8ac:	397d                	addiw	s2,s2,-1
 8ae:	fe0914e3          	bnez	s2,896 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8b2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8b6:	4981                	li	s3,0
 8b8:	b721                	j	7c0 <vprintf+0x60>
        s = va_arg(ap, char*);
 8ba:	008b0993          	addi	s3,s6,8
 8be:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8c2:	02090163          	beqz	s2,8e4 <vprintf+0x184>
        while(*s != 0){
 8c6:	00094583          	lbu	a1,0(s2)
 8ca:	c9a1                	beqz	a1,91a <vprintf+0x1ba>
          putc(fd, *s);
 8cc:	8556                	mv	a0,s5
 8ce:	00000097          	auipc	ra,0x0
 8d2:	dc6080e7          	jalr	-570(ra) # 694 <putc>
          s++;
 8d6:	0905                	addi	s2,s2,1
        while(*s != 0){
 8d8:	00094583          	lbu	a1,0(s2)
 8dc:	f9e5                	bnez	a1,8cc <vprintf+0x16c>
        s = va_arg(ap, char*);
 8de:	8b4e                	mv	s6,s3
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	bdf9                	j	7c0 <vprintf+0x60>
          s = "(null)";
 8e4:	00000917          	auipc	s2,0x0
 8e8:	24c90913          	addi	s2,s2,588 # b30 <malloc+0x106>
        while(*s != 0){
 8ec:	02800593          	li	a1,40
 8f0:	bff1                	j	8cc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8f2:	008b0913          	addi	s2,s6,8
 8f6:	000b4583          	lbu	a1,0(s6)
 8fa:	8556                	mv	a0,s5
 8fc:	00000097          	auipc	ra,0x0
 900:	d98080e7          	jalr	-616(ra) # 694 <putc>
 904:	8b4a                	mv	s6,s2
      state = 0;
 906:	4981                	li	s3,0
 908:	bd65                	j	7c0 <vprintf+0x60>
        putc(fd, c);
 90a:	85d2                	mv	a1,s4
 90c:	8556                	mv	a0,s5
 90e:	00000097          	auipc	ra,0x0
 912:	d86080e7          	jalr	-634(ra) # 694 <putc>
      state = 0;
 916:	4981                	li	s3,0
 918:	b565                	j	7c0 <vprintf+0x60>
        s = va_arg(ap, char*);
 91a:	8b4e                	mv	s6,s3
      state = 0;
 91c:	4981                	li	s3,0
 91e:	b54d                	j	7c0 <vprintf+0x60>
    }
  }
}
 920:	70e6                	ld	ra,120(sp)
 922:	7446                	ld	s0,112(sp)
 924:	74a6                	ld	s1,104(sp)
 926:	7906                	ld	s2,96(sp)
 928:	69e6                	ld	s3,88(sp)
 92a:	6a46                	ld	s4,80(sp)
 92c:	6aa6                	ld	s5,72(sp)
 92e:	6b06                	ld	s6,64(sp)
 930:	7be2                	ld	s7,56(sp)
 932:	7c42                	ld	s8,48(sp)
 934:	7ca2                	ld	s9,40(sp)
 936:	7d02                	ld	s10,32(sp)
 938:	6de2                	ld	s11,24(sp)
 93a:	6109                	addi	sp,sp,128
 93c:	8082                	ret

000000000000093e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 93e:	715d                	addi	sp,sp,-80
 940:	ec06                	sd	ra,24(sp)
 942:	e822                	sd	s0,16(sp)
 944:	1000                	addi	s0,sp,32
 946:	e010                	sd	a2,0(s0)
 948:	e414                	sd	a3,8(s0)
 94a:	e818                	sd	a4,16(s0)
 94c:	ec1c                	sd	a5,24(s0)
 94e:	03043023          	sd	a6,32(s0)
 952:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 956:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 95a:	8622                	mv	a2,s0
 95c:	00000097          	auipc	ra,0x0
 960:	e04080e7          	jalr	-508(ra) # 760 <vprintf>
}
 964:	60e2                	ld	ra,24(sp)
 966:	6442                	ld	s0,16(sp)
 968:	6161                	addi	sp,sp,80
 96a:	8082                	ret

000000000000096c <printf>:

void
printf(const char *fmt, ...)
{
 96c:	711d                	addi	sp,sp,-96
 96e:	ec06                	sd	ra,24(sp)
 970:	e822                	sd	s0,16(sp)
 972:	1000                	addi	s0,sp,32
 974:	e40c                	sd	a1,8(s0)
 976:	e810                	sd	a2,16(s0)
 978:	ec14                	sd	a3,24(s0)
 97a:	f018                	sd	a4,32(s0)
 97c:	f41c                	sd	a5,40(s0)
 97e:	03043823          	sd	a6,48(s0)
 982:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 986:	00840613          	addi	a2,s0,8
 98a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 98e:	85aa                	mv	a1,a0
 990:	4505                	li	a0,1
 992:	00000097          	auipc	ra,0x0
 996:	dce080e7          	jalr	-562(ra) # 760 <vprintf>
}
 99a:	60e2                	ld	ra,24(sp)
 99c:	6442                	ld	s0,16(sp)
 99e:	6125                	addi	sp,sp,96
 9a0:	8082                	ret

00000000000009a2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a2:	1141                	addi	sp,sp,-16
 9a4:	e422                	sd	s0,8(sp)
 9a6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9a8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ac:	00000797          	auipc	a5,0x0
 9b0:	1a47b783          	ld	a5,420(a5) # b50 <freep>
 9b4:	a805                	j	9e4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9b6:	4618                	lw	a4,8(a2)
 9b8:	9db9                	addw	a1,a1,a4
 9ba:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9be:	6398                	ld	a4,0(a5)
 9c0:	6318                	ld	a4,0(a4)
 9c2:	fee53823          	sd	a4,-16(a0)
 9c6:	a091                	j	a0a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9c8:	ff852703          	lw	a4,-8(a0)
 9cc:	9e39                	addw	a2,a2,a4
 9ce:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9d0:	ff053703          	ld	a4,-16(a0)
 9d4:	e398                	sd	a4,0(a5)
 9d6:	a099                	j	a1c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d8:	6398                	ld	a4,0(a5)
 9da:	00e7e463          	bltu	a5,a4,9e2 <free+0x40>
 9de:	00e6ea63          	bltu	a3,a4,9f2 <free+0x50>
{
 9e2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e4:	fed7fae3          	bgeu	a5,a3,9d8 <free+0x36>
 9e8:	6398                	ld	a4,0(a5)
 9ea:	00e6e463          	bltu	a3,a4,9f2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ee:	fee7eae3          	bltu	a5,a4,9e2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9f2:	ff852583          	lw	a1,-8(a0)
 9f6:	6390                	ld	a2,0(a5)
 9f8:	02059813          	slli	a6,a1,0x20
 9fc:	01c85713          	srli	a4,a6,0x1c
 a00:	9736                	add	a4,a4,a3
 a02:	fae60ae3          	beq	a2,a4,9b6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a06:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a0a:	4790                	lw	a2,8(a5)
 a0c:	02061593          	slli	a1,a2,0x20
 a10:	01c5d713          	srli	a4,a1,0x1c
 a14:	973e                	add	a4,a4,a5
 a16:	fae689e3          	beq	a3,a4,9c8 <free+0x26>
  } else
    p->s.ptr = bp;
 a1a:	e394                	sd	a3,0(a5)
  freep = p;
 a1c:	00000717          	auipc	a4,0x0
 a20:	12f73a23          	sd	a5,308(a4) # b50 <freep>
}
 a24:	6422                	ld	s0,8(sp)
 a26:	0141                	addi	sp,sp,16
 a28:	8082                	ret

0000000000000a2a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a2a:	7139                	addi	sp,sp,-64
 a2c:	fc06                	sd	ra,56(sp)
 a2e:	f822                	sd	s0,48(sp)
 a30:	f426                	sd	s1,40(sp)
 a32:	f04a                	sd	s2,32(sp)
 a34:	ec4e                	sd	s3,24(sp)
 a36:	e852                	sd	s4,16(sp)
 a38:	e456                	sd	s5,8(sp)
 a3a:	e05a                	sd	s6,0(sp)
 a3c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a3e:	02051493          	slli	s1,a0,0x20
 a42:	9081                	srli	s1,s1,0x20
 a44:	04bd                	addi	s1,s1,15
 a46:	8091                	srli	s1,s1,0x4
 a48:	0014899b          	addiw	s3,s1,1
 a4c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a4e:	00000517          	auipc	a0,0x0
 a52:	10253503          	ld	a0,258(a0) # b50 <freep>
 a56:	c515                	beqz	a0,a82 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a58:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a5a:	4798                	lw	a4,8(a5)
 a5c:	02977f63          	bgeu	a4,s1,a9a <malloc+0x70>
 a60:	8a4e                	mv	s4,s3
 a62:	0009871b          	sext.w	a4,s3
 a66:	6685                	lui	a3,0x1
 a68:	00d77363          	bgeu	a4,a3,a6e <malloc+0x44>
 a6c:	6a05                	lui	s4,0x1
 a6e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a72:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a76:	00000917          	auipc	s2,0x0
 a7a:	0da90913          	addi	s2,s2,218 # b50 <freep>
  if(p == (char*)-1)
 a7e:	5afd                	li	s5,-1
 a80:	a895                	j	af4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a82:	00000797          	auipc	a5,0x0
 a86:	1c678793          	addi	a5,a5,454 # c48 <base>
 a8a:	00000717          	auipc	a4,0x0
 a8e:	0cf73323          	sd	a5,198(a4) # b50 <freep>
 a92:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a94:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a98:	b7e1                	j	a60 <malloc+0x36>
      if(p->s.size == nunits)
 a9a:	02e48c63          	beq	s1,a4,ad2 <malloc+0xa8>
        p->s.size -= nunits;
 a9e:	4137073b          	subw	a4,a4,s3
 aa2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 aa4:	02071693          	slli	a3,a4,0x20
 aa8:	01c6d713          	srli	a4,a3,0x1c
 aac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ab2:	00000717          	auipc	a4,0x0
 ab6:	08a73f23          	sd	a0,158(a4) # b50 <freep>
      return (void*)(p + 1);
 aba:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 abe:	70e2                	ld	ra,56(sp)
 ac0:	7442                	ld	s0,48(sp)
 ac2:	74a2                	ld	s1,40(sp)
 ac4:	7902                	ld	s2,32(sp)
 ac6:	69e2                	ld	s3,24(sp)
 ac8:	6a42                	ld	s4,16(sp)
 aca:	6aa2                	ld	s5,8(sp)
 acc:	6b02                	ld	s6,0(sp)
 ace:	6121                	addi	sp,sp,64
 ad0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ad2:	6398                	ld	a4,0(a5)
 ad4:	e118                	sd	a4,0(a0)
 ad6:	bff1                	j	ab2 <malloc+0x88>
  hp->s.size = nu;
 ad8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 adc:	0541                	addi	a0,a0,16
 ade:	00000097          	auipc	ra,0x0
 ae2:	ec4080e7          	jalr	-316(ra) # 9a2 <free>
  return freep;
 ae6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aea:	d971                	beqz	a0,abe <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aee:	4798                	lw	a4,8(a5)
 af0:	fa9775e3          	bgeu	a4,s1,a9a <malloc+0x70>
    if(p == freep)
 af4:	00093703          	ld	a4,0(s2)
 af8:	853e                	mv	a0,a5
 afa:	fef719e3          	bne	a4,a5,aec <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 afe:	8552                	mv	a0,s4
 b00:	00000097          	auipc	ra,0x0
 b04:	b74080e7          	jalr	-1164(ra) # 674 <sbrk>
  if(p == (char*)-1)
 b08:	fd5518e3          	bne	a0,s5,ad8 <malloc+0xae>
        return 0;
 b0c:	4501                	li	a0,0
 b0e:	bf45                	j	abe <malloc+0x94>
