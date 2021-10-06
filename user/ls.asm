
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	54e080e7          	jalr	1358(ra) # 55e <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	522080e7          	jalr	1314(ra) # 55e <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	500080e7          	jalr	1280(ra) # 55e <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	cda98993          	addi	s3,s3,-806 # d40 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	65c080e7          	jalr	1628(ra) # 6d2 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	4de080e7          	jalr	1246(ra) # 55e <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	4d0080e7          	jalr	1232(ra) # 55e <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	4e0080e7          	jalr	1248(ra) # 588 <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	addi	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  d8:	4581                	li	a1,0
  da:	00000097          	auipc	ra,0x0
  de:	6ea080e7          	jalr	1770(ra) # 7c4 <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	6f0080e7          	jalr	1776(ra) # 7dc <fstat>
  f4:	08054163          	bltz	a0,176 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	0007869b          	sext.w	a3,a5
 100:	4705                	li	a4,1
 102:	08e68a63          	beq	a3,a4,196 <ls+0xe2>
 106:	4709                	li	a4,2
 108:	02e69663          	bne	a3,a4,134 <ls+0x80>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <fmtname>
 116:	85aa                	mv	a1,a0
 118:	da843703          	ld	a4,-600(s0)
 11c:	d9c42683          	lw	a3,-612(s0)
 120:	da041603          	lh	a2,-608(s0)
 124:	00001517          	auipc	a0,0x1
 128:	bb450513          	addi	a0,a0,-1100 # cd8 <malloc+0x116>
 12c:	00001097          	auipc	ra,0x1
 130:	9d8080e7          	jalr	-1576(ra) # b04 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00000097          	auipc	ra,0x0
 13a:	676080e7          	jalr	1654(ra) # 7ac <close>
}
 13e:	26813083          	ld	ra,616(sp)
 142:	26013403          	ld	s0,608(sp)
 146:	25813483          	ld	s1,600(sp)
 14a:	25013903          	ld	s2,592(sp)
 14e:	24813983          	ld	s3,584(sp)
 152:	24013a03          	ld	s4,576(sp)
 156:	23813a83          	ld	s5,568(sp)
 15a:	27010113          	addi	sp,sp,624
 15e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 160:	864a                	mv	a2,s2
 162:	00001597          	auipc	a1,0x1
 166:	b4658593          	addi	a1,a1,-1210 # ca8 <malloc+0xe6>
 16a:	4509                	li	a0,2
 16c:	00001097          	auipc	ra,0x1
 170:	96a080e7          	jalr	-1686(ra) # ad6 <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	b4858593          	addi	a1,a1,-1208 # cc0 <malloc+0xfe>
 180:	4509                	li	a0,2
 182:	00001097          	auipc	ra,0x1
 186:	954080e7          	jalr	-1708(ra) # ad6 <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	620080e7          	jalr	1568(ra) # 7ac <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	3c6080e7          	jalr	966(ra) # 55e <strlen>
 1a0:	2541                	addiw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	b3e50513          	addi	a0,a0,-1218 # ce8 <malloc+0x126>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	952080e7          	jalr	-1710(ra) # b04 <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	354080e7          	jalr	852(ra) # 516 <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	addi	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	390080e7          	jalr	912(ra) # 55e <strlen>
 1d6:	02051913          	slli	s2,a0,0x20
 1da:	02095913          	srli	s2,s2,0x20
 1de:	dc040793          	addi	a5,s0,-576
 1e2:	993e                	add	s2,s2,a5
    *p++ = '/';
 1e4:	00190993          	addi	s3,s2,1
 1e8:	02f00793          	li	a5,47
 1ec:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1f0:	00001a17          	auipc	s4,0x1
 1f4:	b10a0a13          	addi	s4,s4,-1264 # d00 <malloc+0x13e>
        printf("ls: cannot stat %s\n", buf);
 1f8:	00001a97          	auipc	s5,0x1
 1fc:	ac8a8a93          	addi	s5,s5,-1336 # cc0 <malloc+0xfe>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 200:	a801                	j	210 <ls+0x15c>
        printf("ls: cannot stat %s\n", buf);
 202:	dc040593          	addi	a1,s0,-576
 206:	8556                	mv	a0,s5
 208:	00001097          	auipc	ra,0x1
 20c:	8fc080e7          	jalr	-1796(ra) # b04 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 210:	4641                	li	a2,16
 212:	db040593          	addi	a1,s0,-592
 216:	8526                	mv	a0,s1
 218:	00000097          	auipc	ra,0x0
 21c:	584080e7          	jalr	1412(ra) # 79c <read>
 220:	47c1                	li	a5,16
 222:	f0f519e3          	bne	a0,a5,134 <ls+0x80>
      if(de.inum == 0)
 226:	db045783          	lhu	a5,-592(s0)
 22a:	d3fd                	beqz	a5,210 <ls+0x15c>
      memmove(p, de.name, DIRSIZ);
 22c:	4639                	li	a2,14
 22e:	db240593          	addi	a1,s0,-590
 232:	854e                	mv	a0,s3
 234:	00000097          	auipc	ra,0x0
 238:	49e080e7          	jalr	1182(ra) # 6d2 <memmove>
      p[DIRSIZ] = 0;
 23c:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 240:	d9840593          	addi	a1,s0,-616
 244:	dc040513          	addi	a0,s0,-576
 248:	00000097          	auipc	ra,0x0
 24c:	3fa080e7          	jalr	1018(ra) # 642 <stat>
 250:	fa0549e3          	bltz	a0,202 <ls+0x14e>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 254:	dc040513          	addi	a0,s0,-576
 258:	00000097          	auipc	ra,0x0
 25c:	da8080e7          	jalr	-600(ra) # 0 <fmtname>
 260:	85aa                	mv	a1,a0
 262:	da843703          	ld	a4,-600(s0)
 266:	d9c42683          	lw	a3,-612(s0)
 26a:	da041603          	lh	a2,-608(s0)
 26e:	8552                	mv	a0,s4
 270:	00001097          	auipc	ra,0x1
 274:	894080e7          	jalr	-1900(ra) # b04 <printf>
 278:	bf61                	j	210 <ls+0x15c>

000000000000027a <main>:

int
main(int argc, char *argv[])
{
 27a:	1101                	addi	sp,sp,-32
 27c:	ec06                	sd	ra,24(sp)
 27e:	e822                	sd	s0,16(sp)
 280:	e426                	sd	s1,8(sp)
 282:	e04a                	sd	s2,0(sp)
 284:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 286:	4785                	li	a5,1
 288:	02a7d963          	bge	a5,a0,2ba <main+0x40>
 28c:	00858493          	addi	s1,a1,8
 290:	ffe5091b          	addiw	s2,a0,-2
 294:	02091793          	slli	a5,s2,0x20
 298:	01d7d913          	srli	s2,a5,0x1d
 29c:	05c1                	addi	a1,a1,16
 29e:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2a0:	6088                	ld	a0,0(s1)
 2a2:	00000097          	auipc	ra,0x0
 2a6:	e12080e7          	jalr	-494(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2aa:	04a1                	addi	s1,s1,8
 2ac:	ff249ae3          	bne	s1,s2,2a0 <main+0x26>
  exit(0);
 2b0:	4501                	li	a0,0
 2b2:	00000097          	auipc	ra,0x0
 2b6:	4d2080e7          	jalr	1234(ra) # 784 <exit>
    ls(".");
 2ba:	00001517          	auipc	a0,0x1
 2be:	a5650513          	addi	a0,a0,-1450 # d10 <malloc+0x14e>
 2c2:	00000097          	auipc	ra,0x0
 2c6:	df2080e7          	jalr	-526(ra) # b4 <ls>
    exit(0);
 2ca:	4501                	li	a0,0
 2cc:	00000097          	auipc	ra,0x0
 2d0:	4b8080e7          	jalr	1208(ra) # 784 <exit>

00000000000002d4 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e422                	sd	s0,8(sp)
 2d8:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 2da:	0f50000f          	fence	iorw,ow
 2de:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <load>:

int load(uint64 *p) {
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 2ee:	0ff0000f          	fence
 2f2:	6108                	ld	a0,0(a0)
 2f4:	0ff0000f          	fence
}
 2f8:	2501                	sext.w	a0,a0
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 300:	7179                	addi	sp,sp,-48
 302:	f406                	sd	ra,40(sp)
 304:	f022                	sd	s0,32(sp)
 306:	ec26                	sd	s1,24(sp)
 308:	e84a                	sd	s2,16(sp)
 30a:	e44e                	sd	s3,8(sp)
 30c:	e052                	sd	s4,0(sp)
 30e:	1800                	addi	s0,sp,48
 310:	8a2a                	mv	s4,a0
 312:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 314:	4785                	li	a5,1
 316:	00001497          	auipc	s1,0x1
 31a:	a4a48493          	addi	s1,s1,-1462 # d60 <rings+0x10>
 31e:	00001917          	auipc	s2,0x1
 322:	b3290913          	addi	s2,s2,-1230 # e50 <__BSS_END__>
 326:	04f59563          	bne	a1,a5,370 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 32a:	00001497          	auipc	s1,0x1
 32e:	a364a483          	lw	s1,-1482(s1) # d60 <rings+0x10>
 332:	c099                	beqz	s1,338 <create_or_close_the_buffer_user+0x38>
 334:	4481                	li	s1,0
 336:	a899                	j	38c <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 338:	00001917          	auipc	s2,0x1
 33c:	a1890913          	addi	s2,s2,-1512 # d50 <rings>
 340:	00093603          	ld	a2,0(s2)
 344:	4585                	li	a1,1
 346:	00000097          	auipc	ra,0x0
 34a:	4de080e7          	jalr	1246(ra) # 824 <ringbuf>
        rings[i].book->write_done = 0;
 34e:	00893783          	ld	a5,8(s2)
 352:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 356:	00893783          	ld	a5,8(s2)
 35a:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 35e:	01092783          	lw	a5,16(s2)
 362:	2785                	addiw	a5,a5,1
 364:	00f92823          	sw	a5,16(s2)
        break;
 368:	a015                	j	38c <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 36a:	04e1                	addi	s1,s1,24
 36c:	01248f63          	beq	s1,s2,38a <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 370:	409c                	lw	a5,0(s1)
 372:	dfe5                	beqz	a5,36a <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 374:	ff04b603          	ld	a2,-16(s1)
 378:	85ce                	mv	a1,s3
 37a:	8552                	mv	a0,s4
 37c:	00000097          	auipc	ra,0x0
 380:	4a8080e7          	jalr	1192(ra) # 824 <ringbuf>
        rings[i].exists = 0;
 384:	0004a023          	sw	zero,0(s1)
 388:	b7cd                	j	36a <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 38a:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 38c:	8526                	mv	a0,s1
 38e:	70a2                	ld	ra,40(sp)
 390:	7402                	ld	s0,32(sp)
 392:	64e2                	ld	s1,24(sp)
 394:	6942                	ld	s2,16(sp)
 396:	69a2                	ld	s3,8(sp)
 398:	6a02                	ld	s4,0(sp)
 39a:	6145                	addi	sp,sp,48
 39c:	8082                	ret

000000000000039e <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 39e:	1101                	addi	sp,sp,-32
 3a0:	ec06                	sd	ra,24(sp)
 3a2:	e822                	sd	s0,16(sp)
 3a4:	e426                	sd	s1,8(sp)
 3a6:	1000                	addi	s0,sp,32
 3a8:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 3aa:	00151793          	slli	a5,a0,0x1
 3ae:	97aa                	add	a5,a5,a0
 3b0:	078e                	slli	a5,a5,0x3
 3b2:	00001717          	auipc	a4,0x1
 3b6:	99e70713          	addi	a4,a4,-1634 # d50 <rings>
 3ba:	97ba                	add	a5,a5,a4
 3bc:	6798                	ld	a4,8(a5)
 3be:	671c                	ld	a5,8(a4)
 3c0:	00178693          	addi	a3,a5,1
 3c4:	e714                	sd	a3,8(a4)
 3c6:	17d2                	slli	a5,a5,0x34
 3c8:	93d1                	srli	a5,a5,0x34
 3ca:	6741                	lui	a4,0x10
 3cc:	40f707b3          	sub	a5,a4,a5
 3d0:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 3d2:	421c                	lw	a5,0(a2)
 3d4:	e79d                	bnez	a5,402 <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 3d6:	00001697          	auipc	a3,0x1
 3da:	97a68693          	addi	a3,a3,-1670 # d50 <rings>
 3de:	669c                	ld	a5,8(a3)
 3e0:	6398                	ld	a4,0(a5)
 3e2:	67c1                	lui	a5,0x10
 3e4:	9fb9                	addw	a5,a5,a4
 3e6:	00151713          	slli	a4,a0,0x1
 3ea:	953a                	add	a0,a0,a4
 3ec:	050e                	slli	a0,a0,0x3
 3ee:	9536                	add	a0,a0,a3
 3f0:	6518                	ld	a4,8(a0)
 3f2:	6718                	ld	a4,8(a4)
 3f4:	9f99                	subw	a5,a5,a4
 3f6:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 3f8:	60e2                	ld	ra,24(sp)
 3fa:	6442                	ld	s0,16(sp)
 3fc:	64a2                	ld	s1,8(sp)
 3fe:	6105                	addi	sp,sp,32
 400:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 402:	00151793          	slli	a5,a0,0x1
 406:	953e                	add	a0,a0,a5
 408:	050e                	slli	a0,a0,0x3
 40a:	00001797          	auipc	a5,0x1
 40e:	94678793          	addi	a5,a5,-1722 # d50 <rings>
 412:	953e                	add	a0,a0,a5
 414:	6508                	ld	a0,8(a0)
 416:	0521                	addi	a0,a0,8
 418:	00000097          	auipc	ra,0x0
 41c:	ed0080e7          	jalr	-304(ra) # 2e8 <load>
 420:	c088                	sw	a0,0(s1)
}
 422:	bfd9                	j	3f8 <ringbuf_start_write+0x5a>

0000000000000424 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 424:	1141                	addi	sp,sp,-16
 426:	e406                	sd	ra,8(sp)
 428:	e022                	sd	s0,0(sp)
 42a:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 42c:	00151793          	slli	a5,a0,0x1
 430:	97aa                	add	a5,a5,a0
 432:	078e                	slli	a5,a5,0x3
 434:	00001517          	auipc	a0,0x1
 438:	91c50513          	addi	a0,a0,-1764 # d50 <rings>
 43c:	97aa                	add	a5,a5,a0
 43e:	6788                	ld	a0,8(a5)
 440:	0035959b          	slliw	a1,a1,0x3
 444:	0521                	addi	a0,a0,8
 446:	00000097          	auipc	ra,0x0
 44a:	e8e080e7          	jalr	-370(ra) # 2d4 <store>
}
 44e:	60a2                	ld	ra,8(sp)
 450:	6402                	ld	s0,0(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret

0000000000000456 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 456:	1101                	addi	sp,sp,-32
 458:	ec06                	sd	ra,24(sp)
 45a:	e822                	sd	s0,16(sp)
 45c:	e426                	sd	s1,8(sp)
 45e:	1000                	addi	s0,sp,32
 460:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 462:	00151793          	slli	a5,a0,0x1
 466:	97aa                	add	a5,a5,a0
 468:	078e                	slli	a5,a5,0x3
 46a:	00001517          	auipc	a0,0x1
 46e:	8e650513          	addi	a0,a0,-1818 # d50 <rings>
 472:	97aa                	add	a5,a5,a0
 474:	6788                	ld	a0,8(a5)
 476:	0521                	addi	a0,a0,8
 478:	00000097          	auipc	ra,0x0
 47c:	e70080e7          	jalr	-400(ra) # 2e8 <load>
 480:	c088                	sw	a0,0(s1)
}
 482:	60e2                	ld	ra,24(sp)
 484:	6442                	ld	s0,16(sp)
 486:	64a2                	ld	s1,8(sp)
 488:	6105                	addi	sp,sp,32
 48a:	8082                	ret

