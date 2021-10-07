
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
  1a:	5de080e7          	jalr	1502(ra) # 5f4 <pipe>
    int pid = fork();
  1e:	00000097          	auipc	ra,0x0
  22:	5be080e7          	jalr	1470(ra) # 5dc <fork>

    

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
  36:	9f0080e7          	jalr	-1552(ra) # a22 <malloc>
  3a:	8aaa                	mv	s5,a0

        for(int i=0;i<bytes;i++){
  3c:	892a                	mv	s2,a0
            data[i] = i+1;
            printf("%d ",data[i]);
  3e:	00001a17          	auipc	s4,0x1
  42:	ad2a0a13          	addi	s4,s4,-1326 # b10 <malloc+0xee>
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
  5c:	90c080e7          	jalr	-1780(ra) # 964 <printf>
        for(int i=0;i<bytes;i++){
  60:	0911                	addi	s2,s2,4
  62:	ff3493e3          	bne	s1,s3,48 <main+0x48>
        }

        close(fd[0]);
  66:	fb842503          	lw	a0,-72(s0)
  6a:	00000097          	auipc	ra,0x0
  6e:	5a2080e7          	jalr	1442(ra) # 60c <close>
        close(1);
  72:	4505                	li	a0,1
  74:	00000097          	auipc	ra,0x0
  78:	598080e7          	jalr	1432(ra) # 60c <close>
        dup(fd[1]);
  7c:	fbc42503          	lw	a0,-68(s0)
  80:	00000097          	auipc	ra,0x0
  84:	5dc080e7          	jalr	1500(ra) # 65c <dup>
        write(fd[1],data,sizeof(data));
  88:	4621                	li	a2,8
  8a:	85d6                	mv	a1,s5
  8c:	fbc42503          	lw	a0,-68(s0)
  90:	00000097          	auipc	ra,0x0
  94:	574080e7          	jalr	1396(ra) # 604 <write>
  98:	a861                	j	130 <main+0x130>
        wait(NULL);
  9a:	4501                	li	a0,0
  9c:	00000097          	auipc	ra,0x0
  a0:	550080e7          	jalr	1360(ra) # 5ec <wait>
        close(0);
  a4:	4501                	li	a0,0
  a6:	00000097          	auipc	ra,0x0
  aa:	566080e7          	jalr	1382(ra) # 60c <close>
        close(fd[1]);
  ae:	fbc42503          	lw	a0,-68(s0)
  b2:	00000097          	auipc	ra,0x0
  b6:	55a080e7          	jalr	1370(ra) # 60c <close>
        dup(fd[1]);
  ba:	fbc42503          	lw	a0,-68(s0)
  be:	00000097          	auipc	ra,0x0
  c2:	59e080e7          	jalr	1438(ra) # 65c <dup>
        data = (int*)malloc(bytes);
  c6:	4529                	li	a0,10
  c8:	00001097          	auipc	ra,0x1
  cc:	95a080e7          	jalr	-1702(ra) # a22 <malloc>
  d0:	84aa                	mv	s1,a0
        int n=read(fd[0],data,sizeof(data));
  d2:	4621                	li	a2,8
  d4:	85aa                	mv	a1,a0
  d6:	fb842503          	lw	a0,-72(s0)
  da:	00000097          	auipc	ra,0x0
  de:	522080e7          	jalr	1314(ra) # 5fc <read>
  e2:	892a                	mv	s2,a0
        printf("%d\n",n);
  e4:	85aa                	mv	a1,a0
  e6:	00001517          	auipc	a0,0x1
  ea:	a2250513          	addi	a0,a0,-1502 # b08 <malloc+0xe6>
  ee:	00001097          	auipc	ra,0x1
  f2:	876080e7          	jalr	-1930(ra) # 964 <printf>
        for(i=0;i<n/4;i++){
  f6:	4991                	li	s3,4
  f8:	033949bb          	divw	s3,s2,s3
  fc:	478d                	li	a5,3
  fe:	0327d163          	bge	a5,s2,120 <main+0x120>
 102:	4901                	li	s2,0
            printf("%d ",data[i]);
 104:	00001a17          	auipc	s4,0x1
 108:	a0ca0a13          	addi	s4,s4,-1524 # b10 <malloc+0xee>
 10c:	408c                	lw	a1,0(s1)
 10e:	8552                	mv	a0,s4
 110:	00001097          	auipc	ra,0x1
 114:	854080e7          	jalr	-1964(ra) # 964 <printf>
        for(i=0;i<n/4;i++){
 118:	2905                	addiw	s2,s2,1
 11a:	0491                	addi	s1,s1,4
 11c:	ff3948e3          	blt	s2,s3,10c <main+0x10c>
        printf("\n");
 120:	00001517          	auipc	a0,0x1
 124:	9f850513          	addi	a0,a0,-1544 # b18 <malloc+0xf6>
 128:	00001097          	auipc	ra,0x1
 12c:	83c080e7          	jalr	-1988(ra) # 964 <printf>
    }
    else{
        printf("error");
    }
    exit(0);
 130:	4501                	li	a0,0
 132:	00000097          	auipc	ra,0x0
 136:	4b2080e7          	jalr	1202(ra) # 5e4 <exit>
        printf("error");
 13a:	00001517          	auipc	a0,0x1
 13e:	9e650513          	addi	a0,a0,-1562 # b20 <malloc+0xfe>
 142:	00001097          	auipc	ra,0x1
 146:	822080e7          	jalr	-2014(ra) # 964 <printf>
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
 192:	9d248493          	addi	s1,s1,-1582 # b60 <rings+0x10>
 196:	00001917          	auipc	s2,0x1
 19a:	aba90913          	addi	s2,s2,-1350 # c50 <__BSS_END__>
 19e:	04f59563          	bne	a1,a5,1e8 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 1a2:	00001497          	auipc	s1,0x1
 1a6:	9be4a483          	lw	s1,-1602(s1) # b60 <rings+0x10>
 1aa:	c099                	beqz	s1,1b0 <create_or_close_the_buffer_user+0x38>
 1ac:	4481                	li	s1,0
 1ae:	a899                	j	204 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 1b0:	00001917          	auipc	s2,0x1
 1b4:	9a090913          	addi	s2,s2,-1632 # b50 <rings>
 1b8:	00093603          	ld	a2,0(s2)
 1bc:	4585                	li	a1,1
 1be:	00000097          	auipc	ra,0x0
 1c2:	4c6080e7          	jalr	1222(ra) # 684 <ringbuf>
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
 1f8:	490080e7          	jalr	1168(ra) # 684 <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 216:	1101                	addi	sp,sp,-32
 218:	ec06                	sd	ra,24(sp)
 21a:	e822                	sd	s0,16(sp)
 21c:	e426                	sd	s1,8(sp)
 21e:	1000                	addi	s0,sp,32
 220:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 222:	00151793          	slli	a5,a0,0x1
 226:	97aa                	add	a5,a5,a0
 228:	078e                	slli	a5,a5,0x3
 22a:	00001717          	auipc	a4,0x1
 22e:	92670713          	addi	a4,a4,-1754 # b50 <rings>
 232:	97ba                	add	a5,a5,a4
 234:	639c                	ld	a5,0(a5)
 236:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 238:	421c                	lw	a5,0(a2)
 23a:	e785                	bnez	a5,262 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 23c:	86ba                	mv	a3,a4
 23e:	671c                	ld	a5,8(a4)
 240:	6398                	ld	a4,0(a5)
 242:	67c1                	lui	a5,0x10
 244:	9fb9                	addw	a5,a5,a4
 246:	00151713          	slli	a4,a0,0x1
 24a:	953a                	add	a0,a0,a4
 24c:	050e                	slli	a0,a0,0x3
 24e:	9536                	add	a0,a0,a3
 250:	6518                	ld	a4,8(a0)
 252:	6718                	ld	a4,8(a4)
 254:	9f99                	subw	a5,a5,a4
 256:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 258:	60e2                	ld	ra,24(sp)
 25a:	6442                	ld	s0,16(sp)
 25c:	64a2                	ld	s1,8(sp)
 25e:	6105                	addi	sp,sp,32
 260:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 262:	00151793          	slli	a5,a0,0x1
 266:	953e                	add	a0,a0,a5
 268:	050e                	slli	a0,a0,0x3
 26a:	00001797          	auipc	a5,0x1
 26e:	8e678793          	addi	a5,a5,-1818 # b50 <rings>
 272:	953e                	add	a0,a0,a5
 274:	6508                	ld	a0,8(a0)
 276:	0521                	addi	a0,a0,8
 278:	00000097          	auipc	ra,0x0
 27c:	ee8080e7          	jalr	-280(ra) # 160 <load>
 280:	c088                	sw	a0,0(s1)
}
 282:	bfd9                	j	258 <ringbuf_start_write+0x42>

0000000000000284 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 284:	1141                	addi	sp,sp,-16
 286:	e406                	sd	ra,8(sp)
 288:	e022                	sd	s0,0(sp)
 28a:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 28c:	00151793          	slli	a5,a0,0x1
 290:	97aa                	add	a5,a5,a0
 292:	078e                	slli	a5,a5,0x3
 294:	00001517          	auipc	a0,0x1
 298:	8bc50513          	addi	a0,a0,-1860 # b50 <rings>
 29c:	97aa                	add	a5,a5,a0
 29e:	6788                	ld	a0,8(a5)
 2a0:	0035959b          	slliw	a1,a1,0x3
 2a4:	0521                	addi	a0,a0,8
 2a6:	00000097          	auipc	ra,0x0
 2aa:	ea6080e7          	jalr	-346(ra) # 14c <store>
}
 2ae:	60a2                	ld	ra,8(sp)
 2b0:	6402                	ld	s0,0(sp)
 2b2:	0141                	addi	sp,sp,16
 2b4:	8082                	ret

