
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	addi	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	0880                	addi	s0,sp,80
 130:	89aa                	mv	s3,a0
 132:	8b2e                	mv	s6,a1
  m = 0;
 134:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 136:	3ff00b93          	li	s7,1023
 13a:	00001a97          	auipc	s5,0x1
 13e:	b86a8a93          	addi	s5,s5,-1146 # cc0 <buf>
 142:	a0a1                	j	18a <grep+0x70>
      p = q+1;
 144:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 148:	45a9                	li	a1,10
 14a:	854a                	mv	a0,s2
 14c:	00000097          	auipc	ra,0x0
 150:	410080e7          	jalr	1040(ra) # 55c <strchr>
 154:	84aa                	mv	s1,a0
 156:	c905                	beqz	a0,186 <grep+0x6c>
      *q = 0;
 158:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15c:	85ca                	mv	a1,s2
 15e:	854e                	mv	a0,s3
 160:	00000097          	auipc	ra,0x0
 164:	f6c080e7          	jalr	-148(ra) # cc <match>
 168:	dd71                	beqz	a0,144 <grep+0x2a>
        *q = '\n';
 16a:	47a9                	li	a5,10
 16c:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 170:	00148613          	addi	a2,s1,1
 174:	4126063b          	subw	a2,a2,s2
 178:	85ca                	mv	a1,s2
 17a:	4505                	li	a0,1
 17c:	00000097          	auipc	ra,0x0
 180:	5da080e7          	jalr	1498(ra) # 756 <write>
 184:	b7c1                	j	144 <grep+0x2a>
    if(m > 0){
 186:	03404563          	bgtz	s4,1b0 <grep+0x96>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18a:	414b863b          	subw	a2,s7,s4
 18e:	014a85b3          	add	a1,s5,s4
 192:	855a                	mv	a0,s6
 194:	00000097          	auipc	ra,0x0
 198:	5ba080e7          	jalr	1466(ra) # 74e <read>
 19c:	02a05663          	blez	a0,1c8 <grep+0xae>
    m += n;
 1a0:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1a4:	014a87b3          	add	a5,s5,s4
 1a8:	00078023          	sb	zero,0(a5)
    p = buf;
 1ac:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1ae:	bf69                	j	148 <grep+0x2e>
      m -= p - buf;
 1b0:	415907b3          	sub	a5,s2,s5
 1b4:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1b8:	8652                	mv	a2,s4
 1ba:	85ca                	mv	a1,s2
 1bc:	8556                	mv	a0,s5
 1be:	00000097          	auipc	ra,0x0
 1c2:	4c6080e7          	jalr	1222(ra) # 684 <memmove>
 1c6:	b7d1                	j	18a <grep+0x70>
}
 1c8:	60a6                	ld	ra,72(sp)
 1ca:	6406                	ld	s0,64(sp)
 1cc:	74e2                	ld	s1,56(sp)
 1ce:	7942                	ld	s2,48(sp)
 1d0:	79a2                	ld	s3,40(sp)
 1d2:	7a02                	ld	s4,32(sp)
 1d4:	6ae2                	ld	s5,24(sp)
 1d6:	6b42                	ld	s6,16(sp)
 1d8:	6ba2                	ld	s7,8(sp)
 1da:	6161                	addi	sp,sp,80
 1dc:	8082                	ret

