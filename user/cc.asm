
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
  18:	31d68693          	addi	a3,a3,797 # 1f31d <__global_pointer$+0x1e08c>
  1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
  20:	6611                	lui	a2,0x4
  22:	1a760613          	addi	a2,a2,423 # 41a7 <__global_pointer$+0x2f16>
  26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
  2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
  2e:	76fd                	lui	a3,0xfffff
  30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffe25b>
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
  64:	a3850513          	addi	a0,a0,-1480 # a98 <rand_next>
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
  86:	9ee50513          	addi	a0,a0,-1554 # a70 <malloc+0xe6>
  8a:	00001097          	auipc	ra,0x1
  8e:	842080e7          	jalr	-1982(ra) # 8cc <printf>
  exit(0);
  92:	4501                	li	a0,0
  94:	00000097          	auipc	ra,0x0
  98:	4b8080e7          	jalr	1208(ra) # 54c <exit>

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
  e2:	9da48493          	addi	s1,s1,-1574 # ab8 <rings+0x10>
  e6:	00001917          	auipc	s2,0x1
  ea:	ac290913          	addi	s2,s2,-1342 # ba8 <__BSS_END__>
  ee:	04f59563          	bne	a1,a5,138 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  f2:	00001497          	auipc	s1,0x1
  f6:	9c64a483          	lw	s1,-1594(s1) # ab8 <rings+0x10>
  fa:	c099                	beqz	s1,100 <create_or_close_the_buffer_user+0x38>
  fc:	4481                	li	s1,0
  fe:	a899                	j	154 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 100:	00001917          	auipc	s2,0x1
 104:	9a890913          	addi	s2,s2,-1624 # aa8 <rings>
 108:	00093603          	ld	a2,0(s2)
 10c:	4585                	li	a1,1
 10e:	00000097          	auipc	ra,0x0
 112:	4de080e7          	jalr	1246(ra) # 5ec <ringbuf>
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
 148:	4a8080e7          	jalr	1192(ra) # 5ec <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 166:	1101                	addi	sp,sp,-32
 168:	ec06                	sd	ra,24(sp)
 16a:	e822                	sd	s0,16(sp)
 16c:	e426                	sd	s1,8(sp)
 16e:	1000                	addi	s0,sp,32
 170:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 172:	00151793          	slli	a5,a0,0x1
 176:	97aa                	add	a5,a5,a0
 178:	078e                	slli	a5,a5,0x3
 17a:	00001717          	auipc	a4,0x1
 17e:	92e70713          	addi	a4,a4,-1746 # aa8 <rings>
 182:	97ba                	add	a5,a5,a4
 184:	6798                	ld	a4,8(a5)
 186:	671c                	ld	a5,8(a4)
 188:	00178693          	addi	a3,a5,1
 18c:	e714                	sd	a3,8(a4)
 18e:	17d2                	slli	a5,a5,0x34
 190:	93d1                	srli	a5,a5,0x34
 192:	6741                	lui	a4,0x10
 194:	40f707b3          	sub	a5,a4,a5
 198:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 19a:	421c                	lw	a5,0(a2)
 19c:	e79d                	bnez	a5,1ca <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 19e:	00001697          	auipc	a3,0x1
 1a2:	90a68693          	addi	a3,a3,-1782 # aa8 <rings>
 1a6:	669c                	ld	a5,8(a3)
 1a8:	6398                	ld	a4,0(a5)
 1aa:	67c1                	lui	a5,0x10
 1ac:	9fb9                	addw	a5,a5,a4
 1ae:	00151713          	slli	a4,a0,0x1
 1b2:	953a                	add	a0,a0,a4
 1b4:	050e                	slli	a0,a0,0x3
 1b6:	9536                	add	a0,a0,a3
 1b8:	6518                	ld	a4,8(a0)
 1ba:	6718                	ld	a4,8(a4)
 1bc:	9f99                	subw	a5,a5,a4
 1be:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 1c0:	60e2                	ld	ra,24(sp)
 1c2:	6442                	ld	s0,16(sp)
 1c4:	64a2                	ld	s1,8(sp)
 1c6:	6105                	addi	sp,sp,32
 1c8:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 1ca:	00151793          	slli	a5,a0,0x1
 1ce:	953e                	add	a0,a0,a5
 1d0:	050e                	slli	a0,a0,0x3
 1d2:	00001797          	auipc	a5,0x1
 1d6:	8d678793          	addi	a5,a5,-1834 # aa8 <rings>
 1da:	953e                	add	a0,a0,a5
 1dc:	6508                	ld	a0,8(a0)
 1de:	0521                	addi	a0,a0,8
 1e0:	00000097          	auipc	ra,0x0
 1e4:	ed0080e7          	jalr	-304(ra) # b0 <load>
 1e8:	c088                	sw	a0,0(s1)
}
 1ea:	bfd9                	j	1c0 <ringbuf_start_write+0x5a>

00000000000001ec <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e406                	sd	ra,8(sp)
 1f0:	e022                	sd	s0,0(sp)
 1f2:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1f4:	00151793          	slli	a5,a0,0x1
 1f8:	97aa                	add	a5,a5,a0
 1fa:	078e                	slli	a5,a5,0x3
 1fc:	00001517          	auipc	a0,0x1
 200:	8ac50513          	addi	a0,a0,-1876 # aa8 <rings>
 204:	97aa                	add	a5,a5,a0
 206:	6788                	ld	a0,8(a5)
 208:	0035959b          	slliw	a1,a1,0x3
 20c:	0521                	addi	a0,a0,8
 20e:	00000097          	auipc	ra,0x0
 212:	e8e080e7          	jalr	-370(ra) # 9c <store>
}
 216:	60a2                	ld	ra,8(sp)
 218:	6402                	ld	s0,0(sp)
 21a:	0141                	addi	sp,sp,16
 21c:	8082                	ret