00000000000002b6 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 2b6:	1101                	addi	sp,sp,-32
 2b8:	ec06                	sd	ra,24(sp)
 2ba:	e822                	sd	s0,16(sp)
 2bc:	e426                	sd	s1,8(sp)
 2be:	1000                	addi	s0,sp,32
 2c0:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 2c2:	00151793          	slli	a5,a0,0x1
 2c6:	97aa                	add	a5,a5,a0
 2c8:	078e                	slli	a5,a5,0x3
 2ca:	00001517          	auipc	a0,0x1
 2ce:	88650513          	addi	a0,a0,-1914 # b50 <rings>
 2d2:	97aa                	add	a5,a5,a0
 2d4:	6788                	ld	a0,8(a5)
 2d6:	0521                	addi	a0,a0,8
 2d8:	00000097          	auipc	ra,0x0
 2dc:	e88080e7          	jalr	-376(ra) # 160 <load>
 2e0:	c088                	sw	a0,0(s1)
}
 2e2:	60e2                	ld	ra,24(sp)
 2e4:	6442                	ld	s0,16(sp)
 2e6:	64a2                	ld	s1,8(sp)
 2e8:	6105                	addi	sp,sp,32
 2ea:	8082                	ret

00000000000002ec <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2ec:	1101                	addi	sp,sp,-32
 2ee:	ec06                	sd	ra,24(sp)
 2f0:	e822                	sd	s0,16(sp)
 2f2:	e426                	sd	s1,8(sp)
 2f4:	1000                	addi	s0,sp,32
 2f6:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 2f8:	00151793          	slli	a5,a0,0x1
 2fc:	97aa                	add	a5,a5,a0
 2fe:	078e                	slli	a5,a5,0x3
 300:	00001517          	auipc	a0,0x1
 304:	85050513          	addi	a0,a0,-1968 # b50 <rings>
 308:	97aa                	add	a5,a5,a0
 30a:	6788                	ld	a0,8(a5)
 30c:	611c                	ld	a5,0(a0)
 30e:	ef99                	bnez	a5,32c <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 310:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 312:	41f7579b          	sraiw	a5,a4,0x1f
 316:	01d7d79b          	srliw	a5,a5,0x1d
 31a:	9fb9                	addw	a5,a5,a4
 31c:	4037d79b          	sraiw	a5,a5,0x3
 320:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 322:	60e2                	ld	ra,24(sp)
 324:	6442                	ld	s0,16(sp)
 326:	64a2                	ld	s1,8(sp)
 328:	6105                	addi	sp,sp,32
 32a:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 32c:	00000097          	auipc	ra,0x0
 330:	e34080e7          	jalr	-460(ra) # 160 <load>
    *bytes /= 8;
 334:	41f5579b          	sraiw	a5,a0,0x1f
 338:	01d7d79b          	srliw	a5,a5,0x1d
 33c:	9d3d                	addw	a0,a0,a5
 33e:	4035551b          	sraiw	a0,a0,0x3
 342:	c088                	sw	a0,0(s1)
}
 344:	bff9                	j	322 <ringbuf_start_read+0x36>