00000000000001de <main>:
{
 1de:	7139                	addi	sp,sp,-64
 1e0:	fc06                	sd	ra,56(sp)
 1e2:	f822                	sd	s0,48(sp)
 1e4:	f426                	sd	s1,40(sp)
 1e6:	f04a                	sd	s2,32(sp)
 1e8:	ec4e                	sd	s3,24(sp)
 1ea:	e852                	sd	s4,16(sp)
 1ec:	e456                	sd	s5,8(sp)
 1ee:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1f0:	4785                	li	a5,1
 1f2:	04a7de63          	bge	a5,a0,24e <main+0x70>
  pattern = argv[1];
 1f6:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1fa:	4789                	li	a5,2
 1fc:	06a7d763          	bge	a5,a0,26a <main+0x8c>
 200:	01058913          	addi	s2,a1,16
 204:	ffd5099b          	addiw	s3,a0,-3
 208:	02099793          	slli	a5,s3,0x20
 20c:	01d7d993          	srli	s3,a5,0x1d
 210:	05e1                	addi	a1,a1,24
 212:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 214:	4581                	li	a1,0
 216:	00093503          	ld	a0,0(s2)
 21a:	00000097          	auipc	ra,0x0
 21e:	55c080e7          	jalr	1372(ra) # 776 <open>
 222:	84aa                	mv	s1,a0
 224:	04054e63          	bltz	a0,280 <main+0xa2>
    grep(pattern, fd);
 228:	85aa                	mv	a1,a0
 22a:	8552                	mv	a0,s4
 22c:	00000097          	auipc	ra,0x0
 230:	eee080e7          	jalr	-274(ra) # 11a <grep>
    close(fd);
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	528080e7          	jalr	1320(ra) # 75e <close>
  for(i = 2; i < argc; i++){
 23e:	0921                	addi	s2,s2,8
 240:	fd391ae3          	bne	s2,s3,214 <main+0x36>
  exit(0);
 244:	4501                	li	a0,0
 246:	00000097          	auipc	ra,0x0
 24a:	4f0080e7          	jalr	1264(ra) # 736 <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 24e:	00001597          	auipc	a1,0x1
 252:	a1258593          	addi	a1,a1,-1518 # c60 <malloc+0xec>
 256:	4509                	li	a0,2
 258:	00001097          	auipc	ra,0x1
 25c:	830080e7          	jalr	-2000(ra) # a88 <fprintf>
    exit(1);
 260:	4505                	li	a0,1
 262:	00000097          	auipc	ra,0x0
 266:	4d4080e7          	jalr	1236(ra) # 736 <exit>
    grep(pattern, 0);
 26a:	4581                	li	a1,0
 26c:	8552                	mv	a0,s4
 26e:	00000097          	auipc	ra,0x0
 272:	eac080e7          	jalr	-340(ra) # 11a <grep>
    exit(0);
 276:	4501                	li	a0,0
 278:	00000097          	auipc	ra,0x0
 27c:	4be080e7          	jalr	1214(ra) # 736 <exit>
      printf("grep: cannot open %s\n", argv[i]);
 280:	00093583          	ld	a1,0(s2)
 284:	00001517          	auipc	a0,0x1
 288:	9fc50513          	addi	a0,a0,-1540 # c80 <malloc+0x10c>
 28c:	00001097          	auipc	ra,0x1
 290:	82a080e7          	jalr	-2006(ra) # ab6 <printf>
      exit(1);
 294:	4505                	li	a0,1
 296:	00000097          	auipc	ra,0x0
 29a:	4a0080e7          	jalr	1184(ra) # 736 <exit>

000000000000029e <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 2a4:	0f50000f          	fence	iorw,ow
 2a8:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 2ac:	6422                	ld	s0,8(sp)
 2ae:	0141                	addi	sp,sp,16
 2b0:	8082                	ret

00000000000002b2 <load>:

int load(uint64 *p) {
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 2b8:	0ff0000f          	fence
 2bc:	6108                	ld	a0,0(a0)
 2be:	0ff0000f          	fence
}
 2c2:	2501                	sext.w	a0,a0
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 2ca:	7179                	addi	sp,sp,-48
 2cc:	f406                	sd	ra,40(sp)
 2ce:	f022                	sd	s0,32(sp)
 2d0:	ec26                	sd	s1,24(sp)
 2d2:	e84a                	sd	s2,16(sp)
 2d4:	e44e                	sd	s3,8(sp)
 2d6:	e052                	sd	s4,0(sp)
 2d8:	1800                	addi	s0,sp,48
 2da:	8a2a                	mv	s4,a0
 2dc:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 2de:	4785                	li	a5,1
 2e0:	00001497          	auipc	s1,0x1
 2e4:	df048493          	addi	s1,s1,-528 # 10d0 <rings+0x10>
 2e8:	00001917          	auipc	s2,0x1
 2ec:	ed890913          	addi	s2,s2,-296 # 11c0 <__BSS_END__>
 2f0:	04f59563          	bne	a1,a5,33a <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 2f4:	00001497          	auipc	s1,0x1
 2f8:	ddc4a483          	lw	s1,-548(s1) # 10d0 <rings+0x10>
 2fc:	c099                	beqz	s1,302 <create_or_close_the_buffer_user+0x38>
 2fe:	4481                	li	s1,0
 300:	a899                	j	356 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 302:	00001917          	auipc	s2,0x1
 306:	dbe90913          	addi	s2,s2,-578 # 10c0 <rings>
 30a:	00093603          	ld	a2,0(s2)
 30e:	4585                	li	a1,1
 310:	00000097          	auipc	ra,0x0
 314:	4c6080e7          	jalr	1222(ra) # 7d6 <ringbuf>
        rings[i].book->write_done = 0;
 318:	00893783          	ld	a5,8(s2)
 31c:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 320:	00893783          	ld	a5,8(s2)
 324:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 328:	01092783          	lw	a5,16(s2)
 32c:	2785                	addiw	a5,a5,1
 32e:	00f92823          	sw	a5,16(s2)
        break;
 332:	a015                	j	356 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 334:	04e1                	addi	s1,s1,24
 336:	01248f63          	beq	s1,s2,354 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 33a:	409c                	lw	a5,0(s1)
 33c:	dfe5                	beqz	a5,334 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 33e:	ff04b603          	ld	a2,-16(s1)
 342:	85ce                	mv	a1,s3
 344:	8552                	mv	a0,s4
 346:	00000097          	auipc	ra,0x0
 34a:	490080e7          	jalr	1168(ra) # 7d6 <ringbuf>
        rings[i].exists = 0;
 34e:	0004a023          	sw	zero,0(s1)
 352:	b7cd                	j	334 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 354:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 356:	8526                	mv	a0,s1
 358:	70a2                	ld	ra,40(sp)
 35a:	7402                	ld	s0,32(sp)
 35c:	64e2                	ld	s1,24(sp)
 35e:	6942                	ld	s2,16(sp)
 360:	69a2                	ld	s3,8(sp)
 362:	6a02                	ld	s4,0(sp)
 364:	6145                	addi	sp,sp,48
 366:	8082                	ret

0000000000000368 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 368:	1101                	addi	sp,sp,-32
 36a:	ec06                	sd	ra,24(sp)
 36c:	e822                	sd	s0,16(sp)
 36e:	e426                	sd	s1,8(sp)
 370:	1000                	addi	s0,sp,32
 372:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 374:	00151793          	slli	a5,a0,0x1
 378:	97aa                	add	a5,a5,a0
 37a:	078e                	slli	a5,a5,0x3
 37c:	00001717          	auipc	a4,0x1
 380:	d4470713          	addi	a4,a4,-700 # 10c0 <rings>
 384:	97ba                	add	a5,a5,a4
 386:	639c                	ld	a5,0(a5)
 388:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 38a:	421c                	lw	a5,0(a2)
 38c:	e785                	bnez	a5,3b4 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 38e:	86ba                	mv	a3,a4
 390:	671c                	ld	a5,8(a4)
 392:	6398                	ld	a4,0(a5)
 394:	67c1                	lui	a5,0x10
 396:	9fb9                	addw	a5,a5,a4
 398:	00151713          	slli	a4,a0,0x1
 39c:	953a                	add	a0,a0,a4
 39e:	050e                	slli	a0,a0,0x3
 3a0:	9536                	add	a0,a0,a3
 3a2:	6518                	ld	a4,8(a0)
 3a4:	6718                	ld	a4,8(a4)
 3a6:	9f99                	subw	a5,a5,a4
 3a8:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 3aa:	60e2                	ld	ra,24(sp)
 3ac:	6442                	ld	s0,16(sp)
 3ae:	64a2                	ld	s1,8(sp)
 3b0:	6105                	addi	sp,sp,32
 3b2:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 3b4:	00151793          	slli	a5,a0,0x1
 3b8:	953e                	add	a0,a0,a5
 3ba:	050e                	slli	a0,a0,0x3
 3bc:	00001797          	auipc	a5,0x1
 3c0:	d0478793          	addi	a5,a5,-764 # 10c0 <rings>
 3c4:	953e                	add	a0,a0,a5
 3c6:	6508                	ld	a0,8(a0)
 3c8:	0521                	addi	a0,a0,8
 3ca:	00000097          	auipc	ra,0x0
 3ce:	ee8080e7          	jalr	-280(ra) # 2b2 <load>
 3d2:	c088                	sw	a0,0(s1)
}
 3d4:	bfd9                	j	3aa <ringbuf_start_write+0x42>

00000000000003d6 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e406                	sd	ra,8(sp)
 3da:	e022                	sd	s0,0(sp)
 3dc:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 3de:	00151793          	slli	a5,a0,0x1
 3e2:	97aa                	add	a5,a5,a0
 3e4:	078e                	slli	a5,a5,0x3
 3e6:	00001517          	auipc	a0,0x1
 3ea:	cda50513          	addi	a0,a0,-806 # 10c0 <rings>
 3ee:	97aa                	add	a5,a5,a0
 3f0:	6788                	ld	a0,8(a5)
 3f2:	0035959b          	slliw	a1,a1,0x3
 3f6:	0521                	addi	a0,a0,8
 3f8:	00000097          	auipc	ra,0x0
 3fc:	ea6080e7          	jalr	-346(ra) # 29e <store>
}
 400:	60a2                	ld	ra,8(sp)
 402:	6402                	ld	s0,0(sp)
 404:	0141                	addi	sp,sp,16
 406:	8082                	ret