000000000000021e <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 21e:	1101                	addi	sp,sp,-32
 220:	ec06                	sd	ra,24(sp)
 222:	e822                	sd	s0,16(sp)
 224:	e426                	sd	s1,8(sp)
 226:	1000                	addi	s0,sp,32
 228:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 22a:	00151793          	slli	a5,a0,0x1
 22e:	97aa                	add	a5,a5,a0
 230:	078e                	slli	a5,a5,0x3
 232:	00001517          	auipc	a0,0x1
 236:	87650513          	addi	a0,a0,-1930 # aa8 <rings>
 23a:	97aa                	add	a5,a5,a0
 23c:	6788                	ld	a0,8(a5)
 23e:	0521                	addi	a0,a0,8
 240:	00000097          	auipc	ra,0x0
 244:	e70080e7          	jalr	-400(ra) # b0 <load>
 248:	c088                	sw	a0,0(s1)
}
 24a:	60e2                	ld	ra,24(sp)
 24c:	6442                	ld	s0,16(sp)
 24e:	64a2                	ld	s1,8(sp)
 250:	6105                	addi	sp,sp,32
 252:	8082                	ret

0000000000000254 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 254:	1101                	addi	sp,sp,-32
 256:	ec06                	sd	ra,24(sp)
 258:	e822                	sd	s0,16(sp)
 25a:	e426                	sd	s1,8(sp)
 25c:	1000                	addi	s0,sp,32
 25e:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 260:	00151793          	slli	a5,a0,0x1
 264:	97aa                	add	a5,a5,a0
 266:	078e                	slli	a5,a5,0x3
 268:	00001517          	auipc	a0,0x1
 26c:	84050513          	addi	a0,a0,-1984 # aa8 <rings>
 270:	97aa                	add	a5,a5,a0
 272:	6788                	ld	a0,8(a5)
 274:	611c                	ld	a5,0(a0)
 276:	ef99                	bnez	a5,294 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 278:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 27a:	41f7579b          	sraiw	a5,a4,0x1f
 27e:	01d7d79b          	srliw	a5,a5,0x1d
 282:	9fb9                	addw	a5,a5,a4
 284:	4037d79b          	sraiw	a5,a5,0x3
 288:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 28a:	60e2                	ld	ra,24(sp)
 28c:	6442                	ld	s0,16(sp)
 28e:	64a2                	ld	s1,8(sp)
 290:	6105                	addi	sp,sp,32
 292:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 294:	00000097          	auipc	ra,0x0
 298:	e1c080e7          	jalr	-484(ra) # b0 <load>
    *bytes /= 8;
 29c:	41f5579b          	sraiw	a5,a0,0x1f
 2a0:	01d7d79b          	srliw	a5,a5,0x1d
 2a4:	9d3d                	addw	a0,a0,a5
 2a6:	4035551b          	sraiw	a0,a0,0x3
 2aa:	c088                	sw	a0,0(s1)
}
 2ac:	bff9                	j	28a <ringbuf_start_read+0x36>

00000000000002ae <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 2b6:	00151793          	slli	a5,a0,0x1
 2ba:	97aa                	add	a5,a5,a0
 2bc:	078e                	slli	a5,a5,0x3
 2be:	00000517          	auipc	a0,0x0
 2c2:	7ea50513          	addi	a0,a0,2026 # aa8 <rings>
 2c6:	97aa                	add	a5,a5,a0
 2c8:	0035959b          	slliw	a1,a1,0x3
 2cc:	6788                	ld	a0,8(a5)
 2ce:	00000097          	auipc	ra,0x0
 2d2:	dce080e7          	jalr	-562(ra) # 9c <store>
}
 2d6:	60a2                	ld	ra,8(sp)
 2d8:	6402                	ld	s0,0(sp)
 2da:	0141                	addi	sp,sp,16
 2dc:	8082                	ret

