
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
  1c:	5cc080e7          	jalr	1484(ra) # 5e4 <pipe>
    int pid = fork();
  20:	00000097          	auipc	ra,0x0
  24:	5ac080e7          	jalr	1452(ra) # 5cc <fork>

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
  52:	5ae080e7          	jalr	1454(ra) # 5fc <close>
        close(1);
  56:	4505                	li	a0,1
  58:	00000097          	auipc	ra,0x0
  5c:	5a4080e7          	jalr	1444(ra) # 5fc <close>
        dup(fd[1]);
  60:	fcc42503          	lw	a0,-52(s0)
  64:	00000097          	auipc	ra,0x0
  68:	5e8080e7          	jalr	1512(ra) # 64c <dup>
        write(1,arr,sizeof(arr));
  6c:	6605                	lui	a2,0x1
  6e:	75fd                	lui	a1,0xfffff
  70:	15e1                	addi	a1,a1,-8
  72:	fd040793          	addi	a5,s0,-48
  76:	95be                	add	a1,a1,a5
  78:	4505                	li	a0,1
  7a:	00000097          	auipc	ra,0x0
  7e:	57a080e7          	jalr	1402(ra) # 5f4 <write>
  82:	a879                	j	120 <main+0x120>
        wait(NULL);
  84:	4501                	li	a0,0
  86:	00000097          	auipc	ra,0x0
  8a:	556080e7          	jalr	1366(ra) # 5dc <wait>
        close(0);
  8e:	4501                	li	a0,0
  90:	00000097          	auipc	ra,0x0
  94:	56c080e7          	jalr	1388(ra) # 5fc <close>
        close(fd[1]);
  98:	fcc42503          	lw	a0,-52(s0)
  9c:	00000097          	auipc	ra,0x0
  a0:	560080e7          	jalr	1376(ra) # 5fc <close>
        dup(fd[1]);
  a4:	fcc42503          	lw	a0,-52(s0)
  a8:	00000097          	auipc	ra,0x0
  ac:	5a4080e7          	jalr	1444(ra) # 64c <dup>
        int n=read(fd[0],arr,sizeof(arr));
  b0:	6605                	lui	a2,0x1
  b2:	75fd                	lui	a1,0xfffff
  b4:	15e1                	addi	a1,a1,-8
  b6:	fd040793          	addi	a5,s0,-48
  ba:	95be                	add	a1,a1,a5
  bc:	fc842503          	lw	a0,-56(s0)
  c0:	00000097          	auipc	ra,0x0
  c4:	52c080e7          	jalr	1324(ra) # 5ec <read>
  c8:	84aa                	mv	s1,a0
        printf("%d\n",n);
  ca:	85aa                	mv	a1,a0
  cc:	00001517          	auipc	a0,0x1
  d0:	a2c50513          	addi	a0,a0,-1492 # af8 <malloc+0xe6>
  d4:	00001097          	auipc	ra,0x1
  d8:	880080e7          	jalr	-1920(ra) # 954 <printf>
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
  f8:	a0ca0a13          	addi	s4,s4,-1524 # b00 <malloc+0xee>
  fc:	408c                	lw	a1,0(s1)
  fe:	8552                	mv	a0,s4
 100:	00001097          	auipc	ra,0x1
 104:	854080e7          	jalr	-1964(ra) # 954 <printf>
        for(i=0;i<n/4;i++){
 108:	2905                	addiw	s2,s2,1
 10a:	0491                	addi	s1,s1,4
 10c:	ff3948e3          	blt	s2,s3,fc <main+0xfc>
        printf("\n");
 110:	00001517          	auipc	a0,0x1
 114:	9f850513          	addi	a0,a0,-1544 # b08 <malloc+0xf6>
 118:	00001097          	auipc	ra,0x1
 11c:	83c080e7          	jalr	-1988(ra) # 954 <printf>
    }
    else{
        printf("error");
    }
    exit(0);
 120:	4501                	li	a0,0
 122:	00000097          	auipc	ra,0x0
 126:	4b2080e7          	jalr	1202(ra) # 5d4 <exit>
        printf("error");
 12a:	00001517          	auipc	a0,0x1
 12e:	9e650513          	addi	a0,a0,-1562 # b10 <malloc+0xfe>
 132:	00001097          	auipc	ra,0x1
 136:	822080e7          	jalr	-2014(ra) # 954 <printf>
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
 182:	9d248493          	addi	s1,s1,-1582 # b50 <rings+0x10>
 186:	00001917          	auipc	s2,0x1
 18a:	aba90913          	addi	s2,s2,-1350 # c40 <__BSS_END__>
 18e:	04f59563          	bne	a1,a5,1d8 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 192:	00001497          	auipc	s1,0x1
 196:	9be4a483          	lw	s1,-1602(s1) # b50 <rings+0x10>
 19a:	c099                	beqz	s1,1a0 <create_or_close_the_buffer_user+0x38>
 19c:	4481                	li	s1,0
 19e:	a899                	j	1f4 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 1a0:	00001917          	auipc	s2,0x1
 1a4:	9a090913          	addi	s2,s2,-1632 # b40 <rings>
 1a8:	00093603          	ld	a2,0(s2)
 1ac:	4585                	li	a1,1
 1ae:	00000097          	auipc	ra,0x0
 1b2:	4c6080e7          	jalr	1222(ra) # 674 <ringbuf>
        rings[i].book->write_done = 0;
 1b6:	00893783          	ld	a5,8(s2)
 1ba:	0007b423          	sd	zero,8(a5) # fffffffffffff008 <__global_pointer$+0xffffffffffffdcd7>
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
 1e8:	490080e7          	jalr	1168(ra) # 674 <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 206:	1101                	addi	sp,sp,-32
 208:	ec06                	sd	ra,24(sp)
 20a:	e822                	sd	s0,16(sp)
 20c:	e426                	sd	s1,8(sp)
 20e:	1000                	addi	s0,sp,32
 210:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 212:	00151793          	slli	a5,a0,0x1
 216:	97aa                	add	a5,a5,a0
 218:	078e                	slli	a5,a5,0x3
 21a:	00001717          	auipc	a4,0x1
 21e:	92670713          	addi	a4,a4,-1754 # b40 <rings>
 222:	97ba                	add	a5,a5,a4
 224:	639c                	ld	a5,0(a5)
 226:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 228:	421c                	lw	a5,0(a2)
 22a:	e785                	bnez	a5,252 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 22c:	86ba                	mv	a3,a4
 22e:	671c                	ld	a5,8(a4)
 230:	6398                	ld	a4,0(a5)
 232:	67c1                	lui	a5,0x10
 234:	9fb9                	addw	a5,a5,a4
 236:	00151713          	slli	a4,a0,0x1
 23a:	953a                	add	a0,a0,a4
 23c:	050e                	slli	a0,a0,0x3
 23e:	9536                	add	a0,a0,a3
 240:	6518                	ld	a4,8(a0)
 242:	6718                	ld	a4,8(a4)
 244:	9f99                	subw	a5,a5,a4
 246:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 248:	60e2                	ld	ra,24(sp)
 24a:	6442                	ld	s0,16(sp)
 24c:	64a2                	ld	s1,8(sp)
 24e:	6105                	addi	sp,sp,32
 250:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 252:	00151793          	slli	a5,a0,0x1
 256:	953e                	add	a0,a0,a5
 258:	050e                	slli	a0,a0,0x3
 25a:	00001797          	auipc	a5,0x1
 25e:	8e678793          	addi	a5,a5,-1818 # b40 <rings>
 262:	953e                	add	a0,a0,a5
 264:	6508                	ld	a0,8(a0)
 266:	0521                	addi	a0,a0,8
 268:	00000097          	auipc	ra,0x0
 26c:	ee8080e7          	jalr	-280(ra) # 150 <load>
 270:	c088                	sw	a0,0(s1)
}
 272:	bfd9                	j	248 <ringbuf_start_write+0x42>