0000000000000408 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 408:	1101                	addi	sp,sp,-32
 40a:	ec06                	sd	ra,24(sp)
 40c:	e822                	sd	s0,16(sp)
 40e:	e426                	sd	s1,8(sp)
 410:	1000                	addi	s0,sp,32
 412:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 414:	00151793          	slli	a5,a0,0x1
 418:	97aa                	add	a5,a5,a0
 41a:	078e                	slli	a5,a5,0x3
 41c:	00001517          	auipc	a0,0x1
 420:	ca450513          	addi	a0,a0,-860 # 10c0 <rings>
 424:	97aa                	add	a5,a5,a0
 426:	6788                	ld	a0,8(a5)
 428:	0521                	addi	a0,a0,8
 42a:	00000097          	auipc	ra,0x0
 42e:	e88080e7          	jalr	-376(ra) # 2b2 <load>
 432:	c088                	sw	a0,0(s1)
}
 434:	60e2                	ld	ra,24(sp)
 436:	6442                	ld	s0,16(sp)
 438:	64a2                	ld	s1,8(sp)
 43a:	6105                	addi	sp,sp,32
 43c:	8082                	ret

000000000000043e <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 43e:	1101                	addi	sp,sp,-32
 440:	ec06                	sd	ra,24(sp)
 442:	e822                	sd	s0,16(sp)
 444:	e426                	sd	s1,8(sp)
 446:	1000                	addi	s0,sp,32
 448:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 44a:	00151793          	slli	a5,a0,0x1
 44e:	97aa                	add	a5,a5,a0
 450:	078e                	slli	a5,a5,0x3
 452:	00001517          	auipc	a0,0x1
 456:	c6e50513          	addi	a0,a0,-914 # 10c0 <rings>
 45a:	97aa                	add	a5,a5,a0
 45c:	6788                	ld	a0,8(a5)
 45e:	611c                	ld	a5,0(a0)
 460:	ef99                	bnez	a5,47e <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 462:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 464:	41f7579b          	sraiw	a5,a4,0x1f
 468:	01d7d79b          	srliw	a5,a5,0x1d
 46c:	9fb9                	addw	a5,a5,a4
 46e:	4037d79b          	sraiw	a5,a5,0x3
 472:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 474:	60e2                	ld	ra,24(sp)
 476:	6442                	ld	s0,16(sp)
 478:	64a2                	ld	s1,8(sp)
 47a:	6105                	addi	sp,sp,32
 47c:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 47e:	00000097          	auipc	ra,0x0
 482:	e34080e7          	jalr	-460(ra) # 2b2 <load>
    *bytes /= 8;
 486:	41f5579b          	sraiw	a5,a0,0x1f
 48a:	01d7d79b          	srliw	a5,a5,0x1d
 48e:	9d3d                	addw	a0,a0,a5
 490:	4035551b          	sraiw	a0,a0,0x3
 494:	c088                	sw	a0,0(s1)
}
 496:	bff9                	j	474 <ringbuf_start_read+0x36>

0000000000000498 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 498:	1141                	addi	sp,sp,-16
 49a:	e406                	sd	ra,8(sp)
 49c:	e022                	sd	s0,0(sp)
 49e:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 4a0:	00151793          	slli	a5,a0,0x1
 4a4:	97aa                	add	a5,a5,a0
 4a6:	078e                	slli	a5,a5,0x3
 4a8:	00001517          	auipc	a0,0x1
 4ac:	c1850513          	addi	a0,a0,-1000 # 10c0 <rings>
 4b0:	97aa                	add	a5,a5,a0
 4b2:	0035959b          	slliw	a1,a1,0x3
 4b6:	6788                	ld	a0,8(a5)
 4b8:	00000097          	auipc	ra,0x0
 4bc:	de6080e7          	jalr	-538(ra) # 29e <store>
}
 4c0:	60a2                	ld	ra,8(sp)
 4c2:	6402                	ld	s0,0(sp)
 4c4:	0141                	addi	sp,sp,16
 4c6:	8082                	ret

00000000000004c8 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e422                	sd	s0,8(sp)
 4cc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4ce:	87aa                	mv	a5,a0
 4d0:	0585                	addi	a1,a1,1
 4d2:	0785                	addi	a5,a5,1
 4d4:	fff5c703          	lbu	a4,-1(a1)
 4d8:	fee78fa3          	sb	a4,-1(a5)
 4dc:	fb75                	bnez	a4,4d0 <strcpy+0x8>
    ;
  return os;
}
 4de:	6422                	ld	s0,8(sp)
 4e0:	0141                	addi	sp,sp,16
 4e2:	8082                	ret

00000000000004e4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4e4:	1141                	addi	sp,sp,-16
 4e6:	e422                	sd	s0,8(sp)
 4e8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 4ea:	00054783          	lbu	a5,0(a0)
 4ee:	cb91                	beqz	a5,502 <strcmp+0x1e>
 4f0:	0005c703          	lbu	a4,0(a1)
 4f4:	00f71763          	bne	a4,a5,502 <strcmp+0x1e>
    p++, q++;
 4f8:	0505                	addi	a0,a0,1
 4fa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 4fc:	00054783          	lbu	a5,0(a0)
 500:	fbe5                	bnez	a5,4f0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 502:	0005c503          	lbu	a0,0(a1)
}
 506:	40a7853b          	subw	a0,a5,a0
 50a:	6422                	ld	s0,8(sp)
 50c:	0141                	addi	sp,sp,16
 50e:	8082                	ret

0000000000000510 <strlen>:

uint
strlen(const char *s)
{
 510:	1141                	addi	sp,sp,-16
 512:	e422                	sd	s0,8(sp)
 514:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 516:	00054783          	lbu	a5,0(a0)
 51a:	cf91                	beqz	a5,536 <strlen+0x26>
 51c:	0505                	addi	a0,a0,1
 51e:	87aa                	mv	a5,a0
 520:	4685                	li	a3,1
 522:	9e89                	subw	a3,a3,a0
 524:	00f6853b          	addw	a0,a3,a5
 528:	0785                	addi	a5,a5,1
 52a:	fff7c703          	lbu	a4,-1(a5)
 52e:	fb7d                	bnez	a4,524 <strlen+0x14>
    ;
  return n;
}
 530:	6422                	ld	s0,8(sp)
 532:	0141                	addi	sp,sp,16
 534:	8082                	ret
  for(n = 0; s[n]; n++)
 536:	4501                	li	a0,0
 538:	bfe5                	j	530 <strlen+0x20>

000000000000053a <memset>:

void*
memset(void *dst, int c, uint n)
{
 53a:	1141                	addi	sp,sp,-16
 53c:	e422                	sd	s0,8(sp)
 53e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 540:	ca19                	beqz	a2,556 <memset+0x1c>
 542:	87aa                	mv	a5,a0
 544:	1602                	slli	a2,a2,0x20
 546:	9201                	srli	a2,a2,0x20
 548:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 54c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 550:	0785                	addi	a5,a5,1
 552:	fee79de3          	bne	a5,a4,54c <memset+0x12>
  }
  return dst;
}
 556:	6422                	ld	s0,8(sp)
 558:	0141                	addi	sp,sp,16
 55a:	8082                	ret

000000000000055c <strchr>:

char*
strchr(const char *s, char c)
{
 55c:	1141                	addi	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	addi	s0,sp,16
  for(; *s; s++)
 562:	00054783          	lbu	a5,0(a0)
 566:	cb99                	beqz	a5,57c <strchr+0x20>
    if(*s == c)
 568:	00f58763          	beq	a1,a5,576 <strchr+0x1a>
  for(; *s; s++)
 56c:	0505                	addi	a0,a0,1
 56e:	00054783          	lbu	a5,0(a0)
 572:	fbfd                	bnez	a5,568 <strchr+0xc>
      return (char*)s;
  return 0;
 574:	4501                	li	a0,0
}
 576:	6422                	ld	s0,8(sp)
 578:	0141                	addi	sp,sp,16
 57a:	8082                	ret
  return 0;
 57c:	4501                	li	a0,0
 57e:	bfe5                	j	576 <strchr+0x1a>

0000000000000580 <gets>:

char*
gets(char *buf, int max)
{
 580:	711d                	addi	sp,sp,-96
 582:	ec86                	sd	ra,88(sp)
 584:	e8a2                	sd	s0,80(sp)
 586:	e4a6                	sd	s1,72(sp)
 588:	e0ca                	sd	s2,64(sp)
 58a:	fc4e                	sd	s3,56(sp)
 58c:	f852                	sd	s4,48(sp)
 58e:	f456                	sd	s5,40(sp)
 590:	f05a                	sd	s6,32(sp)
 592:	ec5e                	sd	s7,24(sp)
 594:	1080                	addi	s0,sp,96
 596:	8baa                	mv	s7,a0
 598:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 59a:	892a                	mv	s2,a0
 59c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 59e:	4aa9                	li	s5,10
 5a0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 5a2:	89a6                	mv	s3,s1
 5a4:	2485                	addiw	s1,s1,1
 5a6:	0344d863          	bge	s1,s4,5d6 <gets+0x56>
    cc = read(0, &c, 1);
 5aa:	4605                	li	a2,1
 5ac:	faf40593          	addi	a1,s0,-81
 5b0:	4501                	li	a0,0
 5b2:	00000097          	auipc	ra,0x0
 5b6:	19c080e7          	jalr	412(ra) # 74e <read>
    if(cc < 1)
 5ba:	00a05e63          	blez	a0,5d6 <gets+0x56>
    buf[i++] = c;
 5be:	faf44783          	lbu	a5,-81(s0)
 5c2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 5c6:	01578763          	beq	a5,s5,5d4 <gets+0x54>
 5ca:	0905                	addi	s2,s2,1
 5cc:	fd679be3          	bne	a5,s6,5a2 <gets+0x22>
  for(i=0; i+1 < max; ){
 5d0:	89a6                	mv	s3,s1
 5d2:	a011                	j	5d6 <gets+0x56>
 5d4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 5d6:	99de                	add	s3,s3,s7
 5d8:	00098023          	sb	zero,0(s3)
  return buf;
}
 5dc:	855e                	mv	a0,s7
 5de:	60e6                	ld	ra,88(sp)
 5e0:	6446                	ld	s0,80(sp)
 5e2:	64a6                	ld	s1,72(sp)
 5e4:	6906                	ld	s2,64(sp)
 5e6:	79e2                	ld	s3,56(sp)
 5e8:	7a42                	ld	s4,48(sp)
 5ea:	7aa2                	ld	s5,40(sp)
 5ec:	7b02                	ld	s6,32(sp)
 5ee:	6be2                	ld	s7,24(sp)
 5f0:	6125                	addi	sp,sp,96
 5f2:	8082                	ret

00000000000005f4 <stat>:

int
stat(const char *n, struct stat *st)
{
 5f4:	1101                	addi	sp,sp,-32
 5f6:	ec06                	sd	ra,24(sp)
 5f8:	e822                	sd	s0,16(sp)
 5fa:	e426                	sd	s1,8(sp)
 5fc:	e04a                	sd	s2,0(sp)
 5fe:	1000                	addi	s0,sp,32
 600:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 602:	4581                	li	a1,0
 604:	00000097          	auipc	ra,0x0
 608:	172080e7          	jalr	370(ra) # 776 <open>
  if(fd < 0)
 60c:	02054563          	bltz	a0,636 <stat+0x42>
 610:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 612:	85ca                	mv	a1,s2
 614:	00000097          	auipc	ra,0x0
 618:	17a080e7          	jalr	378(ra) # 78e <fstat>
 61c:	892a                	mv	s2,a0
  close(fd);
 61e:	8526                	mv	a0,s1
 620:	00000097          	auipc	ra,0x0
 624:	13e080e7          	jalr	318(ra) # 75e <close>
  return r;
}
 628:	854a                	mv	a0,s2
 62a:	60e2                	ld	ra,24(sp)
 62c:	6442                	ld	s0,16(sp)
 62e:	64a2                	ld	s1,8(sp)
 630:	6902                	ld	s2,0(sp)
 632:	6105                	addi	sp,sp,32
 634:	8082                	ret
    return -1;
 636:	597d                	li	s2,-1
 638:	bfc5                	j	628 <stat+0x34>

000000000000063a <atoi>:

int
atoi(const char *s)
{
 63a:	1141                	addi	sp,sp,-16
 63c:	e422                	sd	s0,8(sp)
 63e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 640:	00054603          	lbu	a2,0(a0)
 644:	fd06079b          	addiw	a5,a2,-48
 648:	0ff7f793          	zext.b	a5,a5
 64c:	4725                	li	a4,9
 64e:	02f76963          	bltu	a4,a5,680 <atoi+0x46>
 652:	86aa                	mv	a3,a0
  n = 0;
 654:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 656:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 658:	0685                	addi	a3,a3,1
 65a:	0025179b          	slliw	a5,a0,0x2
 65e:	9fa9                	addw	a5,a5,a0
 660:	0017979b          	slliw	a5,a5,0x1
 664:	9fb1                	addw	a5,a5,a2
 666:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 66a:	0006c603          	lbu	a2,0(a3)
 66e:	fd06071b          	addiw	a4,a2,-48
 672:	0ff77713          	zext.b	a4,a4
 676:	fee5f1e3          	bgeu	a1,a4,658 <atoi+0x1e>
  return n;
}
 67a:	6422                	ld	s0,8(sp)
 67c:	0141                	addi	sp,sp,16
 67e:	8082                	ret
  n = 0;
 680:	4501                	li	a0,0
 682:	bfe5                	j	67a <atoi+0x40>

0000000000000684 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 684:	1141                	addi	sp,sp,-16
 686:	e422                	sd	s0,8(sp)
 688:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 68a:	02b57463          	bgeu	a0,a1,6b2 <memmove+0x2e>
    while(n-- > 0)
 68e:	00c05f63          	blez	a2,6ac <memmove+0x28>
 692:	1602                	slli	a2,a2,0x20
 694:	9201                	srli	a2,a2,0x20
 696:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 69a:	872a                	mv	a4,a0
      *dst++ = *src++;
 69c:	0585                	addi	a1,a1,1
 69e:	0705                	addi	a4,a4,1
 6a0:	fff5c683          	lbu	a3,-1(a1)
 6a4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6a8:	fee79ae3          	bne	a5,a4,69c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6ac:	6422                	ld	s0,8(sp)
 6ae:	0141                	addi	sp,sp,16
 6b0:	8082                	ret
    dst += n;
 6b2:	00c50733          	add	a4,a0,a2
    src += n;
 6b6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 6b8:	fec05ae3          	blez	a2,6ac <memmove+0x28>
 6bc:	fff6079b          	addiw	a5,a2,-1
 6c0:	1782                	slli	a5,a5,0x20
 6c2:	9381                	srli	a5,a5,0x20
 6c4:	fff7c793          	not	a5,a5
 6c8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 6ca:	15fd                	addi	a1,a1,-1
 6cc:	177d                	addi	a4,a4,-1
 6ce:	0005c683          	lbu	a3,0(a1)
 6d2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 6d6:	fee79ae3          	bne	a5,a4,6ca <memmove+0x46>
 6da:	bfc9                	j	6ac <memmove+0x28>

00000000000006dc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 6dc:	1141                	addi	sp,sp,-16
 6de:	e422                	sd	s0,8(sp)
 6e0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 6e2:	ca05                	beqz	a2,712 <memcmp+0x36>
 6e4:	fff6069b          	addiw	a3,a2,-1
 6e8:	1682                	slli	a3,a3,0x20
 6ea:	9281                	srli	a3,a3,0x20
 6ec:	0685                	addi	a3,a3,1
 6ee:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 6f0:	00054783          	lbu	a5,0(a0)
 6f4:	0005c703          	lbu	a4,0(a1)
 6f8:	00e79863          	bne	a5,a4,708 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 6fc:	0505                	addi	a0,a0,1
    p2++;
 6fe:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 700:	fed518e3          	bne	a0,a3,6f0 <memcmp+0x14>
  }
  return 0;
 704:	4501                	li	a0,0
 706:	a019                	j	70c <memcmp+0x30>
      return *p1 - *p2;
 708:	40e7853b          	subw	a0,a5,a4
}
 70c:	6422                	ld	s0,8(sp)
 70e:	0141                	addi	sp,sp,16
 710:	8082                	ret
  return 0;
 712:	4501                	li	a0,0
 714:	bfe5                	j	70c <memcmp+0x30>

