
user/_cc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:


// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
   6:	611c                	ld	a5,0(a0)
   8:	80000737          	lui	a4,0x80000
   c:	ffe74713          	xori	a4,a4,-2
  10:	02e7f7b3          	remu	a5,a5,a4
  14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
  16:	66fd                	lui	a3,0x1f
  18:	31d68693          	addi	a3,a3,797 # 1f31d <__global_pointer$+0x1e0a4>
  1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
  20:	6611                	lui	a2,0x4
  22:	1a760613          	addi	a2,a2,423 # 41a7 <__global_pointer$+0x2f2e>
  26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
  2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
  2e:	76fd                	lui	a3,0xfffff
  30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffe273>
  34:	02d787b3          	mul	a5,a5,a3
  38:	97ba                	add	a5,a5,a4
    if (x < 0)
  3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
  3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
  40:	e11c                	sd	a5,0(a0)
    return (x);
}
  42:	0007851b          	sext.w	a0,a5
  46:	6422                	ld	s0,8(sp)
  48:	0141                	addi	sp,sp,16
  4a:	8082                	ret
        x += 0x7fffffff;
  4c:	80000737          	lui	a4,0x80000
  50:	fff74713          	not	a4,a4
  54:	97ba                	add	a5,a5,a4
  56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
  58:	1141                	addi	sp,sp,-16
  5a:	e406                	sd	ra,8(sp)
  5c:	e022                	sd	s0,0(sp)
  5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
  60:	00001517          	auipc	a0,0x1
  64:	a2050513          	addi	a0,a0,-1504 # a80 <rand_next>
  68:	00000097          	auipc	ra,0x0
  6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
  70:	60a2                	ld	ra,8(sp)
  72:	6402                	ld	s0,0(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <main>:


int main()
{
  78:	1141                	addi	sp,sp,-16
  7a:	e406                	sd	ra,8(sp)
  7c:	e022                	sd	s0,0(sp)
  7e:	0800                	addi	s0,sp,16
        k++;
      }
    } *//* 
    for(int i=0; i<10;i++)
    printf("%d\n",rand()); */
    printf("%d", sizeof(int));
  80:	4591                	li	a1,4
  82:	00001517          	auipc	a0,0x1
  86:	9d650513          	addi	a0,a0,-1578 # a58 <malloc+0xe6>
  8a:	00001097          	auipc	ra,0x1
  8e:	82a080e7          	jalr	-2006(ra) # 8b4 <printf>
  exit(0);
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	4a0080e7          	jalr	1184(ra) # 534 <exit>

000000000000009c <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  9c:	1141                	addi	sp,sp,-16
  9e:	e422                	sd	s0,8(sp)
  a0:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  a2:	0f50000f          	fence	iorw,ow
  a6:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  aa:	6422                	ld	s0,8(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <load>:

int load(uint64 *p) {
  b0:	1141                	addi	sp,sp,-16
  b2:	e422                	sd	s0,8(sp)
  b4:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  b6:	0ff0000f          	fence
  ba:	6108                	ld	a0,0(a0)
  bc:	0ff0000f          	fence
}
  c0:	2501                	sext.w	a0,a0
  c2:	6422                	ld	s0,8(sp)
  c4:	0141                	addi	sp,sp,16
  c6:	8082                	ret

00000000000000c8 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
  c8:	7179                	addi	sp,sp,-48
  ca:	f406                	sd	ra,40(sp)
  cc:	f022                	sd	s0,32(sp)
  ce:	ec26                	sd	s1,24(sp)
  d0:	e84a                	sd	s2,16(sp)
  d2:	e44e                	sd	s3,8(sp)
  d4:	e052                	sd	s4,0(sp)
  d6:	1800                	addi	s0,sp,48
  d8:	8a2a                	mv	s4,a0
  da:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  dc:	4785                	li	a5,1
  de:	00001497          	auipc	s1,0x1
  e2:	9c248493          	addi	s1,s1,-1598 # aa0 <rings+0x10>
  e6:	00001917          	auipc	s2,0x1
  ea:	aaa90913          	addi	s2,s2,-1366 # b90 <__BSS_END__>
  ee:	04f59563          	bne	a1,a5,138 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  f2:	00001497          	auipc	s1,0x1
  f6:	9ae4a483          	lw	s1,-1618(s1) # aa0 <rings+0x10>
  fa:	c099                	beqz	s1,100 <create_or_close_the_buffer_user+0x38>
  fc:	4481                	li	s1,0
  fe:	a899                	j	154 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 100:	00001917          	auipc	s2,0x1
 104:	99090913          	addi	s2,s2,-1648 # a90 <rings>
 108:	00093603          	ld	a2,0(s2)
 10c:	4585                	li	a1,1
 10e:	00000097          	auipc	ra,0x0
 112:	4c6080e7          	jalr	1222(ra) # 5d4 <ringbuf>
        rings[i].book->write_done = 0;
 116:	00893783          	ld	a5,8(s2)
 11a:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 11e:	00893783          	ld	a5,8(s2)
 122:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 126:	01092783          	lw	a5,16(s2)
 12a:	2785                	addiw	a5,a5,1
 12c:	00f92823          	sw	a5,16(s2)
        break;
 130:	a015                	j	154 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 132:	04e1                	addi	s1,s1,24
 134:	01248f63          	beq	s1,s2,152 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 138:	409c                	lw	a5,0(s1)
 13a:	dfe5                	beqz	a5,132 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 13c:	ff04b603          	ld	a2,-16(s1)
 140:	85ce                	mv	a1,s3
 142:	8552                	mv	a0,s4
 144:	00000097          	auipc	ra,0x0
 148:	490080e7          	jalr	1168(ra) # 5d4 <ringbuf>
        rings[i].exists = 0;
 14c:	0004a023          	sw	zero,0(s1)
 150:	b7cd                	j	132 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 152:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 154:	8526                	mv	a0,s1
 156:	70a2                	ld	ra,40(sp)
 158:	7402                	ld	s0,32(sp)
 15a:	64e2                	ld	s1,24(sp)
 15c:	6942                	ld	s2,16(sp)
 15e:	69a2                	ld	s3,8(sp)
 160:	6a02                	ld	s4,0(sp)
 162:	6145                	addi	sp,sp,48
 164:	8082                	ret

0000000000000166 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 166:	1101                	addi	sp,sp,-32
 168:	ec06                	sd	ra,24(sp)
 16a:	e822                	sd	s0,16(sp)
 16c:	e426                	sd	s1,8(sp)
 16e:	1000                	addi	s0,sp,32
 170:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 172:	00151793          	slli	a5,a0,0x1
 176:	97aa                	add	a5,a5,a0
 178:	078e                	slli	a5,a5,0x3
 17a:	00001717          	auipc	a4,0x1
 17e:	91670713          	addi	a4,a4,-1770 # a90 <rings>
 182:	97ba                	add	a5,a5,a4
 184:	639c                	ld	a5,0(a5)
 186:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 188:	421c                	lw	a5,0(a2)
 18a:	e785                	bnez	a5,1b2 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 18c:	86ba                	mv	a3,a4
 18e:	671c                	ld	a5,8(a4)
 190:	6398                	ld	a4,0(a5)
 192:	67c1                	lui	a5,0x10
 194:	9fb9                	addw	a5,a5,a4
 196:	00151713          	slli	a4,a0,0x1
 19a:	953a                	add	a0,a0,a4
 19c:	050e                	slli	a0,a0,0x3
 19e:	9536                	add	a0,a0,a3
 1a0:	6518                	ld	a4,8(a0)
 1a2:	6718                	ld	a4,8(a4)
 1a4:	9f99                	subw	a5,a5,a4
 1a6:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 1a8:	60e2                	ld	ra,24(sp)
 1aa:	6442                	ld	s0,16(sp)
 1ac:	64a2                	ld	s1,8(sp)
 1ae:	6105                	addi	sp,sp,32
 1b0:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 1b2:	00151793          	slli	a5,a0,0x1
 1b6:	953e                	add	a0,a0,a5
 1b8:	050e                	slli	a0,a0,0x3
 1ba:	00001797          	auipc	a5,0x1
 1be:	8d678793          	addi	a5,a5,-1834 # a90 <rings>
 1c2:	953e                	add	a0,a0,a5
 1c4:	6508                	ld	a0,8(a0)
 1c6:	0521                	addi	a0,a0,8
 1c8:	00000097          	auipc	ra,0x0
 1cc:	ee8080e7          	jalr	-280(ra) # b0 <load>
 1d0:	c088                	sw	a0,0(s1)
}
 1d2:	bfd9                	j	1a8 <ringbuf_start_write+0x42>