0000000000000346 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 346:	1141                	addi	sp,sp,-16
 348:	e406                	sd	ra,8(sp)
 34a:	e022                	sd	s0,0(sp)
 34c:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 34e:	00151793          	slli	a5,a0,0x1
 352:	97aa                	add	a5,a5,a0
 354:	078e                	slli	a5,a5,0x3
 356:	00000517          	auipc	a0,0x0
 35a:	7fa50513          	addi	a0,a0,2042 # b50 <rings>
 35e:	97aa                	add	a5,a5,a0
 360:	0035959b          	slliw	a1,a1,0x3
 364:	6788                	ld	a0,8(a5)
 366:	00000097          	auipc	ra,0x0
 36a:	de6080e7          	jalr	-538(ra) # 14c <store>
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret

0000000000000376 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 376:	1141                	addi	sp,sp,-16
 378:	e422                	sd	s0,8(sp)
 37a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 37c:	87aa                	mv	a5,a0
 37e:	0585                	addi	a1,a1,1
 380:	0785                	addi	a5,a5,1
 382:	fff5c703          	lbu	a4,-1(a1)
 386:	fee78fa3          	sb	a4,-1(a5)
 38a:	fb75                	bnez	a4,37e <strcpy+0x8>
    ;
  return os;
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret

0000000000000392 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 392:	1141                	addi	sp,sp,-16
 394:	e422                	sd	s0,8(sp)
 396:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 398:	00054783          	lbu	a5,0(a0)
 39c:	cb91                	beqz	a5,3b0 <strcmp+0x1e>
 39e:	0005c703          	lbu	a4,0(a1)
 3a2:	00f71763          	bne	a4,a5,3b0 <strcmp+0x1e>
    p++, q++;
 3a6:	0505                	addi	a0,a0,1
 3a8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3aa:	00054783          	lbu	a5,0(a0)
 3ae:	fbe5                	bnez	a5,39e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3b0:	0005c503          	lbu	a0,0(a1)
}
 3b4:	40a7853b          	subw	a0,a5,a0
 3b8:	6422                	ld	s0,8(sp)
 3ba:	0141                	addi	sp,sp,16
 3bc:	8082                	ret

00000000000003be <strlen>:

uint
strlen(const char *s)
{
 3be:	1141                	addi	sp,sp,-16
 3c0:	e422                	sd	s0,8(sp)
 3c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3c4:	00054783          	lbu	a5,0(a0)
 3c8:	cf91                	beqz	a5,3e4 <strlen+0x26>
 3ca:	0505                	addi	a0,a0,1
 3cc:	87aa                	mv	a5,a0
 3ce:	4685                	li	a3,1
 3d0:	9e89                	subw	a3,a3,a0
 3d2:	00f6853b          	addw	a0,a3,a5
 3d6:	0785                	addi	a5,a5,1
 3d8:	fff7c703          	lbu	a4,-1(a5)
 3dc:	fb7d                	bnez	a4,3d2 <strlen+0x14>
    ;
  return n;
}
 3de:	6422                	ld	s0,8(sp)
 3e0:	0141                	addi	sp,sp,16
 3e2:	8082                	ret
  for(n = 0; s[n]; n++)
 3e4:	4501                	li	a0,0
 3e6:	bfe5                	j	3de <strlen+0x20>

00000000000003e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e8:	1141                	addi	sp,sp,-16
 3ea:	e422                	sd	s0,8(sp)
 3ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3ee:	ca19                	beqz	a2,404 <memset+0x1c>
 3f0:	87aa                	mv	a5,a0
 3f2:	1602                	slli	a2,a2,0x20
 3f4:	9201                	srli	a2,a2,0x20
 3f6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3fa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3fe:	0785                	addi	a5,a5,1
 400:	fee79de3          	bne	a5,a4,3fa <memset+0x12>
  }
  return dst;
}
 404:	6422                	ld	s0,8(sp)
 406:	0141                	addi	sp,sp,16
 408:	8082                	ret

000000000000040a <strchr>:

char*
strchr(const char *s, char c)
{
 40a:	1141                	addi	sp,sp,-16
 40c:	e422                	sd	s0,8(sp)
 40e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 410:	00054783          	lbu	a5,0(a0)
 414:	cb99                	beqz	a5,42a <strchr+0x20>
    if(*s == c)
 416:	00f58763          	beq	a1,a5,424 <strchr+0x1a>
  for(; *s; s++)
 41a:	0505                	addi	a0,a0,1
 41c:	00054783          	lbu	a5,0(a0)
 420:	fbfd                	bnez	a5,416 <strchr+0xc>
      return (char*)s;
  return 0;
 422:	4501                	li	a0,0
}
 424:	6422                	ld	s0,8(sp)
 426:	0141                	addi	sp,sp,16
 428:	8082                	ret
  return 0;
 42a:	4501                	li	a0,0
 42c:	bfe5                	j	424 <strchr+0x1a>

000000000000042e <gets>:

char*
gets(char *buf, int max)
{
 42e:	711d                	addi	sp,sp,-96
 430:	ec86                	sd	ra,88(sp)
 432:	e8a2                	sd	s0,80(sp)
 434:	e4a6                	sd	s1,72(sp)
 436:	e0ca                	sd	s2,64(sp)
 438:	fc4e                	sd	s3,56(sp)
 43a:	f852                	sd	s4,48(sp)
 43c:	f456                	sd	s5,40(sp)
 43e:	f05a                	sd	s6,32(sp)
 440:	ec5e                	sd	s7,24(sp)
 442:	1080                	addi	s0,sp,96
 444:	8baa                	mv	s7,a0
 446:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 448:	892a                	mv	s2,a0
 44a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 44c:	4aa9                	li	s5,10
 44e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 450:	89a6                	mv	s3,s1
 452:	2485                	addiw	s1,s1,1
 454:	0344d863          	bge	s1,s4,484 <gets+0x56>
    cc = read(0, &c, 1);
 458:	4605                	li	a2,1
 45a:	faf40593          	addi	a1,s0,-81
 45e:	4501                	li	a0,0
 460:	00000097          	auipc	ra,0x0
 464:	19c080e7          	jalr	412(ra) # 5fc <read>
    if(cc < 1)
 468:	00a05e63          	blez	a0,484 <gets+0x56>
    buf[i++] = c;
 46c:	faf44783          	lbu	a5,-81(s0)
 470:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 474:	01578763          	beq	a5,s5,482 <gets+0x54>
 478:	0905                	addi	s2,s2,1
 47a:	fd679be3          	bne	a5,s6,450 <gets+0x22>
  for(i=0; i+1 < max; ){
 47e:	89a6                	mv	s3,s1
 480:	a011                	j	484 <gets+0x56>
 482:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 484:	99de                	add	s3,s3,s7
 486:	00098023          	sb	zero,0(s3)
  return buf;
}
 48a:	855e                	mv	a0,s7
 48c:	60e6                	ld	ra,88(sp)
 48e:	6446                	ld	s0,80(sp)
 490:	64a6                	ld	s1,72(sp)
 492:	6906                	ld	s2,64(sp)
 494:	79e2                	ld	s3,56(sp)
 496:	7a42                	ld	s4,48(sp)
 498:	7aa2                	ld	s5,40(sp)
 49a:	7b02                	ld	s6,32(sp)
 49c:	6be2                	ld	s7,24(sp)
 49e:	6125                	addi	sp,sp,96
 4a0:	8082                	ret

00000000000004a2 <stat>:

int
stat(const char *n, struct stat *st)
{
 4a2:	1101                	addi	sp,sp,-32
 4a4:	ec06                	sd	ra,24(sp)
 4a6:	e822                	sd	s0,16(sp)
 4a8:	e426                	sd	s1,8(sp)
 4aa:	e04a                	sd	s2,0(sp)
 4ac:	1000                	addi	s0,sp,32
 4ae:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b0:	4581                	li	a1,0
 4b2:	00000097          	auipc	ra,0x0
 4b6:	172080e7          	jalr	370(ra) # 624 <open>
  if(fd < 0)
 4ba:	02054563          	bltz	a0,4e4 <stat+0x42>
 4be:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4c0:	85ca                	mv	a1,s2
 4c2:	00000097          	auipc	ra,0x0
 4c6:	17a080e7          	jalr	378(ra) # 63c <fstat>
 4ca:	892a                	mv	s2,a0
  close(fd);
 4cc:	8526                	mv	a0,s1
 4ce:	00000097          	auipc	ra,0x0
 4d2:	13e080e7          	jalr	318(ra) # 60c <close>
  return r;
}
 4d6:	854a                	mv	a0,s2
 4d8:	60e2                	ld	ra,24(sp)
 4da:	6442                	ld	s0,16(sp)
 4dc:	64a2                	ld	s1,8(sp)
 4de:	6902                	ld	s2,0(sp)
 4e0:	6105                	addi	sp,sp,32
 4e2:	8082                	ret
    return -1;
 4e4:	597d                	li	s2,-1
 4e6:	bfc5                	j	4d6 <stat+0x34>

00000000000004e8 <atoi>:

int
atoi(const char *s)
{
 4e8:	1141                	addi	sp,sp,-16
 4ea:	e422                	sd	s0,8(sp)
 4ec:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4ee:	00054603          	lbu	a2,0(a0)
 4f2:	fd06079b          	addiw	a5,a2,-48
 4f6:	0ff7f793          	zext.b	a5,a5
 4fa:	4725                	li	a4,9
 4fc:	02f76963          	bltu	a4,a5,52e <atoi+0x46>
 500:	86aa                	mv	a3,a0
  n = 0;
 502:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 504:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 506:	0685                	addi	a3,a3,1
 508:	0025179b          	slliw	a5,a0,0x2
 50c:	9fa9                	addw	a5,a5,a0
 50e:	0017979b          	slliw	a5,a5,0x1
 512:	9fb1                	addw	a5,a5,a2
 514:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 518:	0006c603          	lbu	a2,0(a3)
 51c:	fd06071b          	addiw	a4,a2,-48
 520:	0ff77713          	zext.b	a4,a4
 524:	fee5f1e3          	bgeu	a1,a4,506 <atoi+0x1e>
  return n;
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
  n = 0;
 52e:	4501                	li	a0,0
 530:	bfe5                	j	528 <atoi+0x40>

0000000000000532 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 532:	1141                	addi	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 538:	02b57463          	bgeu	a0,a1,560 <memmove+0x2e>
    while(n-- > 0)
 53c:	00c05f63          	blez	a2,55a <memmove+0x28>
 540:	1602                	slli	a2,a2,0x20
 542:	9201                	srli	a2,a2,0x20
 544:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 548:	872a                	mv	a4,a0
      *dst++ = *src++;
 54a:	0585                	addi	a1,a1,1
 54c:	0705                	addi	a4,a4,1
 54e:	fff5c683          	lbu	a3,-1(a1)
 552:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 556:	fee79ae3          	bne	a5,a4,54a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 55a:	6422                	ld	s0,8(sp)
 55c:	0141                	addi	sp,sp,16
 55e:	8082                	ret
    dst += n;
 560:	00c50733          	add	a4,a0,a2
    src += n;
 564:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 566:	fec05ae3          	blez	a2,55a <memmove+0x28>
 56a:	fff6079b          	addiw	a5,a2,-1
 56e:	1782                	slli	a5,a5,0x20
 570:	9381                	srli	a5,a5,0x20
 572:	fff7c793          	not	a5,a5
 576:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 578:	15fd                	addi	a1,a1,-1
 57a:	177d                	addi	a4,a4,-1
 57c:	0005c683          	lbu	a3,0(a1)
 580:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 584:	fee79ae3          	bne	a5,a4,578 <memmove+0x46>
 588:	bfc9                	j	55a <memmove+0x28>

000000000000058a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 58a:	1141                	addi	sp,sp,-16
 58c:	e422                	sd	s0,8(sp)
 58e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 590:	ca05                	beqz	a2,5c0 <memcmp+0x36>
 592:	fff6069b          	addiw	a3,a2,-1
 596:	1682                	slli	a3,a3,0x20
 598:	9281                	srli	a3,a3,0x20
 59a:	0685                	addi	a3,a3,1
 59c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 59e:	00054783          	lbu	a5,0(a0)
 5a2:	0005c703          	lbu	a4,0(a1)
 5a6:	00e79863          	bne	a5,a4,5b6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5aa:	0505                	addi	a0,a0,1
    p2++;
 5ac:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5ae:	fed518e3          	bne	a0,a3,59e <memcmp+0x14>
  }
  return 0;
 5b2:	4501                	li	a0,0
 5b4:	a019                	j	5ba <memcmp+0x30>
      return *p1 - *p2;
 5b6:	40e7853b          	subw	a0,a5,a4
}
 5ba:	6422                	ld	s0,8(sp)
 5bc:	0141                	addi	sp,sp,16
 5be:	8082                	ret
  return 0;
 5c0:	4501                	li	a0,0
 5c2:	bfe5                	j	5ba <memcmp+0x30>

