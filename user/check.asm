
user/_check:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
//#include <unistd.h>

#define SIZE 4096

int main()
{  
   0:	715d                	addi	sp,sp,-80
   2:	e486                	sd	ra,72(sp)
   4:	e0a2                	sd	s0,64(sp)
   6:	fc26                	sd	s1,56(sp)
   8:	f84a                	sd	s2,48(sp)
   a:	f44e                	sd	s3,40(sp)
   c:	f052                	sd	s4,32(sp)
   e:	ec56                	sd	s5,24(sp)
  10:	0880                	addi	s0,sp,80
    int fd[2],i;
    pipe(fd);
  12:	fb840513          	addi	a0,s0,-72
  16:	00000097          	auipc	ra,0x0
  1a:	5f6080e7          	jalr	1526(ra) # 60c <pipe>
    int pid = fork();
  1e:	00000097          	auipc	ra,0x0
  22:	5d6080e7          	jalr	1494(ra) # 5f4 <fork>

    

    if(pid > 0){
  26:	06a04a63          	bgtz	a0,9a <main+0x9a>
  2a:	84aa                	mv	s1,a0
        for(i=0;i<n/4;i++){
            printf("%d ",data[i]);
        }
        printf("\n");
    }
    else if(pid == 0){
  2c:	10051763          	bnez	a0,13a <main+0x13a>

        int bytes = 10;
        int *data;
        data = (int*)malloc(bytes);
  30:	4529                	li	a0,10
  32:	00001097          	auipc	ra,0x1
  36:	a08080e7          	jalr	-1528(ra) # a3a <malloc>
  3a:	8aaa                	mv	s5,a0

        for(int i=0;i<bytes;i++){
  3c:	892a                	mv	s2,a0
            data[i] = i+1;
            printf("%d ",data[i]);
  3e:	00001a17          	auipc	s4,0x1
  42:	aeaa0a13          	addi	s4,s4,-1302 # b28 <malloc+0xee>
        for(int i=0;i<bytes;i++){
  46:	49a9                	li	s3,10
            data[i] = i+1;
  48:	0014879b          	addiw	a5,s1,1
  4c:	0007849b          	sext.w	s1,a5
  50:	00f92023          	sw	a5,0(s2)
            printf("%d ",data[i]);
  54:	85a6                	mv	a1,s1
  56:	8552                	mv	a0,s4
  58:	00001097          	auipc	ra,0x1
  5c:	924080e7          	jalr	-1756(ra) # 97c <printf>
        for(int i=0;i<bytes;i++){
  60:	0911                	addi	s2,s2,4
  62:	ff3493e3          	bne	s1,s3,48 <main+0x48>
        }

        close(fd[0]);
  66:	fb842503          	lw	a0,-72(s0)
  6a:	00000097          	auipc	ra,0x0
  6e:	5ba080e7          	jalr	1466(ra) # 624 <close>
        close(1);
  72:	4505                	li	a0,1
  74:	00000097          	auipc	ra,0x0
  78:	5b0080e7          	jalr	1456(ra) # 624 <close>
        dup(fd[1]);
  7c:	fbc42503          	lw	a0,-68(s0)
  80:	00000097          	auipc	ra,0x0
  84:	5f4080e7          	jalr	1524(ra) # 674 <dup>
        write(fd[1],data,sizeof(data));
  88:	4621                	li	a2,8
  8a:	85d6                	mv	a1,s5
  8c:	fbc42503          	lw	a0,-68(s0)
  90:	00000097          	auipc	ra,0x0
  94:	58c080e7          	jalr	1420(ra) # 61c <write>
  98:	a861                	j	130 <main+0x130>
        wait(NULL);
  9a:	4501                	li	a0,0
  9c:	00000097          	auipc	ra,0x0
  a0:	568080e7          	jalr	1384(ra) # 604 <wait>
        close(0);
  a4:	4501                	li	a0,0
  a6:	00000097          	auipc	ra,0x0
  aa:	57e080e7          	jalr	1406(ra) # 624 <close>
        close(fd[1]);
  ae:	fbc42503          	lw	a0,-68(s0)
  b2:	00000097          	auipc	ra,0x0
  b6:	572080e7          	jalr	1394(ra) # 624 <close>
        dup(fd[1]);
  ba:	fbc42503          	lw	a0,-68(s0)
  be:	00000097          	auipc	ra,0x0
  c2:	5b6080e7          	jalr	1462(ra) # 674 <dup>
        data = (int*)malloc(bytes);
  c6:	4529                	li	a0,10
  c8:	00001097          	auipc	ra,0x1
  cc:	972080e7          	jalr	-1678(ra) # a3a <malloc>
  d0:	84aa                	mv	s1,a0
        int n=read(fd[0],data,sizeof(data));
  d2:	4621                	li	a2,8
  d4:	85aa                	mv	a1,a0
  d6:	fb842503          	lw	a0,-72(s0)
  da:	00000097          	auipc	ra,0x0
  de:	53a080e7          	jalr	1338(ra) # 614 <read>
  e2:	892a                	mv	s2,a0
        printf("%d\n",n);
  e4:	85aa                	mv	a1,a0
  e6:	00001517          	auipc	a0,0x1
  ea:	a3a50513          	addi	a0,a0,-1478 # b20 <malloc+0xe6>
  ee:	00001097          	auipc	ra,0x1
  f2:	88e080e7          	jalr	-1906(ra) # 97c <printf>
        for(i=0;i<n/4;i++){
  f6:	4991                	li	s3,4
  f8:	033949bb          	divw	s3,s2,s3
  fc:	478d                	li	a5,3
  fe:	0327d163          	bge	a5,s2,120 <main+0x120>
 102:	4901                	li	s2,0
            printf("%d ",data[i]);
 104:	00001a17          	auipc	s4,0x1
 108:	a24a0a13          	addi	s4,s4,-1500 # b28 <malloc+0xee>
 10c:	408c                	lw	a1,0(s1)
 10e:	8552                	mv	a0,s4
 110:	00001097          	auipc	ra,0x1
 114:	86c080e7          	jalr	-1940(ra) # 97c <printf>
        for(i=0;i<n/4;i++){
 118:	2905                	addiw	s2,s2,1
 11a:	0491                	addi	s1,s1,4
 11c:	ff3948e3          	blt	s2,s3,10c <main+0x10c>
        printf("\n");
 120:	00001517          	auipc	a0,0x1
 124:	a1050513          	addi	a0,a0,-1520 # b30 <malloc+0xf6>
 128:	00001097          	auipc	ra,0x1
 12c:	854080e7          	jalr	-1964(ra) # 97c <printf>
    }
    else{
        printf("error");
    }
    exit(0);
 130:	4501                	li	a0,0
 132:	00000097          	auipc	ra,0x0
 136:	4ca080e7          	jalr	1226(ra) # 5fc <exit>
        printf("error");
 13a:	00001517          	auipc	a0,0x1
 13e:	9fe50513          	addi	a0,a0,-1538 # b38 <malloc+0xfe>
 142:	00001097          	auipc	ra,0x1
 146:	83a080e7          	jalr	-1990(ra) # 97c <printf>
 14a:	b7dd                	j	130 <main+0x130>

000000000000014c <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 14c:	1141                	addi	sp,sp,-16
 14e:	e422                	sd	s0,8(sp)
 150:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 152:	0f50000f          	fence	iorw,ow
 156:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 15a:	6422                	ld	s0,8(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret

0000000000000160 <load>:

int load(uint64 *p) {
 160:	1141                	addi	sp,sp,-16
 162:	e422                	sd	s0,8(sp)
 164:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 166:	0ff0000f          	fence
 16a:	6108                	ld	a0,0(a0)
 16c:	0ff0000f          	fence
}
 170:	2501                	sext.w	a0,a0
 172:	6422                	ld	s0,8(sp)
 174:	0141                	addi	sp,sp,16
 176:	8082                	ret

0000000000000178 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 178:	7179                	addi	sp,sp,-48
 17a:	f406                	sd	ra,40(sp)
 17c:	f022                	sd	s0,32(sp)
 17e:	ec26                	sd	s1,24(sp)
 180:	e84a                	sd	s2,16(sp)
 182:	e44e                	sd	s3,8(sp)
 184:	e052                	sd	s4,0(sp)
 186:	1800                	addi	s0,sp,48
 188:	8a2a                	mv	s4,a0
 18a:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 18c:	4785                	li	a5,1
 18e:	00001497          	auipc	s1,0x1
 192:	9ea48493          	addi	s1,s1,-1558 # b78 <rings+0x10>
 196:	00001917          	auipc	s2,0x1
 19a:	ad290913          	addi	s2,s2,-1326 # c68 <__BSS_END__>
 19e:	04f59563          	bne	a1,a5,1e8 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 1a2:	00001497          	auipc	s1,0x1
 1a6:	9d64a483          	lw	s1,-1578(s1) # b78 <rings+0x10>
 1aa:	c099                	beqz	s1,1b0 <create_or_close_the_buffer_user+0x38>
 1ac:	4481                	li	s1,0
 1ae:	a899                	j	204 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 1b0:	00001917          	auipc	s2,0x1
 1b4:	9b890913          	addi	s2,s2,-1608 # b68 <rings>
 1b8:	00093603          	ld	a2,0(s2)
 1bc:	4585                	li	a1,1
 1be:	00000097          	auipc	ra,0x0
 1c2:	4de080e7          	jalr	1246(ra) # 69c <ringbuf>
        rings[i].book->write_done = 0;
 1c6:	00893783          	ld	a5,8(s2)
 1ca:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 1ce:	00893783          	ld	a5,8(s2)
 1d2:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 1d6:	01092783          	lw	a5,16(s2)
 1da:	2785                	addiw	a5,a5,1
 1dc:	00f92823          	sw	a5,16(s2)
        break;
 1e0:	a015                	j	204 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 1e2:	04e1                	addi	s1,s1,24
 1e4:	01248f63          	beq	s1,s2,202 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 1e8:	409c                	lw	a5,0(s1)
 1ea:	dfe5                	beqz	a5,1e2 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 1ec:	ff04b603          	ld	a2,-16(s1)
 1f0:	85ce                	mv	a1,s3
 1f2:	8552                	mv	a0,s4
 1f4:	00000097          	auipc	ra,0x0
 1f8:	4a8080e7          	jalr	1192(ra) # 69c <ringbuf>
        rings[i].exists = 0;
 1fc:	0004a023          	sw	zero,0(s1)
 200:	b7cd                	j	1e2 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 202:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 204:	8526                	mv	a0,s1
 206:	70a2                	ld	ra,40(sp)
 208:	7402                	ld	s0,32(sp)
 20a:	64e2                	ld	s1,24(sp)
 20c:	6942                	ld	s2,16(sp)
 20e:	69a2                	ld	s3,8(sp)
 210:	6a02                	ld	s4,0(sp)
 212:	6145                	addi	sp,sp,48
 214:	8082                	ret

0000000000000216 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 216:	1101                	addi	sp,sp,-32
 218:	ec06                	sd	ra,24(sp)
 21a:	e822                	sd	s0,16(sp)
 21c:	e426                	sd	s1,8(sp)
 21e:	1000                	addi	s0,sp,32
 220:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 222:	00151793          	slli	a5,a0,0x1
 226:	97aa                	add	a5,a5,a0
 228:	078e                	slli	a5,a5,0x3
 22a:	00001717          	auipc	a4,0x1
 22e:	93e70713          	addi	a4,a4,-1730 # b68 <rings>
 232:	97ba                	add	a5,a5,a4
 234:	6798                	ld	a4,8(a5)
 236:	671c                	ld	a5,8(a4)
 238:	00178693          	addi	a3,a5,1
 23c:	e714                	sd	a3,8(a4)
 23e:	17d2                	slli	a5,a5,0x34
 240:	93d1                	srli	a5,a5,0x34
 242:	6741                	lui	a4,0x10
 244:	40f707b3          	sub	a5,a4,a5
 248:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 24a:	421c                	lw	a5,0(a2)
 24c:	e79d                	bnez	a5,27a <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 24e:	00001697          	auipc	a3,0x1
 252:	91a68693          	addi	a3,a3,-1766 # b68 <rings>
 256:	669c                	ld	a5,8(a3)
 258:	6398                	ld	a4,0(a5)
 25a:	67c1                	lui	a5,0x10
 25c:	9fb9                	addw	a5,a5,a4
 25e:	00151713          	slli	a4,a0,0x1
 262:	953a                	add	a0,a0,a4
 264:	050e                	slli	a0,a0,0x3
 266:	9536                	add	a0,a0,a3
 268:	6518                	ld	a4,8(a0)
 26a:	6718                	ld	a4,8(a4)
 26c:	9f99                	subw	a5,a5,a4
 26e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 270:	60e2                	ld	ra,24(sp)
 272:	6442                	ld	s0,16(sp)
 274:	64a2                	ld	s1,8(sp)
 276:	6105                	addi	sp,sp,32
 278:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 27a:	00151793          	slli	a5,a0,0x1
 27e:	953e                	add	a0,a0,a5
 280:	050e                	slli	a0,a0,0x3
 282:	00001797          	auipc	a5,0x1
 286:	8e678793          	addi	a5,a5,-1818 # b68 <rings>
 28a:	953e                	add	a0,a0,a5
 28c:	6508                	ld	a0,8(a0)
 28e:	0521                	addi	a0,a0,8
 290:	00000097          	auipc	ra,0x0
 294:	ed0080e7          	jalr	-304(ra) # 160 <load>
 298:	c088                	sw	a0,0(s1)
}
 29a:	bfd9                	j	270 <ringbuf_start_write+0x5a>

000000000000029c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 2a4:	00151793          	slli	a5,a0,0x1
 2a8:	97aa                	add	a5,a5,a0
 2aa:	078e                	slli	a5,a5,0x3
 2ac:	00001517          	auipc	a0,0x1
 2b0:	8bc50513          	addi	a0,a0,-1860 # b68 <rings>
 2b4:	97aa                	add	a5,a5,a0
 2b6:	6788                	ld	a0,8(a5)
 2b8:	0035959b          	slliw	a1,a1,0x3
 2bc:	0521                	addi	a0,a0,8
 2be:	00000097          	auipc	ra,0x0
 2c2:	e8e080e7          	jalr	-370(ra) # 14c <store>
}
 2c6:	60a2                	ld	ra,8(sp)
 2c8:	6402                	ld	s0,0(sp)
 2ca:	0141                	addi	sp,sp,16
 2cc:	8082                	ret

00000000000002ce <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 2ce:	1101                	addi	sp,sp,-32
 2d0:	ec06                	sd	ra,24(sp)
 2d2:	e822                	sd	s0,16(sp)
 2d4:	e426                	sd	s1,8(sp)
 2d6:	1000                	addi	s0,sp,32
 2d8:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 2da:	00151793          	slli	a5,a0,0x1
 2de:	97aa                	add	a5,a5,a0
 2e0:	078e                	slli	a5,a5,0x3
 2e2:	00001517          	auipc	a0,0x1
 2e6:	88650513          	addi	a0,a0,-1914 # b68 <rings>
 2ea:	97aa                	add	a5,a5,a0
 2ec:	6788                	ld	a0,8(a5)
 2ee:	0521                	addi	a0,a0,8
 2f0:	00000097          	auipc	ra,0x0
 2f4:	e70080e7          	jalr	-400(ra) # 160 <load>
 2f8:	c088                	sw	a0,0(s1)
}
 2fa:	60e2                	ld	ra,24(sp)
 2fc:	6442                	ld	s0,16(sp)
 2fe:	64a2                	ld	s1,8(sp)
 300:	6105                	addi	sp,sp,32
 302:	8082                	ret

0000000000000304 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 304:	1101                	addi	sp,sp,-32
 306:	ec06                	sd	ra,24(sp)
 308:	e822                	sd	s0,16(sp)
 30a:	e426                	sd	s1,8(sp)
 30c:	1000                	addi	s0,sp,32
 30e:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 310:	00151793          	slli	a5,a0,0x1
 314:	97aa                	add	a5,a5,a0
 316:	078e                	slli	a5,a5,0x3
 318:	00001517          	auipc	a0,0x1
 31c:	85050513          	addi	a0,a0,-1968 # b68 <rings>
 320:	97aa                	add	a5,a5,a0
 322:	6788                	ld	a0,8(a5)
 324:	611c                	ld	a5,0(a0)
 326:	ef99                	bnez	a5,344 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 328:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 32a:	41f7579b          	sraiw	a5,a4,0x1f
 32e:	01d7d79b          	srliw	a5,a5,0x1d
 332:	9fb9                	addw	a5,a5,a4
 334:	4037d79b          	sraiw	a5,a5,0x3
 338:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 33a:	60e2                	ld	ra,24(sp)
 33c:	6442                	ld	s0,16(sp)
 33e:	64a2                	ld	s1,8(sp)
 340:	6105                	addi	sp,sp,32
 342:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 344:	00000097          	auipc	ra,0x0
 348:	e1c080e7          	jalr	-484(ra) # 160 <load>
    *bytes /= 8;
 34c:	41f5579b          	sraiw	a5,a0,0x1f
 350:	01d7d79b          	srliw	a5,a5,0x1d
 354:	9d3d                	addw	a0,a0,a5
 356:	4035551b          	sraiw	a0,a0,0x3
 35a:	c088                	sw	a0,0(s1)
}
 35c:	bff9                	j	33a <ringbuf_start_read+0x36>

000000000000035e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 35e:	1141                	addi	sp,sp,-16
 360:	e406                	sd	ra,8(sp)
 362:	e022                	sd	s0,0(sp)
 364:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 366:	00151793          	slli	a5,a0,0x1
 36a:	97aa                	add	a5,a5,a0
 36c:	078e                	slli	a5,a5,0x3
 36e:	00000517          	auipc	a0,0x0
 372:	7fa50513          	addi	a0,a0,2042 # b68 <rings>
 376:	97aa                	add	a5,a5,a0
 378:	0035959b          	slliw	a1,a1,0x3
 37c:	6788                	ld	a0,8(a5)
 37e:	00000097          	auipc	ra,0x0
 382:	dce080e7          	jalr	-562(ra) # 14c <store>
}
 386:	60a2                	ld	ra,8(sp)
 388:	6402                	ld	s0,0(sp)
 38a:	0141                	addi	sp,sp,16
 38c:	8082                	ret

000000000000038e <strcpy>:



char*
strcpy(char *s, const char *t)
{
 38e:	1141                	addi	sp,sp,-16
 390:	e422                	sd	s0,8(sp)
 392:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 394:	87aa                	mv	a5,a0
 396:	0585                	addi	a1,a1,1
 398:	0785                	addi	a5,a5,1
 39a:	fff5c703          	lbu	a4,-1(a1)
 39e:	fee78fa3          	sb	a4,-1(a5)
 3a2:	fb75                	bnez	a4,396 <strcpy+0x8>
    ;
  return os;
}
 3a4:	6422                	ld	s0,8(sp)
 3a6:	0141                	addi	sp,sp,16
 3a8:	8082                	ret

00000000000003aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3aa:	1141                	addi	sp,sp,-16
 3ac:	e422                	sd	s0,8(sp)
 3ae:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3b0:	00054783          	lbu	a5,0(a0)
 3b4:	cb91                	beqz	a5,3c8 <strcmp+0x1e>
 3b6:	0005c703          	lbu	a4,0(a1)
 3ba:	00f71763          	bne	a4,a5,3c8 <strcmp+0x1e>
    p++, q++;
 3be:	0505                	addi	a0,a0,1
 3c0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3c2:	00054783          	lbu	a5,0(a0)
 3c6:	fbe5                	bnez	a5,3b6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3c8:	0005c503          	lbu	a0,0(a1)
}
 3cc:	40a7853b          	subw	a0,a5,a0
 3d0:	6422                	ld	s0,8(sp)
 3d2:	0141                	addi	sp,sp,16
 3d4:	8082                	ret