0000000000000274 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 274:	1141                	addi	sp,sp,-16
 276:	e406                	sd	ra,8(sp)
 278:	e022                	sd	s0,0(sp)
 27a:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 27c:	00151793          	slli	a5,a0,0x1
 280:	97aa                	add	a5,a5,a0
 282:	078e                	slli	a5,a5,0x3
 284:	00001517          	auipc	a0,0x1
 288:	8bc50513          	addi	a0,a0,-1860 # b40 <rings>
 28c:	97aa                	add	a5,a5,a0
 28e:	6788                	ld	a0,8(a5)
 290:	0035959b          	slliw	a1,a1,0x3
 294:	0521                	addi	a0,a0,8
 296:	00000097          	auipc	ra,0x0
 29a:	ea6080e7          	jalr	-346(ra) # 13c <store>
}
 29e:	60a2                	ld	ra,8(sp)
 2a0:	6402                	ld	s0,0(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 2a6:	1101                	addi	sp,sp,-32
 2a8:	ec06                	sd	ra,24(sp)
 2aa:	e822                	sd	s0,16(sp)
 2ac:	e426                	sd	s1,8(sp)
 2ae:	1000                	addi	s0,sp,32
 2b0:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 2b2:	00151793          	slli	a5,a0,0x1
 2b6:	97aa                	add	a5,a5,a0
 2b8:	078e                	slli	a5,a5,0x3
 2ba:	00001517          	auipc	a0,0x1
 2be:	88650513          	addi	a0,a0,-1914 # b40 <rings>
 2c2:	97aa                	add	a5,a5,a0
 2c4:	6788                	ld	a0,8(a5)
 2c6:	0521                	addi	a0,a0,8
 2c8:	00000097          	auipc	ra,0x0
 2cc:	e88080e7          	jalr	-376(ra) # 150 <load>
 2d0:	c088                	sw	a0,0(s1)
}
 2d2:	60e2                	ld	ra,24(sp)
 2d4:	6442                	ld	s0,16(sp)
 2d6:	64a2                	ld	s1,8(sp)
 2d8:	6105                	addi	sp,sp,32
 2da:	8082                	ret

00000000000002dc <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2dc:	1101                	addi	sp,sp,-32
 2de:	ec06                	sd	ra,24(sp)
 2e0:	e822                	sd	s0,16(sp)
 2e2:	e426                	sd	s1,8(sp)
 2e4:	1000                	addi	s0,sp,32
 2e6:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 2e8:	00151793          	slli	a5,a0,0x1
 2ec:	97aa                	add	a5,a5,a0
 2ee:	078e                	slli	a5,a5,0x3
 2f0:	00001517          	auipc	a0,0x1
 2f4:	85050513          	addi	a0,a0,-1968 # b40 <rings>
 2f8:	97aa                	add	a5,a5,a0
 2fa:	6788                	ld	a0,8(a5)
 2fc:	611c                	ld	a5,0(a0)
 2fe:	ef99                	bnez	a5,31c <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 300:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 302:	41f7579b          	sraiw	a5,a4,0x1f
 306:	01d7d79b          	srliw	a5,a5,0x1d
 30a:	9fb9                	addw	a5,a5,a4
 30c:	4037d79b          	sraiw	a5,a5,0x3
 310:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 312:	60e2                	ld	ra,24(sp)
 314:	6442                	ld	s0,16(sp)
 316:	64a2                	ld	s1,8(sp)
 318:	6105                	addi	sp,sp,32
 31a:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 31c:	00000097          	auipc	ra,0x0
 320:	e34080e7          	jalr	-460(ra) # 150 <load>
    *bytes /= 8;
 324:	41f5579b          	sraiw	a5,a0,0x1f
 328:	01d7d79b          	srliw	a5,a5,0x1d
 32c:	9d3d                	addw	a0,a0,a5
 32e:	4035551b          	sraiw	a0,a0,0x3
 332:	c088                	sw	a0,0(s1)
}
 334:	bff9                	j	312 <ringbuf_start_read+0x36>