000000000000048c <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 48c:	1101                	addi	sp,sp,-32
 48e:	ec06                	sd	ra,24(sp)
 490:	e822                	sd	s0,16(sp)
 492:	e426                	sd	s1,8(sp)
 494:	1000                	addi	s0,sp,32
 496:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 498:	00151793          	slli	a5,a0,0x1
 49c:	97aa                	add	a5,a5,a0
 49e:	078e                	slli	a5,a5,0x3
 4a0:	00001517          	auipc	a0,0x1
 4a4:	8b050513          	addi	a0,a0,-1872 # d50 <rings>
 4a8:	97aa                	add	a5,a5,a0
 4aa:	6788                	ld	a0,8(a5)
 4ac:	611c                	ld	a5,0(a0)
 4ae:	ef99                	bnez	a5,4cc <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 4b0:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 4b2:	41f7579b          	sraiw	a5,a4,0x1f
 4b6:	01d7d79b          	srliw	a5,a5,0x1d
 4ba:	9fb9                	addw	a5,a5,a4
 4bc:	4037d79b          	sraiw	a5,a5,0x3
 4c0:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 4c2:	60e2                	ld	ra,24(sp)
 4c4:	6442                	ld	s0,16(sp)
 4c6:	64a2                	ld	s1,8(sp)
 4c8:	6105                	addi	sp,sp,32
 4ca:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 4cc:	00000097          	auipc	ra,0x0
 4d0:	e1c080e7          	jalr	-484(ra) # 2e8 <load>
    *bytes /= 8;
 4d4:	41f5579b          	sraiw	a5,a0,0x1f
 4d8:	01d7d79b          	srliw	a5,a5,0x1d
 4dc:	9d3d                	addw	a0,a0,a5
 4de:	4035551b          	sraiw	a0,a0,0x3
 4e2:	c088                	sw	a0,0(s1)
}
 4e4:	bff9                	j	4c2 <ringbuf_start_read+0x36>

00000000000004e6 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 4e6:	1141                	addi	sp,sp,-16
 4e8:	e406                	sd	ra,8(sp)
 4ea:	e022                	sd	s0,0(sp)
 4ec:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 4ee:	00151793          	slli	a5,a0,0x1
 4f2:	97aa                	add	a5,a5,a0
 4f4:	078e                	slli	a5,a5,0x3
 4f6:	00001517          	auipc	a0,0x1
 4fa:	85a50513          	addi	a0,a0,-1958 # d50 <rings>
 4fe:	97aa                	add	a5,a5,a0
 500:	0035959b          	slliw	a1,a1,0x3
 504:	6788                	ld	a0,8(a5)
 506:	00000097          	auipc	ra,0x0
 50a:	dce080e7          	jalr	-562(ra) # 2d4 <store>
}
 50e:	60a2                	ld	ra,8(sp)
 510:	6402                	ld	s0,0(sp)
 512:	0141                	addi	sp,sp,16
 514:	8082                	ret

0000000000000516 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 516:	1141                	addi	sp,sp,-16
 518:	e422                	sd	s0,8(sp)
 51a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 51c:	87aa                	mv	a5,a0
 51e:	0585                	addi	a1,a1,1
 520:	0785                	addi	a5,a5,1
 522:	fff5c703          	lbu	a4,-1(a1)
 526:	fee78fa3          	sb	a4,-1(a5)
 52a:	fb75                	bnez	a4,51e <strcpy+0x8>
    ;
  return os;
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret

0000000000000532 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 532:	1141                	addi	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 538:	00054783          	lbu	a5,0(a0)
 53c:	cb91                	beqz	a5,550 <strcmp+0x1e>
 53e:	0005c703          	lbu	a4,0(a1)
 542:	00f71763          	bne	a4,a5,550 <strcmp+0x1e>
    p++, q++;
 546:	0505                	addi	a0,a0,1
 548:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 54a:	00054783          	lbu	a5,0(a0)
 54e:	fbe5                	bnez	a5,53e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 550:	0005c503          	lbu	a0,0(a1)
}
 554:	40a7853b          	subw	a0,a5,a0
 558:	6422                	ld	s0,8(sp)
 55a:	0141                	addi	sp,sp,16
 55c:	8082                	ret

000000000000055e <strlen>:

uint
strlen(const char *s)
{
 55e:	1141                	addi	sp,sp,-16
 560:	e422                	sd	s0,8(sp)
 562:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 564:	00054783          	lbu	a5,0(a0)
 568:	cf91                	beqz	a5,584 <strlen+0x26>
 56a:	0505                	addi	a0,a0,1
 56c:	87aa                	mv	a5,a0
 56e:	4685                	li	a3,1
 570:	9e89                	subw	a3,a3,a0
 572:	00f6853b          	addw	a0,a3,a5
 576:	0785                	addi	a5,a5,1
 578:	fff7c703          	lbu	a4,-1(a5)
 57c:	fb7d                	bnez	a4,572 <strlen+0x14>
    ;
  return n;
}
 57e:	6422                	ld	s0,8(sp)
 580:	0141                	addi	sp,sp,16
 582:	8082                	ret
  for(n = 0; s[n]; n++)
 584:	4501                	li	a0,0
 586:	bfe5                	j	57e <strlen+0x20>