00000000000001d4 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e406                	sd	ra,8(sp)
 1d8:	e022                	sd	s0,0(sp)
 1da:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1dc:	00151793          	slli	a5,a0,0x1
 1e0:	97aa                	add	a5,a5,a0
 1e2:	078e                	slli	a5,a5,0x3
 1e4:	00001517          	auipc	a0,0x1
 1e8:	8ac50513          	addi	a0,a0,-1876 # a90 <rings>
 1ec:	97aa                	add	a5,a5,a0
 1ee:	6788                	ld	a0,8(a5)
 1f0:	0035959b          	slliw	a1,a1,0x3
 1f4:	0521                	addi	a0,a0,8
 1f6:	00000097          	auipc	ra,0x0
 1fa:	ea6080e7          	jalr	-346(ra) # 9c <store>
}
 1fe:	60a2                	ld	ra,8(sp)
 200:	6402                	ld	s0,0(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret

0000000000000206 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 206:	1101                	addi	sp,sp,-32
 208:	ec06                	sd	ra,24(sp)
 20a:	e822                	sd	s0,16(sp)
 20c:	e426                	sd	s1,8(sp)
 20e:	1000                	addi	s0,sp,32
 210:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 212:	00151793          	slli	a5,a0,0x1
 216:	97aa                	add	a5,a5,a0
 218:	078e                	slli	a5,a5,0x3
 21a:	00001517          	auipc	a0,0x1
 21e:	87650513          	addi	a0,a0,-1930 # a90 <rings>
 222:	97aa                	add	a5,a5,a0
 224:	6788                	ld	a0,8(a5)
 226:	0521                	addi	a0,a0,8
 228:	00000097          	auipc	ra,0x0
 22c:	e88080e7          	jalr	-376(ra) # b0 <load>
 230:	c088                	sw	a0,0(s1)
}
 232:	60e2                	ld	ra,24(sp)
 234:	6442                	ld	s0,16(sp)
 236:	64a2                	ld	s1,8(sp)
 238:	6105                	addi	sp,sp,32
 23a:	8082                	ret

000000000000023c <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 23c:	1101                	addi	sp,sp,-32
 23e:	ec06                	sd	ra,24(sp)
 240:	e822                	sd	s0,16(sp)
 242:	e426                	sd	s1,8(sp)
 244:	1000                	addi	s0,sp,32
 246:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 248:	00151793          	slli	a5,a0,0x1
 24c:	97aa                	add	a5,a5,a0
 24e:	078e                	slli	a5,a5,0x3
 250:	00001517          	auipc	a0,0x1
 254:	84050513          	addi	a0,a0,-1984 # a90 <rings>
 258:	97aa                	add	a5,a5,a0
 25a:	6788                	ld	a0,8(a5)
 25c:	611c                	ld	a5,0(a0)
 25e:	ef99                	bnez	a5,27c <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 260:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 262:	41f7579b          	sraiw	a5,a4,0x1f
 266:	01d7d79b          	srliw	a5,a5,0x1d
 26a:	9fb9                	addw	a5,a5,a4
 26c:	4037d79b          	sraiw	a5,a5,0x3
 270:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 272:	60e2                	ld	ra,24(sp)
 274:	6442                	ld	s0,16(sp)
 276:	64a2                	ld	s1,8(sp)
 278:	6105                	addi	sp,sp,32
 27a:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 27c:	00000097          	auipc	ra,0x0
 280:	e34080e7          	jalr	-460(ra) # b0 <load>
    *bytes /= 8;
 284:	41f5579b          	sraiw	a5,a0,0x1f
 288:	01d7d79b          	srliw	a5,a5,0x1d
 28c:	9d3d                	addw	a0,a0,a5
 28e:	4035551b          	sraiw	a0,a0,0x3
 292:	c088                	sw	a0,0(s1)
}
 294:	bff9                	j	272 <ringbuf_start_read+0x36>