00000000000003d6 <strlen>:

uint
strlen(const char *s)
{
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e422                	sd	s0,8(sp)
 3da:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3dc:	00054783          	lbu	a5,0(a0)
 3e0:	cf91                	beqz	a5,3fc <strlen+0x26>
 3e2:	0505                	addi	a0,a0,1
 3e4:	87aa                	mv	a5,a0
 3e6:	4685                	li	a3,1
 3e8:	9e89                	subw	a3,a3,a0
 3ea:	00f6853b          	addw	a0,a3,a5
 3ee:	0785                	addi	a5,a5,1
 3f0:	fff7c703          	lbu	a4,-1(a5)
 3f4:	fb7d                	bnez	a4,3ea <strlen+0x14>
    ;
  return n;
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret
  for(n = 0; s[n]; n++)
 3fc:	4501                	li	a0,0
 3fe:	bfe5                	j	3f6 <strlen+0x20>

0000000000000400 <memset>:

void*
memset(void *dst, int c, uint n)
{
 400:	1141                	addi	sp,sp,-16
 402:	e422                	sd	s0,8(sp)
 404:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 406:	ca19                	beqz	a2,41c <memset+0x1c>
 408:	87aa                	mv	a5,a0
 40a:	1602                	slli	a2,a2,0x20
 40c:	9201                	srli	a2,a2,0x20
 40e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 412:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 416:	0785                	addi	a5,a5,1
 418:	fee79de3          	bne	a5,a4,412 <memset+0x12>
  }
  return dst;
}
 41c:	6422                	ld	s0,8(sp)
 41e:	0141                	addi	sp,sp,16
 420:	8082                	ret