0000000000000716 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 716:	1141                	addi	sp,sp,-16
 718:	e406                	sd	ra,8(sp)
 71a:	e022                	sd	s0,0(sp)
 71c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 71e:	00000097          	auipc	ra,0x0
 722:	f66080e7          	jalr	-154(ra) # 684 <memmove>
}
 726:	60a2                	ld	ra,8(sp)
 728:	6402                	ld	s0,0(sp)
 72a:	0141                	addi	sp,sp,16
 72c:	8082                	ret

000000000000072e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 72e:	4885                	li	a7,1
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <exit>:
.global exit
exit:
 li a7, SYS_exit
 736:	4889                	li	a7,2
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <wait>:
.global wait
wait:
 li a7, SYS_wait
 73e:	488d                	li	a7,3
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 746:	4891                	li	a7,4
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <read>:
.global read
read:
 li a7, SYS_read
 74e:	4895                	li	a7,5
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <write>:
.global write
write:
 li a7, SYS_write
 756:	48c1                	li	a7,16
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <close>:
.global close
close:
 li a7, SYS_close
 75e:	48d5                	li	a7,21
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <kill>:
.global kill
kill:
 li a7, SYS_kill
 766:	4899                	li	a7,6
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <exec>:
.global exec
exec:
 li a7, SYS_exec
 76e:	489d                	li	a7,7
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <open>:
.global open
open:
 li a7, SYS_open
 776:	48bd                	li	a7,15
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 77e:	48c5                	li	a7,17
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 786:	48c9                	li	a7,18
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 78e:	48a1                	li	a7,8
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <link>:
.global link
link:
 li a7, SYS_link
 796:	48cd                	li	a7,19
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 79e:	48d1                	li	a7,20
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7a6:	48a5                	li	a7,9
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <dup>:
.global dup
dup:
 li a7, SYS_dup
 7ae:	48a9                	li	a7,10
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7b6:	48ad                	li	a7,11
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7be:	48b1                	li	a7,12
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7c6:	48b5                	li	a7,13
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7ce:	48b9                	li	a7,14
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 7d6:	48d9                	li	a7,22
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7de:	1101                	addi	sp,sp,-32
 7e0:	ec06                	sd	ra,24(sp)
 7e2:	e822                	sd	s0,16(sp)
 7e4:	1000                	addi	s0,sp,32
 7e6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7ea:	4605                	li	a2,1
 7ec:	fef40593          	addi	a1,s0,-17
 7f0:	00000097          	auipc	ra,0x0
 7f4:	f66080e7          	jalr	-154(ra) # 756 <write>
}
 7f8:	60e2                	ld	ra,24(sp)
 7fa:	6442                	ld	s0,16(sp)
 7fc:	6105                	addi	sp,sp,32
 7fe:	8082                	ret