0000000000000296 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 296:	1141                	addi	sp,sp,-16
 298:	e406                	sd	ra,8(sp)
 29a:	e022                	sd	s0,0(sp)
 29c:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 29e:	00151793          	slli	a5,a0,0x1
 2a2:	97aa                	add	a5,a5,a0
 2a4:	078e                	slli	a5,a5,0x3
 2a6:	00000517          	auipc	a0,0x0
 2aa:	7ea50513          	addi	a0,a0,2026 # a90 <rings>
 2ae:	97aa                	add	a5,a5,a0
 2b0:	0035959b          	slliw	a1,a1,0x3
 2b4:	6788                	ld	a0,8(a5)
 2b6:	00000097          	auipc	ra,0x0
 2ba:	de6080e7          	jalr	-538(ra) # 9c <store>
}
 2be:	60a2                	ld	ra,8(sp)
 2c0:	6402                	ld	s0,0(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2cc:	87aa                	mv	a5,a0
 2ce:	0585                	addi	a1,a1,1
 2d0:	0785                	addi	a5,a5,1
 2d2:	fff5c703          	lbu	a4,-1(a1)
 2d6:	fee78fa3          	sb	a4,-1(a5)
 2da:	fb75                	bnez	a4,2ce <strcpy+0x8>
    ;
  return os;
}
 2dc:	6422                	ld	s0,8(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret

00000000000002e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2e8:	00054783          	lbu	a5,0(a0)
 2ec:	cb91                	beqz	a5,300 <strcmp+0x1e>
 2ee:	0005c703          	lbu	a4,0(a1)
 2f2:	00f71763          	bne	a4,a5,300 <strcmp+0x1e>
    p++, q++;
 2f6:	0505                	addi	a0,a0,1
 2f8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	fbe5                	bnez	a5,2ee <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 300:	0005c503          	lbu	a0,0(a1)
}
 304:	40a7853b          	subw	a0,a5,a0
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret

000000000000030e <strlen>:

uint
strlen(const char *s)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 314:	00054783          	lbu	a5,0(a0)
 318:	cf91                	beqz	a5,334 <strlen+0x26>
 31a:	0505                	addi	a0,a0,1
 31c:	87aa                	mv	a5,a0
 31e:	4685                	li	a3,1
 320:	9e89                	subw	a3,a3,a0
 322:	00f6853b          	addw	a0,a3,a5
 326:	0785                	addi	a5,a5,1
 328:	fff7c703          	lbu	a4,-1(a5)
 32c:	fb7d                	bnez	a4,322 <strlen+0x14>
    ;
  return n;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  for(n = 0; s[n]; n++)
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <strlen+0x20>

0000000000000338 <memset>:

void*
memset(void *dst, int c, uint n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 33e:	ca19                	beqz	a2,354 <memset+0x1c>
 340:	87aa                	mv	a5,a0
 342:	1602                	slli	a2,a2,0x20
 344:	9201                	srli	a2,a2,0x20
 346:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 34a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 34e:	0785                	addi	a5,a5,1
 350:	fee79de3          	bne	a5,a4,34a <memset+0x12>
  }
  return dst;
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret

000000000000035a <strchr>:

char*
strchr(const char *s, char c)
{
 35a:	1141                	addi	sp,sp,-16
 35c:	e422                	sd	s0,8(sp)
 35e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 360:	00054783          	lbu	a5,0(a0)
 364:	cb99                	beqz	a5,37a <strchr+0x20>
    if(*s == c)
 366:	00f58763          	beq	a1,a5,374 <strchr+0x1a>
  for(; *s; s++)
 36a:	0505                	addi	a0,a0,1
 36c:	00054783          	lbu	a5,0(a0)
 370:	fbfd                	bnez	a5,366 <strchr+0xc>
      return (char*)s;
  return 0;
 372:	4501                	li	a0,0
}
 374:	6422                	ld	s0,8(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret
  return 0;
 37a:	4501                	li	a0,0
 37c:	bfe5                	j	374 <strchr+0x1a>

000000000000037e <gets>:

char*
gets(char *buf, int max)
{
 37e:	711d                	addi	sp,sp,-96
 380:	ec86                	sd	ra,88(sp)
 382:	e8a2                	sd	s0,80(sp)
 384:	e4a6                	sd	s1,72(sp)
 386:	e0ca                	sd	s2,64(sp)
 388:	fc4e                	sd	s3,56(sp)
 38a:	f852                	sd	s4,48(sp)
 38c:	f456                	sd	s5,40(sp)
 38e:	f05a                	sd	s6,32(sp)
 390:	ec5e                	sd	s7,24(sp)
 392:	1080                	addi	s0,sp,96
 394:	8baa                	mv	s7,a0
 396:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 398:	892a                	mv	s2,a0
 39a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 39c:	4aa9                	li	s5,10
 39e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3a0:	89a6                	mv	s3,s1
 3a2:	2485                	addiw	s1,s1,1
 3a4:	0344d863          	bge	s1,s4,3d4 <gets+0x56>
    cc = read(0, &c, 1);
 3a8:	4605                	li	a2,1
 3aa:	faf40593          	addi	a1,s0,-81
 3ae:	4501                	li	a0,0
 3b0:	00000097          	auipc	ra,0x0
 3b4:	19c080e7          	jalr	412(ra) # 54c <read>
    if(cc < 1)
 3b8:	00a05e63          	blez	a0,3d4 <gets+0x56>
    buf[i++] = c;
 3bc:	faf44783          	lbu	a5,-81(s0)
 3c0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3c4:	01578763          	beq	a5,s5,3d2 <gets+0x54>
 3c8:	0905                	addi	s2,s2,1
 3ca:	fd679be3          	bne	a5,s6,3a0 <gets+0x22>
  for(i=0; i+1 < max; ){
 3ce:	89a6                	mv	s3,s1
 3d0:	a011                	j	3d4 <gets+0x56>
 3d2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3d4:	99de                	add	s3,s3,s7
 3d6:	00098023          	sb	zero,0(s3)
  return buf;
}
 3da:	855e                	mv	a0,s7
 3dc:	60e6                	ld	ra,88(sp)
 3de:	6446                	ld	s0,80(sp)
 3e0:	64a6                	ld	s1,72(sp)
 3e2:	6906                	ld	s2,64(sp)
 3e4:	79e2                	ld	s3,56(sp)
 3e6:	7a42                	ld	s4,48(sp)
 3e8:	7aa2                	ld	s5,40(sp)
 3ea:	7b02                	ld	s6,32(sp)
 3ec:	6be2                	ld	s7,24(sp)
 3ee:	6125                	addi	sp,sp,96
 3f0:	8082                	ret

00000000000003f2 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f2:	1101                	addi	sp,sp,-32
 3f4:	ec06                	sd	ra,24(sp)
 3f6:	e822                	sd	s0,16(sp)
 3f8:	e426                	sd	s1,8(sp)
 3fa:	e04a                	sd	s2,0(sp)
 3fc:	1000                	addi	s0,sp,32
 3fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 400:	4581                	li	a1,0
 402:	00000097          	auipc	ra,0x0
 406:	172080e7          	jalr	370(ra) # 574 <open>
  if(fd < 0)
 40a:	02054563          	bltz	a0,434 <stat+0x42>
 40e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 410:	85ca                	mv	a1,s2
 412:	00000097          	auipc	ra,0x0
 416:	17a080e7          	jalr	378(ra) # 58c <fstat>
 41a:	892a                	mv	s2,a0
  close(fd);
 41c:	8526                	mv	a0,s1
 41e:	00000097          	auipc	ra,0x0
 422:	13e080e7          	jalr	318(ra) # 55c <close>
  return r;
}
 426:	854a                	mv	a0,s2
 428:	60e2                	ld	ra,24(sp)
 42a:	6442                	ld	s0,16(sp)
 42c:	64a2                	ld	s1,8(sp)
 42e:	6902                	ld	s2,0(sp)
 430:	6105                	addi	sp,sp,32
 432:	8082                	ret
    return -1;
 434:	597d                	li	s2,-1
 436:	bfc5                	j	426 <stat+0x34>

0000000000000438 <atoi>:

int
atoi(const char *s)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e422                	sd	s0,8(sp)
 43c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 43e:	00054603          	lbu	a2,0(a0)
 442:	fd06079b          	addiw	a5,a2,-48
 446:	0ff7f793          	zext.b	a5,a5
 44a:	4725                	li	a4,9
 44c:	02f76963          	bltu	a4,a5,47e <atoi+0x46>
 450:	86aa                	mv	a3,a0
  n = 0;
 452:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 454:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 456:	0685                	addi	a3,a3,1
 458:	0025179b          	slliw	a5,a0,0x2
 45c:	9fa9                	addw	a5,a5,a0
 45e:	0017979b          	slliw	a5,a5,0x1
 462:	9fb1                	addw	a5,a5,a2
 464:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 468:	0006c603          	lbu	a2,0(a3)
 46c:	fd06071b          	addiw	a4,a2,-48
 470:	0ff77713          	zext.b	a4,a4
 474:	fee5f1e3          	bgeu	a1,a4,456 <atoi+0x1e>
  return n;
}
 478:	6422                	ld	s0,8(sp)
 47a:	0141                	addi	sp,sp,16
 47c:	8082                	ret
  n = 0;
 47e:	4501                	li	a0,0
 480:	bfe5                	j	478 <atoi+0x40>

0000000000000482 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 482:	1141                	addi	sp,sp,-16
 484:	e422                	sd	s0,8(sp)
 486:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 488:	02b57463          	bgeu	a0,a1,4b0 <memmove+0x2e>
    while(n-- > 0)
 48c:	00c05f63          	blez	a2,4aa <memmove+0x28>
 490:	1602                	slli	a2,a2,0x20
 492:	9201                	srli	a2,a2,0x20
 494:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 498:	872a                	mv	a4,a0
      *dst++ = *src++;
 49a:	0585                	addi	a1,a1,1
 49c:	0705                	addi	a4,a4,1
 49e:	fff5c683          	lbu	a3,-1(a1)
 4a2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4a6:	fee79ae3          	bne	a5,a4,49a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret
    dst += n;
 4b0:	00c50733          	add	a4,a0,a2
    src += n;
 4b4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4b6:	fec05ae3          	blez	a2,4aa <memmove+0x28>
 4ba:	fff6079b          	addiw	a5,a2,-1
 4be:	1782                	slli	a5,a5,0x20
 4c0:	9381                	srli	a5,a5,0x20
 4c2:	fff7c793          	not	a5,a5
 4c6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4c8:	15fd                	addi	a1,a1,-1
 4ca:	177d                	addi	a4,a4,-1
 4cc:	0005c683          	lbu	a3,0(a1)
 4d0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4d4:	fee79ae3          	bne	a5,a4,4c8 <memmove+0x46>
 4d8:	bfc9                	j	4aa <memmove+0x28>