0000000000000422 <strchr>:

char*
strchr(const char *s, char c)
{
 422:	1141                	addi	sp,sp,-16
 424:	e422                	sd	s0,8(sp)
 426:	0800                	addi	s0,sp,16
  for(; *s; s++)
 428:	00054783          	lbu	a5,0(a0)
 42c:	cb99                	beqz	a5,442 <strchr+0x20>
    if(*s == c)
 42e:	00f58763          	beq	a1,a5,43c <strchr+0x1a>
  for(; *s; s++)
 432:	0505                	addi	a0,a0,1
 434:	00054783          	lbu	a5,0(a0)
 438:	fbfd                	bnez	a5,42e <strchr+0xc>
      return (char*)s;
  return 0;
 43a:	4501                	li	a0,0
}
 43c:	6422                	ld	s0,8(sp)
 43e:	0141                	addi	sp,sp,16
 440:	8082                	ret
  return 0;
 442:	4501                	li	a0,0
 444:	bfe5                	j	43c <strchr+0x1a>

0000000000000446 <gets>:

char*
gets(char *buf, int max)
{
 446:	711d                	addi	sp,sp,-96
 448:	ec86                	sd	ra,88(sp)
 44a:	e8a2                	sd	s0,80(sp)
 44c:	e4a6                	sd	s1,72(sp)
 44e:	e0ca                	sd	s2,64(sp)
 450:	fc4e                	sd	s3,56(sp)
 452:	f852                	sd	s4,48(sp)
 454:	f456                	sd	s5,40(sp)
 456:	f05a                	sd	s6,32(sp)
 458:	ec5e                	sd	s7,24(sp)
 45a:	1080                	addi	s0,sp,96
 45c:	8baa                	mv	s7,a0
 45e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 460:	892a                	mv	s2,a0
 462:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 464:	4aa9                	li	s5,10
 466:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 468:	89a6                	mv	s3,s1
 46a:	2485                	addiw	s1,s1,1
 46c:	0344d863          	bge	s1,s4,49c <gets+0x56>
    cc = read(0, &c, 1);
 470:	4605                	li	a2,1
 472:	faf40593          	addi	a1,s0,-81
 476:	4501                	li	a0,0
 478:	00000097          	auipc	ra,0x0
 47c:	19c080e7          	jalr	412(ra) # 614 <read>
    if(cc < 1)
 480:	00a05e63          	blez	a0,49c <gets+0x56>
    buf[i++] = c;
 484:	faf44783          	lbu	a5,-81(s0)
 488:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 48c:	01578763          	beq	a5,s5,49a <gets+0x54>
 490:	0905                	addi	s2,s2,1
 492:	fd679be3          	bne	a5,s6,468 <gets+0x22>
  for(i=0; i+1 < max; ){
 496:	89a6                	mv	s3,s1
 498:	a011                	j	49c <gets+0x56>
 49a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 49c:	99de                	add	s3,s3,s7
 49e:	00098023          	sb	zero,0(s3)
  return buf;
}
 4a2:	855e                	mv	a0,s7
 4a4:	60e6                	ld	ra,88(sp)
 4a6:	6446                	ld	s0,80(sp)
 4a8:	64a6                	ld	s1,72(sp)
 4aa:	6906                	ld	s2,64(sp)
 4ac:	79e2                	ld	s3,56(sp)
 4ae:	7a42                	ld	s4,48(sp)
 4b0:	7aa2                	ld	s5,40(sp)
 4b2:	7b02                	ld	s6,32(sp)
 4b4:	6be2                	ld	s7,24(sp)
 4b6:	6125                	addi	sp,sp,96
 4b8:	8082                	ret

00000000000004ba <stat>:

int
stat(const char *n, struct stat *st)
{
 4ba:	1101                	addi	sp,sp,-32
 4bc:	ec06                	sd	ra,24(sp)
 4be:	e822                	sd	s0,16(sp)
 4c0:	e426                	sd	s1,8(sp)
 4c2:	e04a                	sd	s2,0(sp)
 4c4:	1000                	addi	s0,sp,32
 4c6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c8:	4581                	li	a1,0
 4ca:	00000097          	auipc	ra,0x0
 4ce:	172080e7          	jalr	370(ra) # 63c <open>
  if(fd < 0)
 4d2:	02054563          	bltz	a0,4fc <stat+0x42>
 4d6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4d8:	85ca                	mv	a1,s2
 4da:	00000097          	auipc	ra,0x0
 4de:	17a080e7          	jalr	378(ra) # 654 <fstat>
 4e2:	892a                	mv	s2,a0
  close(fd);
 4e4:	8526                	mv	a0,s1
 4e6:	00000097          	auipc	ra,0x0
 4ea:	13e080e7          	jalr	318(ra) # 624 <close>
  return r;
}
 4ee:	854a                	mv	a0,s2
 4f0:	60e2                	ld	ra,24(sp)
 4f2:	6442                	ld	s0,16(sp)
 4f4:	64a2                	ld	s1,8(sp)
 4f6:	6902                	ld	s2,0(sp)
 4f8:	6105                	addi	sp,sp,32
 4fa:	8082                	ret
    return -1;
 4fc:	597d                	li	s2,-1
 4fe:	bfc5                	j	4ee <stat+0x34>

0000000000000500 <atoi>:

int
atoi(const char *s)
{
 500:	1141                	addi	sp,sp,-16
 502:	e422                	sd	s0,8(sp)
 504:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 506:	00054603          	lbu	a2,0(a0)
 50a:	fd06079b          	addiw	a5,a2,-48
 50e:	0ff7f793          	zext.b	a5,a5
 512:	4725                	li	a4,9
 514:	02f76963          	bltu	a4,a5,546 <atoi+0x46>
 518:	86aa                	mv	a3,a0
  n = 0;
 51a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 51c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 51e:	0685                	addi	a3,a3,1
 520:	0025179b          	slliw	a5,a0,0x2
 524:	9fa9                	addw	a5,a5,a0
 526:	0017979b          	slliw	a5,a5,0x1
 52a:	9fb1                	addw	a5,a5,a2
 52c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 530:	0006c603          	lbu	a2,0(a3)
 534:	fd06071b          	addiw	a4,a2,-48
 538:	0ff77713          	zext.b	a4,a4
 53c:	fee5f1e3          	bgeu	a1,a4,51e <atoi+0x1e>
  return n;
}
 540:	6422                	ld	s0,8(sp)
 542:	0141                	addi	sp,sp,16
 544:	8082                	ret
  n = 0;
 546:	4501                	li	a0,0
 548:	bfe5                	j	540 <atoi+0x40>

000000000000054a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 54a:	1141                	addi	sp,sp,-16
 54c:	e422                	sd	s0,8(sp)
 54e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 550:	02b57463          	bgeu	a0,a1,578 <memmove+0x2e>
    while(n-- > 0)
 554:	00c05f63          	blez	a2,572 <memmove+0x28>
 558:	1602                	slli	a2,a2,0x20
 55a:	9201                	srli	a2,a2,0x20
 55c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 560:	872a                	mv	a4,a0
      *dst++ = *src++;
 562:	0585                	addi	a1,a1,1
 564:	0705                	addi	a4,a4,1
 566:	fff5c683          	lbu	a3,-1(a1)
 56a:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xeca6>
    while(n-- > 0)
 56e:	fee79ae3          	bne	a5,a4,562 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 572:	6422                	ld	s0,8(sp)
 574:	0141                	addi	sp,sp,16
 576:	8082                	ret
    dst += n;
 578:	00c50733          	add	a4,a0,a2
    src += n;
 57c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 57e:	fec05ae3          	blez	a2,572 <memmove+0x28>
 582:	fff6079b          	addiw	a5,a2,-1
 586:	1782                	slli	a5,a5,0x20
 588:	9381                	srli	a5,a5,0x20
 58a:	fff7c793          	not	a5,a5
 58e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 590:	15fd                	addi	a1,a1,-1
 592:	177d                	addi	a4,a4,-1
 594:	0005c683          	lbu	a3,0(a1)
 598:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 59c:	fee79ae3          	bne	a5,a4,590 <memmove+0x46>
 5a0:	bfc9                	j	572 <memmove+0x28>

00000000000005a2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5a2:	1141                	addi	sp,sp,-16
 5a4:	e422                	sd	s0,8(sp)
 5a6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5a8:	ca05                	beqz	a2,5d8 <memcmp+0x36>
 5aa:	fff6069b          	addiw	a3,a2,-1
 5ae:	1682                	slli	a3,a3,0x20
 5b0:	9281                	srli	a3,a3,0x20
 5b2:	0685                	addi	a3,a3,1
 5b4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5b6:	00054783          	lbu	a5,0(a0)
 5ba:	0005c703          	lbu	a4,0(a1)
 5be:	00e79863          	bne	a5,a4,5ce <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5c2:	0505                	addi	a0,a0,1
    p2++;
 5c4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5c6:	fed518e3          	bne	a0,a3,5b6 <memcmp+0x14>
  }
  return 0;
 5ca:	4501                	li	a0,0
 5cc:	a019                	j	5d2 <memcmp+0x30>
      return *p1 - *p2;
 5ce:	40e7853b          	subw	a0,a5,a4
}
 5d2:	6422                	ld	s0,8(sp)
 5d4:	0141                	addi	sp,sp,16
 5d6:	8082                	ret
  return 0;
 5d8:	4501                	li	a0,0
 5da:	bfe5                	j	5d2 <memcmp+0x30>