00000000000002de <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2e4:	87aa                	mv	a5,a0
 2e6:	0585                	addi	a1,a1,1
 2e8:	0785                	addi	a5,a5,1
 2ea:	fff5c703          	lbu	a4,-1(a1)
 2ee:	fee78fa3          	sb	a4,-1(a5)
 2f2:	fb75                	bnez	a4,2e6 <strcpy+0x8>
    ;
  return os;
}
 2f4:	6422                	ld	s0,8(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e422                	sd	s0,8(sp)
 2fe:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 300:	00054783          	lbu	a5,0(a0)
 304:	cb91                	beqz	a5,318 <strcmp+0x1e>
 306:	0005c703          	lbu	a4,0(a1)
 30a:	00f71763          	bne	a4,a5,318 <strcmp+0x1e>
    p++, q++;
 30e:	0505                	addi	a0,a0,1
 310:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 312:	00054783          	lbu	a5,0(a0)
 316:	fbe5                	bnez	a5,306 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 318:	0005c503          	lbu	a0,0(a1)
}
 31c:	40a7853b          	subw	a0,a5,a0
 320:	6422                	ld	s0,8(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret

0000000000000326 <strlen>:

uint
strlen(const char *s)
{
 326:	1141                	addi	sp,sp,-16
 328:	e422                	sd	s0,8(sp)
 32a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 32c:	00054783          	lbu	a5,0(a0)
 330:	cf91                	beqz	a5,34c <strlen+0x26>
 332:	0505                	addi	a0,a0,1
 334:	87aa                	mv	a5,a0
 336:	4685                	li	a3,1
 338:	9e89                	subw	a3,a3,a0
 33a:	00f6853b          	addw	a0,a3,a5
 33e:	0785                	addi	a5,a5,1
 340:	fff7c703          	lbu	a4,-1(a5)
 344:	fb7d                	bnez	a4,33a <strlen+0x14>
    ;
  return n;
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret
  for(n = 0; s[n]; n++)
 34c:	4501                	li	a0,0
 34e:	bfe5                	j	346 <strlen+0x20>

0000000000000350 <memset>:

void*
memset(void *dst, int c, uint n)
{
 350:	1141                	addi	sp,sp,-16
 352:	e422                	sd	s0,8(sp)
 354:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 356:	ca19                	beqz	a2,36c <memset+0x1c>
 358:	87aa                	mv	a5,a0
 35a:	1602                	slli	a2,a2,0x20
 35c:	9201                	srli	a2,a2,0x20
 35e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 362:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 366:	0785                	addi	a5,a5,1
 368:	fee79de3          	bne	a5,a4,362 <memset+0x12>
  }
  return dst;
}
 36c:	6422                	ld	s0,8(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret

0000000000000372 <strchr>:

char*
strchr(const char *s, char c)
{
 372:	1141                	addi	sp,sp,-16
 374:	e422                	sd	s0,8(sp)
 376:	0800                	addi	s0,sp,16
  for(; *s; s++)
 378:	00054783          	lbu	a5,0(a0)
 37c:	cb99                	beqz	a5,392 <strchr+0x20>
    if(*s == c)
 37e:	00f58763          	beq	a1,a5,38c <strchr+0x1a>
  for(; *s; s++)
 382:	0505                	addi	a0,a0,1
 384:	00054783          	lbu	a5,0(a0)
 388:	fbfd                	bnez	a5,37e <strchr+0xc>
      return (char*)s;
  return 0;
 38a:	4501                	li	a0,0
}
 38c:	6422                	ld	s0,8(sp)
 38e:	0141                	addi	sp,sp,16
 390:	8082                	ret
  return 0;
 392:	4501                	li	a0,0
 394:	bfe5                	j	38c <strchr+0x1a>

0000000000000396 <gets>:

char*
gets(char *buf, int max)
{
 396:	711d                	addi	sp,sp,-96
 398:	ec86                	sd	ra,88(sp)
 39a:	e8a2                	sd	s0,80(sp)
 39c:	e4a6                	sd	s1,72(sp)
 39e:	e0ca                	sd	s2,64(sp)
 3a0:	fc4e                	sd	s3,56(sp)
 3a2:	f852                	sd	s4,48(sp)
 3a4:	f456                	sd	s5,40(sp)
 3a6:	f05a                	sd	s6,32(sp)
 3a8:	ec5e                	sd	s7,24(sp)
 3aa:	1080                	addi	s0,sp,96
 3ac:	8baa                	mv	s7,a0
 3ae:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b0:	892a                	mv	s2,a0
 3b2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3b4:	4aa9                	li	s5,10
 3b6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3b8:	89a6                	mv	s3,s1
 3ba:	2485                	addiw	s1,s1,1
 3bc:	0344d863          	bge	s1,s4,3ec <gets+0x56>
    cc = read(0, &c, 1);
 3c0:	4605                	li	a2,1
 3c2:	faf40593          	addi	a1,s0,-81
 3c6:	4501                	li	a0,0
 3c8:	00000097          	auipc	ra,0x0
 3cc:	19c080e7          	jalr	412(ra) # 564 <read>
    if(cc < 1)
 3d0:	00a05e63          	blez	a0,3ec <gets+0x56>
    buf[i++] = c;
 3d4:	faf44783          	lbu	a5,-81(s0)
 3d8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3dc:	01578763          	beq	a5,s5,3ea <gets+0x54>
 3e0:	0905                	addi	s2,s2,1
 3e2:	fd679be3          	bne	a5,s6,3b8 <gets+0x22>
  for(i=0; i+1 < max; ){
 3e6:	89a6                	mv	s3,s1
 3e8:	a011                	j	3ec <gets+0x56>
 3ea:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3ec:	99de                	add	s3,s3,s7
 3ee:	00098023          	sb	zero,0(s3)
  return buf;
}
 3f2:	855e                	mv	a0,s7
 3f4:	60e6                	ld	ra,88(sp)
 3f6:	6446                	ld	s0,80(sp)
 3f8:	64a6                	ld	s1,72(sp)
 3fa:	6906                	ld	s2,64(sp)
 3fc:	79e2                	ld	s3,56(sp)
 3fe:	7a42                	ld	s4,48(sp)
 400:	7aa2                	ld	s5,40(sp)
 402:	7b02                	ld	s6,32(sp)
 404:	6be2                	ld	s7,24(sp)
 406:	6125                	addi	sp,sp,96
 408:	8082                	ret

000000000000040a <stat>:

int
stat(const char *n, struct stat *st)
{
 40a:	1101                	addi	sp,sp,-32
 40c:	ec06                	sd	ra,24(sp)
 40e:	e822                	sd	s0,16(sp)
 410:	e426                	sd	s1,8(sp)
 412:	e04a                	sd	s2,0(sp)
 414:	1000                	addi	s0,sp,32
 416:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 418:	4581                	li	a1,0
 41a:	00000097          	auipc	ra,0x0
 41e:	172080e7          	jalr	370(ra) # 58c <open>
  if(fd < 0)
 422:	02054563          	bltz	a0,44c <stat+0x42>
 426:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 428:	85ca                	mv	a1,s2
 42a:	00000097          	auipc	ra,0x0
 42e:	17a080e7          	jalr	378(ra) # 5a4 <fstat>
 432:	892a                	mv	s2,a0
  close(fd);
 434:	8526                	mv	a0,s1
 436:	00000097          	auipc	ra,0x0
 43a:	13e080e7          	jalr	318(ra) # 574 <close>
  return r;
}
 43e:	854a                	mv	a0,s2
 440:	60e2                	ld	ra,24(sp)
 442:	6442                	ld	s0,16(sp)
 444:	64a2                	ld	s1,8(sp)
 446:	6902                	ld	s2,0(sp)
 448:	6105                	addi	sp,sp,32
 44a:	8082                	ret
    return -1;
 44c:	597d                	li	s2,-1
 44e:	bfc5                	j	43e <stat+0x34>

0000000000000450 <atoi>:

int
atoi(const char *s)
{
 450:	1141                	addi	sp,sp,-16
 452:	e422                	sd	s0,8(sp)
 454:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 456:	00054603          	lbu	a2,0(a0)
 45a:	fd06079b          	addiw	a5,a2,-48
 45e:	0ff7f793          	zext.b	a5,a5
 462:	4725                	li	a4,9
 464:	02f76963          	bltu	a4,a5,496 <atoi+0x46>
 468:	86aa                	mv	a3,a0
  n = 0;
 46a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 46c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 46e:	0685                	addi	a3,a3,1
 470:	0025179b          	slliw	a5,a0,0x2
 474:	9fa9                	addw	a5,a5,a0
 476:	0017979b          	slliw	a5,a5,0x1
 47a:	9fb1                	addw	a5,a5,a2
 47c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 480:	0006c603          	lbu	a2,0(a3)
 484:	fd06071b          	addiw	a4,a2,-48
 488:	0ff77713          	zext.b	a4,a4
 48c:	fee5f1e3          	bgeu	a1,a4,46e <atoi+0x1e>
  return n;
}
 490:	6422                	ld	s0,8(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret
  n = 0;
 496:	4501                	li	a0,0
 498:	bfe5                	j	490 <atoi+0x40>

000000000000049a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 49a:	1141                	addi	sp,sp,-16
 49c:	e422                	sd	s0,8(sp)
 49e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4a0:	02b57463          	bgeu	a0,a1,4c8 <memmove+0x2e>
    while(n-- > 0)
 4a4:	00c05f63          	blez	a2,4c2 <memmove+0x28>
 4a8:	1602                	slli	a2,a2,0x20
 4aa:	9201                	srli	a2,a2,0x20
 4ac:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4b0:	872a                	mv	a4,a0
      *dst++ = *src++;
 4b2:	0585                	addi	a1,a1,1
 4b4:	0705                	addi	a4,a4,1
 4b6:	fff5c683          	lbu	a3,-1(a1)
 4ba:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xed6e>
    while(n-- > 0)
 4be:	fee79ae3          	bne	a5,a4,4b2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4c2:	6422                	ld	s0,8(sp)
 4c4:	0141                	addi	sp,sp,16
 4c6:	8082                	ret
    dst += n;
 4c8:	00c50733          	add	a4,a0,a2
    src += n;
 4cc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4ce:	fec05ae3          	blez	a2,4c2 <memmove+0x28>
 4d2:	fff6079b          	addiw	a5,a2,-1
 4d6:	1782                	slli	a5,a5,0x20
 4d8:	9381                	srli	a5,a5,0x20
 4da:	fff7c793          	not	a5,a5
 4de:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4e0:	15fd                	addi	a1,a1,-1
 4e2:	177d                	addi	a4,a4,-1
 4e4:	0005c683          	lbu	a3,0(a1)
 4e8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4ec:	fee79ae3          	bne	a5,a4,4e0 <memmove+0x46>
 4f0:	bfc9                	j	4c2 <memmove+0x28>

00000000000004f2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4f2:	1141                	addi	sp,sp,-16
 4f4:	e422                	sd	s0,8(sp)
 4f6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4f8:	ca05                	beqz	a2,528 <memcmp+0x36>
 4fa:	fff6069b          	addiw	a3,a2,-1
 4fe:	1682                	slli	a3,a3,0x20
 500:	9281                	srli	a3,a3,0x20
 502:	0685                	addi	a3,a3,1
 504:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 506:	00054783          	lbu	a5,0(a0)
 50a:	0005c703          	lbu	a4,0(a1)
 50e:	00e79863          	bne	a5,a4,51e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 512:	0505                	addi	a0,a0,1
    p2++;
 514:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 516:	fed518e3          	bne	a0,a3,506 <memcmp+0x14>
  }
  return 0;
 51a:	4501                	li	a0,0
 51c:	a019                	j	522 <memcmp+0x30>
      return *p1 - *p2;
 51e:	40e7853b          	subw	a0,a5,a4
}
 522:	6422                	ld	s0,8(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret
  return 0;
 528:	4501                	li	a0,0
 52a:	bfe5                	j	522 <memcmp+0x30>

000000000000052c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 52c:	1141                	addi	sp,sp,-16
 52e:	e406                	sd	ra,8(sp)
 530:	e022                	sd	s0,0(sp)
 532:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 534:	00000097          	auipc	ra,0x0
 538:	f66080e7          	jalr	-154(ra) # 49a <memmove>
}
 53c:	60a2                	ld	ra,8(sp)
 53e:	6402                	ld	s0,0(sp)
 540:	0141                	addi	sp,sp,16
 542:	8082                	ret

0000000000000544 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 544:	4885                	li	a7,1
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <exit>:
.global exit
exit:
 li a7, SYS_exit
 54c:	4889                	li	a7,2
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <wait>:
.global wait
wait:
 li a7, SYS_wait
 554:	488d                	li	a7,3
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 55c:	4891                	li	a7,4
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <read>:
.global read
read:
 li a7, SYS_read
 564:	4895                	li	a7,5
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <write>:
.global write
write:
 li a7, SYS_write
 56c:	48c1                	li	a7,16
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <close>:
.global close
close:
 li a7, SYS_close
 574:	48d5                	li	a7,21
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <kill>:
.global kill
kill:
 li a7, SYS_kill
 57c:	4899                	li	a7,6
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <exec>:
.global exec
exec:
 li a7, SYS_exec
 584:	489d                	li	a7,7
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <open>:
.global open
open:
 li a7, SYS_open
 58c:	48bd                	li	a7,15
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 594:	48c5                	li	a7,17
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 59c:	48c9                	li	a7,18
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5a4:	48a1                	li	a7,8
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <link>:
.global link
link:
 li a7, SYS_link
 5ac:	48cd                	li	a7,19
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5b4:	48d1                	li	a7,20
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5bc:	48a5                	li	a7,9
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5c4:	48a9                	li	a7,10
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5cc:	48ad                	li	a7,11
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5d4:	48b1                	li	a7,12
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5dc:	48b5                	li	a7,13
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5e4:	48b9                	li	a7,14
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5ec:	48d9                	li	a7,22
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f4:	1101                	addi	sp,sp,-32
 5f6:	ec06                	sd	ra,24(sp)
 5f8:	e822                	sd	s0,16(sp)
 5fa:	1000                	addi	s0,sp,32
 5fc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 600:	4605                	li	a2,1
 602:	fef40593          	addi	a1,s0,-17
 606:	00000097          	auipc	ra,0x0
 60a:	f66080e7          	jalr	-154(ra) # 56c <write>
}
 60e:	60e2                	ld	ra,24(sp)
 610:	6442                	ld	s0,16(sp)
 612:	6105                	addi	sp,sp,32
 614:	8082                	ret

0000000000000616 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 616:	7139                	addi	sp,sp,-64
 618:	fc06                	sd	ra,56(sp)
 61a:	f822                	sd	s0,48(sp)
 61c:	f426                	sd	s1,40(sp)
 61e:	f04a                	sd	s2,32(sp)
 620:	ec4e                	sd	s3,24(sp)
 622:	0080                	addi	s0,sp,64
 624:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 626:	c299                	beqz	a3,62c <printint+0x16>
 628:	0805c863          	bltz	a1,6b8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 62c:	2581                	sext.w	a1,a1
  neg = 0;
 62e:	4881                	li	a7,0
 630:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 634:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 636:	2601                	sext.w	a2,a2
 638:	00000517          	auipc	a0,0x0
 63c:	44850513          	addi	a0,a0,1096 # a80 <digits>
 640:	883a                	mv	a6,a4
 642:	2705                	addiw	a4,a4,1
 644:	02c5f7bb          	remuw	a5,a1,a2
 648:	1782                	slli	a5,a5,0x20
 64a:	9381                	srli	a5,a5,0x20
 64c:	97aa                	add	a5,a5,a0
 64e:	0007c783          	lbu	a5,0(a5)
 652:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 656:	0005879b          	sext.w	a5,a1
 65a:	02c5d5bb          	divuw	a1,a1,a2
 65e:	0685                	addi	a3,a3,1
 660:	fec7f0e3          	bgeu	a5,a2,640 <printint+0x2a>
  if(neg)
 664:	00088b63          	beqz	a7,67a <printint+0x64>
    buf[i++] = '-';
 668:	fd040793          	addi	a5,s0,-48
 66c:	973e                	add	a4,a4,a5
 66e:	02d00793          	li	a5,45
 672:	fef70823          	sb	a5,-16(a4)
 676:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 67a:	02e05863          	blez	a4,6aa <printint+0x94>
 67e:	fc040793          	addi	a5,s0,-64
 682:	00e78933          	add	s2,a5,a4
 686:	fff78993          	addi	s3,a5,-1
 68a:	99ba                	add	s3,s3,a4
 68c:	377d                	addiw	a4,a4,-1
 68e:	1702                	slli	a4,a4,0x20
 690:	9301                	srli	a4,a4,0x20
 692:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 696:	fff94583          	lbu	a1,-1(s2)
 69a:	8526                	mv	a0,s1
 69c:	00000097          	auipc	ra,0x0
 6a0:	f58080e7          	jalr	-168(ra) # 5f4 <putc>
  while(--i >= 0)
 6a4:	197d                	addi	s2,s2,-1
 6a6:	ff3918e3          	bne	s2,s3,696 <printint+0x80>
}
 6aa:	70e2                	ld	ra,56(sp)
 6ac:	7442                	ld	s0,48(sp)
 6ae:	74a2                	ld	s1,40(sp)
 6b0:	7902                	ld	s2,32(sp)
 6b2:	69e2                	ld	s3,24(sp)
 6b4:	6121                	addi	sp,sp,64
 6b6:	8082                	ret
    x = -xx;
 6b8:	40b005bb          	negw	a1,a1
    neg = 1;
 6bc:	4885                	li	a7,1
    x = -xx;
 6be:	bf8d                	j	630 <printint+0x1a>