00000000000005c4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5c4:	1141                	addi	sp,sp,-16
 5c6:	e406                	sd	ra,8(sp)
 5c8:	e022                	sd	s0,0(sp)
 5ca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5cc:	00000097          	auipc	ra,0x0
 5d0:	f66080e7          	jalr	-154(ra) # 532 <memmove>
}
 5d4:	60a2                	ld	ra,8(sp)
 5d6:	6402                	ld	s0,0(sp)
 5d8:	0141                	addi	sp,sp,16
 5da:	8082                	ret

00000000000005dc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5dc:	4885                	li	a7,1
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5e4:	4889                	li	a7,2
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <wait>:
.global wait
wait:
 li a7, SYS_wait
 5ec:	488d                	li	a7,3
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5f4:	4891                	li	a7,4
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <read>:
.global read
read:
 li a7, SYS_read
 5fc:	4895                	li	a7,5
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <write>:
.global write
write:
 li a7, SYS_write
 604:	48c1                	li	a7,16
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <close>:
.global close
close:
 li a7, SYS_close
 60c:	48d5                	li	a7,21
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <kill>:
.global kill
kill:
 li a7, SYS_kill
 614:	4899                	li	a7,6
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <exec>:
.global exec
exec:
 li a7, SYS_exec
 61c:	489d                	li	a7,7
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <open>:
.global open
open:
 li a7, SYS_open
 624:	48bd                	li	a7,15
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 62c:	48c5                	li	a7,17
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 634:	48c9                	li	a7,18
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 63c:	48a1                	li	a7,8
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <link>:
.global link
link:
 li a7, SYS_link
 644:	48cd                	li	a7,19
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 64c:	48d1                	li	a7,20
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 654:	48a5                	li	a7,9
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <dup>:
.global dup
dup:
 li a7, SYS_dup
 65c:	48a9                	li	a7,10
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 664:	48ad                	li	a7,11
 ecall
 666:	00000073          	ecall
 ret
 66a:	8082                	ret

000000000000066c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 66c:	48b1                	li	a7,12
 ecall
 66e:	00000073          	ecall
 ret
 672:	8082                	ret

0000000000000674 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 674:	48b5                	li	a7,13
 ecall
 676:	00000073          	ecall
 ret
 67a:	8082                	ret

000000000000067c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 67c:	48b9                	li	a7,14
 ecall
 67e:	00000073          	ecall
 ret
 682:	8082                	ret

0000000000000684 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 684:	48d9                	li	a7,22
 ecall
 686:	00000073          	ecall
 ret
 68a:	8082                	ret

000000000000068c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 68c:	1101                	addi	sp,sp,-32
 68e:	ec06                	sd	ra,24(sp)
 690:	e822                	sd	s0,16(sp)
 692:	1000                	addi	s0,sp,32
 694:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 698:	4605                	li	a2,1
 69a:	fef40593          	addi	a1,s0,-17
 69e:	00000097          	auipc	ra,0x0
 6a2:	f66080e7          	jalr	-154(ra) # 604 <write>
}
 6a6:	60e2                	ld	ra,24(sp)
 6a8:	6442                	ld	s0,16(sp)
 6aa:	6105                	addi	sp,sp,32
 6ac:	8082                	ret

00000000000006ae <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6ae:	7139                	addi	sp,sp,-64
 6b0:	fc06                	sd	ra,56(sp)
 6b2:	f822                	sd	s0,48(sp)
 6b4:	f426                	sd	s1,40(sp)
 6b6:	f04a                	sd	s2,32(sp)
 6b8:	ec4e                	sd	s3,24(sp)
 6ba:	0080                	addi	s0,sp,64
 6bc:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6be:	c299                	beqz	a3,6c4 <printint+0x16>
 6c0:	0805c863          	bltz	a1,750 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6c4:	2581                	sext.w	a1,a1
  neg = 0;
 6c6:	4881                	li	a7,0
 6c8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6cc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6ce:	2601                	sext.w	a2,a2
 6d0:	00000517          	auipc	a0,0x0
 6d4:	46050513          	addi	a0,a0,1120 # b30 <digits>
 6d8:	883a                	mv	a6,a4
 6da:	2705                	addiw	a4,a4,1
 6dc:	02c5f7bb          	remuw	a5,a1,a2
 6e0:	1782                	slli	a5,a5,0x20
 6e2:	9381                	srli	a5,a5,0x20
 6e4:	97aa                	add	a5,a5,a0
 6e6:	0007c783          	lbu	a5,0(a5)
 6ea:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6ee:	0005879b          	sext.w	a5,a1
 6f2:	02c5d5bb          	divuw	a1,a1,a2
 6f6:	0685                	addi	a3,a3,1
 6f8:	fec7f0e3          	bgeu	a5,a2,6d8 <printint+0x2a>
  if(neg)
 6fc:	00088b63          	beqz	a7,712 <printint+0x64>
    buf[i++] = '-';
 700:	fd040793          	addi	a5,s0,-48
 704:	973e                	add	a4,a4,a5
 706:	02d00793          	li	a5,45
 70a:	fef70823          	sb	a5,-16(a4)
 70e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 712:	02e05863          	blez	a4,742 <printint+0x94>
 716:	fc040793          	addi	a5,s0,-64
 71a:	00e78933          	add	s2,a5,a4
 71e:	fff78993          	addi	s3,a5,-1
 722:	99ba                	add	s3,s3,a4
 724:	377d                	addiw	a4,a4,-1
 726:	1702                	slli	a4,a4,0x20
 728:	9301                	srli	a4,a4,0x20
 72a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 72e:	fff94583          	lbu	a1,-1(s2)
 732:	8526                	mv	a0,s1
 734:	00000097          	auipc	ra,0x0
 738:	f58080e7          	jalr	-168(ra) # 68c <putc>
  while(--i >= 0)
 73c:	197d                	addi	s2,s2,-1
 73e:	ff3918e3          	bne	s2,s3,72e <printint+0x80>
}
 742:	70e2                	ld	ra,56(sp)
 744:	7442                	ld	s0,48(sp)
 746:	74a2                	ld	s1,40(sp)
 748:	7902                	ld	s2,32(sp)
 74a:	69e2                	ld	s3,24(sp)
 74c:	6121                	addi	sp,sp,64
 74e:	8082                	ret
    x = -xx;
 750:	40b005bb          	negw	a1,a1
    neg = 1;
 754:	4885                	li	a7,1
    x = -xx;
 756:	bf8d                	j	6c8 <printint+0x1a>