0000000000000336 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 336:	1141                	addi	sp,sp,-16
 338:	e406                	sd	ra,8(sp)
 33a:	e022                	sd	s0,0(sp)
 33c:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 33e:	00151793          	slli	a5,a0,0x1
 342:	97aa                	add	a5,a5,a0
 344:	078e                	slli	a5,a5,0x3
 346:	00000517          	auipc	a0,0x0
 34a:	7fa50513          	addi	a0,a0,2042 # b40 <rings>
 34e:	97aa                	add	a5,a5,a0
 350:	0035959b          	slliw	a1,a1,0x3
 354:	6788                	ld	a0,8(a5)
 356:	00000097          	auipc	ra,0x0
 35a:	de6080e7          	jalr	-538(ra) # 13c <store>
}
 35e:	60a2                	ld	ra,8(sp)
 360:	6402                	ld	s0,0(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret

0000000000000366 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 366:	1141                	addi	sp,sp,-16
 368:	e422                	sd	s0,8(sp)
 36a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 36c:	87aa                	mv	a5,a0
 36e:	0585                	addi	a1,a1,1
 370:	0785                	addi	a5,a5,1
 372:	fff5c703          	lbu	a4,-1(a1) # ffffffffffffefff <__global_pointer$+0xffffffffffffdcce>
 376:	fee78fa3          	sb	a4,-1(a5)
 37a:	fb75                	bnez	a4,36e <strcpy+0x8>
    ;
  return os;
}
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

0000000000000382 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 382:	1141                	addi	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 388:	00054783          	lbu	a5,0(a0)
 38c:	cb91                	beqz	a5,3a0 <strcmp+0x1e>
 38e:	0005c703          	lbu	a4,0(a1)
 392:	00f71763          	bne	a4,a5,3a0 <strcmp+0x1e>
    p++, q++;
 396:	0505                	addi	a0,a0,1
 398:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 39a:	00054783          	lbu	a5,0(a0)
 39e:	fbe5                	bnez	a5,38e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3a0:	0005c503          	lbu	a0,0(a1)
}
 3a4:	40a7853b          	subw	a0,a5,a0
 3a8:	6422                	ld	s0,8(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <strlen>:

uint
strlen(const char *s)
{
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e422                	sd	s0,8(sp)
 3b2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3b4:	00054783          	lbu	a5,0(a0)
 3b8:	cf91                	beqz	a5,3d4 <strlen+0x26>
 3ba:	0505                	addi	a0,a0,1
 3bc:	87aa                	mv	a5,a0
 3be:	4685                	li	a3,1
 3c0:	9e89                	subw	a3,a3,a0
 3c2:	00f6853b          	addw	a0,a3,a5
 3c6:	0785                	addi	a5,a5,1
 3c8:	fff7c703          	lbu	a4,-1(a5)
 3cc:	fb7d                	bnez	a4,3c2 <strlen+0x14>
    ;
  return n;
}
 3ce:	6422                	ld	s0,8(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret
  for(n = 0; s[n]; n++)
 3d4:	4501                	li	a0,0
 3d6:	bfe5                	j	3ce <strlen+0x20>

00000000000003d8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d8:	1141                	addi	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3de:	ca19                	beqz	a2,3f4 <memset+0x1c>
 3e0:	87aa                	mv	a5,a0
 3e2:	1602                	slli	a2,a2,0x20
 3e4:	9201                	srli	a2,a2,0x20
 3e6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3ee:	0785                	addi	a5,a5,1
 3f0:	fee79de3          	bne	a5,a4,3ea <memset+0x12>
  }
  return dst;
}
 3f4:	6422                	ld	s0,8(sp)
 3f6:	0141                	addi	sp,sp,16
 3f8:	8082                	ret

00000000000003fa <strchr>:

char*
strchr(const char *s, char c)
{
 3fa:	1141                	addi	sp,sp,-16
 3fc:	e422                	sd	s0,8(sp)
 3fe:	0800                	addi	s0,sp,16
  for(; *s; s++)
 400:	00054783          	lbu	a5,0(a0)
 404:	cb99                	beqz	a5,41a <strchr+0x20>
    if(*s == c)
 406:	00f58763          	beq	a1,a5,414 <strchr+0x1a>
  for(; *s; s++)
 40a:	0505                	addi	a0,a0,1
 40c:	00054783          	lbu	a5,0(a0)
 410:	fbfd                	bnez	a5,406 <strchr+0xc>
      return (char*)s;
  return 0;
 412:	4501                	li	a0,0
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret
  return 0;
 41a:	4501                	li	a0,0
 41c:	bfe5                	j	414 <strchr+0x1a>

000000000000041e <gets>:

char*
gets(char *buf, int max)
{
 41e:	711d                	addi	sp,sp,-96
 420:	ec86                	sd	ra,88(sp)
 422:	e8a2                	sd	s0,80(sp)
 424:	e4a6                	sd	s1,72(sp)
 426:	e0ca                	sd	s2,64(sp)
 428:	fc4e                	sd	s3,56(sp)
 42a:	f852                	sd	s4,48(sp)
 42c:	f456                	sd	s5,40(sp)
 42e:	f05a                	sd	s6,32(sp)
 430:	ec5e                	sd	s7,24(sp)
 432:	1080                	addi	s0,sp,96
 434:	8baa                	mv	s7,a0
 436:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 438:	892a                	mv	s2,a0
 43a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 43c:	4aa9                	li	s5,10
 43e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 440:	89a6                	mv	s3,s1
 442:	2485                	addiw	s1,s1,1
 444:	0344d863          	bge	s1,s4,474 <gets+0x56>
    cc = read(0, &c, 1);
 448:	4605                	li	a2,1
 44a:	faf40593          	addi	a1,s0,-81
 44e:	4501                	li	a0,0
 450:	00000097          	auipc	ra,0x0
 454:	19c080e7          	jalr	412(ra) # 5ec <read>
    if(cc < 1)
 458:	00a05e63          	blez	a0,474 <gets+0x56>
    buf[i++] = c;
 45c:	faf44783          	lbu	a5,-81(s0)
 460:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 464:	01578763          	beq	a5,s5,472 <gets+0x54>
 468:	0905                	addi	s2,s2,1
 46a:	fd679be3          	bne	a5,s6,440 <gets+0x22>
  for(i=0; i+1 < max; ){
 46e:	89a6                	mv	s3,s1
 470:	a011                	j	474 <gets+0x56>
 472:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 474:	99de                	add	s3,s3,s7
 476:	00098023          	sb	zero,0(s3)
  return buf;
}
 47a:	855e                	mv	a0,s7
 47c:	60e6                	ld	ra,88(sp)
 47e:	6446                	ld	s0,80(sp)
 480:	64a6                	ld	s1,72(sp)
 482:	6906                	ld	s2,64(sp)
 484:	79e2                	ld	s3,56(sp)
 486:	7a42                	ld	s4,48(sp)
 488:	7aa2                	ld	s5,40(sp)
 48a:	7b02                	ld	s6,32(sp)
 48c:	6be2                	ld	s7,24(sp)
 48e:	6125                	addi	sp,sp,96
 490:	8082                	ret

0000000000000492 <stat>:

int
stat(const char *n, struct stat *st)
{
 492:	1101                	addi	sp,sp,-32
 494:	ec06                	sd	ra,24(sp)
 496:	e822                	sd	s0,16(sp)
 498:	e426                	sd	s1,8(sp)
 49a:	e04a                	sd	s2,0(sp)
 49c:	1000                	addi	s0,sp,32
 49e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a0:	4581                	li	a1,0
 4a2:	00000097          	auipc	ra,0x0
 4a6:	172080e7          	jalr	370(ra) # 614 <open>
  if(fd < 0)
 4aa:	02054563          	bltz	a0,4d4 <stat+0x42>
 4ae:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4b0:	85ca                	mv	a1,s2
 4b2:	00000097          	auipc	ra,0x0
 4b6:	17a080e7          	jalr	378(ra) # 62c <fstat>
 4ba:	892a                	mv	s2,a0
  close(fd);
 4bc:	8526                	mv	a0,s1
 4be:	00000097          	auipc	ra,0x0
 4c2:	13e080e7          	jalr	318(ra) # 5fc <close>
  return r;
}
 4c6:	854a                	mv	a0,s2
 4c8:	60e2                	ld	ra,24(sp)
 4ca:	6442                	ld	s0,16(sp)
 4cc:	64a2                	ld	s1,8(sp)
 4ce:	6902                	ld	s2,0(sp)
 4d0:	6105                	addi	sp,sp,32
 4d2:	8082                	ret
    return -1;
 4d4:	597d                	li	s2,-1
 4d6:	bfc5                	j	4c6 <stat+0x34>

00000000000004d8 <atoi>:

int
atoi(const char *s)
{
 4d8:	1141                	addi	sp,sp,-16
 4da:	e422                	sd	s0,8(sp)
 4dc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4de:	00054603          	lbu	a2,0(a0)
 4e2:	fd06079b          	addiw	a5,a2,-48
 4e6:	0ff7f793          	zext.b	a5,a5
 4ea:	4725                	li	a4,9
 4ec:	02f76963          	bltu	a4,a5,51e <atoi+0x46>
 4f0:	86aa                	mv	a3,a0
  n = 0;
 4f2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4f4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4f6:	0685                	addi	a3,a3,1
 4f8:	0025179b          	slliw	a5,a0,0x2
 4fc:	9fa9                	addw	a5,a5,a0
 4fe:	0017979b          	slliw	a5,a5,0x1
 502:	9fb1                	addw	a5,a5,a2
 504:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 508:	0006c603          	lbu	a2,0(a3)
 50c:	fd06071b          	addiw	a4,a2,-48
 510:	0ff77713          	zext.b	a4,a4
 514:	fee5f1e3          	bgeu	a1,a4,4f6 <atoi+0x1e>
  return n;
}
 518:	6422                	ld	s0,8(sp)
 51a:	0141                	addi	sp,sp,16
 51c:	8082                	ret
  n = 0;
 51e:	4501                	li	a0,0
 520:	bfe5                	j	518 <atoi+0x40>

0000000000000522 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 522:	1141                	addi	sp,sp,-16
 524:	e422                	sd	s0,8(sp)
 526:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 528:	02b57463          	bgeu	a0,a1,550 <memmove+0x2e>
    while(n-- > 0)
 52c:	00c05f63          	blez	a2,54a <memmove+0x28>
 530:	1602                	slli	a2,a2,0x20
 532:	9201                	srli	a2,a2,0x20
 534:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 538:	872a                	mv	a4,a0
      *dst++ = *src++;
 53a:	0585                	addi	a1,a1,1
 53c:	0705                	addi	a4,a4,1
 53e:	fff5c683          	lbu	a3,-1(a1)
 542:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 546:	fee79ae3          	bne	a5,a4,53a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 54a:	6422                	ld	s0,8(sp)
 54c:	0141                	addi	sp,sp,16
 54e:	8082                	ret
    dst += n;
 550:	00c50733          	add	a4,a0,a2
    src += n;
 554:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 556:	fec05ae3          	blez	a2,54a <memmove+0x28>
 55a:	fff6079b          	addiw	a5,a2,-1
 55e:	1782                	slli	a5,a5,0x20
 560:	9381                	srli	a5,a5,0x20
 562:	fff7c793          	not	a5,a5
 566:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 568:	15fd                	addi	a1,a1,-1
 56a:	177d                	addi	a4,a4,-1
 56c:	0005c683          	lbu	a3,0(a1)
 570:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 574:	fee79ae3          	bne	a5,a4,568 <memmove+0x46>
 578:	bfc9                	j	54a <memmove+0x28>

000000000000057a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 57a:	1141                	addi	sp,sp,-16
 57c:	e422                	sd	s0,8(sp)
 57e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 580:	ca05                	beqz	a2,5b0 <memcmp+0x36>
 582:	fff6069b          	addiw	a3,a2,-1
 586:	1682                	slli	a3,a3,0x20
 588:	9281                	srli	a3,a3,0x20
 58a:	0685                	addi	a3,a3,1
 58c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 58e:	00054783          	lbu	a5,0(a0)
 592:	0005c703          	lbu	a4,0(a1)
 596:	00e79863          	bne	a5,a4,5a6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 59a:	0505                	addi	a0,a0,1
    p2++;
 59c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 59e:	fed518e3          	bne	a0,a3,58e <memcmp+0x14>
  }
  return 0;
 5a2:	4501                	li	a0,0
 5a4:	a019                	j	5aa <memcmp+0x30>
      return *p1 - *p2;
 5a6:	40e7853b          	subw	a0,a5,a4
}
 5aa:	6422                	ld	s0,8(sp)
 5ac:	0141                	addi	sp,sp,16
 5ae:	8082                	ret
  return 0;
 5b0:	4501                	li	a0,0
 5b2:	bfe5                	j	5aa <memcmp+0x30>