0000000000000800 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 800:	7139                	addi	sp,sp,-64
 802:	fc06                	sd	ra,56(sp)
 804:	f822                	sd	s0,48(sp)
 806:	f426                	sd	s1,40(sp)
 808:	f04a                	sd	s2,32(sp)
 80a:	ec4e                	sd	s3,24(sp)
 80c:	0080                	addi	s0,sp,64
 80e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 810:	c299                	beqz	a3,816 <printint+0x16>
 812:	0805c863          	bltz	a1,8a2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 816:	2581                	sext.w	a1,a1
  neg = 0;
 818:	4881                	li	a7,0
 81a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 81e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 820:	2601                	sext.w	a2,a2
 822:	00000517          	auipc	a0,0x0
 826:	47e50513          	addi	a0,a0,1150 # ca0 <digits>
 82a:	883a                	mv	a6,a4
 82c:	2705                	addiw	a4,a4,1
 82e:	02c5f7bb          	remuw	a5,a1,a2
 832:	1782                	slli	a5,a5,0x20
 834:	9381                	srli	a5,a5,0x20
 836:	97aa                	add	a5,a5,a0
 838:	0007c783          	lbu	a5,0(a5)
 83c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 840:	0005879b          	sext.w	a5,a1
 844:	02c5d5bb          	divuw	a1,a1,a2
 848:	0685                	addi	a3,a3,1
 84a:	fec7f0e3          	bgeu	a5,a2,82a <printint+0x2a>
  if(neg)
 84e:	00088b63          	beqz	a7,864 <printint+0x64>
    buf[i++] = '-';
 852:	fd040793          	addi	a5,s0,-48
 856:	973e                	add	a4,a4,a5
 858:	02d00793          	li	a5,45
 85c:	fef70823          	sb	a5,-16(a4)
 860:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 864:	02e05863          	blez	a4,894 <printint+0x94>
 868:	fc040793          	addi	a5,s0,-64
 86c:	00e78933          	add	s2,a5,a4
 870:	fff78993          	addi	s3,a5,-1
 874:	99ba                	add	s3,s3,a4
 876:	377d                	addiw	a4,a4,-1
 878:	1702                	slli	a4,a4,0x20
 87a:	9301                	srli	a4,a4,0x20
 87c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 880:	fff94583          	lbu	a1,-1(s2)
 884:	8526                	mv	a0,s1
 886:	00000097          	auipc	ra,0x0
 88a:	f58080e7          	jalr	-168(ra) # 7de <putc>
  while(--i >= 0)
 88e:	197d                	addi	s2,s2,-1
 890:	ff3918e3          	bne	s2,s3,880 <printint+0x80>
}
 894:	70e2                	ld	ra,56(sp)
 896:	7442                	ld	s0,48(sp)
 898:	74a2                	ld	s1,40(sp)
 89a:	7902                	ld	s2,32(sp)
 89c:	69e2                	ld	s3,24(sp)
 89e:	6121                	addi	sp,sp,64
 8a0:	8082                	ret
    x = -xx;
 8a2:	40b005bb          	negw	a1,a1
    neg = 1;
 8a6:	4885                	li	a7,1
    x = -xx;
 8a8:	bf8d                	j	81a <printint+0x1a>