00000000000006c0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6c0:	7119                	addi	sp,sp,-128
 6c2:	fc86                	sd	ra,120(sp)
 6c4:	f8a2                	sd	s0,112(sp)
 6c6:	f4a6                	sd	s1,104(sp)
 6c8:	f0ca                	sd	s2,96(sp)
 6ca:	ecce                	sd	s3,88(sp)
 6cc:	e8d2                	sd	s4,80(sp)
 6ce:	e4d6                	sd	s5,72(sp)
 6d0:	e0da                	sd	s6,64(sp)
 6d2:	fc5e                	sd	s7,56(sp)
 6d4:	f862                	sd	s8,48(sp)
 6d6:	f466                	sd	s9,40(sp)
 6d8:	f06a                	sd	s10,32(sp)
 6da:	ec6e                	sd	s11,24(sp)
 6dc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6de:	0005c903          	lbu	s2,0(a1)
 6e2:	18090f63          	beqz	s2,880 <vprintf+0x1c0>
 6e6:	8aaa                	mv	s5,a0
 6e8:	8b32                	mv	s6,a2
 6ea:	00158493          	addi	s1,a1,1
  state = 0;
 6ee:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6f0:	02500a13          	li	s4,37
      if(c == 'd'){
 6f4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6f8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6fc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 700:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 704:	00000b97          	auipc	s7,0x0
 708:	37cb8b93          	addi	s7,s7,892 # a80 <digits>
 70c:	a839                	j	72a <vprintf+0x6a>
        putc(fd, c);
 70e:	85ca                	mv	a1,s2
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	ee2080e7          	jalr	-286(ra) # 5f4 <putc>
 71a:	a019                	j	720 <vprintf+0x60>
    } else if(state == '%'){
 71c:	01498f63          	beq	s3,s4,73a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 720:	0485                	addi	s1,s1,1
 722:	fff4c903          	lbu	s2,-1(s1)
 726:	14090d63          	beqz	s2,880 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 72a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 72e:	fe0997e3          	bnez	s3,71c <vprintf+0x5c>
      if(c == '%'){
 732:	fd479ee3          	bne	a5,s4,70e <vprintf+0x4e>
        state = '%';
 736:	89be                	mv	s3,a5
 738:	b7e5                	j	720 <vprintf+0x60>
      if(c == 'd'){
 73a:	05878063          	beq	a5,s8,77a <vprintf+0xba>
      } else if(c == 'l') {
 73e:	05978c63          	beq	a5,s9,796 <vprintf+0xd6>
      } else if(c == 'x') {
 742:	07a78863          	beq	a5,s10,7b2 <vprintf+0xf2>
      } else if(c == 'p') {
 746:	09b78463          	beq	a5,s11,7ce <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 74a:	07300713          	li	a4,115
 74e:	0ce78663          	beq	a5,a4,81a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 752:	06300713          	li	a4,99
 756:	0ee78e63          	beq	a5,a4,852 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 75a:	11478863          	beq	a5,s4,86a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 75e:	85d2                	mv	a1,s4
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e92080e7          	jalr	-366(ra) # 5f4 <putc>
        putc(fd, c);
 76a:	85ca                	mv	a1,s2
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	e86080e7          	jalr	-378(ra) # 5f4 <putc>
      }
      state = 0;
 776:	4981                	li	s3,0
 778:	b765                	j	720 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 77a:	008b0913          	addi	s2,s6,8
 77e:	4685                	li	a3,1
 780:	4629                	li	a2,10
 782:	000b2583          	lw	a1,0(s6)
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	e8e080e7          	jalr	-370(ra) # 616 <printint>
 790:	8b4a                	mv	s6,s2
      state = 0;
 792:	4981                	li	s3,0
 794:	b771                	j	720 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 796:	008b0913          	addi	s2,s6,8
 79a:	4681                	li	a3,0
 79c:	4629                	li	a2,10
 79e:	000b2583          	lw	a1,0(s6)
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	e72080e7          	jalr	-398(ra) # 616 <printint>
 7ac:	8b4a                	mv	s6,s2
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	bf85                	j	720 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 7b2:	008b0913          	addi	s2,s6,8
 7b6:	4681                	li	a3,0
 7b8:	4641                	li	a2,16
 7ba:	000b2583          	lw	a1,0(s6)
 7be:	8556                	mv	a0,s5
 7c0:	00000097          	auipc	ra,0x0
 7c4:	e56080e7          	jalr	-426(ra) # 616 <printint>
 7c8:	8b4a                	mv	s6,s2
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	bf91                	j	720 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7ce:	008b0793          	addi	a5,s6,8
 7d2:	f8f43423          	sd	a5,-120(s0)
 7d6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7da:	03000593          	li	a1,48
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e14080e7          	jalr	-492(ra) # 5f4 <putc>
  putc(fd, 'x');
 7e8:	85ea                	mv	a1,s10
 7ea:	8556                	mv	a0,s5
 7ec:	00000097          	auipc	ra,0x0
 7f0:	e08080e7          	jalr	-504(ra) # 5f4 <putc>
 7f4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7f6:	03c9d793          	srli	a5,s3,0x3c
 7fa:	97de                	add	a5,a5,s7
 7fc:	0007c583          	lbu	a1,0(a5)
 800:	8556                	mv	a0,s5
 802:	00000097          	auipc	ra,0x0
 806:	df2080e7          	jalr	-526(ra) # 5f4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 80a:	0992                	slli	s3,s3,0x4
 80c:	397d                	addiw	s2,s2,-1
 80e:	fe0914e3          	bnez	s2,7f6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 812:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 816:	4981                	li	s3,0
 818:	b721                	j	720 <vprintf+0x60>
        s = va_arg(ap, char*);
 81a:	008b0993          	addi	s3,s6,8
 81e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 822:	02090163          	beqz	s2,844 <vprintf+0x184>
        while(*s != 0){
 826:	00094583          	lbu	a1,0(s2)
 82a:	c9a1                	beqz	a1,87a <vprintf+0x1ba>
          putc(fd, *s);
 82c:	8556                	mv	a0,s5
 82e:	00000097          	auipc	ra,0x0
 832:	dc6080e7          	jalr	-570(ra) # 5f4 <putc>
          s++;
 836:	0905                	addi	s2,s2,1
        while(*s != 0){
 838:	00094583          	lbu	a1,0(s2)
 83c:	f9e5                	bnez	a1,82c <vprintf+0x16c>
        s = va_arg(ap, char*);
 83e:	8b4e                	mv	s6,s3
      state = 0;
 840:	4981                	li	s3,0
 842:	bdf9                	j	720 <vprintf+0x60>
          s = "(null)";
 844:	00000917          	auipc	s2,0x0
 848:	23490913          	addi	s2,s2,564 # a78 <malloc+0xee>
        while(*s != 0){
 84c:	02800593          	li	a1,40
 850:	bff1                	j	82c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 852:	008b0913          	addi	s2,s6,8
 856:	000b4583          	lbu	a1,0(s6)
 85a:	8556                	mv	a0,s5
 85c:	00000097          	auipc	ra,0x0
 860:	d98080e7          	jalr	-616(ra) # 5f4 <putc>
 864:	8b4a                	mv	s6,s2
      state = 0;
 866:	4981                	li	s3,0
 868:	bd65                	j	720 <vprintf+0x60>
        putc(fd, c);
 86a:	85d2                	mv	a1,s4
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	d86080e7          	jalr	-634(ra) # 5f4 <putc>
      state = 0;
 876:	4981                	li	s3,0
 878:	b565                	j	720 <vprintf+0x60>
        s = va_arg(ap, char*);
 87a:	8b4e                	mv	s6,s3
      state = 0;
 87c:	4981                	li	s3,0
 87e:	b54d                	j	720 <vprintf+0x60>
    }
  }
}
 880:	70e6                	ld	ra,120(sp)
 882:	7446                	ld	s0,112(sp)
 884:	74a6                	ld	s1,104(sp)
 886:	7906                	ld	s2,96(sp)
 888:	69e6                	ld	s3,88(sp)
 88a:	6a46                	ld	s4,80(sp)
 88c:	6aa6                	ld	s5,72(sp)
 88e:	6b06                	ld	s6,64(sp)
 890:	7be2                	ld	s7,56(sp)
 892:	7c42                	ld	s8,48(sp)
 894:	7ca2                	ld	s9,40(sp)
 896:	7d02                	ld	s10,32(sp)
 898:	6de2                	ld	s11,24(sp)
 89a:	6109                	addi	sp,sp,128
 89c:	8082                	ret

000000000000089e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 89e:	715d                	addi	sp,sp,-80
 8a0:	ec06                	sd	ra,24(sp)
 8a2:	e822                	sd	s0,16(sp)
 8a4:	1000                	addi	s0,sp,32
 8a6:	e010                	sd	a2,0(s0)
 8a8:	e414                	sd	a3,8(s0)
 8aa:	e818                	sd	a4,16(s0)
 8ac:	ec1c                	sd	a5,24(s0)
 8ae:	03043023          	sd	a6,32(s0)
 8b2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8b6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ba:	8622                	mv	a2,s0
 8bc:	00000097          	auipc	ra,0x0
 8c0:	e04080e7          	jalr	-508(ra) # 6c0 <vprintf>
}
 8c4:	60e2                	ld	ra,24(sp)
 8c6:	6442                	ld	s0,16(sp)
 8c8:	6161                	addi	sp,sp,80
 8ca:	8082                	ret

00000000000008cc <printf>:

void
printf(const char *fmt, ...)
{
 8cc:	711d                	addi	sp,sp,-96
 8ce:	ec06                	sd	ra,24(sp)
 8d0:	e822                	sd	s0,16(sp)
 8d2:	1000                	addi	s0,sp,32
 8d4:	e40c                	sd	a1,8(s0)
 8d6:	e810                	sd	a2,16(s0)
 8d8:	ec14                	sd	a3,24(s0)
 8da:	f018                	sd	a4,32(s0)
 8dc:	f41c                	sd	a5,40(s0)
 8de:	03043823          	sd	a6,48(s0)
 8e2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8e6:	00840613          	addi	a2,s0,8
 8ea:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ee:	85aa                	mv	a1,a0
 8f0:	4505                	li	a0,1
 8f2:	00000097          	auipc	ra,0x0
 8f6:	dce080e7          	jalr	-562(ra) # 6c0 <vprintf>
}
 8fa:	60e2                	ld	ra,24(sp)
 8fc:	6442                	ld	s0,16(sp)
 8fe:	6125                	addi	sp,sp,96
 900:	8082                	ret

0000000000000902 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 902:	1141                	addi	sp,sp,-16
 904:	e422                	sd	s0,8(sp)
 906:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 908:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90c:	00000797          	auipc	a5,0x0
 910:	1947b783          	ld	a5,404(a5) # aa0 <freep>
 914:	a805                	j	944 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 916:	4618                	lw	a4,8(a2)
 918:	9db9                	addw	a1,a1,a4
 91a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 91e:	6398                	ld	a4,0(a5)
 920:	6318                	ld	a4,0(a4)
 922:	fee53823          	sd	a4,-16(a0)
 926:	a091                	j	96a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 928:	ff852703          	lw	a4,-8(a0)
 92c:	9e39                	addw	a2,a2,a4
 92e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 930:	ff053703          	ld	a4,-16(a0)
 934:	e398                	sd	a4,0(a5)
 936:	a099                	j	97c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 938:	6398                	ld	a4,0(a5)
 93a:	00e7e463          	bltu	a5,a4,942 <free+0x40>
 93e:	00e6ea63          	bltu	a3,a4,952 <free+0x50>
{
 942:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 944:	fed7fae3          	bgeu	a5,a3,938 <free+0x36>
 948:	6398                	ld	a4,0(a5)
 94a:	00e6e463          	bltu	a3,a4,952 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 94e:	fee7eae3          	bltu	a5,a4,942 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 952:	ff852583          	lw	a1,-8(a0)
 956:	6390                	ld	a2,0(a5)
 958:	02059813          	slli	a6,a1,0x20
 95c:	01c85713          	srli	a4,a6,0x1c
 960:	9736                	add	a4,a4,a3
 962:	fae60ae3          	beq	a2,a4,916 <free+0x14>
    bp->s.ptr = p->s.ptr;
 966:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 96a:	4790                	lw	a2,8(a5)
 96c:	02061593          	slli	a1,a2,0x20
 970:	01c5d713          	srli	a4,a1,0x1c
 974:	973e                	add	a4,a4,a5
 976:	fae689e3          	beq	a3,a4,928 <free+0x26>
  } else
    p->s.ptr = bp;
 97a:	e394                	sd	a3,0(a5)
  freep = p;
 97c:	00000717          	auipc	a4,0x0
 980:	12f73223          	sd	a5,292(a4) # aa0 <freep>
}
 984:	6422                	ld	s0,8(sp)
 986:	0141                	addi	sp,sp,16
 988:	8082                	ret