0000000000000758 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 758:	7119                	addi	sp,sp,-128
 75a:	fc86                	sd	ra,120(sp)
 75c:	f8a2                	sd	s0,112(sp)
 75e:	f4a6                	sd	s1,104(sp)
 760:	f0ca                	sd	s2,96(sp)
 762:	ecce                	sd	s3,88(sp)
 764:	e8d2                	sd	s4,80(sp)
 766:	e4d6                	sd	s5,72(sp)
 768:	e0da                	sd	s6,64(sp)
 76a:	fc5e                	sd	s7,56(sp)
 76c:	f862                	sd	s8,48(sp)
 76e:	f466                	sd	s9,40(sp)
 770:	f06a                	sd	s10,32(sp)
 772:	ec6e                	sd	s11,24(sp)
 774:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 776:	0005c903          	lbu	s2,0(a1)
 77a:	18090f63          	beqz	s2,918 <vprintf+0x1c0>
 77e:	8aaa                	mv	s5,a0
 780:	8b32                	mv	s6,a2
 782:	00158493          	addi	s1,a1,1
  state = 0;
 786:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 788:	02500a13          	li	s4,37
      if(c == 'd'){
 78c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 790:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 794:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 798:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 79c:	00000b97          	auipc	s7,0x0
 7a0:	394b8b93          	addi	s7,s7,916 # b30 <digits>
 7a4:	a839                	j	7c2 <vprintf+0x6a>
        putc(fd, c);
 7a6:	85ca                	mv	a1,s2
 7a8:	8556                	mv	a0,s5
 7aa:	00000097          	auipc	ra,0x0
 7ae:	ee2080e7          	jalr	-286(ra) # 68c <putc>
 7b2:	a019                	j	7b8 <vprintf+0x60>
    } else if(state == '%'){
 7b4:	01498f63          	beq	s3,s4,7d2 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7b8:	0485                	addi	s1,s1,1
 7ba:	fff4c903          	lbu	s2,-1(s1)
 7be:	14090d63          	beqz	s2,918 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7c2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7c6:	fe0997e3          	bnez	s3,7b4 <vprintf+0x5c>
      if(c == '%'){
 7ca:	fd479ee3          	bne	a5,s4,7a6 <vprintf+0x4e>
        state = '%';
 7ce:	89be                	mv	s3,a5
 7d0:	b7e5                	j	7b8 <vprintf+0x60>
      if(c == 'd'){
 7d2:	05878063          	beq	a5,s8,812 <vprintf+0xba>
      } else if(c == 'l') {
 7d6:	05978c63          	beq	a5,s9,82e <vprintf+0xd6>
      } else if(c == 'x') {
 7da:	07a78863          	beq	a5,s10,84a <vprintf+0xf2>
      } else if(c == 'p') {
 7de:	09b78463          	beq	a5,s11,866 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7e2:	07300713          	li	a4,115
 7e6:	0ce78663          	beq	a5,a4,8b2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ea:	06300713          	li	a4,99
 7ee:	0ee78e63          	beq	a5,a4,8ea <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7f2:	11478863          	beq	a5,s4,902 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7f6:	85d2                	mv	a1,s4
 7f8:	8556                	mv	a0,s5
 7fa:	00000097          	auipc	ra,0x0
 7fe:	e92080e7          	jalr	-366(ra) # 68c <putc>
        putc(fd, c);
 802:	85ca                	mv	a1,s2
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	e86080e7          	jalr	-378(ra) # 68c <putc>
      }
      state = 0;
 80e:	4981                	li	s3,0
 810:	b765                	j	7b8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 812:	008b0913          	addi	s2,s6,8
 816:	4685                	li	a3,1
 818:	4629                	li	a2,10
 81a:	000b2583          	lw	a1,0(s6)
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	e8e080e7          	jalr	-370(ra) # 6ae <printint>
 828:	8b4a                	mv	s6,s2
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b771                	j	7b8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 82e:	008b0913          	addi	s2,s6,8
 832:	4681                	li	a3,0
 834:	4629                	li	a2,10
 836:	000b2583          	lw	a1,0(s6)
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	e72080e7          	jalr	-398(ra) # 6ae <printint>
 844:	8b4a                	mv	s6,s2
      state = 0;
 846:	4981                	li	s3,0
 848:	bf85                	j	7b8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 84a:	008b0913          	addi	s2,s6,8
 84e:	4681                	li	a3,0
 850:	4641                	li	a2,16
 852:	000b2583          	lw	a1,0(s6)
 856:	8556                	mv	a0,s5
 858:	00000097          	auipc	ra,0x0
 85c:	e56080e7          	jalr	-426(ra) # 6ae <printint>
 860:	8b4a                	mv	s6,s2
      state = 0;
 862:	4981                	li	s3,0
 864:	bf91                	j	7b8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 866:	008b0793          	addi	a5,s6,8
 86a:	f8f43423          	sd	a5,-120(s0)
 86e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 872:	03000593          	li	a1,48
 876:	8556                	mv	a0,s5
 878:	00000097          	auipc	ra,0x0
 87c:	e14080e7          	jalr	-492(ra) # 68c <putc>
  putc(fd, 'x');
 880:	85ea                	mv	a1,s10
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	e08080e7          	jalr	-504(ra) # 68c <putc>
 88c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 88e:	03c9d793          	srli	a5,s3,0x3c
 892:	97de                	add	a5,a5,s7
 894:	0007c583          	lbu	a1,0(a5)
 898:	8556                	mv	a0,s5
 89a:	00000097          	auipc	ra,0x0
 89e:	df2080e7          	jalr	-526(ra) # 68c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8a2:	0992                	slli	s3,s3,0x4
 8a4:	397d                	addiw	s2,s2,-1
 8a6:	fe0914e3          	bnez	s2,88e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8aa:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8ae:	4981                	li	s3,0
 8b0:	b721                	j	7b8 <vprintf+0x60>
        s = va_arg(ap, char*);
 8b2:	008b0993          	addi	s3,s6,8
 8b6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8ba:	02090163          	beqz	s2,8dc <vprintf+0x184>
        while(*s != 0){
 8be:	00094583          	lbu	a1,0(s2)
 8c2:	c9a1                	beqz	a1,912 <vprintf+0x1ba>
          putc(fd, *s);
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	dc6080e7          	jalr	-570(ra) # 68c <putc>
          s++;
 8ce:	0905                	addi	s2,s2,1
        while(*s != 0){
 8d0:	00094583          	lbu	a1,0(s2)
 8d4:	f9e5                	bnez	a1,8c4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 8d6:	8b4e                	mv	s6,s3
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	bdf9                	j	7b8 <vprintf+0x60>
          s = "(null)";
 8dc:	00000917          	auipc	s2,0x0
 8e0:	24c90913          	addi	s2,s2,588 # b28 <malloc+0x106>
        while(*s != 0){
 8e4:	02800593          	li	a1,40
 8e8:	bff1                	j	8c4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8ea:	008b0913          	addi	s2,s6,8
 8ee:	000b4583          	lbu	a1,0(s6)
 8f2:	8556                	mv	a0,s5
 8f4:	00000097          	auipc	ra,0x0
 8f8:	d98080e7          	jalr	-616(ra) # 68c <putc>
 8fc:	8b4a                	mv	s6,s2
      state = 0;
 8fe:	4981                	li	s3,0
 900:	bd65                	j	7b8 <vprintf+0x60>
        putc(fd, c);
 902:	85d2                	mv	a1,s4
 904:	8556                	mv	a0,s5
 906:	00000097          	auipc	ra,0x0
 90a:	d86080e7          	jalr	-634(ra) # 68c <putc>
      state = 0;
 90e:	4981                	li	s3,0
 910:	b565                	j	7b8 <vprintf+0x60>
        s = va_arg(ap, char*);
 912:	8b4e                	mv	s6,s3
      state = 0;
 914:	4981                	li	s3,0
 916:	b54d                	j	7b8 <vprintf+0x60>
    }
  }
}
 918:	70e6                	ld	ra,120(sp)
 91a:	7446                	ld	s0,112(sp)
 91c:	74a6                	ld	s1,104(sp)
 91e:	7906                	ld	s2,96(sp)
 920:	69e6                	ld	s3,88(sp)
 922:	6a46                	ld	s4,80(sp)
 924:	6aa6                	ld	s5,72(sp)
 926:	6b06                	ld	s6,64(sp)
 928:	7be2                	ld	s7,56(sp)
 92a:	7c42                	ld	s8,48(sp)
 92c:	7ca2                	ld	s9,40(sp)
 92e:	7d02                	ld	s10,32(sp)
 930:	6de2                	ld	s11,24(sp)
 932:	6109                	addi	sp,sp,128
 934:	8082                	ret

0000000000000936 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 936:	715d                	addi	sp,sp,-80
 938:	ec06                	sd	ra,24(sp)
 93a:	e822                	sd	s0,16(sp)
 93c:	1000                	addi	s0,sp,32
 93e:	e010                	sd	a2,0(s0)
 940:	e414                	sd	a3,8(s0)
 942:	e818                	sd	a4,16(s0)
 944:	ec1c                	sd	a5,24(s0)
 946:	03043023          	sd	a6,32(s0)
 94a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 94e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 952:	8622                	mv	a2,s0
 954:	00000097          	auipc	ra,0x0
 958:	e04080e7          	jalr	-508(ra) # 758 <vprintf>
}
 95c:	60e2                	ld	ra,24(sp)
 95e:	6442                	ld	s0,16(sp)
 960:	6161                	addi	sp,sp,80
 962:	8082                	ret

0000000000000964 <printf>:

void
printf(const char *fmt, ...)
{
 964:	711d                	addi	sp,sp,-96
 966:	ec06                	sd	ra,24(sp)
 968:	e822                	sd	s0,16(sp)
 96a:	1000                	addi	s0,sp,32
 96c:	e40c                	sd	a1,8(s0)
 96e:	e810                	sd	a2,16(s0)
 970:	ec14                	sd	a3,24(s0)
 972:	f018                	sd	a4,32(s0)
 974:	f41c                	sd	a5,40(s0)
 976:	03043823          	sd	a6,48(s0)
 97a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 97e:	00840613          	addi	a2,s0,8
 982:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 986:	85aa                	mv	a1,a0
 988:	4505                	li	a0,1
 98a:	00000097          	auipc	ra,0x0
 98e:	dce080e7          	jalr	-562(ra) # 758 <vprintf>
}
 992:	60e2                	ld	ra,24(sp)
 994:	6442                	ld	s0,16(sp)
 996:	6125                	addi	sp,sp,96
 998:	8082                	ret

000000000000099a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 99a:	1141                	addi	sp,sp,-16
 99c:	e422                	sd	s0,8(sp)
 99e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9a0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a4:	00000797          	auipc	a5,0x0
 9a8:	1a47b783          	ld	a5,420(a5) # b48 <freep>
 9ac:	a805                	j	9dc <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9ae:	4618                	lw	a4,8(a2)
 9b0:	9db9                	addw	a1,a1,a4
 9b2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9b6:	6398                	ld	a4,0(a5)
 9b8:	6318                	ld	a4,0(a4)
 9ba:	fee53823          	sd	a4,-16(a0)
 9be:	a091                	j	a02 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9c0:	ff852703          	lw	a4,-8(a0)
 9c4:	9e39                	addw	a2,a2,a4
 9c6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9c8:	ff053703          	ld	a4,-16(a0)
 9cc:	e398                	sd	a4,0(a5)
 9ce:	a099                	j	a14 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d0:	6398                	ld	a4,0(a5)
 9d2:	00e7e463          	bltu	a5,a4,9da <free+0x40>
 9d6:	00e6ea63          	bltu	a3,a4,9ea <free+0x50>
{
 9da:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9dc:	fed7fae3          	bgeu	a5,a3,9d0 <free+0x36>
 9e0:	6398                	ld	a4,0(a5)
 9e2:	00e6e463          	bltu	a3,a4,9ea <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e6:	fee7eae3          	bltu	a5,a4,9da <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9ea:	ff852583          	lw	a1,-8(a0)
 9ee:	6390                	ld	a2,0(a5)
 9f0:	02059813          	slli	a6,a1,0x20
 9f4:	01c85713          	srli	a4,a6,0x1c
 9f8:	9736                	add	a4,a4,a3
 9fa:	fae60ae3          	beq	a2,a4,9ae <free+0x14>
    bp->s.ptr = p->s.ptr;
 9fe:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a02:	4790                	lw	a2,8(a5)
 a04:	02061593          	slli	a1,a2,0x20
 a08:	01c5d713          	srli	a4,a1,0x1c
 a0c:	973e                	add	a4,a4,a5
 a0e:	fae689e3          	beq	a3,a4,9c0 <free+0x26>
  } else
    p->s.ptr = bp;
 a12:	e394                	sd	a3,0(a5)
  freep = p;
 a14:	00000717          	auipc	a4,0x0
 a18:	12f73a23          	sd	a5,308(a4) # b48 <freep>
}
 a1c:	6422                	ld	s0,8(sp)
 a1e:	0141                	addi	sp,sp,16
 a20:	8082                	ret