00000000000008aa <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8aa:	7119                	addi	sp,sp,-128
 8ac:	fc86                	sd	ra,120(sp)
 8ae:	f8a2                	sd	s0,112(sp)
 8b0:	f4a6                	sd	s1,104(sp)
 8b2:	f0ca                	sd	s2,96(sp)
 8b4:	ecce                	sd	s3,88(sp)
 8b6:	e8d2                	sd	s4,80(sp)
 8b8:	e4d6                	sd	s5,72(sp)
 8ba:	e0da                	sd	s6,64(sp)
 8bc:	fc5e                	sd	s7,56(sp)
 8be:	f862                	sd	s8,48(sp)
 8c0:	f466                	sd	s9,40(sp)
 8c2:	f06a                	sd	s10,32(sp)
 8c4:	ec6e                	sd	s11,24(sp)
 8c6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8c8:	0005c903          	lbu	s2,0(a1)
 8cc:	18090f63          	beqz	s2,a6a <vprintf+0x1c0>
 8d0:	8aaa                	mv	s5,a0
 8d2:	8b32                	mv	s6,a2
 8d4:	00158493          	addi	s1,a1,1
  state = 0;
 8d8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8da:	02500a13          	li	s4,37
      if(c == 'd'){
 8de:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 8e2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 8e6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 8ea:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8ee:	00000b97          	auipc	s7,0x0
 8f2:	3b2b8b93          	addi	s7,s7,946 # ca0 <digits>
 8f6:	a839                	j	914 <vprintf+0x6a>
        putc(fd, c);
 8f8:	85ca                	mv	a1,s2
 8fa:	8556                	mv	a0,s5
 8fc:	00000097          	auipc	ra,0x0
 900:	ee2080e7          	jalr	-286(ra) # 7de <putc>
 904:	a019                	j	90a <vprintf+0x60>
    } else if(state == '%'){
 906:	01498f63          	beq	s3,s4,924 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 90a:	0485                	addi	s1,s1,1
 90c:	fff4c903          	lbu	s2,-1(s1)
 910:	14090d63          	beqz	s2,a6a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 914:	0009079b          	sext.w	a5,s2
    if(state == 0){
 918:	fe0997e3          	bnez	s3,906 <vprintf+0x5c>
      if(c == '%'){
 91c:	fd479ee3          	bne	a5,s4,8f8 <vprintf+0x4e>
        state = '%';
 920:	89be                	mv	s3,a5
 922:	b7e5                	j	90a <vprintf+0x60>
      if(c == 'd'){
 924:	05878063          	beq	a5,s8,964 <vprintf+0xba>
      } else if(c == 'l') {
 928:	05978c63          	beq	a5,s9,980 <vprintf+0xd6>
      } else if(c == 'x') {
 92c:	07a78863          	beq	a5,s10,99c <vprintf+0xf2>
      } else if(c == 'p') {
 930:	09b78463          	beq	a5,s11,9b8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 934:	07300713          	li	a4,115
 938:	0ce78663          	beq	a5,a4,a04 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 93c:	06300713          	li	a4,99
 940:	0ee78e63          	beq	a5,a4,a3c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 944:	11478863          	beq	a5,s4,a54 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 948:	85d2                	mv	a1,s4
 94a:	8556                	mv	a0,s5
 94c:	00000097          	auipc	ra,0x0
 950:	e92080e7          	jalr	-366(ra) # 7de <putc>
        putc(fd, c);
 954:	85ca                	mv	a1,s2
 956:	8556                	mv	a0,s5
 958:	00000097          	auipc	ra,0x0
 95c:	e86080e7          	jalr	-378(ra) # 7de <putc>
      }
      state = 0;
 960:	4981                	li	s3,0
 962:	b765                	j	90a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 964:	008b0913          	addi	s2,s6,8
 968:	4685                	li	a3,1
 96a:	4629                	li	a2,10
 96c:	000b2583          	lw	a1,0(s6)
 970:	8556                	mv	a0,s5
 972:	00000097          	auipc	ra,0x0
 976:	e8e080e7          	jalr	-370(ra) # 800 <printint>
 97a:	8b4a                	mv	s6,s2
      state = 0;
 97c:	4981                	li	s3,0
 97e:	b771                	j	90a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 980:	008b0913          	addi	s2,s6,8
 984:	4681                	li	a3,0
 986:	4629                	li	a2,10
 988:	000b2583          	lw	a1,0(s6)
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	e72080e7          	jalr	-398(ra) # 800 <printint>
 996:	8b4a                	mv	s6,s2
      state = 0;
 998:	4981                	li	s3,0
 99a:	bf85                	j	90a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 99c:	008b0913          	addi	s2,s6,8
 9a0:	4681                	li	a3,0
 9a2:	4641                	li	a2,16
 9a4:	000b2583          	lw	a1,0(s6)
 9a8:	8556                	mv	a0,s5
 9aa:	00000097          	auipc	ra,0x0
 9ae:	e56080e7          	jalr	-426(ra) # 800 <printint>
 9b2:	8b4a                	mv	s6,s2
      state = 0;
 9b4:	4981                	li	s3,0
 9b6:	bf91                	j	90a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 9b8:	008b0793          	addi	a5,s6,8
 9bc:	f8f43423          	sd	a5,-120(s0)
 9c0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 9c4:	03000593          	li	a1,48
 9c8:	8556                	mv	a0,s5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	e14080e7          	jalr	-492(ra) # 7de <putc>
  putc(fd, 'x');
 9d2:	85ea                	mv	a1,s10
 9d4:	8556                	mv	a0,s5
 9d6:	00000097          	auipc	ra,0x0
 9da:	e08080e7          	jalr	-504(ra) # 7de <putc>
 9de:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9e0:	03c9d793          	srli	a5,s3,0x3c
 9e4:	97de                	add	a5,a5,s7
 9e6:	0007c583          	lbu	a1,0(a5)
 9ea:	8556                	mv	a0,s5
 9ec:	00000097          	auipc	ra,0x0
 9f0:	df2080e7          	jalr	-526(ra) # 7de <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9f4:	0992                	slli	s3,s3,0x4
 9f6:	397d                	addiw	s2,s2,-1
 9f8:	fe0914e3          	bnez	s2,9e0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 9fc:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a00:	4981                	li	s3,0
 a02:	b721                	j	90a <vprintf+0x60>
        s = va_arg(ap, char*);
 a04:	008b0993          	addi	s3,s6,8
 a08:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 a0c:	02090163          	beqz	s2,a2e <vprintf+0x184>
        while(*s != 0){
 a10:	00094583          	lbu	a1,0(s2)
 a14:	c9a1                	beqz	a1,a64 <vprintf+0x1ba>
          putc(fd, *s);
 a16:	8556                	mv	a0,s5
 a18:	00000097          	auipc	ra,0x0
 a1c:	dc6080e7          	jalr	-570(ra) # 7de <putc>
          s++;
 a20:	0905                	addi	s2,s2,1
        while(*s != 0){
 a22:	00094583          	lbu	a1,0(s2)
 a26:	f9e5                	bnez	a1,a16 <vprintf+0x16c>
        s = va_arg(ap, char*);
 a28:	8b4e                	mv	s6,s3
      state = 0;
 a2a:	4981                	li	s3,0
 a2c:	bdf9                	j	90a <vprintf+0x60>
          s = "(null)";
 a2e:	00000917          	auipc	s2,0x0
 a32:	26a90913          	addi	s2,s2,618 # c98 <malloc+0x124>
        while(*s != 0){
 a36:	02800593          	li	a1,40
 a3a:	bff1                	j	a16 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 a3c:	008b0913          	addi	s2,s6,8
 a40:	000b4583          	lbu	a1,0(s6)
 a44:	8556                	mv	a0,s5
 a46:	00000097          	auipc	ra,0x0
 a4a:	d98080e7          	jalr	-616(ra) # 7de <putc>
 a4e:	8b4a                	mv	s6,s2
      state = 0;
 a50:	4981                	li	s3,0
 a52:	bd65                	j	90a <vprintf+0x60>
        putc(fd, c);
 a54:	85d2                	mv	a1,s4
 a56:	8556                	mv	a0,s5
 a58:	00000097          	auipc	ra,0x0
 a5c:	d86080e7          	jalr	-634(ra) # 7de <putc>
      state = 0;
 a60:	4981                	li	s3,0
 a62:	b565                	j	90a <vprintf+0x60>
        s = va_arg(ap, char*);
 a64:	8b4e                	mv	s6,s3
      state = 0;
 a66:	4981                	li	s3,0
 a68:	b54d                	j	90a <vprintf+0x60>
    }
  }
}
 a6a:	70e6                	ld	ra,120(sp)
 a6c:	7446                	ld	s0,112(sp)
 a6e:	74a6                	ld	s1,104(sp)
 a70:	7906                	ld	s2,96(sp)
 a72:	69e6                	ld	s3,88(sp)
 a74:	6a46                	ld	s4,80(sp)
 a76:	6aa6                	ld	s5,72(sp)
 a78:	6b06                	ld	s6,64(sp)
 a7a:	7be2                	ld	s7,56(sp)
 a7c:	7c42                	ld	s8,48(sp)
 a7e:	7ca2                	ld	s9,40(sp)
 a80:	7d02                	ld	s10,32(sp)
 a82:	6de2                	ld	s11,24(sp)
 a84:	6109                	addi	sp,sp,128
 a86:	8082                	ret

0000000000000a88 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a88:	715d                	addi	sp,sp,-80
 a8a:	ec06                	sd	ra,24(sp)
 a8c:	e822                	sd	s0,16(sp)
 a8e:	1000                	addi	s0,sp,32
 a90:	e010                	sd	a2,0(s0)
 a92:	e414                	sd	a3,8(s0)
 a94:	e818                	sd	a4,16(s0)
 a96:	ec1c                	sd	a5,24(s0)
 a98:	03043023          	sd	a6,32(s0)
 a9c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aa0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 aa4:	8622                	mv	a2,s0
 aa6:	00000097          	auipc	ra,0x0
 aaa:	e04080e7          	jalr	-508(ra) # 8aa <vprintf>
}
 aae:	60e2                	ld	ra,24(sp)
 ab0:	6442                	ld	s0,16(sp)
 ab2:	6161                	addi	sp,sp,80
 ab4:	8082                	ret

0000000000000ab6 <printf>:

void
printf(const char *fmt, ...)
{
 ab6:	711d                	addi	sp,sp,-96
 ab8:	ec06                	sd	ra,24(sp)
 aba:	e822                	sd	s0,16(sp)
 abc:	1000                	addi	s0,sp,32
 abe:	e40c                	sd	a1,8(s0)
 ac0:	e810                	sd	a2,16(s0)
 ac2:	ec14                	sd	a3,24(s0)
 ac4:	f018                	sd	a4,32(s0)
 ac6:	f41c                	sd	a5,40(s0)
 ac8:	03043823          	sd	a6,48(s0)
 acc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ad0:	00840613          	addi	a2,s0,8
 ad4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 ad8:	85aa                	mv	a1,a0
 ada:	4505                	li	a0,1
 adc:	00000097          	auipc	ra,0x0
 ae0:	dce080e7          	jalr	-562(ra) # 8aa <vprintf>
}
 ae4:	60e2                	ld	ra,24(sp)
 ae6:	6442                	ld	s0,16(sp)
 ae8:	6125                	addi	sp,sp,96
 aea:	8082                	ret

0000000000000aec <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aec:	1141                	addi	sp,sp,-16
 aee:	e422                	sd	s0,8(sp)
 af0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 af2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af6:	00000797          	auipc	a5,0x0
 afa:	1c27b783          	ld	a5,450(a5) # cb8 <freep>
 afe:	a805                	j	b2e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b00:	4618                	lw	a4,8(a2)
 b02:	9db9                	addw	a1,a1,a4
 b04:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b08:	6398                	ld	a4,0(a5)
 b0a:	6318                	ld	a4,0(a4)
 b0c:	fee53823          	sd	a4,-16(a0)
 b10:	a091                	j	b54 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b12:	ff852703          	lw	a4,-8(a0)
 b16:	9e39                	addw	a2,a2,a4
 b18:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 b1a:	ff053703          	ld	a4,-16(a0)
 b1e:	e398                	sd	a4,0(a5)
 b20:	a099                	j	b66 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b22:	6398                	ld	a4,0(a5)
 b24:	00e7e463          	bltu	a5,a4,b2c <free+0x40>
 b28:	00e6ea63          	bltu	a3,a4,b3c <free+0x50>
{
 b2c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2e:	fed7fae3          	bgeu	a5,a3,b22 <free+0x36>
 b32:	6398                	ld	a4,0(a5)
 b34:	00e6e463          	bltu	a3,a4,b3c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b38:	fee7eae3          	bltu	a5,a4,b2c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 b3c:	ff852583          	lw	a1,-8(a0)
 b40:	6390                	ld	a2,0(a5)
 b42:	02059813          	slli	a6,a1,0x20
 b46:	01c85713          	srli	a4,a6,0x1c
 b4a:	9736                	add	a4,a4,a3
 b4c:	fae60ae3          	beq	a2,a4,b00 <free+0x14>
    bp->s.ptr = p->s.ptr;
 b50:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b54:	4790                	lw	a2,8(a5)
 b56:	02061593          	slli	a1,a2,0x20
 b5a:	01c5d713          	srli	a4,a1,0x1c
 b5e:	973e                	add	a4,a4,a5
 b60:	fae689e3          	beq	a3,a4,b12 <free+0x26>
  } else
    p->s.ptr = bp;
 b64:	e394                	sd	a3,0(a5)
  freep = p;
 b66:	00000717          	auipc	a4,0x0
 b6a:	14f73923          	sd	a5,338(a4) # cb8 <freep>
}
 b6e:	6422                	ld	s0,8(sp)
 b70:	0141                	addi	sp,sp,16
 b72:	8082                	ret

0000000000000b74 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b74:	7139                	addi	sp,sp,-64
 b76:	fc06                	sd	ra,56(sp)
 b78:	f822                	sd	s0,48(sp)
 b7a:	f426                	sd	s1,40(sp)
 b7c:	f04a                	sd	s2,32(sp)
 b7e:	ec4e                	sd	s3,24(sp)
 b80:	e852                	sd	s4,16(sp)
 b82:	e456                	sd	s5,8(sp)
 b84:	e05a                	sd	s6,0(sp)
 b86:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b88:	02051493          	slli	s1,a0,0x20
 b8c:	9081                	srli	s1,s1,0x20
 b8e:	04bd                	addi	s1,s1,15
 b90:	8091                	srli	s1,s1,0x4
 b92:	0014899b          	addiw	s3,s1,1
 b96:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b98:	00000517          	auipc	a0,0x0
 b9c:	12053503          	ld	a0,288(a0) # cb8 <freep>
 ba0:	c515                	beqz	a0,bcc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ba4:	4798                	lw	a4,8(a5)
 ba6:	02977f63          	bgeu	a4,s1,be4 <malloc+0x70>
 baa:	8a4e                	mv	s4,s3
 bac:	0009871b          	sext.w	a4,s3
 bb0:	6685                	lui	a3,0x1
 bb2:	00d77363          	bgeu	a4,a3,bb8 <malloc+0x44>
 bb6:	6a05                	lui	s4,0x1
 bb8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bbc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bc0:	00000917          	auipc	s2,0x0
 bc4:	0f890913          	addi	s2,s2,248 # cb8 <freep>
  if(p == (char*)-1)
 bc8:	5afd                	li	s5,-1
 bca:	a895                	j	c3e <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 bcc:	00000797          	auipc	a5,0x0
 bd0:	5e478793          	addi	a5,a5,1508 # 11b0 <base>
 bd4:	00000717          	auipc	a4,0x0
 bd8:	0ef73223          	sd	a5,228(a4) # cb8 <freep>
 bdc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bde:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 be2:	b7e1                	j	baa <malloc+0x36>
      if(p->s.size == nunits)
 be4:	02e48c63          	beq	s1,a4,c1c <malloc+0xa8>
        p->s.size -= nunits;
 be8:	4137073b          	subw	a4,a4,s3
 bec:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bee:	02071693          	slli	a3,a4,0x20
 bf2:	01c6d713          	srli	a4,a3,0x1c
 bf6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bf8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bfc:	00000717          	auipc	a4,0x0
 c00:	0aa73e23          	sd	a0,188(a4) # cb8 <freep>
      return (void*)(p + 1);
 c04:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c08:	70e2                	ld	ra,56(sp)
 c0a:	7442                	ld	s0,48(sp)
 c0c:	74a2                	ld	s1,40(sp)
 c0e:	7902                	ld	s2,32(sp)
 c10:	69e2                	ld	s3,24(sp)
 c12:	6a42                	ld	s4,16(sp)
 c14:	6aa2                	ld	s5,8(sp)
 c16:	6b02                	ld	s6,0(sp)
 c18:	6121                	addi	sp,sp,64
 c1a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c1c:	6398                	ld	a4,0(a5)
 c1e:	e118                	sd	a4,0(a0)
 c20:	bff1                	j	bfc <malloc+0x88>
  hp->s.size = nu;
 c22:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c26:	0541                	addi	a0,a0,16
 c28:	00000097          	auipc	ra,0x0
 c2c:	ec4080e7          	jalr	-316(ra) # aec <free>
  return freep;
 c30:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c34:	d971                	beqz	a0,c08 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c36:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c38:	4798                	lw	a4,8(a5)
 c3a:	fa9775e3          	bgeu	a4,s1,be4 <malloc+0x70>
    if(p == freep)
 c3e:	00093703          	ld	a4,0(s2)
 c42:	853e                	mv	a0,a5
 c44:	fef719e3          	bne	a4,a5,c36 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 c48:	8552                	mv	a0,s4
 c4a:	00000097          	auipc	ra,0x0
 c4e:	b74080e7          	jalr	-1164(ra) # 7be <sbrk>
  if(p == (char*)-1)
 c52:	fd5518e3          	bne	a0,s5,c22 <malloc+0xae>
        return 0;
 c56:	4501                	li	a0,0
 c58:	bf45                	j	c08 <malloc+0x94>