00000000000005dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5dc:	1141                	addi	sp,sp,-16
 5de:	e406                	sd	ra,8(sp)
 5e0:	e022                	sd	s0,0(sp)
 5e2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5e4:	00000097          	auipc	ra,0x0
 5e8:	f66080e7          	jalr	-154(ra) # 54a <memmove>
}
 5ec:	60a2                	ld	ra,8(sp)
 5ee:	6402                	ld	s0,0(sp)
 5f0:	0141                	addi	sp,sp,16
 5f2:	8082                	ret

00000000000005f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5f4:	4885                	li	a7,1
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 5fc:	4889                	li	a7,2
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <wait>:
.global wait
wait:
 li a7, SYS_wait
 604:	488d                	li	a7,3
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 60c:	4891                	li	a7,4
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <read>:
.global read
read:
 li a7, SYS_read
 614:	4895                	li	a7,5
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <write>:
.global write
write:
 li a7, SYS_write
 61c:	48c1                	li	a7,16
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <close>:
.global close
close:
 li a7, SYS_close
 624:	48d5                	li	a7,21
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <kill>:
.global kill
kill:
 li a7, SYS_kill
 62c:	4899                	li	a7,6
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <exec>:
.global exec
exec:
 li a7, SYS_exec
 634:	489d                	li	a7,7
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <open>:
.global open
open:
 li a7, SYS_open
 63c:	48bd                	li	a7,15
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 644:	48c5                	li	a7,17
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 64c:	48c9                	li	a7,18
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 654:	48a1                	li	a7,8
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <link>:
.global link
link:
 li a7, SYS_link
 65c:	48cd                	li	a7,19
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 664:	48d1                	li	a7,20
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 66c:	48a5                	li	a7,9
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <dup>:
.global dup
dup:
 li a7, SYS_dup
 674:	48a9                	li	a7,10
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 67c:	48ad                	li	a7,11
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 684:	48b1                	li	a7,12
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 68c:	48b5                	li	a7,13
 ecall
 68e:	00000073          	ecall
 ret
 692:	8082                	ret