00000000000005b4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5b4:	1141                	addi	sp,sp,-16
 5b6:	e406                	sd	ra,8(sp)
 5b8:	e022                	sd	s0,0(sp)
 5ba:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5bc:	00000097          	auipc	ra,0x0
 5c0:	f66080e7          	jalr	-154(ra) # 522 <memmove>
}
 5c4:	60a2                	ld	ra,8(sp)
 5c6:	6402                	ld	s0,0(sp)
 5c8:	0141                	addi	sp,sp,16
 5ca:	8082                	ret

00000000000005cc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5cc:	4885                	li	a7,1
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5d4:	4889                	li	a7,2
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <wait>:
.global wait
wait:
 li a7, SYS_wait
 5dc:	488d                	li	a7,3
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5e4:	4891                	li	a7,4
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <read>:
.global read
read:
 li a7, SYS_read
 5ec:	4895                	li	a7,5
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <write>:
.global write
write:
 li a7, SYS_write
 5f4:	48c1                	li	a7,16
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <close>:
.global close
close:
 li a7, SYS_close
 5fc:	48d5                	li	a7,21
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <kill>:
.global kill
kill:
 li a7, SYS_kill
 604:	4899                	li	a7,6
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <exec>:
.global exec
exec:
 li a7, SYS_exec
 60c:	489d                	li	a7,7
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <open>:
.global open
open:
 li a7, SYS_open
 614:	48bd                	li	a7,15
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 61c:	48c5                	li	a7,17
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 624:	48c9                	li	a7,18
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 62c:	48a1                	li	a7,8
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <link>:
.global link
link:
 li a7, SYS_link
 634:	48cd                	li	a7,19
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 63c:	48d1                	li	a7,20
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 644:	48a5                	li	a7,9
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <dup>:
.global dup
dup:
 li a7, SYS_dup
 64c:	48a9                	li	a7,10
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 654:	48ad                	li	a7,11
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 65c:	48b1                	li	a7,12
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 664:	48b5                	li	a7,13
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 66c:	48b9                	li	a7,14
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 674:	48d9                	li	a7,22
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 67c:	1101                	addi	sp,sp,-32
 67e:	ec06                	sd	ra,24(sp)
 680:	e822                	sd	s0,16(sp)
 682:	1000                	addi	s0,sp,32
 684:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 688:	4605                	li	a2,1
 68a:	fef40593          	addi	a1,s0,-17
 68e:	00000097          	auipc	ra,0x0
 692:	f66080e7          	jalr	-154(ra) # 5f4 <write>
}
 696:	60e2                	ld	ra,24(sp)
 698:	6442                	ld	s0,16(sp)
 69a:	6105                	addi	sp,sp,32
 69c:	8082                	ret

000000000000069e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 69e:	7139                	addi	sp,sp,-64
 6a0:	fc06                	sd	ra,56(sp)
 6a2:	f822                	sd	s0,48(sp)
 6a4:	f426                	sd	s1,40(sp)
 6a6:	f04a                	sd	s2,32(sp)
 6a8:	ec4e                	sd	s3,24(sp)
 6aa:	0080                	addi	s0,sp,64
 6ac:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6ae:	c299                	beqz	a3,6b4 <printint+0x16>
 6b0:	0805c863          	bltz	a1,740 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6b4:	2581                	sext.w	a1,a1
  neg = 0;
 6b6:	4881                	li	a7,0
 6b8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6bc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6be:	2601                	sext.w	a2,a2
 6c0:	00000517          	auipc	a0,0x0
 6c4:	46050513          	addi	a0,a0,1120 # b20 <digits>
 6c8:	883a                	mv	a6,a4
 6ca:	2705                	addiw	a4,a4,1
 6cc:	02c5f7bb          	remuw	a5,a1,a2
 6d0:	1782                	slli	a5,a5,0x20
 6d2:	9381                	srli	a5,a5,0x20
 6d4:	97aa                	add	a5,a5,a0
 6d6:	0007c783          	lbu	a5,0(a5)
 6da:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6de:	0005879b          	sext.w	a5,a1
 6e2:	02c5d5bb          	divuw	a1,a1,a2
 6e6:	0685                	addi	a3,a3,1
 6e8:	fec7f0e3          	bgeu	a5,a2,6c8 <printint+0x2a>
  if(neg)
 6ec:	00088b63          	beqz	a7,702 <printint+0x64>
    buf[i++] = '-';
 6f0:	fd040793          	addi	a5,s0,-48
 6f4:	973e                	add	a4,a4,a5
 6f6:	02d00793          	li	a5,45
 6fa:	fef70823          	sb	a5,-16(a4)
 6fe:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 702:	02e05863          	blez	a4,732 <printint+0x94>
 706:	fc040793          	addi	a5,s0,-64
 70a:	00e78933          	add	s2,a5,a4
 70e:	fff78993          	addi	s3,a5,-1
 712:	99ba                	add	s3,s3,a4
 714:	377d                	addiw	a4,a4,-1
 716:	1702                	slli	a4,a4,0x20
 718:	9301                	srli	a4,a4,0x20
 71a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 71e:	fff94583          	lbu	a1,-1(s2)
 722:	8526                	mv	a0,s1
 724:	00000097          	auipc	ra,0x0
 728:	f58080e7          	jalr	-168(ra) # 67c <putc>
  while(--i >= 0)
 72c:	197d                	addi	s2,s2,-1
 72e:	ff3918e3          	bne	s2,s3,71e <printint+0x80>
}
 732:	70e2                	ld	ra,56(sp)
 734:	7442                	ld	s0,48(sp)
 736:	74a2                	ld	s1,40(sp)
 738:	7902                	ld	s2,32(sp)
 73a:	69e2                	ld	s3,24(sp)
 73c:	6121                	addi	sp,sp,64
 73e:	8082                	ret
    x = -xx;
 740:	40b005bb          	negw	a1,a1
    neg = 1;
 744:	4885                	li	a7,1
    x = -xx;
 746:	bf8d                	j	6b8 <printint+0x1a>