000000000000098a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 98a:	7139                	addi	sp,sp,-64
 98c:	fc06                	sd	ra,56(sp)
 98e:	f822                	sd	s0,48(sp)
 990:	f426                	sd	s1,40(sp)
 992:	f04a                	sd	s2,32(sp)
 994:	ec4e                	sd	s3,24(sp)
 996:	e852                	sd	s4,16(sp)
 998:	e456                	sd	s5,8(sp)
 99a:	e05a                	sd	s6,0(sp)
 99c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99e:	02051493          	slli	s1,a0,0x20
 9a2:	9081                	srli	s1,s1,0x20
 9a4:	04bd                	addi	s1,s1,15
 9a6:	8091                	srli	s1,s1,0x4
 9a8:	0014899b          	addiw	s3,s1,1
 9ac:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9ae:	00000517          	auipc	a0,0x0
 9b2:	0f253503          	ld	a0,242(a0) # aa0 <freep>
 9b6:	c515                	beqz	a0,9e2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ba:	4798                	lw	a4,8(a5)
 9bc:	02977f63          	bgeu	a4,s1,9fa <malloc+0x70>
 9c0:	8a4e                	mv	s4,s3
 9c2:	0009871b          	sext.w	a4,s3
 9c6:	6685                	lui	a3,0x1
 9c8:	00d77363          	bgeu	a4,a3,9ce <malloc+0x44>
 9cc:	6a05                	lui	s4,0x1
 9ce:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9d2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9d6:	00000917          	auipc	s2,0x0
 9da:	0ca90913          	addi	s2,s2,202 # aa0 <freep>
  if(p == (char*)-1)
 9de:	5afd                	li	s5,-1
 9e0:	a895                	j	a54 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9e2:	00000797          	auipc	a5,0x0
 9e6:	1b678793          	addi	a5,a5,438 # b98 <base>
 9ea:	00000717          	auipc	a4,0x0
 9ee:	0af73b23          	sd	a5,182(a4) # aa0 <freep>
 9f2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9f4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9f8:	b7e1                	j	9c0 <malloc+0x36>
      if(p->s.size == nunits)
 9fa:	02e48c63          	beq	s1,a4,a32 <malloc+0xa8>
        p->s.size -= nunits;
 9fe:	4137073b          	subw	a4,a4,s3
 a02:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a04:	02071693          	slli	a3,a4,0x20
 a08:	01c6d713          	srli	a4,a3,0x1c
 a0c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a0e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a12:	00000717          	auipc	a4,0x0
 a16:	08a73723          	sd	a0,142(a4) # aa0 <freep>
      return (void*)(p + 1);
 a1a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a1e:	70e2                	ld	ra,56(sp)
 a20:	7442                	ld	s0,48(sp)
 a22:	74a2                	ld	s1,40(sp)
 a24:	7902                	ld	s2,32(sp)
 a26:	69e2                	ld	s3,24(sp)
 a28:	6a42                	ld	s4,16(sp)
 a2a:	6aa2                	ld	s5,8(sp)
 a2c:	6b02                	ld	s6,0(sp)
 a2e:	6121                	addi	sp,sp,64
 a30:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a32:	6398                	ld	a4,0(a5)
 a34:	e118                	sd	a4,0(a0)
 a36:	bff1                	j	a12 <malloc+0x88>
  hp->s.size = nu;
 a38:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a3c:	0541                	addi	a0,a0,16
 a3e:	00000097          	auipc	ra,0x0
 a42:	ec4080e7          	jalr	-316(ra) # 902 <free>
  return freep;
 a46:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a4a:	d971                	beqz	a0,a1e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a4c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a4e:	4798                	lw	a4,8(a5)
 a50:	fa9775e3          	bgeu	a4,s1,9fa <malloc+0x70>
    if(p == freep)
 a54:	00093703          	ld	a4,0(s2)
 a58:	853e                	mv	a0,a5
 a5a:	fef719e3          	bne	a4,a5,a4c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a5e:	8552                	mv	a0,s4
 a60:	00000097          	auipc	ra,0x0
 a64:	b74080e7          	jalr	-1164(ra) # 5d4 <sbrk>
  if(p == (char*)-1)
 a68:	fd5518e3          	bne	a0,s5,a38 <malloc+0xae>
        return 0;
 a6c:	4501                	li	a0,0
 a6e:	bf45                	j	a1e <malloc+0x94>