0000000000000694 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 694:	48b9                	li	a7,14
 ecall
 696:	00000073          	ecall
 ret
 69a:	8082                	ret

000000000000069c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 69c:	48d9                	li	a7,22
 ecall
 69e:	00000073          	ecall
 ret
 6a2:	8082                	ret

00000000000006a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6a4:	1101                	addi	sp,sp,-32
 6a6:	ec06                	sd	ra,24(sp)
 6a8:	e822                	sd	s0,16(sp)
 6aa:	1000                	addi	s0,sp,32
 6ac:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6b0:	4605                	li	a2,1
 6b2:	fef40593          	addi	a1,s0,-17
 6b6:	00000097          	auipc	ra,0x0
 6ba:	f66080e7          	jalr	-154(ra) # 61c <write>
}
 6be:	60e2                	ld	ra,24(sp)
 6c0:	6442                	ld	s0,16(sp)
 6c2:	6105                	addi	sp,sp,32
 6c4:	8082                	ret

00000000000006c6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6c6:	7139                	addi	sp,sp,-64
 6c8:	fc06                	sd	ra,56(sp)
 6ca:	f822                	sd	s0,48(sp)
 6cc:	f426                	sd	s1,40(sp)
 6ce:	f04a                	sd	s2,32(sp)
 6d0:	ec4e                	sd	s3,24(sp)
 6d2:	0080                	addi	s0,sp,64
 6d4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6d6:	c299                	beqz	a3,6dc <printint+0x16>
 6d8:	0805c863          	bltz	a1,768 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6dc:	2581                	sext.w	a1,a1
  neg = 0;
 6de:	4881                	li	a7,0
 6e0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6e4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6e6:	2601                	sext.w	a2,a2
 6e8:	00000517          	auipc	a0,0x0
 6ec:	46050513          	addi	a0,a0,1120 # b48 <digits>
 6f0:	883a                	mv	a6,a4
 6f2:	2705                	addiw	a4,a4,1
 6f4:	02c5f7bb          	remuw	a5,a1,a2
 6f8:	1782                	slli	a5,a5,0x20
 6fa:	9381                	srli	a5,a5,0x20
 6fc:	97aa                	add	a5,a5,a0
 6fe:	0007c783          	lbu	a5,0(a5)
 702:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 706:	0005879b          	sext.w	a5,a1
 70a:	02c5d5bb          	divuw	a1,a1,a2
 70e:	0685                	addi	a3,a3,1
 710:	fec7f0e3          	bgeu	a5,a2,6f0 <printint+0x2a>
  if(neg)
 714:	00088b63          	beqz	a7,72a <printint+0x64>
    buf[i++] = '-';
 718:	fd040793          	addi	a5,s0,-48
 71c:	973e                	add	a4,a4,a5
 71e:	02d00793          	li	a5,45
 722:	fef70823          	sb	a5,-16(a4)
 726:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 72a:	02e05863          	blez	a4,75a <printint+0x94>
 72e:	fc040793          	addi	a5,s0,-64
 732:	00e78933          	add	s2,a5,a4
 736:	fff78993          	addi	s3,a5,-1
 73a:	99ba                	add	s3,s3,a4
 73c:	377d                	addiw	a4,a4,-1
 73e:	1702                	slli	a4,a4,0x20
 740:	9301                	srli	a4,a4,0x20
 742:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 746:	fff94583          	lbu	a1,-1(s2)
 74a:	8526                	mv	a0,s1
 74c:	00000097          	auipc	ra,0x0
 750:	f58080e7          	jalr	-168(ra) # 6a4 <putc>
  while(--i >= 0)
 754:	197d                	addi	s2,s2,-1
 756:	ff3918e3          	bne	s2,s3,746 <printint+0x80>
}
 75a:	70e2                	ld	ra,56(sp)
 75c:	7442                	ld	s0,48(sp)
 75e:	74a2                	ld	s1,40(sp)
 760:	7902                	ld	s2,32(sp)
 762:	69e2                	ld	s3,24(sp)
 764:	6121                	addi	sp,sp,64
 766:	8082                	ret
    x = -xx;
 768:	40b005bb          	negw	a1,a1
    neg = 1;
 76c:	4885                	li	a7,1
    x = -xx;
 76e:	bf8d                	j	6e0 <printint+0x1a>