00000000000004da <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4da:	1141                	addi	sp,sp,-16
 4dc:	e422                	sd	s0,8(sp)
 4de:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4e0:	ca05                	beqz	a2,510 <memcmp+0x36>
 4e2:	fff6069b          	addiw	a3,a2,-1
 4e6:	1682                	slli	a3,a3,0x20
 4e8:	9281                	srli	a3,a3,0x20
 4ea:	0685                	addi	a3,a3,1
 4ec:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ee:	00054783          	lbu	a5,0(a0)
 4f2:	0005c703          	lbu	a4,0(a1)
 4f6:	00e79863          	bne	a5,a4,506 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4fa:	0505                	addi	a0,a0,1
    p2++;
 4fc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4fe:	fed518e3          	bne	a0,a3,4ee <memcmp+0x14>
  }
  return 0;
 502:	4501                	li	a0,0
 504:	a019                	j	50a <memcmp+0x30>
      return *p1 - *p2;
 506:	40e7853b          	subw	a0,a5,a4
}
 50a:	6422                	ld	s0,8(sp)
 50c:	0141                	addi	sp,sp,16
 50e:	8082                	ret
  return 0;
 510:	4501                	li	a0,0
 512:	bfe5                	j	50a <memcmp+0x30>

0000000000000514 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 514:	1141                	addi	sp,sp,-16
 516:	e406                	sd	ra,8(sp)
 518:	e022                	sd	s0,0(sp)
 51a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 51c:	00000097          	auipc	ra,0x0
 520:	f66080e7          	jalr	-154(ra) # 482 <memmove>
}
 524:	60a2                	ld	ra,8(sp)
 526:	6402                	ld	s0,0(sp)
 528:	0141                	addi	sp,sp,16
 52a:	8082                	ret

000000000000052c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 52c:	4885                	li	a7,1
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <exit>:
.global exit
exit:
 li a7, SYS_exit
 534:	4889                	li	a7,2
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <wait>:
.global wait
wait:
 li a7, SYS_wait
 53c:	488d                	li	a7,3
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 544:	4891                	li	a7,4
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <read>:
.global read
read:
 li a7, SYS_read
 54c:	4895                	li	a7,5
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <write>:
.global write
write:
 li a7, SYS_write
 554:	48c1                	li	a7,16
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <close>:
.global close
close:
 li a7, SYS_close
 55c:	48d5                	li	a7,21
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <kill>:
.global kill
kill:
 li a7, SYS_kill
 564:	4899                	li	a7,6
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <exec>:
.global exec
exec:
 li a7, SYS_exec
 56c:	489d                	li	a7,7
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <open>:
.global open
open:
 li a7, SYS_open
 574:	48bd                	li	a7,15
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 57c:	48c5                	li	a7,17
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 584:	48c9                	li	a7,18
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 58c:	48a1                	li	a7,8
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <link>:
.global link
link:
 li a7, SYS_link
 594:	48cd                	li	a7,19
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 59c:	48d1                	li	a7,20
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a4:	48a5                	li	a7,9
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ac:	48a9                	li	a7,10
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b4:	48ad                	li	a7,11
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5bc:	48b1                	li	a7,12
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c4:	48b5                	li	a7,13
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5cc:	48b9                	li	a7,14
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5d4:	48d9                	li	a7,22
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5dc:	1101                	addi	sp,sp,-32
 5de:	ec06                	sd	ra,24(sp)
 5e0:	e822                	sd	s0,16(sp)
 5e2:	1000                	addi	s0,sp,32
 5e4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5e8:	4605                	li	a2,1
 5ea:	fef40593          	addi	a1,s0,-17
 5ee:	00000097          	auipc	ra,0x0
 5f2:	f66080e7          	jalr	-154(ra) # 554 <write>
}
 5f6:	60e2                	ld	ra,24(sp)
 5f8:	6442                	ld	s0,16(sp)
 5fa:	6105                	addi	sp,sp,32
 5fc:	8082                	ret

00000000000005fe <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5fe:	7139                	addi	sp,sp,-64
 600:	fc06                	sd	ra,56(sp)
 602:	f822                	sd	s0,48(sp)
 604:	f426                	sd	s1,40(sp)
 606:	f04a                	sd	s2,32(sp)
 608:	ec4e                	sd	s3,24(sp)
 60a:	0080                	addi	s0,sp,64
 60c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60e:	c299                	beqz	a3,614 <printint+0x16>
 610:	0805c863          	bltz	a1,6a0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 614:	2581                	sext.w	a1,a1
  neg = 0;
 616:	4881                	li	a7,0
 618:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 61c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 61e:	2601                	sext.w	a2,a2
 620:	00000517          	auipc	a0,0x0
 624:	44850513          	addi	a0,a0,1096 # a68 <digits>
 628:	883a                	mv	a6,a4
 62a:	2705                	addiw	a4,a4,1
 62c:	02c5f7bb          	remuw	a5,a1,a2
 630:	1782                	slli	a5,a5,0x20
 632:	9381                	srli	a5,a5,0x20
 634:	97aa                	add	a5,a5,a0
 636:	0007c783          	lbu	a5,0(a5)
 63a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 63e:	0005879b          	sext.w	a5,a1
 642:	02c5d5bb          	divuw	a1,a1,a2
 646:	0685                	addi	a3,a3,1
 648:	fec7f0e3          	bgeu	a5,a2,628 <printint+0x2a>
  if(neg)
 64c:	00088b63          	beqz	a7,662 <printint+0x64>
    buf[i++] = '-';
 650:	fd040793          	addi	a5,s0,-48
 654:	973e                	add	a4,a4,a5
 656:	02d00793          	li	a5,45
 65a:	fef70823          	sb	a5,-16(a4)
 65e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 662:	02e05863          	blez	a4,692 <printint+0x94>
 666:	fc040793          	addi	a5,s0,-64
 66a:	00e78933          	add	s2,a5,a4
 66e:	fff78993          	addi	s3,a5,-1
 672:	99ba                	add	s3,s3,a4
 674:	377d                	addiw	a4,a4,-1
 676:	1702                	slli	a4,a4,0x20
 678:	9301                	srli	a4,a4,0x20
 67a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 67e:	fff94583          	lbu	a1,-1(s2)
 682:	8526                	mv	a0,s1
 684:	00000097          	auipc	ra,0x0
 688:	f58080e7          	jalr	-168(ra) # 5dc <putc>
  while(--i >= 0)
 68c:	197d                	addi	s2,s2,-1
 68e:	ff3918e3          	bne	s2,s3,67e <printint+0x80>
}
 692:	70e2                	ld	ra,56(sp)
 694:	7442                	ld	s0,48(sp)
 696:	74a2                	ld	s1,40(sp)
 698:	7902                	ld	s2,32(sp)
 69a:	69e2                	ld	s3,24(sp)
 69c:	6121                	addi	sp,sp,64
 69e:	8082                	ret
    x = -xx;
 6a0:	40b005bb          	negw	a1,a1
    neg = 1;
 6a4:	4885                	li	a7,1
    x = -xx;
 6a6:	bf8d                	j	618 <printint+0x1a>