0000000000000588 <memset>:

void*
memset(void *dst, int c, uint n)
{
 588:	1141                	addi	sp,sp,-16
 58a:	e422                	sd	s0,8(sp)
 58c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 58e:	ca19                	beqz	a2,5a4 <memset+0x1c>
 590:	87aa                	mv	a5,a0
 592:	1602                	slli	a2,a2,0x20
 594:	9201                	srli	a2,a2,0x20
 596:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 59a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 59e:	0785                	addi	a5,a5,1
 5a0:	fee79de3          	bne	a5,a4,59a <memset+0x12>
  }
  return dst;
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret

00000000000005aa <strchr>:

char*
strchr(const char *s, char c)
{
 5aa:	1141                	addi	sp,sp,-16
 5ac:	e422                	sd	s0,8(sp)
 5ae:	0800                	addi	s0,sp,16
  for(; *s; s++)
 5b0:	00054783          	lbu	a5,0(a0)
 5b4:	cb99                	beqz	a5,5ca <strchr+0x20>
    if(*s == c)
 5b6:	00f58763          	beq	a1,a5,5c4 <strchr+0x1a>
  for(; *s; s++)
 5ba:	0505                	addi	a0,a0,1
 5bc:	00054783          	lbu	a5,0(a0)
 5c0:	fbfd                	bnez	a5,5b6 <strchr+0xc>
      return (char*)s;
  return 0;
 5c2:	4501                	li	a0,0
}
 5c4:	6422                	ld	s0,8(sp)
 5c6:	0141                	addi	sp,sp,16
 5c8:	8082                	ret
  return 0;
 5ca:	4501                	li	a0,0
 5cc:	bfe5                	j	5c4 <strchr+0x1a>

00000000000005ce <gets>:

char*
gets(char *buf, int max)
{
 5ce:	711d                	addi	sp,sp,-96
 5d0:	ec86                	sd	ra,88(sp)
 5d2:	e8a2                	sd	s0,80(sp)
 5d4:	e4a6                	sd	s1,72(sp)
 5d6:	e0ca                	sd	s2,64(sp)
 5d8:	fc4e                	sd	s3,56(sp)
 5da:	f852                	sd	s4,48(sp)
 5dc:	f456                	sd	s5,40(sp)
 5de:	f05a                	sd	s6,32(sp)
 5e0:	ec5e                	sd	s7,24(sp)
 5e2:	1080                	addi	s0,sp,96
 5e4:	8baa                	mv	s7,a0
 5e6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5e8:	892a                	mv	s2,a0
 5ea:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 5ec:	4aa9                	li	s5,10
 5ee:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 5f0:	89a6                	mv	s3,s1
 5f2:	2485                	addiw	s1,s1,1
 5f4:	0344d863          	bge	s1,s4,624 <gets+0x56>
    cc = read(0, &c, 1);
 5f8:	4605                	li	a2,1
 5fa:	faf40593          	addi	a1,s0,-81
 5fe:	4501                	li	a0,0
 600:	00000097          	auipc	ra,0x0
 604:	19c080e7          	jalr	412(ra) # 79c <read>
    if(cc < 1)
 608:	00a05e63          	blez	a0,624 <gets+0x56>
    buf[i++] = c;
 60c:	faf44783          	lbu	a5,-81(s0)
 610:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 614:	01578763          	beq	a5,s5,622 <gets+0x54>
 618:	0905                	addi	s2,s2,1
 61a:	fd679be3          	bne	a5,s6,5f0 <gets+0x22>
  for(i=0; i+1 < max; ){
 61e:	89a6                	mv	s3,s1
 620:	a011                	j	624 <gets+0x56>
 622:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 624:	99de                	add	s3,s3,s7
 626:	00098023          	sb	zero,0(s3)
  return buf;
}
 62a:	855e                	mv	a0,s7
 62c:	60e6                	ld	ra,88(sp)
 62e:	6446                	ld	s0,80(sp)
 630:	64a6                	ld	s1,72(sp)
 632:	6906                	ld	s2,64(sp)
 634:	79e2                	ld	s3,56(sp)
 636:	7a42                	ld	s4,48(sp)
 638:	7aa2                	ld	s5,40(sp)
 63a:	7b02                	ld	s6,32(sp)
 63c:	6be2                	ld	s7,24(sp)
 63e:	6125                	addi	sp,sp,96
 640:	8082                	ret

0000000000000642 <stat>:

int
stat(const char *n, struct stat *st)
{
 642:	1101                	addi	sp,sp,-32
 644:	ec06                	sd	ra,24(sp)
 646:	e822                	sd	s0,16(sp)
 648:	e426                	sd	s1,8(sp)
 64a:	e04a                	sd	s2,0(sp)
 64c:	1000                	addi	s0,sp,32
 64e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 650:	4581                	li	a1,0
 652:	00000097          	auipc	ra,0x0
 656:	172080e7          	jalr	370(ra) # 7c4 <open>
  if(fd < 0)
 65a:	02054563          	bltz	a0,684 <stat+0x42>
 65e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 660:	85ca                	mv	a1,s2
 662:	00000097          	auipc	ra,0x0
 666:	17a080e7          	jalr	378(ra) # 7dc <fstat>
 66a:	892a                	mv	s2,a0
  close(fd);
 66c:	8526                	mv	a0,s1
 66e:	00000097          	auipc	ra,0x0
 672:	13e080e7          	jalr	318(ra) # 7ac <close>
  return r;
}
 676:	854a                	mv	a0,s2
 678:	60e2                	ld	ra,24(sp)
 67a:	6442                	ld	s0,16(sp)
 67c:	64a2                	ld	s1,8(sp)
 67e:	6902                	ld	s2,0(sp)
 680:	6105                	addi	sp,sp,32
 682:	8082                	ret
    return -1;
 684:	597d                	li	s2,-1
 686:	bfc5                	j	676 <stat+0x34>

0000000000000688 <atoi>:

int
atoi(const char *s)
{
 688:	1141                	addi	sp,sp,-16
 68a:	e422                	sd	s0,8(sp)
 68c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 68e:	00054603          	lbu	a2,0(a0)
 692:	fd06079b          	addiw	a5,a2,-48
 696:	0ff7f793          	zext.b	a5,a5
 69a:	4725                	li	a4,9
 69c:	02f76963          	bltu	a4,a5,6ce <atoi+0x46>
 6a0:	86aa                	mv	a3,a0
  n = 0;
 6a2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 6a4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 6a6:	0685                	addi	a3,a3,1
 6a8:	0025179b          	slliw	a5,a0,0x2
 6ac:	9fa9                	addw	a5,a5,a0
 6ae:	0017979b          	slliw	a5,a5,0x1
 6b2:	9fb1                	addw	a5,a5,a2
 6b4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 6b8:	0006c603          	lbu	a2,0(a3)
 6bc:	fd06071b          	addiw	a4,a2,-48
 6c0:	0ff77713          	zext.b	a4,a4
 6c4:	fee5f1e3          	bgeu	a1,a4,6a6 <atoi+0x1e>
  return n;
}
 6c8:	6422                	ld	s0,8(sp)
 6ca:	0141                	addi	sp,sp,16
 6cc:	8082                	ret
  n = 0;
 6ce:	4501                	li	a0,0
 6d0:	bfe5                	j	6c8 <atoi+0x40>

00000000000006d2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6d2:	1141                	addi	sp,sp,-16
 6d4:	e422                	sd	s0,8(sp)
 6d6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6d8:	02b57463          	bgeu	a0,a1,700 <memmove+0x2e>
    while(n-- > 0)
 6dc:	00c05f63          	blez	a2,6fa <memmove+0x28>
 6e0:	1602                	slli	a2,a2,0x20
 6e2:	9201                	srli	a2,a2,0x20
 6e4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6e8:	872a                	mv	a4,a0
      *dst++ = *src++;
 6ea:	0585                	addi	a1,a1,1
 6ec:	0705                	addi	a4,a4,1
 6ee:	fff5c683          	lbu	a3,-1(a1)
 6f2:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xeace>
    while(n-- > 0)
 6f6:	fee79ae3          	bne	a5,a4,6ea <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6fa:	6422                	ld	s0,8(sp)
 6fc:	0141                	addi	sp,sp,16
 6fe:	8082                	ret
    dst += n;
 700:	00c50733          	add	a4,a0,a2
    src += n;
 704:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 706:	fec05ae3          	blez	a2,6fa <memmove+0x28>
 70a:	fff6079b          	addiw	a5,a2,-1
 70e:	1782                	slli	a5,a5,0x20
 710:	9381                	srli	a5,a5,0x20
 712:	fff7c793          	not	a5,a5
 716:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 718:	15fd                	addi	a1,a1,-1
 71a:	177d                	addi	a4,a4,-1
 71c:	0005c683          	lbu	a3,0(a1)
 720:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 724:	fee79ae3          	bne	a5,a4,718 <memmove+0x46>
 728:	bfc9                	j	6fa <memmove+0x28>

000000000000072a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 72a:	1141                	addi	sp,sp,-16
 72c:	e422                	sd	s0,8(sp)
 72e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 730:	ca05                	beqz	a2,760 <memcmp+0x36>
 732:	fff6069b          	addiw	a3,a2,-1
 736:	1682                	slli	a3,a3,0x20
 738:	9281                	srli	a3,a3,0x20
 73a:	0685                	addi	a3,a3,1
 73c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 73e:	00054783          	lbu	a5,0(a0)
 742:	0005c703          	lbu	a4,0(a1)
 746:	00e79863          	bne	a5,a4,756 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 74a:	0505                	addi	a0,a0,1
    p2++;
 74c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 74e:	fed518e3          	bne	a0,a3,73e <memcmp+0x14>
  }
  return 0;
 752:	4501                	li	a0,0
 754:	a019                	j	75a <memcmp+0x30>
      return *p1 - *p2;
 756:	40e7853b          	subw	a0,a5,a4
}
 75a:	6422                	ld	s0,8(sp)
 75c:	0141                	addi	sp,sp,16
 75e:	8082                	ret
  return 0;
 760:	4501                	li	a0,0
 762:	bfe5                	j	75a <memcmp+0x30>