0000000000000770 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 770:	7119                	addi	sp,sp,-128
 772:	fc86                	sd	ra,120(sp)
 774:	f8a2                	sd	s0,112(sp)
 776:	f4a6                	sd	s1,104(sp)
 778:	f0ca                	sd	s2,96(sp)
 77a:	ecce                	sd	s3,88(sp)
 77c:	e8d2                	sd	s4,80(sp)
 77e:	e4d6                	sd	s5,72(sp)
 780:	e0da                	sd	s6,64(sp)
 782:	fc5e                	sd	s7,56(sp)
 784:	f862                	sd	s8,48(sp)
 786:	f466                	sd	s9,40(sp)
 788:	f06a                	sd	s10,32(sp)
 78a:	ec6e                	sd	s11,24(sp)
 78c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 78e:	0005c903          	lbu	s2,0(a1)
 792:	18090f63          	beqz	s2,930 <vprintf+0x1c0>
 796:	8aaa                	mv	s5,a0
 798:	8b32                	mv	s6,a2
 79a:	00158493          	addi	s1,a1,1
  state = 0;
 79e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7a0:	02500a13          	li	s4,37
      if(c == 'd'){
 7a4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 7a8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 7ac:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 7b0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7b4:	00000b97          	auipc	s7,0x0
 7b8:	394b8b93          	addi	s7,s7,916 # b48 <digits>
 7bc:	a839                	j	7da <vprintf+0x6a>
        putc(fd, c);
 7be:	85ca                	mv	a1,s2
 7c0:	8556                	mv	a0,s5
 7c2:	00000097          	auipc	ra,0x0
 7c6:	ee2080e7          	jalr	-286(ra) # 6a4 <putc>
 7ca:	a019                	j	7d0 <vprintf+0x60>
    } else if(state == '%'){
 7cc:	01498f63          	beq	s3,s4,7ea <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7d0:	0485                	addi	s1,s1,1
 7d2:	fff4c903          	lbu	s2,-1(s1)
 7d6:	14090d63          	beqz	s2,930 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7da:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7de:	fe0997e3          	bnez	s3,7cc <vprintf+0x5c>
      if(c == '%'){
 7e2:	fd479ee3          	bne	a5,s4,7be <vprintf+0x4e>
        state = '%';
 7e6:	89be                	mv	s3,a5
 7e8:	b7e5                	j	7d0 <vprintf+0x60>
      if(c == 'd'){
 7ea:	05878063          	beq	a5,s8,82a <vprintf+0xba>
      } else if(c == 'l') {
 7ee:	05978c63          	beq	a5,s9,846 <vprintf+0xd6>
      } else if(c == 'x') {
 7f2:	07a78863          	beq	a5,s10,862 <vprintf+0xf2>
      } else if(c == 'p') {
 7f6:	09b78463          	beq	a5,s11,87e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7fa:	07300713          	li	a4,115
 7fe:	0ce78663          	beq	a5,a4,8ca <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 802:	06300713          	li	a4,99
 806:	0ee78e63          	beq	a5,a4,902 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 80a:	11478863          	beq	a5,s4,91a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 80e:	85d2                	mv	a1,s4
 810:	8556                	mv	a0,s5
 812:	00000097          	auipc	ra,0x0
 816:	e92080e7          	jalr	-366(ra) # 6a4 <putc>
        putc(fd, c);
 81a:	85ca                	mv	a1,s2
 81c:	8556                	mv	a0,s5
 81e:	00000097          	auipc	ra,0x0
 822:	e86080e7          	jalr	-378(ra) # 6a4 <putc>
      }
      state = 0;
 826:	4981                	li	s3,0
 828:	b765                	j	7d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 82a:	008b0913          	addi	s2,s6,8
 82e:	4685                	li	a3,1
 830:	4629                	li	a2,10
 832:	000b2583          	lw	a1,0(s6)
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	e8e080e7          	jalr	-370(ra) # 6c6 <printint>
 840:	8b4a                	mv	s6,s2
      state = 0;
 842:	4981                	li	s3,0
 844:	b771                	j	7d0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 846:	008b0913          	addi	s2,s6,8
 84a:	4681                	li	a3,0
 84c:	4629                	li	a2,10
 84e:	000b2583          	lw	a1,0(s6)
 852:	8556                	mv	a0,s5
 854:	00000097          	auipc	ra,0x0
 858:	e72080e7          	jalr	-398(ra) # 6c6 <printint>
 85c:	8b4a                	mv	s6,s2
      state = 0;
 85e:	4981                	li	s3,0
 860:	bf85                	j	7d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 862:	008b0913          	addi	s2,s6,8
 866:	4681                	li	a3,0
 868:	4641                	li	a2,16
 86a:	000b2583          	lw	a1,0(s6)
 86e:	8556                	mv	a0,s5
 870:	00000097          	auipc	ra,0x0
 874:	e56080e7          	jalr	-426(ra) # 6c6 <printint>
 878:	8b4a                	mv	s6,s2
      state = 0;
 87a:	4981                	li	s3,0
 87c:	bf91                	j	7d0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 87e:	008b0793          	addi	a5,s6,8
 882:	f8f43423          	sd	a5,-120(s0)
 886:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 88a:	03000593          	li	a1,48
 88e:	8556                	mv	a0,s5
 890:	00000097          	auipc	ra,0x0
 894:	e14080e7          	jalr	-492(ra) # 6a4 <putc>
  putc(fd, 'x');
 898:	85ea                	mv	a1,s10
 89a:	8556                	mv	a0,s5
 89c:	00000097          	auipc	ra,0x0
 8a0:	e08080e7          	jalr	-504(ra) # 6a4 <putc>
 8a4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8a6:	03c9d793          	srli	a5,s3,0x3c
 8aa:	97de                	add	a5,a5,s7
 8ac:	0007c583          	lbu	a1,0(a5)
 8b0:	8556                	mv	a0,s5
 8b2:	00000097          	auipc	ra,0x0
 8b6:	df2080e7          	jalr	-526(ra) # 6a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ba:	0992                	slli	s3,s3,0x4
 8bc:	397d                	addiw	s2,s2,-1
 8be:	fe0914e3          	bnez	s2,8a6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8c2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8c6:	4981                	li	s3,0
 8c8:	b721                	j	7d0 <vprintf+0x60>
        s = va_arg(ap, char*);
 8ca:	008b0993          	addi	s3,s6,8
 8ce:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8d2:	02090163          	beqz	s2,8f4 <vprintf+0x184>
        while(*s != 0){
 8d6:	00094583          	lbu	a1,0(s2)
 8da:	c9a1                	beqz	a1,92a <vprintf+0x1ba>
          putc(fd, *s);
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	dc6080e7          	jalr	-570(ra) # 6a4 <putc>
          s++;
 8e6:	0905                	addi	s2,s2,1
        while(*s != 0){
 8e8:	00094583          	lbu	a1,0(s2)
 8ec:	f9e5                	bnez	a1,8dc <vprintf+0x16c>
        s = va_arg(ap, char*);
 8ee:	8b4e                	mv	s6,s3
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	bdf9                	j	7d0 <vprintf+0x60>
          s = "(null)";
 8f4:	00000917          	auipc	s2,0x0
 8f8:	24c90913          	addi	s2,s2,588 # b40 <malloc+0x106>
        while(*s != 0){
 8fc:	02800593          	li	a1,40
 900:	bff1                	j	8dc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 902:	008b0913          	addi	s2,s6,8
 906:	000b4583          	lbu	a1,0(s6)
 90a:	8556                	mv	a0,s5
 90c:	00000097          	auipc	ra,0x0
 910:	d98080e7          	jalr	-616(ra) # 6a4 <putc>
 914:	8b4a                	mv	s6,s2
      state = 0;
 916:	4981                	li	s3,0
 918:	bd65                	j	7d0 <vprintf+0x60>
        putc(fd, c);
 91a:	85d2                	mv	a1,s4
 91c:	8556                	mv	a0,s5
 91e:	00000097          	auipc	ra,0x0
 922:	d86080e7          	jalr	-634(ra) # 6a4 <putc>
      state = 0;
 926:	4981                	li	s3,0
 928:	b565                	j	7d0 <vprintf+0x60>
        s = va_arg(ap, char*);
 92a:	8b4e                	mv	s6,s3
      state = 0;
 92c:	4981                	li	s3,0
 92e:	b54d                	j	7d0 <vprintf+0x60>
    }
  }
}
 930:	70e6                	ld	ra,120(sp)
 932:	7446                	ld	s0,112(sp)
 934:	74a6                	ld	s1,104(sp)
 936:	7906                	ld	s2,96(sp)
 938:	69e6                	ld	s3,88(sp)
 93a:	6a46                	ld	s4,80(sp)
 93c:	6aa6                	ld	s5,72(sp)
 93e:	6b06                	ld	s6,64(sp)
 940:	7be2                	ld	s7,56(sp)
 942:	7c42                	ld	s8,48(sp)
 944:	7ca2                	ld	s9,40(sp)
 946:	7d02                	ld	s10,32(sp)
 948:	6de2                	ld	s11,24(sp)
 94a:	6109                	addi	sp,sp,128
 94c:	8082                	ret

000000000000094e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 94e:	715d                	addi	sp,sp,-80
 950:	ec06                	sd	ra,24(sp)
 952:	e822                	sd	s0,16(sp)
 954:	1000                	addi	s0,sp,32
 956:	e010                	sd	a2,0(s0)
 958:	e414                	sd	a3,8(s0)
 95a:	e818                	sd	a4,16(s0)
 95c:	ec1c                	sd	a5,24(s0)
 95e:	03043023          	sd	a6,32(s0)
 962:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 966:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 96a:	8622                	mv	a2,s0
 96c:	00000097          	auipc	ra,0x0
 970:	e04080e7          	jalr	-508(ra) # 770 <vprintf>
}
 974:	60e2                	ld	ra,24(sp)
 976:	6442                	ld	s0,16(sp)
 978:	6161                	addi	sp,sp,80
 97a:	8082                	ret

000000000000097c <printf>:

void
printf(const char *fmt, ...)
{
 97c:	711d                	addi	sp,sp,-96
 97e:	ec06                	sd	ra,24(sp)
 980:	e822                	sd	s0,16(sp)
 982:	1000                	addi	s0,sp,32
 984:	e40c                	sd	a1,8(s0)
 986:	e810                	sd	a2,16(s0)
 988:	ec14                	sd	a3,24(s0)
 98a:	f018                	sd	a4,32(s0)
 98c:	f41c                	sd	a5,40(s0)
 98e:	03043823          	sd	a6,48(s0)
 992:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 996:	00840613          	addi	a2,s0,8
 99a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 99e:	85aa                	mv	a1,a0
 9a0:	4505                	li	a0,1
 9a2:	00000097          	auipc	ra,0x0
 9a6:	dce080e7          	jalr	-562(ra) # 770 <vprintf>
}
 9aa:	60e2                	ld	ra,24(sp)
 9ac:	6442                	ld	s0,16(sp)
 9ae:	6125                	addi	sp,sp,96
 9b0:	8082                	ret

00000000000009b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9b2:	1141                	addi	sp,sp,-16
 9b4:	e422                	sd	s0,8(sp)
 9b6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9b8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9bc:	00000797          	auipc	a5,0x0
 9c0:	1a47b783          	ld	a5,420(a5) # b60 <freep>
 9c4:	a805                	j	9f4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9c6:	4618                	lw	a4,8(a2)
 9c8:	9db9                	addw	a1,a1,a4
 9ca:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9ce:	6398                	ld	a4,0(a5)
 9d0:	6318                	ld	a4,0(a4)
 9d2:	fee53823          	sd	a4,-16(a0)
 9d6:	a091                	j	a1a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9d8:	ff852703          	lw	a4,-8(a0)
 9dc:	9e39                	addw	a2,a2,a4
 9de:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9e0:	ff053703          	ld	a4,-16(a0)
 9e4:	e398                	sd	a4,0(a5)
 9e6:	a099                	j	a2c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e8:	6398                	ld	a4,0(a5)
 9ea:	00e7e463          	bltu	a5,a4,9f2 <free+0x40>
 9ee:	00e6ea63          	bltu	a3,a4,a02 <free+0x50>
{
 9f2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9f4:	fed7fae3          	bgeu	a5,a3,9e8 <free+0x36>
 9f8:	6398                	ld	a4,0(a5)
 9fa:	00e6e463          	bltu	a3,a4,a02 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9fe:	fee7eae3          	bltu	a5,a4,9f2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a02:	ff852583          	lw	a1,-8(a0)
 a06:	6390                	ld	a2,0(a5)
 a08:	02059813          	slli	a6,a1,0x20
 a0c:	01c85713          	srli	a4,a6,0x1c
 a10:	9736                	add	a4,a4,a3
 a12:	fae60ae3          	beq	a2,a4,9c6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a16:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a1a:	4790                	lw	a2,8(a5)
 a1c:	02061593          	slli	a1,a2,0x20
 a20:	01c5d713          	srli	a4,a1,0x1c
 a24:	973e                	add	a4,a4,a5
 a26:	fae689e3          	beq	a3,a4,9d8 <free+0x26>
  } else
    p->s.ptr = bp;
 a2a:	e394                	sd	a3,0(a5)
  freep = p;
 a2c:	00000717          	auipc	a4,0x0
 a30:	12f73a23          	sd	a5,308(a4) # b60 <freep>
}
 a34:	6422                	ld	s0,8(sp)
 a36:	0141                	addi	sp,sp,16
 a38:	8082                	ret