0000000000000a22 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a22:	7139                	addi	sp,sp,-64
 a24:	fc06                	sd	ra,56(sp)
 a26:	f822                	sd	s0,48(sp)
 a28:	f426                	sd	s1,40(sp)
 a2a:	f04a                	sd	s2,32(sp)
 a2c:	ec4e                	sd	s3,24(sp)
 a2e:	e852                	sd	s4,16(sp)
 a30:	e456                	sd	s5,8(sp)
 a32:	e05a                	sd	s6,0(sp)
 a34:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a36:	02051493          	slli	s1,a0,0x20
 a3a:	9081                	srli	s1,s1,0x20
 a3c:	04bd                	addi	s1,s1,15
 a3e:	8091                	srli	s1,s1,0x4
 a40:	0014899b          	addiw	s3,s1,1
 a44:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a46:	00000517          	auipc	a0,0x0
 a4a:	10253503          	ld	a0,258(a0) # b48 <freep>
 a4e:	c515                	beqz	a0,a7a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a50:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a52:	4798                	lw	a4,8(a5)
 a54:	02977f63          	bgeu	a4,s1,a92 <malloc+0x70>
 a58:	8a4e                	mv	s4,s3
 a5a:	0009871b          	sext.w	a4,s3
 a5e:	6685                	lui	a3,0x1
 a60:	00d77363          	bgeu	a4,a3,a66 <malloc+0x44>
 a64:	6a05                	lui	s4,0x1
 a66:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a6a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a6e:	00000917          	auipc	s2,0x0
 a72:	0da90913          	addi	s2,s2,218 # b48 <freep>
  if(p == (char*)-1)
 a76:	5afd                	li	s5,-1
 a78:	a895                	j	aec <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a7a:	00000797          	auipc	a5,0x0
 a7e:	1c678793          	addi	a5,a5,454 # c40 <base>
 a82:	00000717          	auipc	a4,0x0
 a86:	0cf73323          	sd	a5,198(a4) # b48 <freep>
 a8a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a8c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a90:	b7e1                	j	a58 <malloc+0x36>
      if(p->s.size == nunits)
 a92:	02e48c63          	beq	s1,a4,aca <malloc+0xa8>
        p->s.size -= nunits;
 a96:	4137073b          	subw	a4,a4,s3
 a9a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a9c:	02071693          	slli	a3,a4,0x20
 aa0:	01c6d713          	srli	a4,a3,0x1c
 aa4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 aa6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 aaa:	00000717          	auipc	a4,0x0
 aae:	08a73f23          	sd	a0,158(a4) # b48 <freep>
      return (void*)(p + 1);
 ab2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ab6:	70e2                	ld	ra,56(sp)
 ab8:	7442                	ld	s0,48(sp)
 aba:	74a2                	ld	s1,40(sp)
 abc:	7902                	ld	s2,32(sp)
 abe:	69e2                	ld	s3,24(sp)
 ac0:	6a42                	ld	s4,16(sp)
 ac2:	6aa2                	ld	s5,8(sp)
 ac4:	6b02                	ld	s6,0(sp)
 ac6:	6121                	addi	sp,sp,64
 ac8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aca:	6398                	ld	a4,0(a5)
 acc:	e118                	sd	a4,0(a0)
 ace:	bff1                	j	aaa <malloc+0x88>
  hp->s.size = nu;
 ad0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ad4:	0541                	addi	a0,a0,16
 ad6:	00000097          	auipc	ra,0x0
 ada:	ec4080e7          	jalr	-316(ra) # 99a <free>
  return freep;
 ade:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ae2:	d971                	beqz	a0,ab6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae6:	4798                	lw	a4,8(a5)
 ae8:	fa9775e3          	bgeu	a4,s1,a92 <malloc+0x70>
    if(p == freep)
 aec:	00093703          	ld	a4,0(s2)
 af0:	853e                	mv	a0,a5
 af2:	fef719e3          	bne	a4,a5,ae4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 af6:	8552                	mv	a0,s4
 af8:	00000097          	auipc	ra,0x0
 afc:	b74080e7          	jalr	-1164(ra) # 66c <sbrk>
  if(p == (char*)-1)
 b00:	fd5518e3          	bne	a0,s5,ad0 <malloc+0xae>
        return 0;
 b04:	4501                	li	a0,0
 b06:	bf45                	j	ab6 <malloc+0x94>