0000000000000748 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 748:	7119                	addi	sp,sp,-128
 74a:	fc86                	sd	ra,120(sp)
 74c:	f8a2                	sd	s0,112(sp)
 74e:	f4a6                	sd	s1,104(sp)
 750:	f0ca                	sd	s2,96(sp)
 752:	ecce                	sd	s3,88(sp)
 754:	e8d2                	sd	s4,80(sp)
 756:	e4d6                	sd	s5,72(sp)
 758:	e0da                	sd	s6,64(sp)
 75a:	fc5e                	sd	s7,56(sp)
 75c:	f862                	sd	s8,48(sp)
 75e:	f466                	sd	s9,40(sp)
 760:	f06a                	sd	s10,32(sp)
 762:	ec6e                	sd	s11,24(sp)
 764:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 766:	0005c903          	lbu	s2,0(a1)
 76a:	18090f63          	beqz	s2,908 <vprintf+0x1c0>
 76e:	8aaa                	mv	s5,a0
 770:	8b32                	mv	s6,a2
 772:	00158493          	addi	s1,a1,1
  state = 0;
 776:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 778:	02500a13          	li	s4,37
      if(c == 'd'){
 77c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 780:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 784:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 788:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 78c:	00000b97          	auipc	s7,0x0
 790:	394b8b93          	addi	s7,s7,916 # b20 <digits>
 794:	a839                	j	7b2 <vprintf+0x6a>
        putc(fd, c);
 796:	85ca                	mv	a1,s2
 798:	8556                	mv	a0,s5
 79a:	00000097          	auipc	ra,0x0
 79e:	ee2080e7          	jalr	-286(ra) # 67c <putc>
 7a2:	a019                	j	7a8 <vprintf+0x60>
    } else if(state == '%'){
 7a4:	01498f63          	beq	s3,s4,7c2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7a8:	0485                	addi	s1,s1,1
 7aa:	fff4c903          	lbu	s2,-1(s1)
 7ae:	14090d63          	beqz	s2,908 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7b2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7b6:	fe0997e3          	bnez	s3,7a4 <vprintf+0x5c>
      if(c == '%'){
 7ba:	fd479ee3          	bne	a5,s4,796 <vprintf+0x4e>
        state = '%';
 7be:	89be                	mv	s3,a5
 7c0:	b7e5                	j	7a8 <vprintf+0x60>
      if(c == 'd'){
 7c2:	05878063          	beq	a5,s8,802 <vprintf+0xba>
      } else if(c == 'l') {
 7c6:	05978c63          	beq	a5,s9,81e <vprintf+0xd6>
      } else if(c == 'x') {
 7ca:	07a78863          	beq	a5,s10,83a <vprintf+0xf2>
      } else if(c == 'p') {
 7ce:	09b78463          	beq	a5,s11,856 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7d2:	07300713          	li	a4,115
 7d6:	0ce78663          	beq	a5,a4,8a2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7da:	06300713          	li	a4,99
 7de:	0ee78e63          	beq	a5,a4,8da <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7e2:	11478863          	beq	a5,s4,8f2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7e6:	85d2                	mv	a1,s4
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	e92080e7          	jalr	-366(ra) # 67c <putc>
        putc(fd, c);
 7f2:	85ca                	mv	a1,s2
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	e86080e7          	jalr	-378(ra) # 67c <putc>
      }
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b765                	j	7a8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 802:	008b0913          	addi	s2,s6,8
 806:	4685                	li	a3,1
 808:	4629                	li	a2,10
 80a:	000b2583          	lw	a1,0(s6)
 80e:	8556                	mv	a0,s5
 810:	00000097          	auipc	ra,0x0
 814:	e8e080e7          	jalr	-370(ra) # 69e <printint>
 818:	8b4a                	mv	s6,s2
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b771                	j	7a8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 81e:	008b0913          	addi	s2,s6,8
 822:	4681                	li	a3,0
 824:	4629                	li	a2,10
 826:	000b2583          	lw	a1,0(s6)
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	e72080e7          	jalr	-398(ra) # 69e <printint>
 834:	8b4a                	mv	s6,s2
      state = 0;
 836:	4981                	li	s3,0
 838:	bf85                	j	7a8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 83a:	008b0913          	addi	s2,s6,8
 83e:	4681                	li	a3,0
 840:	4641                	li	a2,16
 842:	000b2583          	lw	a1,0(s6)
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	e56080e7          	jalr	-426(ra) # 69e <printint>
 850:	8b4a                	mv	s6,s2
      state = 0;
 852:	4981                	li	s3,0
 854:	bf91                	j	7a8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 856:	008b0793          	addi	a5,s6,8
 85a:	f8f43423          	sd	a5,-120(s0)
 85e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 862:	03000593          	li	a1,48
 866:	8556                	mv	a0,s5
 868:	00000097          	auipc	ra,0x0
 86c:	e14080e7          	jalr	-492(ra) # 67c <putc>
  putc(fd, 'x');
 870:	85ea                	mv	a1,s10
 872:	8556                	mv	a0,s5
 874:	00000097          	auipc	ra,0x0
 878:	e08080e7          	jalr	-504(ra) # 67c <putc>
 87c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 87e:	03c9d793          	srli	a5,s3,0x3c
 882:	97de                	add	a5,a5,s7
 884:	0007c583          	lbu	a1,0(a5)
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	df2080e7          	jalr	-526(ra) # 67c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 892:	0992                	slli	s3,s3,0x4
 894:	397d                	addiw	s2,s2,-1
 896:	fe0914e3          	bnez	s2,87e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 89a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 89e:	4981                	li	s3,0
 8a0:	b721                	j	7a8 <vprintf+0x60>
        s = va_arg(ap, char*);
 8a2:	008b0993          	addi	s3,s6,8
 8a6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8aa:	02090163          	beqz	s2,8cc <vprintf+0x184>
        while(*s != 0){
 8ae:	00094583          	lbu	a1,0(s2)
 8b2:	c9a1                	beqz	a1,902 <vprintf+0x1ba>
          putc(fd, *s);
 8b4:	8556                	mv	a0,s5
 8b6:	00000097          	auipc	ra,0x0
 8ba:	dc6080e7          	jalr	-570(ra) # 67c <putc>
          s++;
 8be:	0905                	addi	s2,s2,1
        while(*s != 0){
 8c0:	00094583          	lbu	a1,0(s2)
 8c4:	f9e5                	bnez	a1,8b4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 8c6:	8b4e                	mv	s6,s3
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	bdf9                	j	7a8 <vprintf+0x60>
          s = "(null)";
 8cc:	00000917          	auipc	s2,0x0
 8d0:	24c90913          	addi	s2,s2,588 # b18 <malloc+0x106>
        while(*s != 0){
 8d4:	02800593          	li	a1,40
 8d8:	bff1                	j	8b4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8da:	008b0913          	addi	s2,s6,8
 8de:	000b4583          	lbu	a1,0(s6)
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	d98080e7          	jalr	-616(ra) # 67c <putc>
 8ec:	8b4a                	mv	s6,s2
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	bd65                	j	7a8 <vprintf+0x60>
        putc(fd, c);
 8f2:	85d2                	mv	a1,s4
 8f4:	8556                	mv	a0,s5
 8f6:	00000097          	auipc	ra,0x0
 8fa:	d86080e7          	jalr	-634(ra) # 67c <putc>
      state = 0;
 8fe:	4981                	li	s3,0
 900:	b565                	j	7a8 <vprintf+0x60>
        s = va_arg(ap, char*);
 902:	8b4e                	mv	s6,s3
      state = 0;
 904:	4981                	li	s3,0
 906:	b54d                	j	7a8 <vprintf+0x60>
    }
  }
}
 908:	70e6                	ld	ra,120(sp)
 90a:	7446                	ld	s0,112(sp)
 90c:	74a6                	ld	s1,104(sp)
 90e:	7906                	ld	s2,96(sp)
 910:	69e6                	ld	s3,88(sp)
 912:	6a46                	ld	s4,80(sp)
 914:	6aa6                	ld	s5,72(sp)
 916:	6b06                	ld	s6,64(sp)
 918:	7be2                	ld	s7,56(sp)
 91a:	7c42                	ld	s8,48(sp)
 91c:	7ca2                	ld	s9,40(sp)
 91e:	7d02                	ld	s10,32(sp)
 920:	6de2                	ld	s11,24(sp)
 922:	6109                	addi	sp,sp,128
 924:	8082                	ret

0000000000000926 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 926:	715d                	addi	sp,sp,-80
 928:	ec06                	sd	ra,24(sp)
 92a:	e822                	sd	s0,16(sp)
 92c:	1000                	addi	s0,sp,32
 92e:	e010                	sd	a2,0(s0)
 930:	e414                	sd	a3,8(s0)
 932:	e818                	sd	a4,16(s0)
 934:	ec1c                	sd	a5,24(s0)
 936:	03043023          	sd	a6,32(s0)
 93a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 93e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 942:	8622                	mv	a2,s0
 944:	00000097          	auipc	ra,0x0
 948:	e04080e7          	jalr	-508(ra) # 748 <vprintf>
}
 94c:	60e2                	ld	ra,24(sp)
 94e:	6442                	ld	s0,16(sp)
 950:	6161                	addi	sp,sp,80
 952:	8082                	ret

0000000000000954 <printf>:

void
printf(const char *fmt, ...)
{
 954:	711d                	addi	sp,sp,-96
 956:	ec06                	sd	ra,24(sp)
 958:	e822                	sd	s0,16(sp)
 95a:	1000                	addi	s0,sp,32
 95c:	e40c                	sd	a1,8(s0)
 95e:	e810                	sd	a2,16(s0)
 960:	ec14                	sd	a3,24(s0)
 962:	f018                	sd	a4,32(s0)
 964:	f41c                	sd	a5,40(s0)
 966:	03043823          	sd	a6,48(s0)
 96a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 96e:	00840613          	addi	a2,s0,8
 972:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 976:	85aa                	mv	a1,a0
 978:	4505                	li	a0,1
 97a:	00000097          	auipc	ra,0x0
 97e:	dce080e7          	jalr	-562(ra) # 748 <vprintf>
}
 982:	60e2                	ld	ra,24(sp)
 984:	6442                	ld	s0,16(sp)
 986:	6125                	addi	sp,sp,96
 988:	8082                	ret

000000000000098a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 98a:	1141                	addi	sp,sp,-16
 98c:	e422                	sd	s0,8(sp)
 98e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 990:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 994:	00000797          	auipc	a5,0x0
 998:	1a47b783          	ld	a5,420(a5) # b38 <freep>
 99c:	a805                	j	9cc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 99e:	4618                	lw	a4,8(a2)
 9a0:	9db9                	addw	a1,a1,a4
 9a2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a6:	6398                	ld	a4,0(a5)
 9a8:	6318                	ld	a4,0(a4)
 9aa:	fee53823          	sd	a4,-16(a0)
 9ae:	a091                	j	9f2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9b0:	ff852703          	lw	a4,-8(a0)
 9b4:	9e39                	addw	a2,a2,a4
 9b6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9b8:	ff053703          	ld	a4,-16(a0)
 9bc:	e398                	sd	a4,0(a5)
 9be:	a099                	j	a04 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c0:	6398                	ld	a4,0(a5)
 9c2:	00e7e463          	bltu	a5,a4,9ca <free+0x40>
 9c6:	00e6ea63          	bltu	a3,a4,9da <free+0x50>
{
 9ca:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9cc:	fed7fae3          	bgeu	a5,a3,9c0 <free+0x36>
 9d0:	6398                	ld	a4,0(a5)
 9d2:	00e6e463          	bltu	a3,a4,9da <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d6:	fee7eae3          	bltu	a5,a4,9ca <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9da:	ff852583          	lw	a1,-8(a0)
 9de:	6390                	ld	a2,0(a5)
 9e0:	02059813          	slli	a6,a1,0x20
 9e4:	01c85713          	srli	a4,a6,0x1c
 9e8:	9736                	add	a4,a4,a3
 9ea:	fae60ae3          	beq	a2,a4,99e <free+0x14>
    bp->s.ptr = p->s.ptr;
 9ee:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9f2:	4790                	lw	a2,8(a5)
 9f4:	02061593          	slli	a1,a2,0x20
 9f8:	01c5d713          	srli	a4,a1,0x1c
 9fc:	973e                	add	a4,a4,a5
 9fe:	fae689e3          	beq	a3,a4,9b0 <free+0x26>
  } else
    p->s.ptr = bp;
 a02:	e394                	sd	a3,0(a5)
  freep = p;
 a04:	00000717          	auipc	a4,0x0
 a08:	12f73a23          	sd	a5,308(a4) # b38 <freep>
}
 a0c:	6422                	ld	s0,8(sp)
 a0e:	0141                	addi	sp,sp,16
 a10:	8082                	ret