0000000000000764 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 764:	1141                	addi	sp,sp,-16
 766:	e406                	sd	ra,8(sp)
 768:	e022                	sd	s0,0(sp)
 76a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 76c:	00000097          	auipc	ra,0x0
 770:	f66080e7          	jalr	-154(ra) # 6d2 <memmove>
}
 774:	60a2                	ld	ra,8(sp)
 776:	6402                	ld	s0,0(sp)
 778:	0141                	addi	sp,sp,16
 77a:	8082                	ret

000000000000077c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 77c:	4885                	li	a7,1
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <exit>:
.global exit
exit:
 li a7, SYS_exit
 784:	4889                	li	a7,2
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <wait>:
.global wait
wait:
 li a7, SYS_wait
 78c:	488d                	li	a7,3
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 794:	4891                	li	a7,4
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <read>:
.global read
read:
 li a7, SYS_read
 79c:	4895                	li	a7,5
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <write>:
.global write
write:
 li a7, SYS_write
 7a4:	48c1                	li	a7,16
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <close>:
.global close
close:
 li a7, SYS_close
 7ac:	48d5                	li	a7,21
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 7b4:	4899                	li	a7,6
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <exec>:
.global exec
exec:
 li a7, SYS_exec
 7bc:	489d                	li	a7,7
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <open>:
.global open
open:
 li a7, SYS_open
 7c4:	48bd                	li	a7,15
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7cc:	48c5                	li	a7,17
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7d4:	48c9                	li	a7,18
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7dc:	48a1                	li	a7,8
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <link>:
.global link
link:
 li a7, SYS_link
 7e4:	48cd                	li	a7,19
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7ec:	48d1                	li	a7,20
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7f4:	48a5                	li	a7,9
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <dup>:
.global dup
dup:
 li a7, SYS_dup
 7fc:	48a9                	li	a7,10
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 804:	48ad                	li	a7,11
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 80c:	48b1                	li	a7,12
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 814:	48b5                	li	a7,13
 ecall
 816:	00000073          	ecall
 ret
 81a:	8082                	ret

000000000000081c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 81c:	48b9                	li	a7,14
 ecall
 81e:	00000073          	ecall
 ret
 822:	8082                	ret

0000000000000824 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 824:	48d9                	li	a7,22
 ecall
 826:	00000073          	ecall
 ret
 82a:	8082                	ret

000000000000082c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 82c:	1101                	addi	sp,sp,-32
 82e:	ec06                	sd	ra,24(sp)
 830:	e822                	sd	s0,16(sp)
 832:	1000                	addi	s0,sp,32
 834:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 838:	4605                	li	a2,1
 83a:	fef40593          	addi	a1,s0,-17
 83e:	00000097          	auipc	ra,0x0
 842:	f66080e7          	jalr	-154(ra) # 7a4 <write>
}
 846:	60e2                	ld	ra,24(sp)
 848:	6442                	ld	s0,16(sp)
 84a:	6105                	addi	sp,sp,32
 84c:	8082                	ret