0000000000000a3a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a3a:	7139                	addi	sp,sp,-64
 a3c:	fc06                	sd	ra,56(sp)
 a3e:	f822                	sd	s0,48(sp)
 a40:	f426                	sd	s1,40(sp)
 a42:	f04a                	sd	s2,32(sp)
 a44:	ec4e                	sd	s3,24(sp)
 a46:	e852                	sd	s4,16(sp)
 a48:	e456                	sd	s5,8(sp)
 a4a:	e05a                	sd	s6,0(sp)
 a4c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a4e:	02051493          	slli	s1,a0,0x20
 a52:	9081                	srli	s1,s1,0x20
 a54:	04bd                	addi	s1,s1,15
 a56:	8091                	srli	s1,s1,0x4
 a58:	0014899b          	addiw	s3,s1,1
 a5c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a5e:	00000517          	auipc	a0,0x0
 a62:	10253503          	ld	a0,258(a0) # b60 <freep>
 a66:	c515                	beqz	a0,a92 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a68:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a6a:	4798                	lw	a4,8(a5)
 a6c:	02977f63          	bgeu	a4,s1,aaa <malloc+0x70>
 a70:	8a4e                	mv	s4,s3
 a72:	0009871b          	sext.w	a4,s3
 a76:	6685                	lui	a3,0x1
 a78:	00d77363          	bgeu	a4,a3,a7e <malloc+0x44>
 a7c:	6a05                	lui	s4,0x1
 a7e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a82:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a86:	00000917          	auipc	s2,0x0
 a8a:	0da90913          	addi	s2,s2,218 # b60 <freep>
  if(p == (char*)-1)
 a8e:	5afd                	li	s5,-1
 a90:	a895                	j	b04 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a92:	00000797          	auipc	a5,0x0
 a96:	1c678793          	addi	a5,a5,454 # c58 <base>
 a9a:	00000717          	auipc	a4,0x0
 a9e:	0cf73323          	sd	a5,198(a4) # b60 <freep>
 aa2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 aa4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 aa8:	b7e1                	j	a70 <malloc+0x36>
      if(p->s.size == nunits)
 aaa:	02e48c63          	beq	s1,a4,ae2 <malloc+0xa8>
        p->s.size -= nunits;
 aae:	4137073b          	subw	a4,a4,s3
 ab2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ab4:	02071693          	slli	a3,a4,0x20
 ab8:	01c6d713          	srli	a4,a3,0x1c
 abc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 abe:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ac2:	00000717          	auipc	a4,0x0
 ac6:	08a73f23          	sd	a0,158(a4) # b60 <freep>
      return (void*)(p + 1);
 aca:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ace:	70e2                	ld	ra,56(sp)
 ad0:	7442                	ld	s0,48(sp)
 ad2:	74a2                	ld	s1,40(sp)
 ad4:	7902                	ld	s2,32(sp)
 ad6:	69e2                	ld	s3,24(sp)
 ad8:	6a42                	ld	s4,16(sp)
 ada:	6aa2                	ld	s5,8(sp)
 adc:	6b02                	ld	s6,0(sp)
 ade:	6121                	addi	sp,sp,64
 ae0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ae2:	6398                	ld	a4,0(a5)
 ae4:	e118                	sd	a4,0(a0)
 ae6:	bff1                	j	ac2 <malloc+0x88>
  hp->s.size = nu;
 ae8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aec:	0541                	addi	a0,a0,16
 aee:	00000097          	auipc	ra,0x0
 af2:	ec4080e7          	jalr	-316(ra) # 9b2 <free>
  return freep;
 af6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 afa:	d971                	beqz	a0,ace <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 afc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 afe:	4798                	lw	a4,8(a5)
 b00:	fa9775e3          	bgeu	a4,s1,aaa <malloc+0x70>
    if(p == freep)
 b04:	00093703          	ld	a4,0(s2)
 b08:	853e                	mv	a0,a5
 b0a:	fef719e3          	bne	a4,a5,afc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 b0e:	8552                	mv	a0,s4
 b10:	00000097          	auipc	ra,0x0
 b14:	b74080e7          	jalr	-1164(ra) # 684 <sbrk>
  if(p == (char*)-1)
 b18:	fd5518e3          	bne	a0,s5,ae8 <malloc+0xae>
        return 0;
 b1c:	4501                	li	a0,0
 b1e:	bf45                	j	ace <malloc+0x94>