0000000000000a12 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a12:	7139                	addi	sp,sp,-64
 a14:	fc06                	sd	ra,56(sp)
 a16:	f822                	sd	s0,48(sp)
 a18:	f426                	sd	s1,40(sp)
 a1a:	f04a                	sd	s2,32(sp)
 a1c:	ec4e                	sd	s3,24(sp)
 a1e:	e852                	sd	s4,16(sp)
 a20:	e456                	sd	s5,8(sp)
 a22:	e05a                	sd	s6,0(sp)
 a24:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a26:	02051493          	slli	s1,a0,0x20
 a2a:	9081                	srli	s1,s1,0x20
 a2c:	04bd                	addi	s1,s1,15
 a2e:	8091                	srli	s1,s1,0x4
 a30:	0014899b          	addiw	s3,s1,1
 a34:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a36:	00000517          	auipc	a0,0x0
 a3a:	10253503          	ld	a0,258(a0) # b38 <freep>
 a3e:	c515                	beqz	a0,a6a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a40:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a42:	4798                	lw	a4,8(a5)
 a44:	02977f63          	bgeu	a4,s1,a82 <malloc+0x70>
 a48:	8a4e                	mv	s4,s3
 a4a:	0009871b          	sext.w	a4,s3
 a4e:	6685                	lui	a3,0x1
 a50:	00d77363          	bgeu	a4,a3,a56 <malloc+0x44>
 a54:	6a05                	lui	s4,0x1
 a56:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a5a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a5e:	00000917          	auipc	s2,0x0
 a62:	0da90913          	addi	s2,s2,218 # b38 <freep>
  if(p == (char*)-1)
 a66:	5afd                	li	s5,-1
 a68:	a895                	j	adc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a6a:	00000797          	auipc	a5,0x0
 a6e:	1c678793          	addi	a5,a5,454 # c30 <base>
 a72:	00000717          	auipc	a4,0x0
 a76:	0cf73323          	sd	a5,198(a4) # b38 <freep>
 a7a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a7c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a80:	b7e1                	j	a48 <malloc+0x36>
      if(p->s.size == nunits)
 a82:	02e48c63          	beq	s1,a4,aba <malloc+0xa8>
        p->s.size -= nunits;
 a86:	4137073b          	subw	a4,a4,s3
 a8a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a8c:	02071693          	slli	a3,a4,0x20
 a90:	01c6d713          	srli	a4,a3,0x1c
 a94:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a96:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a9a:	00000717          	auipc	a4,0x0
 a9e:	08a73f23          	sd	a0,158(a4) # b38 <freep>
      return (void*)(p + 1);
 aa2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 aa6:	70e2                	ld	ra,56(sp)
 aa8:	7442                	ld	s0,48(sp)
 aaa:	74a2                	ld	s1,40(sp)
 aac:	7902                	ld	s2,32(sp)
 aae:	69e2                	ld	s3,24(sp)
 ab0:	6a42                	ld	s4,16(sp)
 ab2:	6aa2                	ld	s5,8(sp)
 ab4:	6b02                	ld	s6,0(sp)
 ab6:	6121                	addi	sp,sp,64
 ab8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aba:	6398                	ld	a4,0(a5)
 abc:	e118                	sd	a4,0(a0)
 abe:	bff1                	j	a9a <malloc+0x88>
  hp->s.size = nu;
 ac0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ac4:	0541                	addi	a0,a0,16
 ac6:	00000097          	auipc	ra,0x0
 aca:	ec4080e7          	jalr	-316(ra) # 98a <free>
  return freep;
 ace:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ad2:	d971                	beqz	a0,aa6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ad6:	4798                	lw	a4,8(a5)
 ad8:	fa9775e3          	bgeu	a4,s1,a82 <malloc+0x70>
    if(p == freep)
 adc:	00093703          	ld	a4,0(s2)
 ae0:	853e                	mv	a0,a5
 ae2:	fef719e3          	bne	a4,a5,ad4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ae6:	8552                	mv	a0,s4
 ae8:	00000097          	auipc	ra,0x0
 aec:	b74080e7          	jalr	-1164(ra) # 65c <sbrk>
  if(p == (char*)-1)
 af0:	fd5518e3          	bne	a0,s5,ac0 <malloc+0xae>
        return 0;
 af4:	4501                	li	a0,0
 af6:	bf45                	j	aa6 <malloc+0x94>