000000000000084e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 84e:	7139                	addi	sp,sp,-64
 850:	fc06                	sd	ra,56(sp)
 852:	f822                	sd	s0,48(sp)
 854:	f426                	sd	s1,40(sp)
 856:	f04a                	sd	s2,32(sp)
 858:	ec4e                	sd	s3,24(sp)
 85a:	0080                	addi	s0,sp,64
 85c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 85e:	c299                	beqz	a3,864 <printint+0x16>
 860:	0805c863          	bltz	a1,8f0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 864:	2581                	sext.w	a1,a1
  neg = 0;
 866:	4881                	li	a7,0
 868:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 86c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 86e:	2601                	sext.w	a2,a2
 870:	00000517          	auipc	a0,0x0
 874:	4b050513          	addi	a0,a0,1200 # d20 <digits>
 878:	883a                	mv	a6,a4
 87a:	2705                	addiw	a4,a4,1
 87c:	02c5f7bb          	remuw	a5,a1,a2
 880:	1782                	slli	a5,a5,0x20
 882:	9381                	srli	a5,a5,0x20
 884:	97aa                	add	a5,a5,a0
 886:	0007c783          	lbu	a5,0(a5)
 88a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 88e:	0005879b          	sext.w	a5,a1
 892:	02c5d5bb          	divuw	a1,a1,a2
 896:	0685                	addi	a3,a3,1
 898:	fec7f0e3          	bgeu	a5,a2,878 <printint+0x2a>
  if(neg)
 89c:	00088b63          	beqz	a7,8b2 <printint+0x64>
    buf[i++] = '-';
 8a0:	fd040793          	addi	a5,s0,-48
 8a4:	973e                	add	a4,a4,a5
 8a6:	02d00793          	li	a5,45
 8aa:	fef70823          	sb	a5,-16(a4)
 8ae:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 8b2:	02e05863          	blez	a4,8e2 <printint+0x94>
 8b6:	fc040793          	addi	a5,s0,-64
 8ba:	00e78933          	add	s2,a5,a4
 8be:	fff78993          	addi	s3,a5,-1
 8c2:	99ba                	add	s3,s3,a4
 8c4:	377d                	addiw	a4,a4,-1
 8c6:	1702                	slli	a4,a4,0x20
 8c8:	9301                	srli	a4,a4,0x20
 8ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8ce:	fff94583          	lbu	a1,-1(s2)
 8d2:	8526                	mv	a0,s1
 8d4:	00000097          	auipc	ra,0x0
 8d8:	f58080e7          	jalr	-168(ra) # 82c <putc>
  while(--i >= 0)
 8dc:	197d                	addi	s2,s2,-1
 8de:	ff3918e3          	bne	s2,s3,8ce <printint+0x80>
}
 8e2:	70e2                	ld	ra,56(sp)
 8e4:	7442                	ld	s0,48(sp)
 8e6:	74a2                	ld	s1,40(sp)
 8e8:	7902                	ld	s2,32(sp)
 8ea:	69e2                	ld	s3,24(sp)
 8ec:	6121                	addi	sp,sp,64
 8ee:	8082                	ret
    x = -xx;
 8f0:	40b005bb          	negw	a1,a1
    neg = 1;
 8f4:	4885                	li	a7,1
    x = -xx;
 8f6:	bf8d                	j	868 <printint+0x1a>