00000000000006a8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a8:	7119                	addi	sp,sp,-128
 6aa:	fc86                	sd	ra,120(sp)
 6ac:	f8a2                	sd	s0,112(sp)
 6ae:	f4a6                	sd	s1,104(sp)
 6b0:	f0ca                	sd	s2,96(sp)
 6b2:	ecce                	sd	s3,88(sp)
 6b4:	e8d2                	sd	s4,80(sp)
 6b6:	e4d6                	sd	s5,72(sp)
 6b8:	e0da                	sd	s6,64(sp)
 6ba:	fc5e                	sd	s7,56(sp)
 6bc:	f862                	sd	s8,48(sp)
 6be:	f466                	sd	s9,40(sp)
 6c0:	f06a                	sd	s10,32(sp)
 6c2:	ec6e                	sd	s11,24(sp)
 6c4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6c6:	0005c903          	lbu	s2,0(a1)
 6ca:	18090f63          	beqz	s2,868 <vprintf+0x1c0>
 6ce:	8aaa                	mv	s5,a0
 6d0:	8b32                	mv	s6,a2
 6d2:	00158493          	addi	s1,a1,1
  state = 0;
 6d6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6d8:	02500a13          	li	s4,37
      if(c == 'd'){
 6dc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6e0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6e4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6e8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ec:	00000b97          	auipc	s7,0x0
 6f0:	37cb8b93          	addi	s7,s7,892 # a68 <digits>
 6f4:	a839                	j	712 <vprintf+0x6a>
        putc(fd, c);
 6f6:	85ca                	mv	a1,s2
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	ee2080e7          	jalr	-286(ra) # 5dc <putc>
 702:	a019                	j	708 <vprintf+0x60>
    } else if(state == '%'){
 704:	01498f63          	beq	s3,s4,722 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 708:	0485                	addi	s1,s1,1
 70a:	fff4c903          	lbu	s2,-1(s1)
 70e:	14090d63          	beqz	s2,868 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 712:	0009079b          	sext.w	a5,s2
    if(state == 0){
 716:	fe0997e3          	bnez	s3,704 <vprintf+0x5c>
      if(c == '%'){
 71a:	fd479ee3          	bne	a5,s4,6f6 <vprintf+0x4e>
        state = '%';
 71e:	89be                	mv	s3,a5
 720:	b7e5                	j	708 <vprintf+0x60>
      if(c == 'd'){
 722:	05878063          	beq	a5,s8,762 <vprintf+0xba>
      } else if(c == 'l') {
 726:	05978c63          	beq	a5,s9,77e <vprintf+0xd6>
      } else if(c == 'x') {
 72a:	07a78863          	beq	a5,s10,79a <vprintf+0xf2>
      } else if(c == 'p') {
 72e:	09b78463          	beq	a5,s11,7b6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 732:	07300713          	li	a4,115
 736:	0ce78663          	beq	a5,a4,802 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 73a:	06300713          	li	a4,99
 73e:	0ee78e63          	beq	a5,a4,83a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 742:	11478863          	beq	a5,s4,852 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 746:	85d2                	mv	a1,s4
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e92080e7          	jalr	-366(ra) # 5dc <putc>
        putc(fd, c);
 752:	85ca                	mv	a1,s2
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	e86080e7          	jalr	-378(ra) # 5dc <putc>
      }
      state = 0;
 75e:	4981                	li	s3,0
 760:	b765                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 762:	008b0913          	addi	s2,s6,8
 766:	4685                	li	a3,1
 768:	4629                	li	a2,10
 76a:	000b2583          	lw	a1,0(s6)
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e8e080e7          	jalr	-370(ra) # 5fe <printint>
 778:	8b4a                	mv	s6,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b771                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 77e:	008b0913          	addi	s2,s6,8
 782:	4681                	li	a3,0
 784:	4629                	li	a2,10
 786:	000b2583          	lw	a1,0(s6)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e72080e7          	jalr	-398(ra) # 5fe <printint>
 794:	8b4a                	mv	s6,s2
      state = 0;
 796:	4981                	li	s3,0
 798:	bf85                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 79a:	008b0913          	addi	s2,s6,8
 79e:	4681                	li	a3,0
 7a0:	4641                	li	a2,16
 7a2:	000b2583          	lw	a1,0(s6)
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e56080e7          	jalr	-426(ra) # 5fe <printint>
 7b0:	8b4a                	mv	s6,s2
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	bf91                	j	708 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7b6:	008b0793          	addi	a5,s6,8
 7ba:	f8f43423          	sd	a5,-120(s0)
 7be:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7c2:	03000593          	li	a1,48
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	e14080e7          	jalr	-492(ra) # 5dc <putc>
  putc(fd, 'x');
 7d0:	85ea                	mv	a1,s10
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	e08080e7          	jalr	-504(ra) # 5dc <putc>
 7dc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7de:	03c9d793          	srli	a5,s3,0x3c
 7e2:	97de                	add	a5,a5,s7
 7e4:	0007c583          	lbu	a1,0(a5)
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	df2080e7          	jalr	-526(ra) # 5dc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f2:	0992                	slli	s3,s3,0x4
 7f4:	397d                	addiw	s2,s2,-1
 7f6:	fe0914e3          	bnez	s2,7de <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7fa:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b721                	j	708 <vprintf+0x60>
        s = va_arg(ap, char*);
 802:	008b0993          	addi	s3,s6,8
 806:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 80a:	02090163          	beqz	s2,82c <vprintf+0x184>
        while(*s != 0){
 80e:	00094583          	lbu	a1,0(s2)
 812:	c9a1                	beqz	a1,862 <vprintf+0x1ba>
          putc(fd, *s);
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	dc6080e7          	jalr	-570(ra) # 5dc <putc>
          s++;
 81e:	0905                	addi	s2,s2,1
        while(*s != 0){
 820:	00094583          	lbu	a1,0(s2)
 824:	f9e5                	bnez	a1,814 <vprintf+0x16c>
        s = va_arg(ap, char*);
 826:	8b4e                	mv	s6,s3
      state = 0;
 828:	4981                	li	s3,0
 82a:	bdf9                	j	708 <vprintf+0x60>
          s = "(null)";
 82c:	00000917          	auipc	s2,0x0
 830:	23490913          	addi	s2,s2,564 # a60 <malloc+0xee>
        while(*s != 0){
 834:	02800593          	li	a1,40
 838:	bff1                	j	814 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 83a:	008b0913          	addi	s2,s6,8
 83e:	000b4583          	lbu	a1,0(s6)
 842:	8556                	mv	a0,s5
 844:	00000097          	auipc	ra,0x0
 848:	d98080e7          	jalr	-616(ra) # 5dc <putc>
 84c:	8b4a                	mv	s6,s2
      state = 0;
 84e:	4981                	li	s3,0
 850:	bd65                	j	708 <vprintf+0x60>
        putc(fd, c);
 852:	85d2                	mv	a1,s4
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	d86080e7          	jalr	-634(ra) # 5dc <putc>
      state = 0;
 85e:	4981                	li	s3,0
 860:	b565                	j	708 <vprintf+0x60>
        s = va_arg(ap, char*);
 862:	8b4e                	mv	s6,s3
      state = 0;
 864:	4981                	li	s3,0
 866:	b54d                	j	708 <vprintf+0x60>
    }
  }
}
 868:	70e6                	ld	ra,120(sp)
 86a:	7446                	ld	s0,112(sp)
 86c:	74a6                	ld	s1,104(sp)
 86e:	7906                	ld	s2,96(sp)
 870:	69e6                	ld	s3,88(sp)
 872:	6a46                	ld	s4,80(sp)
 874:	6aa6                	ld	s5,72(sp)
 876:	6b06                	ld	s6,64(sp)
 878:	7be2                	ld	s7,56(sp)
 87a:	7c42                	ld	s8,48(sp)
 87c:	7ca2                	ld	s9,40(sp)
 87e:	7d02                	ld	s10,32(sp)
 880:	6de2                	ld	s11,24(sp)
 882:	6109                	addi	sp,sp,128
 884:	8082                	ret

0000000000000886 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 886:	715d                	addi	sp,sp,-80
 888:	ec06                	sd	ra,24(sp)
 88a:	e822                	sd	s0,16(sp)
 88c:	1000                	addi	s0,sp,32
 88e:	e010                	sd	a2,0(s0)
 890:	e414                	sd	a3,8(s0)
 892:	e818                	sd	a4,16(s0)
 894:	ec1c                	sd	a5,24(s0)
 896:	03043023          	sd	a6,32(s0)
 89a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a2:	8622                	mv	a2,s0
 8a4:	00000097          	auipc	ra,0x0
 8a8:	e04080e7          	jalr	-508(ra) # 6a8 <vprintf>
}
 8ac:	60e2                	ld	ra,24(sp)
 8ae:	6442                	ld	s0,16(sp)
 8b0:	6161                	addi	sp,sp,80
 8b2:	8082                	ret

00000000000008b4 <printf>:

void
printf(const char *fmt, ...)
{
 8b4:	711d                	addi	sp,sp,-96
 8b6:	ec06                	sd	ra,24(sp)
 8b8:	e822                	sd	s0,16(sp)
 8ba:	1000                	addi	s0,sp,32
 8bc:	e40c                	sd	a1,8(s0)
 8be:	e810                	sd	a2,16(s0)
 8c0:	ec14                	sd	a3,24(s0)
 8c2:	f018                	sd	a4,32(s0)
 8c4:	f41c                	sd	a5,40(s0)
 8c6:	03043823          	sd	a6,48(s0)
 8ca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ce:	00840613          	addi	a2,s0,8
 8d2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d6:	85aa                	mv	a1,a0
 8d8:	4505                	li	a0,1
 8da:	00000097          	auipc	ra,0x0
 8de:	dce080e7          	jalr	-562(ra) # 6a8 <vprintf>
}
 8e2:	60e2                	ld	ra,24(sp)
 8e4:	6442                	ld	s0,16(sp)
 8e6:	6125                	addi	sp,sp,96
 8e8:	8082                	ret

00000000000008ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ea:	1141                	addi	sp,sp,-16
 8ec:	e422                	sd	s0,8(sp)
 8ee:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f4:	00000797          	auipc	a5,0x0
 8f8:	1947b783          	ld	a5,404(a5) # a88 <freep>
 8fc:	a805                	j	92c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fe:	4618                	lw	a4,8(a2)
 900:	9db9                	addw	a1,a1,a4
 902:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 906:	6398                	ld	a4,0(a5)
 908:	6318                	ld	a4,0(a4)
 90a:	fee53823          	sd	a4,-16(a0)
 90e:	a091                	j	952 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 910:	ff852703          	lw	a4,-8(a0)
 914:	9e39                	addw	a2,a2,a4
 916:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 918:	ff053703          	ld	a4,-16(a0)
 91c:	e398                	sd	a4,0(a5)
 91e:	a099                	j	964 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 920:	6398                	ld	a4,0(a5)
 922:	00e7e463          	bltu	a5,a4,92a <free+0x40>
 926:	00e6ea63          	bltu	a3,a4,93a <free+0x50>
{
 92a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92c:	fed7fae3          	bgeu	a5,a3,920 <free+0x36>
 930:	6398                	ld	a4,0(a5)
 932:	00e6e463          	bltu	a3,a4,93a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 936:	fee7eae3          	bltu	a5,a4,92a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 93a:	ff852583          	lw	a1,-8(a0)
 93e:	6390                	ld	a2,0(a5)
 940:	02059813          	slli	a6,a1,0x20
 944:	01c85713          	srli	a4,a6,0x1c
 948:	9736                	add	a4,a4,a3
 94a:	fae60ae3          	beq	a2,a4,8fe <free+0x14>
    bp->s.ptr = p->s.ptr;
 94e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 952:	4790                	lw	a2,8(a5)
 954:	02061593          	slli	a1,a2,0x20
 958:	01c5d713          	srli	a4,a1,0x1c
 95c:	973e                	add	a4,a4,a5
 95e:	fae689e3          	beq	a3,a4,910 <free+0x26>
  } else
    p->s.ptr = bp;
 962:	e394                	sd	a3,0(a5)
  freep = p;
 964:	00000717          	auipc	a4,0x0
 968:	12f73223          	sd	a5,292(a4) # a88 <freep>
}
 96c:	6422                	ld	s0,8(sp)
 96e:	0141                	addi	sp,sp,16
 970:	8082                	ret

0000000000000972 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 972:	7139                	addi	sp,sp,-64
 974:	fc06                	sd	ra,56(sp)
 976:	f822                	sd	s0,48(sp)
 978:	f426                	sd	s1,40(sp)
 97a:	f04a                	sd	s2,32(sp)
 97c:	ec4e                	sd	s3,24(sp)
 97e:	e852                	sd	s4,16(sp)
 980:	e456                	sd	s5,8(sp)
 982:	e05a                	sd	s6,0(sp)
 984:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 986:	02051493          	slli	s1,a0,0x20
 98a:	9081                	srli	s1,s1,0x20
 98c:	04bd                	addi	s1,s1,15
 98e:	8091                	srli	s1,s1,0x4
 990:	0014899b          	addiw	s3,s1,1
 994:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 996:	00000517          	auipc	a0,0x0
 99a:	0f253503          	ld	a0,242(a0) # a88 <freep>
 99e:	c515                	beqz	a0,9ca <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a2:	4798                	lw	a4,8(a5)
 9a4:	02977f63          	bgeu	a4,s1,9e2 <malloc+0x70>
 9a8:	8a4e                	mv	s4,s3
 9aa:	0009871b          	sext.w	a4,s3
 9ae:	6685                	lui	a3,0x1
 9b0:	00d77363          	bgeu	a4,a3,9b6 <malloc+0x44>
 9b4:	6a05                	lui	s4,0x1
 9b6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9ba:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9be:	00000917          	auipc	s2,0x0
 9c2:	0ca90913          	addi	s2,s2,202 # a88 <freep>
  if(p == (char*)-1)
 9c6:	5afd                	li	s5,-1
 9c8:	a895                	j	a3c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9ca:	00000797          	auipc	a5,0x0
 9ce:	1b678793          	addi	a5,a5,438 # b80 <base>
 9d2:	00000717          	auipc	a4,0x0
 9d6:	0af73b23          	sd	a5,182(a4) # a88 <freep>
 9da:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9dc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9e0:	b7e1                	j	9a8 <malloc+0x36>
      if(p->s.size == nunits)
 9e2:	02e48c63          	beq	s1,a4,a1a <malloc+0xa8>
        p->s.size -= nunits;
 9e6:	4137073b          	subw	a4,a4,s3
 9ea:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ec:	02071693          	slli	a3,a4,0x20
 9f0:	01c6d713          	srli	a4,a3,0x1c
 9f4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9fa:	00000717          	auipc	a4,0x0
 9fe:	08a73723          	sd	a0,142(a4) # a88 <freep>
      return (void*)(p + 1);
 a02:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a06:	70e2                	ld	ra,56(sp)
 a08:	7442                	ld	s0,48(sp)
 a0a:	74a2                	ld	s1,40(sp)
 a0c:	7902                	ld	s2,32(sp)
 a0e:	69e2                	ld	s3,24(sp)
 a10:	6a42                	ld	s4,16(sp)
 a12:	6aa2                	ld	s5,8(sp)
 a14:	6b02                	ld	s6,0(sp)
 a16:	6121                	addi	sp,sp,64
 a18:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a1a:	6398                	ld	a4,0(a5)
 a1c:	e118                	sd	a4,0(a0)
 a1e:	bff1                	j	9fa <malloc+0x88>
  hp->s.size = nu;
 a20:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a24:	0541                	addi	a0,a0,16
 a26:	00000097          	auipc	ra,0x0
 a2a:	ec4080e7          	jalr	-316(ra) # 8ea <free>
  return freep;
 a2e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a32:	d971                	beqz	a0,a06 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a34:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a36:	4798                	lw	a4,8(a5)
 a38:	fa9775e3          	bgeu	a4,s1,9e2 <malloc+0x70>
    if(p == freep)
 a3c:	00093703          	ld	a4,0(s2)
 a40:	853e                	mv	a0,a5
 a42:	fef719e3          	bne	a4,a5,a34 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a46:	8552                	mv	a0,s4
 a48:	00000097          	auipc	ra,0x0
 a4c:	b74080e7          	jalr	-1164(ra) # 5bc <sbrk>
  if(p == (char*)-1)
 a50:	fd5518e3          	bne	a0,s5,a20 <malloc+0xae>
        return 0;
 a54:	4501                	li	a0,0
 a56:	bf45                	j	a06 <malloc+0x94>