00000000000008f8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8f8:	7119                	addi	sp,sp,-128
 8fa:	fc86                	sd	ra,120(sp)
 8fc:	f8a2                	sd	s0,112(sp)
 8fe:	f4a6                	sd	s1,104(sp)
 900:	f0ca                	sd	s2,96(sp)
 902:	ecce                	sd	s3,88(sp)
 904:	e8d2                	sd	s4,80(sp)
 906:	e4d6                	sd	s5,72(sp)
 908:	e0da                	sd	s6,64(sp)
 90a:	fc5e                	sd	s7,56(sp)
 90c:	f862                	sd	s8,48(sp)
 90e:	f466                	sd	s9,40(sp)
 910:	f06a                	sd	s10,32(sp)
 912:	ec6e                	sd	s11,24(sp)
 914:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 916:	0005c903          	lbu	s2,0(a1)
 91a:	18090f63          	beqz	s2,ab8 <vprintf+0x1c0>
 91e:	8aaa                	mv	s5,a0
 920:	8b32                	mv	s6,a2
 922:	00158493          	addi	s1,a1,1
  state = 0;
 926:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 928:	02500a13          	li	s4,37
      if(c == 'd'){
 92c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 930:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 934:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 938:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 93c:	00000b97          	auipc	s7,0x0
 940:	3e4b8b93          	addi	s7,s7,996 # d20 <digits>
 944:	a839                	j	962 <vprintf+0x6a>
        putc(fd, c);
 946:	85ca                	mv	a1,s2
 948:	8556                	mv	a0,s5
 94a:	00000097          	auipc	ra,0x0
 94e:	ee2080e7          	jalr	-286(ra) # 82c <putc>
 952:	a019                	j	958 <vprintf+0x60>
    } else if(state == '%'){
 954:	01498f63          	beq	s3,s4,972 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 958:	0485                	addi	s1,s1,1
 95a:	fff4c903          	lbu	s2,-1(s1)
 95e:	14090d63          	beqz	s2,ab8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 962:	0009079b          	sext.w	a5,s2
    if(state == 0){
 966:	fe0997e3          	bnez	s3,954 <vprintf+0x5c>
      if(c == '%'){
 96a:	fd479ee3          	bne	a5,s4,946 <vprintf+0x4e>
        state = '%';
 96e:	89be                	mv	s3,a5
 970:	b7e5                	j	958 <vprintf+0x60>
      if(c == 'd'){
 972:	05878063          	beq	a5,s8,9b2 <vprintf+0xba>
      } else if(c == 'l') {
 976:	05978c63          	beq	a5,s9,9ce <vprintf+0xd6>
      } else if(c == 'x') {
 97a:	07a78863          	beq	a5,s10,9ea <vprintf+0xf2>
      } else if(c == 'p') {
 97e:	09b78463          	beq	a5,s11,a06 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 982:	07300713          	li	a4,115
 986:	0ce78663          	beq	a5,a4,a52 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 98a:	06300713          	li	a4,99
 98e:	0ee78e63          	beq	a5,a4,a8a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 992:	11478863          	beq	a5,s4,aa2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 996:	85d2                	mv	a1,s4
 998:	8556                	mv	a0,s5
 99a:	00000097          	auipc	ra,0x0
 99e:	e92080e7          	jalr	-366(ra) # 82c <putc>
        putc(fd, c);
 9a2:	85ca                	mv	a1,s2
 9a4:	8556                	mv	a0,s5
 9a6:	00000097          	auipc	ra,0x0
 9aa:	e86080e7          	jalr	-378(ra) # 82c <putc>
      }
      state = 0;
 9ae:	4981                	li	s3,0
 9b0:	b765                	j	958 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 9b2:	008b0913          	addi	s2,s6,8
 9b6:	4685                	li	a3,1
 9b8:	4629                	li	a2,10
 9ba:	000b2583          	lw	a1,0(s6)
 9be:	8556                	mv	a0,s5
 9c0:	00000097          	auipc	ra,0x0
 9c4:	e8e080e7          	jalr	-370(ra) # 84e <printint>
 9c8:	8b4a                	mv	s6,s2
      state = 0;
 9ca:	4981                	li	s3,0
 9cc:	b771                	j	958 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9ce:	008b0913          	addi	s2,s6,8
 9d2:	4681                	li	a3,0
 9d4:	4629                	li	a2,10
 9d6:	000b2583          	lw	a1,0(s6)
 9da:	8556                	mv	a0,s5
 9dc:	00000097          	auipc	ra,0x0
 9e0:	e72080e7          	jalr	-398(ra) # 84e <printint>
 9e4:	8b4a                	mv	s6,s2
      state = 0;
 9e6:	4981                	li	s3,0
 9e8:	bf85                	j	958 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9ea:	008b0913          	addi	s2,s6,8
 9ee:	4681                	li	a3,0
 9f0:	4641                	li	a2,16
 9f2:	000b2583          	lw	a1,0(s6)
 9f6:	8556                	mv	a0,s5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	e56080e7          	jalr	-426(ra) # 84e <printint>
 a00:	8b4a                	mv	s6,s2
      state = 0;
 a02:	4981                	li	s3,0
 a04:	bf91                	j	958 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 a06:	008b0793          	addi	a5,s6,8
 a0a:	f8f43423          	sd	a5,-120(s0)
 a0e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 a12:	03000593          	li	a1,48
 a16:	8556                	mv	a0,s5
 a18:	00000097          	auipc	ra,0x0
 a1c:	e14080e7          	jalr	-492(ra) # 82c <putc>
  putc(fd, 'x');
 a20:	85ea                	mv	a1,s10
 a22:	8556                	mv	a0,s5
 a24:	00000097          	auipc	ra,0x0
 a28:	e08080e7          	jalr	-504(ra) # 82c <putc>
 a2c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a2e:	03c9d793          	srli	a5,s3,0x3c
 a32:	97de                	add	a5,a5,s7
 a34:	0007c583          	lbu	a1,0(a5)
 a38:	8556                	mv	a0,s5
 a3a:	00000097          	auipc	ra,0x0
 a3e:	df2080e7          	jalr	-526(ra) # 82c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a42:	0992                	slli	s3,s3,0x4
 a44:	397d                	addiw	s2,s2,-1
 a46:	fe0914e3          	bnez	s2,a2e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 a4a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a4e:	4981                	li	s3,0
 a50:	b721                	j	958 <vprintf+0x60>
        s = va_arg(ap, char*);
 a52:	008b0993          	addi	s3,s6,8
 a56:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 a5a:	02090163          	beqz	s2,a7c <vprintf+0x184>
        while(*s != 0){
 a5e:	00094583          	lbu	a1,0(s2)
 a62:	c9a1                	beqz	a1,ab2 <vprintf+0x1ba>
          putc(fd, *s);
 a64:	8556                	mv	a0,s5
 a66:	00000097          	auipc	ra,0x0
 a6a:	dc6080e7          	jalr	-570(ra) # 82c <putc>
          s++;
 a6e:	0905                	addi	s2,s2,1
        while(*s != 0){
 a70:	00094583          	lbu	a1,0(s2)
 a74:	f9e5                	bnez	a1,a64 <vprintf+0x16c>
        s = va_arg(ap, char*);
 a76:	8b4e                	mv	s6,s3
      state = 0;
 a78:	4981                	li	s3,0
 a7a:	bdf9                	j	958 <vprintf+0x60>
          s = "(null)";
 a7c:	00000917          	auipc	s2,0x0
 a80:	29c90913          	addi	s2,s2,668 # d18 <malloc+0x156>
        while(*s != 0){
 a84:	02800593          	li	a1,40
 a88:	bff1                	j	a64 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 a8a:	008b0913          	addi	s2,s6,8
 a8e:	000b4583          	lbu	a1,0(s6)
 a92:	8556                	mv	a0,s5
 a94:	00000097          	auipc	ra,0x0
 a98:	d98080e7          	jalr	-616(ra) # 82c <putc>
 a9c:	8b4a                	mv	s6,s2
      state = 0;
 a9e:	4981                	li	s3,0
 aa0:	bd65                	j	958 <vprintf+0x60>
        putc(fd, c);
 aa2:	85d2                	mv	a1,s4
 aa4:	8556                	mv	a0,s5
 aa6:	00000097          	auipc	ra,0x0
 aaa:	d86080e7          	jalr	-634(ra) # 82c <putc>
      state = 0;
 aae:	4981                	li	s3,0
 ab0:	b565                	j	958 <vprintf+0x60>
        s = va_arg(ap, char*);
 ab2:	8b4e                	mv	s6,s3
      state = 0;
 ab4:	4981                	li	s3,0
 ab6:	b54d                	j	958 <vprintf+0x60>
    }
  }
}
 ab8:	70e6                	ld	ra,120(sp)
 aba:	7446                	ld	s0,112(sp)
 abc:	74a6                	ld	s1,104(sp)
 abe:	7906                	ld	s2,96(sp)
 ac0:	69e6                	ld	s3,88(sp)
 ac2:	6a46                	ld	s4,80(sp)
 ac4:	6aa6                	ld	s5,72(sp)
 ac6:	6b06                	ld	s6,64(sp)
 ac8:	7be2                	ld	s7,56(sp)
 aca:	7c42                	ld	s8,48(sp)
 acc:	7ca2                	ld	s9,40(sp)
 ace:	7d02                	ld	s10,32(sp)
 ad0:	6de2                	ld	s11,24(sp)
 ad2:	6109                	addi	sp,sp,128
 ad4:	8082                	ret

0000000000000ad6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 ad6:	715d                	addi	sp,sp,-80
 ad8:	ec06                	sd	ra,24(sp)
 ada:	e822                	sd	s0,16(sp)
 adc:	1000                	addi	s0,sp,32
 ade:	e010                	sd	a2,0(s0)
 ae0:	e414                	sd	a3,8(s0)
 ae2:	e818                	sd	a4,16(s0)
 ae4:	ec1c                	sd	a5,24(s0)
 ae6:	03043023          	sd	a6,32(s0)
 aea:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 aee:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 af2:	8622                	mv	a2,s0
 af4:	00000097          	auipc	ra,0x0
 af8:	e04080e7          	jalr	-508(ra) # 8f8 <vprintf>
}
 afc:	60e2                	ld	ra,24(sp)
 afe:	6442                	ld	s0,16(sp)
 b00:	6161                	addi	sp,sp,80
 b02:	8082                	ret

0000000000000b04 <printf>:

void
printf(const char *fmt, ...)
{
 b04:	711d                	addi	sp,sp,-96
 b06:	ec06                	sd	ra,24(sp)
 b08:	e822                	sd	s0,16(sp)
 b0a:	1000                	addi	s0,sp,32
 b0c:	e40c                	sd	a1,8(s0)
 b0e:	e810                	sd	a2,16(s0)
 b10:	ec14                	sd	a3,24(s0)
 b12:	f018                	sd	a4,32(s0)
 b14:	f41c                	sd	a5,40(s0)
 b16:	03043823          	sd	a6,48(s0)
 b1a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b1e:	00840613          	addi	a2,s0,8
 b22:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b26:	85aa                	mv	a1,a0
 b28:	4505                	li	a0,1
 b2a:	00000097          	auipc	ra,0x0
 b2e:	dce080e7          	jalr	-562(ra) # 8f8 <vprintf>
}
 b32:	60e2                	ld	ra,24(sp)
 b34:	6442                	ld	s0,16(sp)
 b36:	6125                	addi	sp,sp,96
 b38:	8082                	ret

0000000000000b3a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b3a:	1141                	addi	sp,sp,-16
 b3c:	e422                	sd	s0,8(sp)
 b3e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b40:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b44:	00000797          	auipc	a5,0x0
 b48:	1f47b783          	ld	a5,500(a5) # d38 <freep>
 b4c:	a805                	j	b7c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b4e:	4618                	lw	a4,8(a2)
 b50:	9db9                	addw	a1,a1,a4
 b52:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b56:	6398                	ld	a4,0(a5)
 b58:	6318                	ld	a4,0(a4)
 b5a:	fee53823          	sd	a4,-16(a0)
 b5e:	a091                	j	ba2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b60:	ff852703          	lw	a4,-8(a0)
 b64:	9e39                	addw	a2,a2,a4
 b66:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 b68:	ff053703          	ld	a4,-16(a0)
 b6c:	e398                	sd	a4,0(a5)
 b6e:	a099                	j	bb4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b70:	6398                	ld	a4,0(a5)
 b72:	00e7e463          	bltu	a5,a4,b7a <free+0x40>
 b76:	00e6ea63          	bltu	a3,a4,b8a <free+0x50>
{
 b7a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b7c:	fed7fae3          	bgeu	a5,a3,b70 <free+0x36>
 b80:	6398                	ld	a4,0(a5)
 b82:	00e6e463          	bltu	a3,a4,b8a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b86:	fee7eae3          	bltu	a5,a4,b7a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 b8a:	ff852583          	lw	a1,-8(a0)
 b8e:	6390                	ld	a2,0(a5)
 b90:	02059813          	slli	a6,a1,0x20
 b94:	01c85713          	srli	a4,a6,0x1c
 b98:	9736                	add	a4,a4,a3
 b9a:	fae60ae3          	beq	a2,a4,b4e <free+0x14>
    bp->s.ptr = p->s.ptr;
 b9e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ba2:	4790                	lw	a2,8(a5)
 ba4:	02061593          	slli	a1,a2,0x20
 ba8:	01c5d713          	srli	a4,a1,0x1c
 bac:	973e                	add	a4,a4,a5
 bae:	fae689e3          	beq	a3,a4,b60 <free+0x26>
  } else
    p->s.ptr = bp;
 bb2:	e394                	sd	a3,0(a5)
  freep = p;
 bb4:	00000717          	auipc	a4,0x0
 bb8:	18f73223          	sd	a5,388(a4) # d38 <freep>
}
 bbc:	6422                	ld	s0,8(sp)
 bbe:	0141                	addi	sp,sp,16
 bc0:	8082                	ret

0000000000000bc2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 bc2:	7139                	addi	sp,sp,-64
 bc4:	fc06                	sd	ra,56(sp)
 bc6:	f822                	sd	s0,48(sp)
 bc8:	f426                	sd	s1,40(sp)
 bca:	f04a                	sd	s2,32(sp)
 bcc:	ec4e                	sd	s3,24(sp)
 bce:	e852                	sd	s4,16(sp)
 bd0:	e456                	sd	s5,8(sp)
 bd2:	e05a                	sd	s6,0(sp)
 bd4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bd6:	02051493          	slli	s1,a0,0x20
 bda:	9081                	srli	s1,s1,0x20
 bdc:	04bd                	addi	s1,s1,15
 bde:	8091                	srli	s1,s1,0x4
 be0:	0014899b          	addiw	s3,s1,1
 be4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 be6:	00000517          	auipc	a0,0x0
 bea:	15253503          	ld	a0,338(a0) # d38 <freep>
 bee:	c515                	beqz	a0,c1a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bf0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bf2:	4798                	lw	a4,8(a5)
 bf4:	02977f63          	bgeu	a4,s1,c32 <malloc+0x70>
 bf8:	8a4e                	mv	s4,s3
 bfa:	0009871b          	sext.w	a4,s3
 bfe:	6685                	lui	a3,0x1
 c00:	00d77363          	bgeu	a4,a3,c06 <malloc+0x44>
 c04:	6a05                	lui	s4,0x1
 c06:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 c0a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c0e:	00000917          	auipc	s2,0x0
 c12:	12a90913          	addi	s2,s2,298 # d38 <freep>
  if(p == (char*)-1)
 c16:	5afd                	li	s5,-1
 c18:	a895                	j	c8c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 c1a:	00000797          	auipc	a5,0x0
 c1e:	22678793          	addi	a5,a5,550 # e40 <base>
 c22:	00000717          	auipc	a4,0x0
 c26:	10f73b23          	sd	a5,278(a4) # d38 <freep>
 c2a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c2c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c30:	b7e1                	j	bf8 <malloc+0x36>
      if(p->s.size == nunits)
 c32:	02e48c63          	beq	s1,a4,c6a <malloc+0xa8>
        p->s.size -= nunits;
 c36:	4137073b          	subw	a4,a4,s3
 c3a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c3c:	02071693          	slli	a3,a4,0x20
 c40:	01c6d713          	srli	a4,a3,0x1c
 c44:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c46:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c4a:	00000717          	auipc	a4,0x0
 c4e:	0ea73723          	sd	a0,238(a4) # d38 <freep>
      return (void*)(p + 1);
 c52:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c56:	70e2                	ld	ra,56(sp)
 c58:	7442                	ld	s0,48(sp)
 c5a:	74a2                	ld	s1,40(sp)
 c5c:	7902                	ld	s2,32(sp)
 c5e:	69e2                	ld	s3,24(sp)
 c60:	6a42                	ld	s4,16(sp)
 c62:	6aa2                	ld	s5,8(sp)
 c64:	6b02                	ld	s6,0(sp)
 c66:	6121                	addi	sp,sp,64
 c68:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c6a:	6398                	ld	a4,0(a5)
 c6c:	e118                	sd	a4,0(a0)
 c6e:	bff1                	j	c4a <malloc+0x88>
  hp->s.size = nu;
 c70:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c74:	0541                	addi	a0,a0,16
 c76:	00000097          	auipc	ra,0x0
 c7a:	ec4080e7          	jalr	-316(ra) # b3a <free>
  return freep;
 c7e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c82:	d971                	beqz	a0,c56 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c84:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c86:	4798                	lw	a4,8(a5)
 c88:	fa9775e3          	bgeu	a4,s1,c32 <malloc+0x70>
    if(p == freep)
 c8c:	00093703          	ld	a4,0(s2)
 c90:	853e                	mv	a0,a5
 c92:	fef719e3          	bne	a4,a5,c84 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 c96:	8552                	mv	a0,s4
 c98:	00000097          	auipc	ra,0x0
 c9c:	b74080e7          	jalr	-1164(ra) # 80c <sbrk>
  if(p == (char*)-1)
 ca0:	fd5518e3          	bne	a0,s5,c70 <malloc+0xae>
        return 0;
 ca4:	4501                	li	a0,0
 ca6:	bf45                	j	c56 <malloc+0x94>
