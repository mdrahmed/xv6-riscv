
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

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
      18:	31d68693          	addi	a3,a3,797 # 1f31d <__global_pointer$+0x1d254>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <__global_pointer$+0x20de>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffd423>
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
      60:	00002517          	auipc	a0,0x2
      64:	87050513          	addi	a0,a0,-1936 # 18d0 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	addi	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	addi	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	addi	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	098080e7          	jalr	152(ra) # 1128 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	52e50513          	addi	a0,a0,1326 # 15c8 <malloc+0xea>
      a2:	00001097          	auipc	ra,0x1
      a6:	066080e7          	jalr	102(ra) # 1108 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	51e50513          	addi	a0,a0,1310 # 15c8 <malloc+0xea>
      b2:	00001097          	auipc	ra,0x1
      b6:	05e080e7          	jalr	94(ra) # 1110 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	51450513          	addi	a0,a0,1300 # 15d0 <malloc+0xf2>
      c4:	00001097          	auipc	ra,0x1
      c8:	35c080e7          	jalr	860(ra) # 1420 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	fd2080e7          	jalr	-46(ra) # 10a0 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	51a50513          	addi	a0,a0,1306 # 15f0 <malloc+0x112>
      de:	00001097          	auipc	ra,0x1
      e2:	032080e7          	jalr	50(ra) # 1110 <chdir>
  
  while(1){
    iters++;
    if((iters % 500) == 0)
      e6:	00001997          	auipc	s3,0x1
      ea:	51a98993          	addi	s3,s3,1306 # 1600 <malloc+0x122>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	50898993          	addi	s3,s3,1288 # 15f8 <malloc+0x11a>
    iters++;
      f8:	4485                	li	s1,1
  int fd = -1;
      fa:	597d                	li	s2,-1
      close(fd);
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
      fc:	00001a17          	auipc	s4,0x1
     100:	7eca0a13          	addi	s4,s4,2028 # 18e8 <buf.0>
     104:	a825                	j	13c <go+0xc4>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	4fe50513          	addi	a0,a0,1278 # 1608 <malloc+0x12a>
     112:	00001097          	auipc	ra,0x1
     116:	fce080e7          	jalr	-50(ra) # 10e0 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	fae080e7          	jalr	-82(ra) # 10c8 <close>
    iters++;
     122:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	f8c080e7          	jalr	-116(ra) # 10c0 <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	4789                	li	a5,2
     152:	18f50563          	beq	a0,a5,2dc <go+0x264>
    } else if(what == 3){
     156:	478d                	li	a5,3
     158:	1af50163          	beq	a0,a5,2fa <go+0x282>
    } else if(what == 4){
     15c:	4791                	li	a5,4
     15e:	1af50763          	beq	a0,a5,30c <go+0x294>
    } else if(what == 5){
     162:	4795                	li	a5,5
     164:	1ef50b63          	beq	a0,a5,35a <go+0x2e2>
    } else if(what == 6){
     168:	4799                	li	a5,6
     16a:	20f50963          	beq	a0,a5,37c <go+0x304>
    } else if(what == 7){
     16e:	479d                	li	a5,7
     170:	22f50763          	beq	a0,a5,39e <go+0x326>
    } else if(what == 8){
     174:	47a1                	li	a5,8
     176:	22f50d63          	beq	a0,a5,3b0 <go+0x338>
    } else if(what == 9){
     17a:	47a5                	li	a5,9
     17c:	24f50363          	beq	a0,a5,3c2 <go+0x34a>
      mkdir("grindir/../a");
      close(open("a/../a/./a", O_CREATE|O_RDWR));
      unlink("a/a");
    } else if(what == 10){
     180:	47a9                	li	a5,10
     182:	26f50f63          	beq	a0,a5,400 <go+0x388>
      mkdir("/../b");
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
      unlink("b/b");
    } else if(what == 11){
     186:	47ad                	li	a5,11
     188:	2af50b63          	beq	a0,a5,43e <go+0x3c6>
      unlink("b");
      link("../grindir/./../a", "../b");
    } else if(what == 12){
     18c:	47b1                	li	a5,12
     18e:	2cf50d63          	beq	a0,a5,468 <go+0x3f0>
      unlink("../grindir/../a");
      link(".././b", "/grindir/../a");
    } else if(what == 13){
     192:	47b5                	li	a5,13
     194:	2ef50f63          	beq	a0,a5,492 <go+0x41a>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 14){
     198:	47b9                	li	a5,14
     19a:	32f50a63          	beq	a0,a5,4ce <go+0x456>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 15){
     19e:	47bd                	li	a5,15
     1a0:	36f50e63          	beq	a0,a5,51c <go+0x4a4>
      sbrk(6011);
    } else if(what == 16){
     1a4:	47c1                	li	a5,16
     1a6:	38f50363          	beq	a0,a5,52c <go+0x4b4>
      if(sbrk(0) > break0)
        sbrk(-(sbrk(0) - break0));
    } else if(what == 17){
     1aa:	47c5                	li	a5,17
     1ac:	3af50363          	beq	a0,a5,552 <go+0x4da>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
      wait(0);
    } else if(what == 18){
     1b0:	47c9                	li	a5,18
     1b2:	42f50963          	beq	a0,a5,5e4 <go+0x56c>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 19){
     1b6:	47cd                	li	a5,19
     1b8:	46f50d63          	beq	a0,a5,632 <go+0x5ba>
        exit(1);
      }
      close(fds[0]);
      close(fds[1]);
      wait(0);
    } else if(what == 20){
     1bc:	47d1                	li	a5,20
     1be:	54f50e63          	beq	a0,a5,71a <go+0x6a2>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 21){
     1c2:	47d5                	li	a5,21
     1c4:	5ef50c63          	beq	a0,a5,7bc <go+0x744>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
      unlink("c");
    } else if(what == 22){
     1c8:	47d9                	li	a5,22
     1ca:	f4f51ce3          	bne	a0,a5,122 <go+0xaa>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     1ce:	f9840513          	addi	a0,s0,-104
     1d2:	00001097          	auipc	ra,0x1
     1d6:	ede080e7          	jalr	-290(ra) # 10b0 <pipe>
     1da:	6e054563          	bltz	a0,8c4 <go+0x84c>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     1de:	fa040513          	addi	a0,s0,-96
     1e2:	00001097          	auipc	ra,0x1
     1e6:	ece080e7          	jalr	-306(ra) # 10b0 <pipe>
     1ea:	6e054b63          	bltz	a0,8e0 <go+0x868>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     1ee:	00001097          	auipc	ra,0x1
     1f2:	eaa080e7          	jalr	-342(ra) # 1098 <fork>
      if(pid1 == 0){
     1f6:	70050363          	beqz	a0,8fc <go+0x884>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     1fa:	7a054b63          	bltz	a0,9b0 <go+0x938>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     1fe:	00001097          	auipc	ra,0x1
     202:	e9a080e7          	jalr	-358(ra) # 1098 <fork>
      if(pid2 == 0){
     206:	7c050363          	beqz	a0,9cc <go+0x954>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     20a:	08054fe3          	bltz	a0,aa8 <go+0xa30>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     20e:	f9842503          	lw	a0,-104(s0)
     212:	00001097          	auipc	ra,0x1
     216:	eb6080e7          	jalr	-330(ra) # 10c8 <close>
      close(aa[1]);
     21a:	f9c42503          	lw	a0,-100(s0)
     21e:	00001097          	auipc	ra,0x1
     222:	eaa080e7          	jalr	-342(ra) # 10c8 <close>
      close(bb[1]);
     226:	fa442503          	lw	a0,-92(s0)
     22a:	00001097          	auipc	ra,0x1
     22e:	e9e080e7          	jalr	-354(ra) # 10c8 <close>
      char buf[4] = { 0, 0, 0, 0 };
     232:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     236:	4605                	li	a2,1
     238:	f9040593          	addi	a1,s0,-112
     23c:	fa042503          	lw	a0,-96(s0)
     240:	00001097          	auipc	ra,0x1
     244:	e78080e7          	jalr	-392(ra) # 10b8 <read>
      read(bb[0], buf+1, 1);
     248:	4605                	li	a2,1
     24a:	f9140593          	addi	a1,s0,-111
     24e:	fa042503          	lw	a0,-96(s0)
     252:	00001097          	auipc	ra,0x1
     256:	e66080e7          	jalr	-410(ra) # 10b8 <read>
      read(bb[0], buf+2, 1);
     25a:	4605                	li	a2,1
     25c:	f9240593          	addi	a1,s0,-110
     260:	fa042503          	lw	a0,-96(s0)
     264:	00001097          	auipc	ra,0x1
     268:	e54080e7          	jalr	-428(ra) # 10b8 <read>
      close(bb[0]);
     26c:	fa042503          	lw	a0,-96(s0)
     270:	00001097          	auipc	ra,0x1
     274:	e58080e7          	jalr	-424(ra) # 10c8 <close>
      int st1, st2;
      wait(&st1);
     278:	f9440513          	addi	a0,s0,-108
     27c:	00001097          	auipc	ra,0x1
     280:	e2c080e7          	jalr	-468(ra) # 10a8 <wait>
      wait(&st2);
     284:	fa840513          	addi	a0,s0,-88
     288:	00001097          	auipc	ra,0x1
     28c:	e20080e7          	jalr	-480(ra) # 10a8 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     290:	f9442783          	lw	a5,-108(s0)
     294:	fa842703          	lw	a4,-88(s0)
     298:	8fd9                	or	a5,a5,a4
     29a:	2781                	sext.w	a5,a5
     29c:	ef89                	bnez	a5,2b6 <go+0x23e>
     29e:	00001597          	auipc	a1,0x1
     2a2:	5e258593          	addi	a1,a1,1506 # 1880 <malloc+0x3a2>
     2a6:	f9040513          	addi	a0,s0,-112
     2aa:	00001097          	auipc	ra,0x1
     2ae:	ba4080e7          	jalr	-1116(ra) # e4e <strcmp>
     2b2:	e60508e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     2b6:	f9040693          	addi	a3,s0,-112
     2ba:	fa842603          	lw	a2,-88(s0)
     2be:	f9442583          	lw	a1,-108(s0)
     2c2:	00001517          	auipc	a0,0x1
     2c6:	5c650513          	addi	a0,a0,1478 # 1888 <malloc+0x3aa>
     2ca:	00001097          	auipc	ra,0x1
     2ce:	156080e7          	jalr	342(ra) # 1420 <printf>
        exit(1);
     2d2:	4505                	li	a0,1
     2d4:	00001097          	auipc	ra,0x1
     2d8:	dcc080e7          	jalr	-564(ra) # 10a0 <exit>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     2dc:	20200593          	li	a1,514
     2e0:	00001517          	auipc	a0,0x1
     2e4:	33850513          	addi	a0,a0,824 # 1618 <malloc+0x13a>
     2e8:	00001097          	auipc	ra,0x1
     2ec:	df8080e7          	jalr	-520(ra) # 10e0 <open>
     2f0:	00001097          	auipc	ra,0x1
     2f4:	dd8080e7          	jalr	-552(ra) # 10c8 <close>
     2f8:	b52d                	j	122 <go+0xaa>
      unlink("grindir/../a");
     2fa:	00001517          	auipc	a0,0x1
     2fe:	30e50513          	addi	a0,a0,782 # 1608 <malloc+0x12a>
     302:	00001097          	auipc	ra,0x1
     306:	dee080e7          	jalr	-530(ra) # 10f0 <unlink>
     30a:	bd21                	j	122 <go+0xaa>
      if(chdir("grindir") != 0){
     30c:	00001517          	auipc	a0,0x1
     310:	2bc50513          	addi	a0,a0,700 # 15c8 <malloc+0xea>
     314:	00001097          	auipc	ra,0x1
     318:	dfc080e7          	jalr	-516(ra) # 1110 <chdir>
     31c:	e115                	bnez	a0,340 <go+0x2c8>
      unlink("../b");
     31e:	00001517          	auipc	a0,0x1
     322:	31250513          	addi	a0,a0,786 # 1630 <malloc+0x152>
     326:	00001097          	auipc	ra,0x1
     32a:	dca080e7          	jalr	-566(ra) # 10f0 <unlink>
      chdir("/");
     32e:	00001517          	auipc	a0,0x1
     332:	2c250513          	addi	a0,a0,706 # 15f0 <malloc+0x112>
     336:	00001097          	auipc	ra,0x1
     33a:	dda080e7          	jalr	-550(ra) # 1110 <chdir>
     33e:	b3d5                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     340:	00001517          	auipc	a0,0x1
     344:	29050513          	addi	a0,a0,656 # 15d0 <malloc+0xf2>
     348:	00001097          	auipc	ra,0x1
     34c:	0d8080e7          	jalr	216(ra) # 1420 <printf>
        exit(1);
     350:	4505                	li	a0,1
     352:	00001097          	auipc	ra,0x1
     356:	d4e080e7          	jalr	-690(ra) # 10a0 <exit>
      close(fd);
     35a:	854a                	mv	a0,s2
     35c:	00001097          	auipc	ra,0x1
     360:	d6c080e7          	jalr	-660(ra) # 10c8 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     364:	20200593          	li	a1,514
     368:	00001517          	auipc	a0,0x1
     36c:	2d050513          	addi	a0,a0,720 # 1638 <malloc+0x15a>
     370:	00001097          	auipc	ra,0x1
     374:	d70080e7          	jalr	-656(ra) # 10e0 <open>
     378:	892a                	mv	s2,a0
     37a:	b365                	j	122 <go+0xaa>
      close(fd);
     37c:	854a                	mv	a0,s2
     37e:	00001097          	auipc	ra,0x1
     382:	d4a080e7          	jalr	-694(ra) # 10c8 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     386:	20200593          	li	a1,514
     38a:	00001517          	auipc	a0,0x1
     38e:	2be50513          	addi	a0,a0,702 # 1648 <malloc+0x16a>
     392:	00001097          	auipc	ra,0x1
     396:	d4e080e7          	jalr	-690(ra) # 10e0 <open>
     39a:	892a                	mv	s2,a0
     39c:	b359                	j	122 <go+0xaa>
      write(fd, buf, sizeof(buf));
     39e:	3e700613          	li	a2,999
     3a2:	85d2                	mv	a1,s4
     3a4:	854a                	mv	a0,s2
     3a6:	00001097          	auipc	ra,0x1
     3aa:	d1a080e7          	jalr	-742(ra) # 10c0 <write>
     3ae:	bb95                	j	122 <go+0xaa>
      read(fd, buf, sizeof(buf));
     3b0:	3e700613          	li	a2,999
     3b4:	85d2                	mv	a1,s4
     3b6:	854a                	mv	a0,s2
     3b8:	00001097          	auipc	ra,0x1
     3bc:	d00080e7          	jalr	-768(ra) # 10b8 <read>
     3c0:	b38d                	j	122 <go+0xaa>
      mkdir("grindir/../a");
     3c2:	00001517          	auipc	a0,0x1
     3c6:	24650513          	addi	a0,a0,582 # 1608 <malloc+0x12a>
     3ca:	00001097          	auipc	ra,0x1
     3ce:	d3e080e7          	jalr	-706(ra) # 1108 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     3d2:	20200593          	li	a1,514
     3d6:	00001517          	auipc	a0,0x1
     3da:	28a50513          	addi	a0,a0,650 # 1660 <malloc+0x182>
     3de:	00001097          	auipc	ra,0x1
     3e2:	d02080e7          	jalr	-766(ra) # 10e0 <open>
     3e6:	00001097          	auipc	ra,0x1
     3ea:	ce2080e7          	jalr	-798(ra) # 10c8 <close>
      unlink("a/a");
     3ee:	00001517          	auipc	a0,0x1
     3f2:	28250513          	addi	a0,a0,642 # 1670 <malloc+0x192>
     3f6:	00001097          	auipc	ra,0x1
     3fa:	cfa080e7          	jalr	-774(ra) # 10f0 <unlink>
     3fe:	b315                	j	122 <go+0xaa>
      mkdir("/../b");
     400:	00001517          	auipc	a0,0x1
     404:	27850513          	addi	a0,a0,632 # 1678 <malloc+0x19a>
     408:	00001097          	auipc	ra,0x1
     40c:	d00080e7          	jalr	-768(ra) # 1108 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     410:	20200593          	li	a1,514
     414:	00001517          	auipc	a0,0x1
     418:	26c50513          	addi	a0,a0,620 # 1680 <malloc+0x1a2>
     41c:	00001097          	auipc	ra,0x1
     420:	cc4080e7          	jalr	-828(ra) # 10e0 <open>
     424:	00001097          	auipc	ra,0x1
     428:	ca4080e7          	jalr	-860(ra) # 10c8 <close>
      unlink("b/b");
     42c:	00001517          	auipc	a0,0x1
     430:	26450513          	addi	a0,a0,612 # 1690 <malloc+0x1b2>
     434:	00001097          	auipc	ra,0x1
     438:	cbc080e7          	jalr	-836(ra) # 10f0 <unlink>
     43c:	b1dd                	j	122 <go+0xaa>
      unlink("b");
     43e:	00001517          	auipc	a0,0x1
     442:	21a50513          	addi	a0,a0,538 # 1658 <malloc+0x17a>
     446:	00001097          	auipc	ra,0x1
     44a:	caa080e7          	jalr	-854(ra) # 10f0 <unlink>
      link("../grindir/./../a", "../b");
     44e:	00001597          	auipc	a1,0x1
     452:	1e258593          	addi	a1,a1,482 # 1630 <malloc+0x152>
     456:	00001517          	auipc	a0,0x1
     45a:	24250513          	addi	a0,a0,578 # 1698 <malloc+0x1ba>
     45e:	00001097          	auipc	ra,0x1
     462:	ca2080e7          	jalr	-862(ra) # 1100 <link>
     466:	b975                	j	122 <go+0xaa>
      unlink("../grindir/../a");
     468:	00001517          	auipc	a0,0x1
     46c:	24850513          	addi	a0,a0,584 # 16b0 <malloc+0x1d2>
     470:	00001097          	auipc	ra,0x1
     474:	c80080e7          	jalr	-896(ra) # 10f0 <unlink>
      link(".././b", "/grindir/../a");
     478:	00001597          	auipc	a1,0x1
     47c:	1c058593          	addi	a1,a1,448 # 1638 <malloc+0x15a>
     480:	00001517          	auipc	a0,0x1
     484:	24050513          	addi	a0,a0,576 # 16c0 <malloc+0x1e2>
     488:	00001097          	auipc	ra,0x1
     48c:	c78080e7          	jalr	-904(ra) # 1100 <link>
     490:	b949                	j	122 <go+0xaa>
      int pid = fork();
     492:	00001097          	auipc	ra,0x1
     496:	c06080e7          	jalr	-1018(ra) # 1098 <fork>
      if(pid == 0){
     49a:	c909                	beqz	a0,4ac <go+0x434>
      } else if(pid < 0){
     49c:	00054c63          	bltz	a0,4b4 <go+0x43c>
      wait(0);
     4a0:	4501                	li	a0,0
     4a2:	00001097          	auipc	ra,0x1
     4a6:	c06080e7          	jalr	-1018(ra) # 10a8 <wait>
     4aa:	b9a5                	j	122 <go+0xaa>
        exit(0);
     4ac:	00001097          	auipc	ra,0x1
     4b0:	bf4080e7          	jalr	-1036(ra) # 10a0 <exit>
        printf("grind: fork failed\n");
     4b4:	00001517          	auipc	a0,0x1
     4b8:	21450513          	addi	a0,a0,532 # 16c8 <malloc+0x1ea>
     4bc:	00001097          	auipc	ra,0x1
     4c0:	f64080e7          	jalr	-156(ra) # 1420 <printf>
        exit(1);
     4c4:	4505                	li	a0,1
     4c6:	00001097          	auipc	ra,0x1
     4ca:	bda080e7          	jalr	-1062(ra) # 10a0 <exit>
      int pid = fork();
     4ce:	00001097          	auipc	ra,0x1
     4d2:	bca080e7          	jalr	-1078(ra) # 1098 <fork>
      if(pid == 0){
     4d6:	c909                	beqz	a0,4e8 <go+0x470>
      } else if(pid < 0){
     4d8:	02054563          	bltz	a0,502 <go+0x48a>
      wait(0);
     4dc:	4501                	li	a0,0
     4de:	00001097          	auipc	ra,0x1
     4e2:	bca080e7          	jalr	-1078(ra) # 10a8 <wait>
     4e6:	b935                	j	122 <go+0xaa>
        fork();
     4e8:	00001097          	auipc	ra,0x1
     4ec:	bb0080e7          	jalr	-1104(ra) # 1098 <fork>
        fork();
     4f0:	00001097          	auipc	ra,0x1
     4f4:	ba8080e7          	jalr	-1112(ra) # 1098 <fork>
        exit(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	ba6080e7          	jalr	-1114(ra) # 10a0 <exit>
        printf("grind: fork failed\n");
     502:	00001517          	auipc	a0,0x1
     506:	1c650513          	addi	a0,a0,454 # 16c8 <malloc+0x1ea>
     50a:	00001097          	auipc	ra,0x1
     50e:	f16080e7          	jalr	-234(ra) # 1420 <printf>
        exit(1);
     512:	4505                	li	a0,1
     514:	00001097          	auipc	ra,0x1
     518:	b8c080e7          	jalr	-1140(ra) # 10a0 <exit>
      sbrk(6011);
     51c:	6505                	lui	a0,0x1
     51e:	77b50513          	addi	a0,a0,1915 # 177b <malloc+0x29d>
     522:	00001097          	auipc	ra,0x1
     526:	c06080e7          	jalr	-1018(ra) # 1128 <sbrk>
     52a:	bee5                	j	122 <go+0xaa>
      if(sbrk(0) > break0)
     52c:	4501                	li	a0,0
     52e:	00001097          	auipc	ra,0x1
     532:	bfa080e7          	jalr	-1030(ra) # 1128 <sbrk>
     536:	beaaf6e3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     53a:	4501                	li	a0,0
     53c:	00001097          	auipc	ra,0x1
     540:	bec080e7          	jalr	-1044(ra) # 1128 <sbrk>
     544:	40aa853b          	subw	a0,s5,a0
     548:	00001097          	auipc	ra,0x1
     54c:	be0080e7          	jalr	-1056(ra) # 1128 <sbrk>
     550:	bec9                	j	122 <go+0xaa>
      int pid = fork();
     552:	00001097          	auipc	ra,0x1
     556:	b46080e7          	jalr	-1210(ra) # 1098 <fork>
     55a:	8b2a                	mv	s6,a0
      if(pid == 0){
     55c:	c51d                	beqz	a0,58a <go+0x512>
      } else if(pid < 0){
     55e:	04054963          	bltz	a0,5b0 <go+0x538>
      if(chdir("../grindir/..") != 0){
     562:	00001517          	auipc	a0,0x1
     566:	17e50513          	addi	a0,a0,382 # 16e0 <malloc+0x202>
     56a:	00001097          	auipc	ra,0x1
     56e:	ba6080e7          	jalr	-1114(ra) # 1110 <chdir>
     572:	ed21                	bnez	a0,5ca <go+0x552>
      kill(pid);
     574:	855a                	mv	a0,s6
     576:	00001097          	auipc	ra,0x1
     57a:	b5a080e7          	jalr	-1190(ra) # 10d0 <kill>
      wait(0);
     57e:	4501                	li	a0,0
     580:	00001097          	auipc	ra,0x1
     584:	b28080e7          	jalr	-1240(ra) # 10a8 <wait>
     588:	be69                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     58a:	20200593          	li	a1,514
     58e:	00001517          	auipc	a0,0x1
     592:	11a50513          	addi	a0,a0,282 # 16a8 <malloc+0x1ca>
     596:	00001097          	auipc	ra,0x1
     59a:	b4a080e7          	jalr	-1206(ra) # 10e0 <open>
     59e:	00001097          	auipc	ra,0x1
     5a2:	b2a080e7          	jalr	-1238(ra) # 10c8 <close>
        exit(0);
     5a6:	4501                	li	a0,0
     5a8:	00001097          	auipc	ra,0x1
     5ac:	af8080e7          	jalr	-1288(ra) # 10a0 <exit>
        printf("grind: fork failed\n");
     5b0:	00001517          	auipc	a0,0x1
     5b4:	11850513          	addi	a0,a0,280 # 16c8 <malloc+0x1ea>
     5b8:	00001097          	auipc	ra,0x1
     5bc:	e68080e7          	jalr	-408(ra) # 1420 <printf>
        exit(1);
     5c0:	4505                	li	a0,1
     5c2:	00001097          	auipc	ra,0x1
     5c6:	ade080e7          	jalr	-1314(ra) # 10a0 <exit>
        printf("grind: chdir failed\n");
     5ca:	00001517          	auipc	a0,0x1
     5ce:	12650513          	addi	a0,a0,294 # 16f0 <malloc+0x212>
     5d2:	00001097          	auipc	ra,0x1
     5d6:	e4e080e7          	jalr	-434(ra) # 1420 <printf>
        exit(1);
     5da:	4505                	li	a0,1
     5dc:	00001097          	auipc	ra,0x1
     5e0:	ac4080e7          	jalr	-1340(ra) # 10a0 <exit>
      int pid = fork();
     5e4:	00001097          	auipc	ra,0x1
     5e8:	ab4080e7          	jalr	-1356(ra) # 1098 <fork>
      if(pid == 0){
     5ec:	c909                	beqz	a0,5fe <go+0x586>
      } else if(pid < 0){
     5ee:	02054563          	bltz	a0,618 <go+0x5a0>
      wait(0);
     5f2:	4501                	li	a0,0
     5f4:	00001097          	auipc	ra,0x1
     5f8:	ab4080e7          	jalr	-1356(ra) # 10a8 <wait>
     5fc:	b61d                	j	122 <go+0xaa>
        kill(getpid());
     5fe:	00001097          	auipc	ra,0x1
     602:	b22080e7          	jalr	-1246(ra) # 1120 <getpid>
     606:	00001097          	auipc	ra,0x1
     60a:	aca080e7          	jalr	-1334(ra) # 10d0 <kill>
        exit(0);
     60e:	4501                	li	a0,0
     610:	00001097          	auipc	ra,0x1
     614:	a90080e7          	jalr	-1392(ra) # 10a0 <exit>
        printf("grind: fork failed\n");
     618:	00001517          	auipc	a0,0x1
     61c:	0b050513          	addi	a0,a0,176 # 16c8 <malloc+0x1ea>
     620:	00001097          	auipc	ra,0x1
     624:	e00080e7          	jalr	-512(ra) # 1420 <printf>
        exit(1);
     628:	4505                	li	a0,1
     62a:	00001097          	auipc	ra,0x1
     62e:	a76080e7          	jalr	-1418(ra) # 10a0 <exit>
      if(pipe(fds) < 0){
     632:	fa840513          	addi	a0,s0,-88
     636:	00001097          	auipc	ra,0x1
     63a:	a7a080e7          	jalr	-1414(ra) # 10b0 <pipe>
     63e:	02054b63          	bltz	a0,674 <go+0x5fc>
      int pid = fork();
     642:	00001097          	auipc	ra,0x1
     646:	a56080e7          	jalr	-1450(ra) # 1098 <fork>
      if(pid == 0){
     64a:	c131                	beqz	a0,68e <go+0x616>
      } else if(pid < 0){
     64c:	0a054a63          	bltz	a0,700 <go+0x688>
      close(fds[0]);
     650:	fa842503          	lw	a0,-88(s0)
     654:	00001097          	auipc	ra,0x1
     658:	a74080e7          	jalr	-1420(ra) # 10c8 <close>
      close(fds[1]);
     65c:	fac42503          	lw	a0,-84(s0)
     660:	00001097          	auipc	ra,0x1
     664:	a68080e7          	jalr	-1432(ra) # 10c8 <close>
      wait(0);
     668:	4501                	li	a0,0
     66a:	00001097          	auipc	ra,0x1
     66e:	a3e080e7          	jalr	-1474(ra) # 10a8 <wait>
     672:	bc45                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     674:	00001517          	auipc	a0,0x1
     678:	09450513          	addi	a0,a0,148 # 1708 <malloc+0x22a>
     67c:	00001097          	auipc	ra,0x1
     680:	da4080e7          	jalr	-604(ra) # 1420 <printf>
        exit(1);
     684:	4505                	li	a0,1
     686:	00001097          	auipc	ra,0x1
     68a:	a1a080e7          	jalr	-1510(ra) # 10a0 <exit>
        fork();
     68e:	00001097          	auipc	ra,0x1
     692:	a0a080e7          	jalr	-1526(ra) # 1098 <fork>
        fork();
     696:	00001097          	auipc	ra,0x1
     69a:	a02080e7          	jalr	-1534(ra) # 1098 <fork>
        if(write(fds[1], "x", 1) != 1)
     69e:	4605                	li	a2,1
     6a0:	00001597          	auipc	a1,0x1
     6a4:	08058593          	addi	a1,a1,128 # 1720 <malloc+0x242>
     6a8:	fac42503          	lw	a0,-84(s0)
     6ac:	00001097          	auipc	ra,0x1
     6b0:	a14080e7          	jalr	-1516(ra) # 10c0 <write>
     6b4:	4785                	li	a5,1
     6b6:	02f51363          	bne	a0,a5,6dc <go+0x664>
        if(read(fds[0], &c, 1) != 1)
     6ba:	4605                	li	a2,1
     6bc:	fa040593          	addi	a1,s0,-96
     6c0:	fa842503          	lw	a0,-88(s0)
     6c4:	00001097          	auipc	ra,0x1
     6c8:	9f4080e7          	jalr	-1548(ra) # 10b8 <read>
     6cc:	4785                	li	a5,1
     6ce:	02f51063          	bne	a0,a5,6ee <go+0x676>
        exit(0);
     6d2:	4501                	li	a0,0
     6d4:	00001097          	auipc	ra,0x1
     6d8:	9cc080e7          	jalr	-1588(ra) # 10a0 <exit>
          printf("grind: pipe write failed\n");
     6dc:	00001517          	auipc	a0,0x1
     6e0:	04c50513          	addi	a0,a0,76 # 1728 <malloc+0x24a>
     6e4:	00001097          	auipc	ra,0x1
     6e8:	d3c080e7          	jalr	-708(ra) # 1420 <printf>
     6ec:	b7f9                	j	6ba <go+0x642>
          printf("grind: pipe read failed\n");
     6ee:	00001517          	auipc	a0,0x1
     6f2:	05a50513          	addi	a0,a0,90 # 1748 <malloc+0x26a>
     6f6:	00001097          	auipc	ra,0x1
     6fa:	d2a080e7          	jalr	-726(ra) # 1420 <printf>
     6fe:	bfd1                	j	6d2 <go+0x65a>
        printf("grind: fork failed\n");
     700:	00001517          	auipc	a0,0x1
     704:	fc850513          	addi	a0,a0,-56 # 16c8 <malloc+0x1ea>
     708:	00001097          	auipc	ra,0x1
     70c:	d18080e7          	jalr	-744(ra) # 1420 <printf>
        exit(1);
     710:	4505                	li	a0,1
     712:	00001097          	auipc	ra,0x1
     716:	98e080e7          	jalr	-1650(ra) # 10a0 <exit>
      int pid = fork();
     71a:	00001097          	auipc	ra,0x1
     71e:	97e080e7          	jalr	-1666(ra) # 1098 <fork>
      if(pid == 0){
     722:	c909                	beqz	a0,734 <go+0x6bc>
      } else if(pid < 0){
     724:	06054f63          	bltz	a0,7a2 <go+0x72a>
      wait(0);
     728:	4501                	li	a0,0
     72a:	00001097          	auipc	ra,0x1
     72e:	97e080e7          	jalr	-1666(ra) # 10a8 <wait>
     732:	bac5                	j	122 <go+0xaa>
        unlink("a");
     734:	00001517          	auipc	a0,0x1
     738:	f7450513          	addi	a0,a0,-140 # 16a8 <malloc+0x1ca>
     73c:	00001097          	auipc	ra,0x1
     740:	9b4080e7          	jalr	-1612(ra) # 10f0 <unlink>
        mkdir("a");
     744:	00001517          	auipc	a0,0x1
     748:	f6450513          	addi	a0,a0,-156 # 16a8 <malloc+0x1ca>
     74c:	00001097          	auipc	ra,0x1
     750:	9bc080e7          	jalr	-1604(ra) # 1108 <mkdir>
        chdir("a");
     754:	00001517          	auipc	a0,0x1
     758:	f5450513          	addi	a0,a0,-172 # 16a8 <malloc+0x1ca>
     75c:	00001097          	auipc	ra,0x1
     760:	9b4080e7          	jalr	-1612(ra) # 1110 <chdir>
        unlink("../a");
     764:	00001517          	auipc	a0,0x1
     768:	eac50513          	addi	a0,a0,-340 # 1610 <malloc+0x132>
     76c:	00001097          	auipc	ra,0x1
     770:	984080e7          	jalr	-1660(ra) # 10f0 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     774:	20200593          	li	a1,514
     778:	00001517          	auipc	a0,0x1
     77c:	fa850513          	addi	a0,a0,-88 # 1720 <malloc+0x242>
     780:	00001097          	auipc	ra,0x1
     784:	960080e7          	jalr	-1696(ra) # 10e0 <open>
        unlink("x");
     788:	00001517          	auipc	a0,0x1
     78c:	f9850513          	addi	a0,a0,-104 # 1720 <malloc+0x242>
     790:	00001097          	auipc	ra,0x1
     794:	960080e7          	jalr	-1696(ra) # 10f0 <unlink>
        exit(0);
     798:	4501                	li	a0,0
     79a:	00001097          	auipc	ra,0x1
     79e:	906080e7          	jalr	-1786(ra) # 10a0 <exit>
        printf("grind: fork failed\n");
     7a2:	00001517          	auipc	a0,0x1
     7a6:	f2650513          	addi	a0,a0,-218 # 16c8 <malloc+0x1ea>
     7aa:	00001097          	auipc	ra,0x1
     7ae:	c76080e7          	jalr	-906(ra) # 1420 <printf>
        exit(1);
     7b2:	4505                	li	a0,1
     7b4:	00001097          	auipc	ra,0x1
     7b8:	8ec080e7          	jalr	-1812(ra) # 10a0 <exit>
      unlink("c");
     7bc:	00001517          	auipc	a0,0x1
     7c0:	fac50513          	addi	a0,a0,-84 # 1768 <malloc+0x28a>
     7c4:	00001097          	auipc	ra,0x1
     7c8:	92c080e7          	jalr	-1748(ra) # 10f0 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     7cc:	20200593          	li	a1,514
     7d0:	00001517          	auipc	a0,0x1
     7d4:	f9850513          	addi	a0,a0,-104 # 1768 <malloc+0x28a>
     7d8:	00001097          	auipc	ra,0x1
     7dc:	908080e7          	jalr	-1784(ra) # 10e0 <open>
     7e0:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     7e2:	04054f63          	bltz	a0,840 <go+0x7c8>
      if(write(fd1, "x", 1) != 1){
     7e6:	4605                	li	a2,1
     7e8:	00001597          	auipc	a1,0x1
     7ec:	f3858593          	addi	a1,a1,-200 # 1720 <malloc+0x242>
     7f0:	00001097          	auipc	ra,0x1
     7f4:	8d0080e7          	jalr	-1840(ra) # 10c0 <write>
     7f8:	4785                	li	a5,1
     7fa:	06f51063          	bne	a0,a5,85a <go+0x7e2>
      if(fstat(fd1, &st) != 0){
     7fe:	fa840593          	addi	a1,s0,-88
     802:	855a                	mv	a0,s6
     804:	00001097          	auipc	ra,0x1
     808:	8f4080e7          	jalr	-1804(ra) # 10f8 <fstat>
     80c:	e525                	bnez	a0,874 <go+0x7fc>
      if(st.size != 1){
     80e:	fb843583          	ld	a1,-72(s0)
     812:	4785                	li	a5,1
     814:	06f59d63          	bne	a1,a5,88e <go+0x816>
      if(st.ino > 200){
     818:	fac42583          	lw	a1,-84(s0)
     81c:	0c800793          	li	a5,200
     820:	08b7e563          	bltu	a5,a1,8aa <go+0x832>
      close(fd1);
     824:	855a                	mv	a0,s6
     826:	00001097          	auipc	ra,0x1
     82a:	8a2080e7          	jalr	-1886(ra) # 10c8 <close>
      unlink("c");
     82e:	00001517          	auipc	a0,0x1
     832:	f3a50513          	addi	a0,a0,-198 # 1768 <malloc+0x28a>
     836:	00001097          	auipc	ra,0x1
     83a:	8ba080e7          	jalr	-1862(ra) # 10f0 <unlink>
     83e:	b0d5                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     840:	00001517          	auipc	a0,0x1
     844:	f3050513          	addi	a0,a0,-208 # 1770 <malloc+0x292>
     848:	00001097          	auipc	ra,0x1
     84c:	bd8080e7          	jalr	-1064(ra) # 1420 <printf>
        exit(1);
     850:	4505                	li	a0,1
     852:	00001097          	auipc	ra,0x1
     856:	84e080e7          	jalr	-1970(ra) # 10a0 <exit>
        printf("grind: write c failed\n");
     85a:	00001517          	auipc	a0,0x1
     85e:	f2e50513          	addi	a0,a0,-210 # 1788 <malloc+0x2aa>
     862:	00001097          	auipc	ra,0x1
     866:	bbe080e7          	jalr	-1090(ra) # 1420 <printf>
        exit(1);
     86a:	4505                	li	a0,1
     86c:	00001097          	auipc	ra,0x1
     870:	834080e7          	jalr	-1996(ra) # 10a0 <exit>
        printf("grind: fstat failed\n");
     874:	00001517          	auipc	a0,0x1
     878:	f2c50513          	addi	a0,a0,-212 # 17a0 <malloc+0x2c2>
     87c:	00001097          	auipc	ra,0x1
     880:	ba4080e7          	jalr	-1116(ra) # 1420 <printf>
        exit(1);
     884:	4505                	li	a0,1
     886:	00001097          	auipc	ra,0x1
     88a:	81a080e7          	jalr	-2022(ra) # 10a0 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     88e:	2581                	sext.w	a1,a1
     890:	00001517          	auipc	a0,0x1
     894:	f2850513          	addi	a0,a0,-216 # 17b8 <malloc+0x2da>
     898:	00001097          	auipc	ra,0x1
     89c:	b88080e7          	jalr	-1144(ra) # 1420 <printf>
        exit(1);
     8a0:	4505                	li	a0,1
     8a2:	00000097          	auipc	ra,0x0
     8a6:	7fe080e7          	jalr	2046(ra) # 10a0 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     8aa:	00001517          	auipc	a0,0x1
     8ae:	f3650513          	addi	a0,a0,-202 # 17e0 <malloc+0x302>
     8b2:	00001097          	auipc	ra,0x1
     8b6:	b6e080e7          	jalr	-1170(ra) # 1420 <printf>
        exit(1);
     8ba:	4505                	li	a0,1
     8bc:	00000097          	auipc	ra,0x0
     8c0:	7e4080e7          	jalr	2020(ra) # 10a0 <exit>
        fprintf(2, "grind: pipe failed\n");
     8c4:	00001597          	auipc	a1,0x1
     8c8:	e4458593          	addi	a1,a1,-444 # 1708 <malloc+0x22a>
     8cc:	4509                	li	a0,2
     8ce:	00001097          	auipc	ra,0x1
     8d2:	b24080e7          	jalr	-1244(ra) # 13f2 <fprintf>
        exit(1);
     8d6:	4505                	li	a0,1
     8d8:	00000097          	auipc	ra,0x0
     8dc:	7c8080e7          	jalr	1992(ra) # 10a0 <exit>
        fprintf(2, "grind: pipe failed\n");
     8e0:	00001597          	auipc	a1,0x1
     8e4:	e2858593          	addi	a1,a1,-472 # 1708 <malloc+0x22a>
     8e8:	4509                	li	a0,2
     8ea:	00001097          	auipc	ra,0x1
     8ee:	b08080e7          	jalr	-1272(ra) # 13f2 <fprintf>
        exit(1);
     8f2:	4505                	li	a0,1
     8f4:	00000097          	auipc	ra,0x0
     8f8:	7ac080e7          	jalr	1964(ra) # 10a0 <exit>
        close(bb[0]);
     8fc:	fa042503          	lw	a0,-96(s0)
     900:	00000097          	auipc	ra,0x0
     904:	7c8080e7          	jalr	1992(ra) # 10c8 <close>
        close(bb[1]);
     908:	fa442503          	lw	a0,-92(s0)
     90c:	00000097          	auipc	ra,0x0
     910:	7bc080e7          	jalr	1980(ra) # 10c8 <close>
        close(aa[0]);
     914:	f9842503          	lw	a0,-104(s0)
     918:	00000097          	auipc	ra,0x0
     91c:	7b0080e7          	jalr	1968(ra) # 10c8 <close>
        close(1);
     920:	4505                	li	a0,1
     922:	00000097          	auipc	ra,0x0
     926:	7a6080e7          	jalr	1958(ra) # 10c8 <close>
        if(dup(aa[1]) != 1){
     92a:	f9c42503          	lw	a0,-100(s0)
     92e:	00000097          	auipc	ra,0x0
     932:	7ea080e7          	jalr	2026(ra) # 1118 <dup>
     936:	4785                	li	a5,1
     938:	02f50063          	beq	a0,a5,958 <go+0x8e0>
          fprintf(2, "grind: dup failed\n");
     93c:	00001597          	auipc	a1,0x1
     940:	ecc58593          	addi	a1,a1,-308 # 1808 <malloc+0x32a>
     944:	4509                	li	a0,2
     946:	00001097          	auipc	ra,0x1
     94a:	aac080e7          	jalr	-1364(ra) # 13f2 <fprintf>
          exit(1);
     94e:	4505                	li	a0,1
     950:	00000097          	auipc	ra,0x0
     954:	750080e7          	jalr	1872(ra) # 10a0 <exit>
        close(aa[1]);
     958:	f9c42503          	lw	a0,-100(s0)
     95c:	00000097          	auipc	ra,0x0
     960:	76c080e7          	jalr	1900(ra) # 10c8 <close>
        char *args[3] = { "echo", "hi", 0 };
     964:	00001797          	auipc	a5,0x1
     968:	ebc78793          	addi	a5,a5,-324 # 1820 <malloc+0x342>
     96c:	faf43423          	sd	a5,-88(s0)
     970:	00001797          	auipc	a5,0x1
     974:	eb878793          	addi	a5,a5,-328 # 1828 <malloc+0x34a>
     978:	faf43823          	sd	a5,-80(s0)
     97c:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     980:	fa840593          	addi	a1,s0,-88
     984:	00001517          	auipc	a0,0x1
     988:	eac50513          	addi	a0,a0,-340 # 1830 <malloc+0x352>
     98c:	00000097          	auipc	ra,0x0
     990:	74c080e7          	jalr	1868(ra) # 10d8 <exec>
        fprintf(2, "grind: echo: not found\n");
     994:	00001597          	auipc	a1,0x1
     998:	eac58593          	addi	a1,a1,-340 # 1840 <malloc+0x362>
     99c:	4509                	li	a0,2
     99e:	00001097          	auipc	ra,0x1
     9a2:	a54080e7          	jalr	-1452(ra) # 13f2 <fprintf>
        exit(2);
     9a6:	4509                	li	a0,2
     9a8:	00000097          	auipc	ra,0x0
     9ac:	6f8080e7          	jalr	1784(ra) # 10a0 <exit>
        fprintf(2, "grind: fork failed\n");
     9b0:	00001597          	auipc	a1,0x1
     9b4:	d1858593          	addi	a1,a1,-744 # 16c8 <malloc+0x1ea>
     9b8:	4509                	li	a0,2
     9ba:	00001097          	auipc	ra,0x1
     9be:	a38080e7          	jalr	-1480(ra) # 13f2 <fprintf>
        exit(3);
     9c2:	450d                	li	a0,3
     9c4:	00000097          	auipc	ra,0x0
     9c8:	6dc080e7          	jalr	1756(ra) # 10a0 <exit>
        close(aa[1]);
     9cc:	f9c42503          	lw	a0,-100(s0)
     9d0:	00000097          	auipc	ra,0x0
     9d4:	6f8080e7          	jalr	1784(ra) # 10c8 <close>
        close(bb[0]);
     9d8:	fa042503          	lw	a0,-96(s0)
     9dc:	00000097          	auipc	ra,0x0
     9e0:	6ec080e7          	jalr	1772(ra) # 10c8 <close>
        close(0);
     9e4:	4501                	li	a0,0
     9e6:	00000097          	auipc	ra,0x0
     9ea:	6e2080e7          	jalr	1762(ra) # 10c8 <close>
        if(dup(aa[0]) != 0){
     9ee:	f9842503          	lw	a0,-104(s0)
     9f2:	00000097          	auipc	ra,0x0
     9f6:	726080e7          	jalr	1830(ra) # 1118 <dup>
     9fa:	cd19                	beqz	a0,a18 <go+0x9a0>
          fprintf(2, "grind: dup failed\n");
     9fc:	00001597          	auipc	a1,0x1
     a00:	e0c58593          	addi	a1,a1,-500 # 1808 <malloc+0x32a>
     a04:	4509                	li	a0,2
     a06:	00001097          	auipc	ra,0x1
     a0a:	9ec080e7          	jalr	-1556(ra) # 13f2 <fprintf>
          exit(4);
     a0e:	4511                	li	a0,4
     a10:	00000097          	auipc	ra,0x0
     a14:	690080e7          	jalr	1680(ra) # 10a0 <exit>
        close(aa[0]);
     a18:	f9842503          	lw	a0,-104(s0)
     a1c:	00000097          	auipc	ra,0x0
     a20:	6ac080e7          	jalr	1708(ra) # 10c8 <close>
        close(1);
     a24:	4505                	li	a0,1
     a26:	00000097          	auipc	ra,0x0
     a2a:	6a2080e7          	jalr	1698(ra) # 10c8 <close>
        if(dup(bb[1]) != 1){
     a2e:	fa442503          	lw	a0,-92(s0)
     a32:	00000097          	auipc	ra,0x0
     a36:	6e6080e7          	jalr	1766(ra) # 1118 <dup>
     a3a:	4785                	li	a5,1
     a3c:	02f50063          	beq	a0,a5,a5c <go+0x9e4>
          fprintf(2, "grind: dup failed\n");
     a40:	00001597          	auipc	a1,0x1
     a44:	dc858593          	addi	a1,a1,-568 # 1808 <malloc+0x32a>
     a48:	4509                	li	a0,2
     a4a:	00001097          	auipc	ra,0x1
     a4e:	9a8080e7          	jalr	-1624(ra) # 13f2 <fprintf>
          exit(5);
     a52:	4515                	li	a0,5
     a54:	00000097          	auipc	ra,0x0
     a58:	64c080e7          	jalr	1612(ra) # 10a0 <exit>
        close(bb[1]);
     a5c:	fa442503          	lw	a0,-92(s0)
     a60:	00000097          	auipc	ra,0x0
     a64:	668080e7          	jalr	1640(ra) # 10c8 <close>
        char *args[2] = { "cat", 0 };
     a68:	00001797          	auipc	a5,0x1
     a6c:	df078793          	addi	a5,a5,-528 # 1858 <malloc+0x37a>
     a70:	faf43423          	sd	a5,-88(s0)
     a74:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a78:	fa840593          	addi	a1,s0,-88
     a7c:	00001517          	auipc	a0,0x1
     a80:	de450513          	addi	a0,a0,-540 # 1860 <malloc+0x382>
     a84:	00000097          	auipc	ra,0x0
     a88:	654080e7          	jalr	1620(ra) # 10d8 <exec>
        fprintf(2, "grind: cat: not found\n");
     a8c:	00001597          	auipc	a1,0x1
     a90:	ddc58593          	addi	a1,a1,-548 # 1868 <malloc+0x38a>
     a94:	4509                	li	a0,2
     a96:	00001097          	auipc	ra,0x1
     a9a:	95c080e7          	jalr	-1700(ra) # 13f2 <fprintf>
        exit(6);
     a9e:	4519                	li	a0,6
     aa0:	00000097          	auipc	ra,0x0
     aa4:	600080e7          	jalr	1536(ra) # 10a0 <exit>
        fprintf(2, "grind: fork failed\n");
     aa8:	00001597          	auipc	a1,0x1
     aac:	c2058593          	addi	a1,a1,-992 # 16c8 <malloc+0x1ea>
     ab0:	4509                	li	a0,2
     ab2:	00001097          	auipc	ra,0x1
     ab6:	940080e7          	jalr	-1728(ra) # 13f2 <fprintf>
        exit(7);
     aba:	451d                	li	a0,7
     abc:	00000097          	auipc	ra,0x0
     ac0:	5e4080e7          	jalr	1508(ra) # 10a0 <exit>

0000000000000ac4 <iter>:
  }
}

void
iter()
{
     ac4:	7179                	addi	sp,sp,-48
     ac6:	f406                	sd	ra,40(sp)
     ac8:	f022                	sd	s0,32(sp)
     aca:	ec26                	sd	s1,24(sp)
     acc:	e84a                	sd	s2,16(sp)
     ace:	1800                	addi	s0,sp,48
  unlink("a");
     ad0:	00001517          	auipc	a0,0x1
     ad4:	bd850513          	addi	a0,a0,-1064 # 16a8 <malloc+0x1ca>
     ad8:	00000097          	auipc	ra,0x0
     adc:	618080e7          	jalr	1560(ra) # 10f0 <unlink>
  unlink("b");
     ae0:	00001517          	auipc	a0,0x1
     ae4:	b7850513          	addi	a0,a0,-1160 # 1658 <malloc+0x17a>
     ae8:	00000097          	auipc	ra,0x0
     aec:	608080e7          	jalr	1544(ra) # 10f0 <unlink>
  
  int pid1 = fork();
     af0:	00000097          	auipc	ra,0x0
     af4:	5a8080e7          	jalr	1448(ra) # 1098 <fork>
  if(pid1 < 0){
     af8:	00054e63          	bltz	a0,b14 <iter+0x50>
     afc:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     afe:	e905                	bnez	a0,b2e <iter+0x6a>
    rand_next = 31;
     b00:	47fd                	li	a5,31
     b02:	00001717          	auipc	a4,0x1
     b06:	dcf73723          	sd	a5,-562(a4) # 18d0 <rand_next>
    go(0);
     b0a:	4501                	li	a0,0
     b0c:	fffff097          	auipc	ra,0xfffff
     b10:	56c080e7          	jalr	1388(ra) # 78 <go>
    printf("grind: fork failed\n");
     b14:	00001517          	auipc	a0,0x1
     b18:	bb450513          	addi	a0,a0,-1100 # 16c8 <malloc+0x1ea>
     b1c:	00001097          	auipc	ra,0x1
     b20:	904080e7          	jalr	-1788(ra) # 1420 <printf>
    exit(1);
     b24:	4505                	li	a0,1
     b26:	00000097          	auipc	ra,0x0
     b2a:	57a080e7          	jalr	1402(ra) # 10a0 <exit>
    exit(0);
  }

  int pid2 = fork();
     b2e:	00000097          	auipc	ra,0x0
     b32:	56a080e7          	jalr	1386(ra) # 1098 <fork>
     b36:	892a                	mv	s2,a0
  if(pid2 < 0){
     b38:	00054f63          	bltz	a0,b56 <iter+0x92>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     b3c:	e915                	bnez	a0,b70 <iter+0xac>
    rand_next = 7177;
     b3e:	6789                	lui	a5,0x2
     b40:	c0978793          	addi	a5,a5,-1015 # 1c09 <buf.0+0x321>
     b44:	00001717          	auipc	a4,0x1
     b48:	d8f73623          	sd	a5,-628(a4) # 18d0 <rand_next>
    go(1);
     b4c:	4505                	li	a0,1
     b4e:	fffff097          	auipc	ra,0xfffff
     b52:	52a080e7          	jalr	1322(ra) # 78 <go>
    printf("grind: fork failed\n");
     b56:	00001517          	auipc	a0,0x1
     b5a:	b7250513          	addi	a0,a0,-1166 # 16c8 <malloc+0x1ea>
     b5e:	00001097          	auipc	ra,0x1
     b62:	8c2080e7          	jalr	-1854(ra) # 1420 <printf>
    exit(1);
     b66:	4505                	li	a0,1
     b68:	00000097          	auipc	ra,0x0
     b6c:	538080e7          	jalr	1336(ra) # 10a0 <exit>
    exit(0);
  }

  int st1 = -1;
     b70:	57fd                	li	a5,-1
     b72:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b76:	fdc40513          	addi	a0,s0,-36
     b7a:	00000097          	auipc	ra,0x0
     b7e:	52e080e7          	jalr	1326(ra) # 10a8 <wait>
  if(st1 != 0){
     b82:	fdc42783          	lw	a5,-36(s0)
     b86:	ef99                	bnez	a5,ba4 <iter+0xe0>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b88:	57fd                	li	a5,-1
     b8a:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b8e:	fd840513          	addi	a0,s0,-40
     b92:	00000097          	auipc	ra,0x0
     b96:	516080e7          	jalr	1302(ra) # 10a8 <wait>

  exit(0);
     b9a:	4501                	li	a0,0
     b9c:	00000097          	auipc	ra,0x0
     ba0:	504080e7          	jalr	1284(ra) # 10a0 <exit>
    kill(pid1);
     ba4:	8526                	mv	a0,s1
     ba6:	00000097          	auipc	ra,0x0
     baa:	52a080e7          	jalr	1322(ra) # 10d0 <kill>
    kill(pid2);
     bae:	854a                	mv	a0,s2
     bb0:	00000097          	auipc	ra,0x0
     bb4:	520080e7          	jalr	1312(ra) # 10d0 <kill>
     bb8:	bfc1                	j	b88 <iter+0xc4>

0000000000000bba <main>:
}

int
main()
{
     bba:	1141                	addi	sp,sp,-16
     bbc:	e406                	sd	ra,8(sp)
     bbe:	e022                	sd	s0,0(sp)
     bc0:	0800                	addi	s0,sp,16
     bc2:	a811                	j	bd6 <main+0x1c>
  while(1){
    int pid = fork();
    if(pid == 0){
      iter();
     bc4:	00000097          	auipc	ra,0x0
     bc8:	f00080e7          	jalr	-256(ra) # ac4 <iter>
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     bcc:	4551                	li	a0,20
     bce:	00000097          	auipc	ra,0x0
     bd2:	562080e7          	jalr	1378(ra) # 1130 <sleep>
    int pid = fork();
     bd6:	00000097          	auipc	ra,0x0
     bda:	4c2080e7          	jalr	1218(ra) # 1098 <fork>
    if(pid == 0){
     bde:	d17d                	beqz	a0,bc4 <main+0xa>
    if(pid > 0){
     be0:	fea056e3          	blez	a0,bcc <main+0x12>
      wait(0);
     be4:	4501                	li	a0,0
     be6:	00000097          	auipc	ra,0x0
     bea:	4c2080e7          	jalr	1218(ra) # 10a8 <wait>
     bee:	bff9                	j	bcc <main+0x12>

0000000000000bf0 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
     bf0:	1141                	addi	sp,sp,-16
     bf2:	e422                	sd	s0,8(sp)
     bf4:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
     bf6:	0f50000f          	fence	iorw,ow
     bfa:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
     bfe:	6422                	ld	s0,8(sp)
     c00:	0141                	addi	sp,sp,16
     c02:	8082                	ret

0000000000000c04 <load>:

int load(uint64 *p) {
     c04:	1141                	addi	sp,sp,-16
     c06:	e422                	sd	s0,8(sp)
     c08:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
     c0a:	0ff0000f          	fence
     c0e:	6108                	ld	a0,0(a0)
     c10:	0ff0000f          	fence
}
     c14:	2501                	sext.w	a0,a0
     c16:	6422                	ld	s0,8(sp)
     c18:	0141                	addi	sp,sp,16
     c1a:	8082                	ret

0000000000000c1c <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
     c1c:	7139                	addi	sp,sp,-64
     c1e:	fc06                	sd	ra,56(sp)
     c20:	f822                	sd	s0,48(sp)
     c22:	f426                	sd	s1,40(sp)
     c24:	f04a                	sd	s2,32(sp)
     c26:	ec4e                	sd	s3,24(sp)
     c28:	e852                	sd	s4,16(sp)
     c2a:	e456                	sd	s5,8(sp)
     c2c:	e05a                	sd	s6,0(sp)
     c2e:	0080                	addi	s0,sp,64
     c30:	8a2a                	mv	s4,a0
     c32:	89ae                	mv	s3,a1
     c34:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
     c36:	4785                	li	a5,1
     c38:	00001497          	auipc	s1,0x1
     c3c:	0a048493          	addi	s1,s1,160 # 1cd8 <rings+0x8>
     c40:	00001917          	auipc	s2,0x1
     c44:	18890913          	addi	s2,s2,392 # 1dc8 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
     c48:	00001b17          	auipc	s6,0x1
     c4c:	c90b0b13          	addi	s6,s6,-880 # 18d8 <vm_addr>
  if(open_close == 1){
     c50:	04f59063          	bne	a1,a5,c90 <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
     c54:	00001497          	auipc	s1,0x1
     c58:	08c4a483          	lw	s1,140(s1) # 1ce0 <rings+0x10>
     c5c:	c099                	beqz	s1,c62 <create_or_close_the_buffer_user+0x46>
     c5e:	4481                	li	s1,0
     c60:	a899                	j	cb6 <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
     c62:	865a                	mv	a2,s6
     c64:	4585                	li	a1,1
     c66:	00000097          	auipc	ra,0x0
     c6a:	4da080e7          	jalr	1242(ra) # 1140 <ringbuf>
        rings[i].book->write_done = 0;
     c6e:	00001797          	auipc	a5,0x1
     c72:	06278793          	addi	a5,a5,98 # 1cd0 <rings>
     c76:	6798                	ld	a4,8(a5)
     c78:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
     c7c:	6798                	ld	a4,8(a5)
     c7e:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
     c82:	4b98                	lw	a4,16(a5)
     c84:	2705                	addiw	a4,a4,1
     c86:	cb98                	sw	a4,16(a5)
        break;
     c88:	a03d                	j	cb6 <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
     c8a:	04e1                	addi	s1,s1,24
     c8c:	03248463          	beq	s1,s2,cb4 <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
     c90:	449c                	lw	a5,8(s1)
     c92:	dfe5                	beqz	a5,c8a <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
     c94:	865a                	mv	a2,s6
     c96:	85ce                	mv	a1,s3
     c98:	8552                	mv	a0,s4
     c9a:	00000097          	auipc	ra,0x0
     c9e:	4a6080e7          	jalr	1190(ra) # 1140 <ringbuf>
        rings[i].book->write_done = 0;
     ca2:	609c                	ld	a5,0(s1)
     ca4:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
     ca8:	609c                	ld	a5,0(s1)
     caa:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
     cae:	0004a423          	sw	zero,8(s1)
     cb2:	bfe1                	j	c8a <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
     cb4:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
     cb6:	00001797          	auipc	a5,0x1
     cba:	c227b783          	ld	a5,-990(a5) # 18d8 <vm_addr>
     cbe:	00fab023          	sd	a5,0(s5)
  return i;
}
     cc2:	8526                	mv	a0,s1
     cc4:	70e2                	ld	ra,56(sp)
     cc6:	7442                	ld	s0,48(sp)
     cc8:	74a2                	ld	s1,40(sp)
     cca:	7902                	ld	s2,32(sp)
     ccc:	69e2                	ld	s3,24(sp)
     cce:	6a42                	ld	s4,16(sp)
     cd0:	6aa2                	ld	s5,8(sp)
     cd2:	6b02                	ld	s6,0(sp)
     cd4:	6121                	addi	sp,sp,64
     cd6:	8082                	ret

0000000000000cd8 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
     cd8:	1101                	addi	sp,sp,-32
     cda:	ec06                	sd	ra,24(sp)
     cdc:	e822                	sd	s0,16(sp)
     cde:	e426                	sd	s1,8(sp)
     ce0:	1000                	addi	s0,sp,32
     ce2:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
     ce4:	00001797          	auipc	a5,0x1
     ce8:	bf47b783          	ld	a5,-1036(a5) # 18d8 <vm_addr>
     cec:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
     cee:	421c                	lw	a5,0(a2)
     cf0:	e79d                	bnez	a5,d1e <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
     cf2:	00001697          	auipc	a3,0x1
     cf6:	fde68693          	addi	a3,a3,-34 # 1cd0 <rings>
     cfa:	669c                	ld	a5,8(a3)
     cfc:	6398                	ld	a4,0(a5)
     cfe:	67c1                	lui	a5,0x10
     d00:	9fb9                	addw	a5,a5,a4
     d02:	00151713          	slli	a4,a0,0x1
     d06:	953a                	add	a0,a0,a4
     d08:	050e                	slli	a0,a0,0x3
     d0a:	9536                	add	a0,a0,a3
     d0c:	6518                	ld	a4,8(a0)
     d0e:	6718                	ld	a4,8(a4)
     d10:	9f99                	subw	a5,a5,a4
     d12:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
     d14:	60e2                	ld	ra,24(sp)
     d16:	6442                	ld	s0,16(sp)
     d18:	64a2                	ld	s1,8(sp)
     d1a:	6105                	addi	sp,sp,32
     d1c:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
     d1e:	00151793          	slli	a5,a0,0x1
     d22:	953e                	add	a0,a0,a5
     d24:	050e                	slli	a0,a0,0x3
     d26:	00001797          	auipc	a5,0x1
     d2a:	faa78793          	addi	a5,a5,-86 # 1cd0 <rings>
     d2e:	953e                	add	a0,a0,a5
     d30:	6508                	ld	a0,8(a0)
     d32:	0521                	addi	a0,a0,8
     d34:	00000097          	auipc	ra,0x0
     d38:	ed0080e7          	jalr	-304(ra) # c04 <load>
     d3c:	c088                	sw	a0,0(s1)
}
     d3e:	bfd9                	j	d14 <ringbuf_start_write+0x3c>

0000000000000d40 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
     d40:	1141                	addi	sp,sp,-16
     d42:	e406                	sd	ra,8(sp)
     d44:	e022                	sd	s0,0(sp)
     d46:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
     d48:	00151793          	slli	a5,a0,0x1
     d4c:	97aa                	add	a5,a5,a0
     d4e:	078e                	slli	a5,a5,0x3
     d50:	00001517          	auipc	a0,0x1
     d54:	f8050513          	addi	a0,a0,-128 # 1cd0 <rings>
     d58:	97aa                	add	a5,a5,a0
     d5a:	6788                	ld	a0,8(a5)
     d5c:	0035959b          	slliw	a1,a1,0x3
     d60:	0521                	addi	a0,a0,8
     d62:	00000097          	auipc	ra,0x0
     d66:	e8e080e7          	jalr	-370(ra) # bf0 <store>
}
     d6a:	60a2                	ld	ra,8(sp)
     d6c:	6402                	ld	s0,0(sp)
     d6e:	0141                	addi	sp,sp,16
     d70:	8082                	ret

0000000000000d72 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
     d72:	1101                	addi	sp,sp,-32
     d74:	ec06                	sd	ra,24(sp)
     d76:	e822                	sd	s0,16(sp)
     d78:	e426                	sd	s1,8(sp)
     d7a:	1000                	addi	s0,sp,32
     d7c:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
     d7e:	00151793          	slli	a5,a0,0x1
     d82:	97aa                	add	a5,a5,a0
     d84:	078e                	slli	a5,a5,0x3
     d86:	00001517          	auipc	a0,0x1
     d8a:	f4a50513          	addi	a0,a0,-182 # 1cd0 <rings>
     d8e:	97aa                	add	a5,a5,a0
     d90:	6788                	ld	a0,8(a5)
     d92:	0521                	addi	a0,a0,8
     d94:	00000097          	auipc	ra,0x0
     d98:	e70080e7          	jalr	-400(ra) # c04 <load>
     d9c:	c088                	sw	a0,0(s1)
}
     d9e:	60e2                	ld	ra,24(sp)
     da0:	6442                	ld	s0,16(sp)
     da2:	64a2                	ld	s1,8(sp)
     da4:	6105                	addi	sp,sp,32
     da6:	8082                	ret

0000000000000da8 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
     da8:	1101                	addi	sp,sp,-32
     daa:	ec06                	sd	ra,24(sp)
     dac:	e822                	sd	s0,16(sp)
     dae:	e426                	sd	s1,8(sp)
     db0:	1000                	addi	s0,sp,32
     db2:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
     db4:	00151793          	slli	a5,a0,0x1
     db8:	97aa                	add	a5,a5,a0
     dba:	078e                	slli	a5,a5,0x3
     dbc:	00001517          	auipc	a0,0x1
     dc0:	f1450513          	addi	a0,a0,-236 # 1cd0 <rings>
     dc4:	97aa                	add	a5,a5,a0
     dc6:	6788                	ld	a0,8(a5)
     dc8:	611c                	ld	a5,0(a0)
     dca:	ef99                	bnez	a5,de8 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
     dcc:	6518                	ld	a4,8(a0)
    *bytes /= 8;
     dce:	41f7579b          	sraiw	a5,a4,0x1f
     dd2:	01d7d79b          	srliw	a5,a5,0x1d
     dd6:	9fb9                	addw	a5,a5,a4
     dd8:	4037d79b          	sraiw	a5,a5,0x3
     ddc:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
     dde:	60e2                	ld	ra,24(sp)
     de0:	6442                	ld	s0,16(sp)
     de2:	64a2                	ld	s1,8(sp)
     de4:	6105                	addi	sp,sp,32
     de6:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
     de8:	00000097          	auipc	ra,0x0
     dec:	e1c080e7          	jalr	-484(ra) # c04 <load>
    *bytes /= 8;
     df0:	41f5579b          	sraiw	a5,a0,0x1f
     df4:	01d7d79b          	srliw	a5,a5,0x1d
     df8:	9d3d                	addw	a0,a0,a5
     dfa:	4035551b          	sraiw	a0,a0,0x3
     dfe:	c088                	sw	a0,0(s1)
}
     e00:	bff9                	j	dde <ringbuf_start_read+0x36>

0000000000000e02 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
     e02:	1141                	addi	sp,sp,-16
     e04:	e406                	sd	ra,8(sp)
     e06:	e022                	sd	s0,0(sp)
     e08:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
     e0a:	00151793          	slli	a5,a0,0x1
     e0e:	97aa                	add	a5,a5,a0
     e10:	078e                	slli	a5,a5,0x3
     e12:	00001517          	auipc	a0,0x1
     e16:	ebe50513          	addi	a0,a0,-322 # 1cd0 <rings>
     e1a:	97aa                	add	a5,a5,a0
     e1c:	0035959b          	slliw	a1,a1,0x3
     e20:	6788                	ld	a0,8(a5)
     e22:	00000097          	auipc	ra,0x0
     e26:	dce080e7          	jalr	-562(ra) # bf0 <store>
}
     e2a:	60a2                	ld	ra,8(sp)
     e2c:	6402                	ld	s0,0(sp)
     e2e:	0141                	addi	sp,sp,16
     e30:	8082                	ret

0000000000000e32 <strcpy>:



char*
strcpy(char *s, const char *t)
{
     e32:	1141                	addi	sp,sp,-16
     e34:	e422                	sd	s0,8(sp)
     e36:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e38:	87aa                	mv	a5,a0
     e3a:	0585                	addi	a1,a1,1
     e3c:	0785                	addi	a5,a5,1
     e3e:	fff5c703          	lbu	a4,-1(a1)
     e42:	fee78fa3          	sb	a4,-1(a5)
     e46:	fb75                	bnez	a4,e3a <strcpy+0x8>
    ;
  return os;
}
     e48:	6422                	ld	s0,8(sp)
     e4a:	0141                	addi	sp,sp,16
     e4c:	8082                	ret

0000000000000e4e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e4e:	1141                	addi	sp,sp,-16
     e50:	e422                	sd	s0,8(sp)
     e52:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     e54:	00054783          	lbu	a5,0(a0)
     e58:	cb91                	beqz	a5,e6c <strcmp+0x1e>
     e5a:	0005c703          	lbu	a4,0(a1)
     e5e:	00f71763          	bne	a4,a5,e6c <strcmp+0x1e>
    p++, q++;
     e62:	0505                	addi	a0,a0,1
     e64:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     e66:	00054783          	lbu	a5,0(a0)
     e6a:	fbe5                	bnez	a5,e5a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     e6c:	0005c503          	lbu	a0,0(a1)
}
     e70:	40a7853b          	subw	a0,a5,a0
     e74:	6422                	ld	s0,8(sp)
     e76:	0141                	addi	sp,sp,16
     e78:	8082                	ret

0000000000000e7a <strlen>:

uint
strlen(const char *s)
{
     e7a:	1141                	addi	sp,sp,-16
     e7c:	e422                	sd	s0,8(sp)
     e7e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     e80:	00054783          	lbu	a5,0(a0)
     e84:	cf91                	beqz	a5,ea0 <strlen+0x26>
     e86:	0505                	addi	a0,a0,1
     e88:	87aa                	mv	a5,a0
     e8a:	4685                	li	a3,1
     e8c:	9e89                	subw	a3,a3,a0
     e8e:	00f6853b          	addw	a0,a3,a5
     e92:	0785                	addi	a5,a5,1
     e94:	fff7c703          	lbu	a4,-1(a5)
     e98:	fb7d                	bnez	a4,e8e <strlen+0x14>
    ;
  return n;
}
     e9a:	6422                	ld	s0,8(sp)
     e9c:	0141                	addi	sp,sp,16
     e9e:	8082                	ret
  for(n = 0; s[n]; n++)
     ea0:	4501                	li	a0,0
     ea2:	bfe5                	j	e9a <strlen+0x20>

0000000000000ea4 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ea4:	1141                	addi	sp,sp,-16
     ea6:	e422                	sd	s0,8(sp)
     ea8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     eaa:	ca19                	beqz	a2,ec0 <memset+0x1c>
     eac:	87aa                	mv	a5,a0
     eae:	1602                	slli	a2,a2,0x20
     eb0:	9201                	srli	a2,a2,0x20
     eb2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     eb6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     eba:	0785                	addi	a5,a5,1
     ebc:	fee79de3          	bne	a5,a4,eb6 <memset+0x12>
  }
  return dst;
}
     ec0:	6422                	ld	s0,8(sp)
     ec2:	0141                	addi	sp,sp,16
     ec4:	8082                	ret

0000000000000ec6 <strchr>:

char*
strchr(const char *s, char c)
{
     ec6:	1141                	addi	sp,sp,-16
     ec8:	e422                	sd	s0,8(sp)
     eca:	0800                	addi	s0,sp,16
  for(; *s; s++)
     ecc:	00054783          	lbu	a5,0(a0)
     ed0:	cb99                	beqz	a5,ee6 <strchr+0x20>
    if(*s == c)
     ed2:	00f58763          	beq	a1,a5,ee0 <strchr+0x1a>
  for(; *s; s++)
     ed6:	0505                	addi	a0,a0,1
     ed8:	00054783          	lbu	a5,0(a0)
     edc:	fbfd                	bnez	a5,ed2 <strchr+0xc>
      return (char*)s;
  return 0;
     ede:	4501                	li	a0,0
}
     ee0:	6422                	ld	s0,8(sp)
     ee2:	0141                	addi	sp,sp,16
     ee4:	8082                	ret
  return 0;
     ee6:	4501                	li	a0,0
     ee8:	bfe5                	j	ee0 <strchr+0x1a>

0000000000000eea <gets>:

char*
gets(char *buf, int max)
{
     eea:	711d                	addi	sp,sp,-96
     eec:	ec86                	sd	ra,88(sp)
     eee:	e8a2                	sd	s0,80(sp)
     ef0:	e4a6                	sd	s1,72(sp)
     ef2:	e0ca                	sd	s2,64(sp)
     ef4:	fc4e                	sd	s3,56(sp)
     ef6:	f852                	sd	s4,48(sp)
     ef8:	f456                	sd	s5,40(sp)
     efa:	f05a                	sd	s6,32(sp)
     efc:	ec5e                	sd	s7,24(sp)
     efe:	1080                	addi	s0,sp,96
     f00:	8baa                	mv	s7,a0
     f02:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f04:	892a                	mv	s2,a0
     f06:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     f08:	4aa9                	li	s5,10
     f0a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     f0c:	89a6                	mv	s3,s1
     f0e:	2485                	addiw	s1,s1,1
     f10:	0344d863          	bge	s1,s4,f40 <gets+0x56>
    cc = read(0, &c, 1);
     f14:	4605                	li	a2,1
     f16:	faf40593          	addi	a1,s0,-81
     f1a:	4501                	li	a0,0
     f1c:	00000097          	auipc	ra,0x0
     f20:	19c080e7          	jalr	412(ra) # 10b8 <read>
    if(cc < 1)
     f24:	00a05e63          	blez	a0,f40 <gets+0x56>
    buf[i++] = c;
     f28:	faf44783          	lbu	a5,-81(s0)
     f2c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     f30:	01578763          	beq	a5,s5,f3e <gets+0x54>
     f34:	0905                	addi	s2,s2,1
     f36:	fd679be3          	bne	a5,s6,f0c <gets+0x22>
  for(i=0; i+1 < max; ){
     f3a:	89a6                	mv	s3,s1
     f3c:	a011                	j	f40 <gets+0x56>
     f3e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     f40:	99de                	add	s3,s3,s7
     f42:	00098023          	sb	zero,0(s3)
  return buf;
}
     f46:	855e                	mv	a0,s7
     f48:	60e6                	ld	ra,88(sp)
     f4a:	6446                	ld	s0,80(sp)
     f4c:	64a6                	ld	s1,72(sp)
     f4e:	6906                	ld	s2,64(sp)
     f50:	79e2                	ld	s3,56(sp)
     f52:	7a42                	ld	s4,48(sp)
     f54:	7aa2                	ld	s5,40(sp)
     f56:	7b02                	ld	s6,32(sp)
     f58:	6be2                	ld	s7,24(sp)
     f5a:	6125                	addi	sp,sp,96
     f5c:	8082                	ret

0000000000000f5e <stat>:

int
stat(const char *n, struct stat *st)
{
     f5e:	1101                	addi	sp,sp,-32
     f60:	ec06                	sd	ra,24(sp)
     f62:	e822                	sd	s0,16(sp)
     f64:	e426                	sd	s1,8(sp)
     f66:	e04a                	sd	s2,0(sp)
     f68:	1000                	addi	s0,sp,32
     f6a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f6c:	4581                	li	a1,0
     f6e:	00000097          	auipc	ra,0x0
     f72:	172080e7          	jalr	370(ra) # 10e0 <open>
  if(fd < 0)
     f76:	02054563          	bltz	a0,fa0 <stat+0x42>
     f7a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     f7c:	85ca                	mv	a1,s2
     f7e:	00000097          	auipc	ra,0x0
     f82:	17a080e7          	jalr	378(ra) # 10f8 <fstat>
     f86:	892a                	mv	s2,a0
  close(fd);
     f88:	8526                	mv	a0,s1
     f8a:	00000097          	auipc	ra,0x0
     f8e:	13e080e7          	jalr	318(ra) # 10c8 <close>
  return r;
}
     f92:	854a                	mv	a0,s2
     f94:	60e2                	ld	ra,24(sp)
     f96:	6442                	ld	s0,16(sp)
     f98:	64a2                	ld	s1,8(sp)
     f9a:	6902                	ld	s2,0(sp)
     f9c:	6105                	addi	sp,sp,32
     f9e:	8082                	ret
    return -1;
     fa0:	597d                	li	s2,-1
     fa2:	bfc5                	j	f92 <stat+0x34>

0000000000000fa4 <atoi>:

int
atoi(const char *s)
{
     fa4:	1141                	addi	sp,sp,-16
     fa6:	e422                	sd	s0,8(sp)
     fa8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     faa:	00054603          	lbu	a2,0(a0)
     fae:	fd06079b          	addiw	a5,a2,-48
     fb2:	0ff7f793          	zext.b	a5,a5
     fb6:	4725                	li	a4,9
     fb8:	02f76963          	bltu	a4,a5,fea <atoi+0x46>
     fbc:	86aa                	mv	a3,a0
  n = 0;
     fbe:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     fc0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     fc2:	0685                	addi	a3,a3,1
     fc4:	0025179b          	slliw	a5,a0,0x2
     fc8:	9fa9                	addw	a5,a5,a0
     fca:	0017979b          	slliw	a5,a5,0x1
     fce:	9fb1                	addw	a5,a5,a2
     fd0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     fd4:	0006c603          	lbu	a2,0(a3)
     fd8:	fd06071b          	addiw	a4,a2,-48
     fdc:	0ff77713          	zext.b	a4,a4
     fe0:	fee5f1e3          	bgeu	a1,a4,fc2 <atoi+0x1e>
  return n;
}
     fe4:	6422                	ld	s0,8(sp)
     fe6:	0141                	addi	sp,sp,16
     fe8:	8082                	ret
  n = 0;
     fea:	4501                	li	a0,0
     fec:	bfe5                	j	fe4 <atoi+0x40>

0000000000000fee <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     fee:	1141                	addi	sp,sp,-16
     ff0:	e422                	sd	s0,8(sp)
     ff2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     ff4:	02b57463          	bgeu	a0,a1,101c <memmove+0x2e>
    while(n-- > 0)
     ff8:	00c05f63          	blez	a2,1016 <memmove+0x28>
     ffc:	1602                	slli	a2,a2,0x20
     ffe:	9201                	srli	a2,a2,0x20
    1000:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    1004:	872a                	mv	a4,a0
      *dst++ = *src++;
    1006:	0585                	addi	a1,a1,1
    1008:	0705                	addi	a4,a4,1
    100a:	fff5c683          	lbu	a3,-1(a1)
    100e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    1012:	fee79ae3          	bne	a5,a4,1006 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    1016:	6422                	ld	s0,8(sp)
    1018:	0141                	addi	sp,sp,16
    101a:	8082                	ret
    dst += n;
    101c:	00c50733          	add	a4,a0,a2
    src += n;
    1020:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    1022:	fec05ae3          	blez	a2,1016 <memmove+0x28>
    1026:	fff6079b          	addiw	a5,a2,-1
    102a:	1782                	slli	a5,a5,0x20
    102c:	9381                	srli	a5,a5,0x20
    102e:	fff7c793          	not	a5,a5
    1032:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    1034:	15fd                	addi	a1,a1,-1
    1036:	177d                	addi	a4,a4,-1
    1038:	0005c683          	lbu	a3,0(a1)
    103c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    1040:	fee79ae3          	bne	a5,a4,1034 <memmove+0x46>
    1044:	bfc9                	j	1016 <memmove+0x28>

0000000000001046 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    1046:	1141                	addi	sp,sp,-16
    1048:	e422                	sd	s0,8(sp)
    104a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    104c:	ca05                	beqz	a2,107c <memcmp+0x36>
    104e:	fff6069b          	addiw	a3,a2,-1
    1052:	1682                	slli	a3,a3,0x20
    1054:	9281                	srli	a3,a3,0x20
    1056:	0685                	addi	a3,a3,1
    1058:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    105a:	00054783          	lbu	a5,0(a0)
    105e:	0005c703          	lbu	a4,0(a1)
    1062:	00e79863          	bne	a5,a4,1072 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    1066:	0505                	addi	a0,a0,1
    p2++;
    1068:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    106a:	fed518e3          	bne	a0,a3,105a <memcmp+0x14>
  }
  return 0;
    106e:	4501                	li	a0,0
    1070:	a019                	j	1076 <memcmp+0x30>
      return *p1 - *p2;
    1072:	40e7853b          	subw	a0,a5,a4
}
    1076:	6422                	ld	s0,8(sp)
    1078:	0141                	addi	sp,sp,16
    107a:	8082                	ret
  return 0;
    107c:	4501                	li	a0,0
    107e:	bfe5                	j	1076 <memcmp+0x30>

0000000000001080 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1080:	1141                	addi	sp,sp,-16
    1082:	e406                	sd	ra,8(sp)
    1084:	e022                	sd	s0,0(sp)
    1086:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    1088:	00000097          	auipc	ra,0x0
    108c:	f66080e7          	jalr	-154(ra) # fee <memmove>
}
    1090:	60a2                	ld	ra,8(sp)
    1092:	6402                	ld	s0,0(sp)
    1094:	0141                	addi	sp,sp,16
    1096:	8082                	ret

0000000000001098 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    1098:	4885                	li	a7,1
 ecall
    109a:	00000073          	ecall
 ret
    109e:	8082                	ret

00000000000010a0 <exit>:
.global exit
exit:
 li a7, SYS_exit
    10a0:	4889                	li	a7,2
 ecall
    10a2:	00000073          	ecall
 ret
    10a6:	8082                	ret

00000000000010a8 <wait>:
.global wait
wait:
 li a7, SYS_wait
    10a8:	488d                	li	a7,3
 ecall
    10aa:	00000073          	ecall
 ret
    10ae:	8082                	ret

00000000000010b0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    10b0:	4891                	li	a7,4
 ecall
    10b2:	00000073          	ecall
 ret
    10b6:	8082                	ret

00000000000010b8 <read>:
.global read
read:
 li a7, SYS_read
    10b8:	4895                	li	a7,5
 ecall
    10ba:	00000073          	ecall
 ret
    10be:	8082                	ret

00000000000010c0 <write>:
.global write
write:
 li a7, SYS_write
    10c0:	48c1                	li	a7,16
 ecall
    10c2:	00000073          	ecall
 ret
    10c6:	8082                	ret

00000000000010c8 <close>:
.global close
close:
 li a7, SYS_close
    10c8:	48d5                	li	a7,21
 ecall
    10ca:	00000073          	ecall
 ret
    10ce:	8082                	ret

00000000000010d0 <kill>:
.global kill
kill:
 li a7, SYS_kill
    10d0:	4899                	li	a7,6
 ecall
    10d2:	00000073          	ecall
 ret
    10d6:	8082                	ret

00000000000010d8 <exec>:
.global exec
exec:
 li a7, SYS_exec
    10d8:	489d                	li	a7,7
 ecall
    10da:	00000073          	ecall
 ret
    10de:	8082                	ret

00000000000010e0 <open>:
.global open
open:
 li a7, SYS_open
    10e0:	48bd                	li	a7,15
 ecall
    10e2:	00000073          	ecall
 ret
    10e6:	8082                	ret

00000000000010e8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    10e8:	48c5                	li	a7,17
 ecall
    10ea:	00000073          	ecall
 ret
    10ee:	8082                	ret

00000000000010f0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    10f0:	48c9                	li	a7,18
 ecall
    10f2:	00000073          	ecall
 ret
    10f6:	8082                	ret

00000000000010f8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    10f8:	48a1                	li	a7,8
 ecall
    10fa:	00000073          	ecall
 ret
    10fe:	8082                	ret

0000000000001100 <link>:
.global link
link:
 li a7, SYS_link
    1100:	48cd                	li	a7,19
 ecall
    1102:	00000073          	ecall
 ret
    1106:	8082                	ret

0000000000001108 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1108:	48d1                	li	a7,20
 ecall
    110a:	00000073          	ecall
 ret
    110e:	8082                	ret

0000000000001110 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    1110:	48a5                	li	a7,9
 ecall
    1112:	00000073          	ecall
 ret
    1116:	8082                	ret

0000000000001118 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1118:	48a9                	li	a7,10
 ecall
    111a:	00000073          	ecall
 ret
    111e:	8082                	ret

0000000000001120 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1120:	48ad                	li	a7,11
 ecall
    1122:	00000073          	ecall
 ret
    1126:	8082                	ret

0000000000001128 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1128:	48b1                	li	a7,12
 ecall
    112a:	00000073          	ecall
 ret
    112e:	8082                	ret

0000000000001130 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1130:	48b5                	li	a7,13
 ecall
    1132:	00000073          	ecall
 ret
    1136:	8082                	ret

0000000000001138 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1138:	48b9                	li	a7,14
 ecall
    113a:	00000073          	ecall
 ret
    113e:	8082                	ret

0000000000001140 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
    1140:	48d9                	li	a7,22
 ecall
    1142:	00000073          	ecall
 ret
    1146:	8082                	ret

0000000000001148 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1148:	1101                	addi	sp,sp,-32
    114a:	ec06                	sd	ra,24(sp)
    114c:	e822                	sd	s0,16(sp)
    114e:	1000                	addi	s0,sp,32
    1150:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    1154:	4605                	li	a2,1
    1156:	fef40593          	addi	a1,s0,-17
    115a:	00000097          	auipc	ra,0x0
    115e:	f66080e7          	jalr	-154(ra) # 10c0 <write>
}
    1162:	60e2                	ld	ra,24(sp)
    1164:	6442                	ld	s0,16(sp)
    1166:	6105                	addi	sp,sp,32
    1168:	8082                	ret

000000000000116a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    116a:	7139                	addi	sp,sp,-64
    116c:	fc06                	sd	ra,56(sp)
    116e:	f822                	sd	s0,48(sp)
    1170:	f426                	sd	s1,40(sp)
    1172:	f04a                	sd	s2,32(sp)
    1174:	ec4e                	sd	s3,24(sp)
    1176:	0080                	addi	s0,sp,64
    1178:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    117a:	c299                	beqz	a3,1180 <printint+0x16>
    117c:	0805c863          	bltz	a1,120c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1180:	2581                	sext.w	a1,a1
  neg = 0;
    1182:	4881                	li	a7,0
    1184:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    1188:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    118a:	2601                	sext.w	a2,a2
    118c:	00000517          	auipc	a0,0x0
    1190:	72c50513          	addi	a0,a0,1836 # 18b8 <digits>
    1194:	883a                	mv	a6,a4
    1196:	2705                	addiw	a4,a4,1
    1198:	02c5f7bb          	remuw	a5,a1,a2
    119c:	1782                	slli	a5,a5,0x20
    119e:	9381                	srli	a5,a5,0x20
    11a0:	97aa                	add	a5,a5,a0
    11a2:	0007c783          	lbu	a5,0(a5)
    11a6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    11aa:	0005879b          	sext.w	a5,a1
    11ae:	02c5d5bb          	divuw	a1,a1,a2
    11b2:	0685                	addi	a3,a3,1
    11b4:	fec7f0e3          	bgeu	a5,a2,1194 <printint+0x2a>
  if(neg)
    11b8:	00088b63          	beqz	a7,11ce <printint+0x64>
    buf[i++] = '-';
    11bc:	fd040793          	addi	a5,s0,-48
    11c0:	973e                	add	a4,a4,a5
    11c2:	02d00793          	li	a5,45
    11c6:	fef70823          	sb	a5,-16(a4)
    11ca:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    11ce:	02e05863          	blez	a4,11fe <printint+0x94>
    11d2:	fc040793          	addi	a5,s0,-64
    11d6:	00e78933          	add	s2,a5,a4
    11da:	fff78993          	addi	s3,a5,-1
    11de:	99ba                	add	s3,s3,a4
    11e0:	377d                	addiw	a4,a4,-1
    11e2:	1702                	slli	a4,a4,0x20
    11e4:	9301                	srli	a4,a4,0x20
    11e6:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    11ea:	fff94583          	lbu	a1,-1(s2)
    11ee:	8526                	mv	a0,s1
    11f0:	00000097          	auipc	ra,0x0
    11f4:	f58080e7          	jalr	-168(ra) # 1148 <putc>
  while(--i >= 0)
    11f8:	197d                	addi	s2,s2,-1
    11fa:	ff3918e3          	bne	s2,s3,11ea <printint+0x80>
}
    11fe:	70e2                	ld	ra,56(sp)
    1200:	7442                	ld	s0,48(sp)
    1202:	74a2                	ld	s1,40(sp)
    1204:	7902                	ld	s2,32(sp)
    1206:	69e2                	ld	s3,24(sp)
    1208:	6121                	addi	sp,sp,64
    120a:	8082                	ret
    x = -xx;
    120c:	40b005bb          	negw	a1,a1
    neg = 1;
    1210:	4885                	li	a7,1
    x = -xx;
    1212:	bf8d                	j	1184 <printint+0x1a>

0000000000001214 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1214:	7119                	addi	sp,sp,-128
    1216:	fc86                	sd	ra,120(sp)
    1218:	f8a2                	sd	s0,112(sp)
    121a:	f4a6                	sd	s1,104(sp)
    121c:	f0ca                	sd	s2,96(sp)
    121e:	ecce                	sd	s3,88(sp)
    1220:	e8d2                	sd	s4,80(sp)
    1222:	e4d6                	sd	s5,72(sp)
    1224:	e0da                	sd	s6,64(sp)
    1226:	fc5e                	sd	s7,56(sp)
    1228:	f862                	sd	s8,48(sp)
    122a:	f466                	sd	s9,40(sp)
    122c:	f06a                	sd	s10,32(sp)
    122e:	ec6e                	sd	s11,24(sp)
    1230:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    1232:	0005c903          	lbu	s2,0(a1)
    1236:	18090f63          	beqz	s2,13d4 <vprintf+0x1c0>
    123a:	8aaa                	mv	s5,a0
    123c:	8b32                	mv	s6,a2
    123e:	00158493          	addi	s1,a1,1
  state = 0;
    1242:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1244:	02500a13          	li	s4,37
      if(c == 'd'){
    1248:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    124c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    1250:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    1254:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1258:	00000b97          	auipc	s7,0x0
    125c:	660b8b93          	addi	s7,s7,1632 # 18b8 <digits>
    1260:	a839                	j	127e <vprintf+0x6a>
        putc(fd, c);
    1262:	85ca                	mv	a1,s2
    1264:	8556                	mv	a0,s5
    1266:	00000097          	auipc	ra,0x0
    126a:	ee2080e7          	jalr	-286(ra) # 1148 <putc>
    126e:	a019                	j	1274 <vprintf+0x60>
    } else if(state == '%'){
    1270:	01498f63          	beq	s3,s4,128e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    1274:	0485                	addi	s1,s1,1
    1276:	fff4c903          	lbu	s2,-1(s1)
    127a:	14090d63          	beqz	s2,13d4 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    127e:	0009079b          	sext.w	a5,s2
    if(state == 0){
    1282:	fe0997e3          	bnez	s3,1270 <vprintf+0x5c>
      if(c == '%'){
    1286:	fd479ee3          	bne	a5,s4,1262 <vprintf+0x4e>
        state = '%';
    128a:	89be                	mv	s3,a5
    128c:	b7e5                	j	1274 <vprintf+0x60>
      if(c == 'd'){
    128e:	05878063          	beq	a5,s8,12ce <vprintf+0xba>
      } else if(c == 'l') {
    1292:	05978c63          	beq	a5,s9,12ea <vprintf+0xd6>
      } else if(c == 'x') {
    1296:	07a78863          	beq	a5,s10,1306 <vprintf+0xf2>
      } else if(c == 'p') {
    129a:	09b78463          	beq	a5,s11,1322 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    129e:	07300713          	li	a4,115
    12a2:	0ce78663          	beq	a5,a4,136e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    12a6:	06300713          	li	a4,99
    12aa:	0ee78e63          	beq	a5,a4,13a6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    12ae:	11478863          	beq	a5,s4,13be <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    12b2:	85d2                	mv	a1,s4
    12b4:	8556                	mv	a0,s5
    12b6:	00000097          	auipc	ra,0x0
    12ba:	e92080e7          	jalr	-366(ra) # 1148 <putc>
        putc(fd, c);
    12be:	85ca                	mv	a1,s2
    12c0:	8556                	mv	a0,s5
    12c2:	00000097          	auipc	ra,0x0
    12c6:	e86080e7          	jalr	-378(ra) # 1148 <putc>
      }
      state = 0;
    12ca:	4981                	li	s3,0
    12cc:	b765                	j	1274 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    12ce:	008b0913          	addi	s2,s6,8
    12d2:	4685                	li	a3,1
    12d4:	4629                	li	a2,10
    12d6:	000b2583          	lw	a1,0(s6)
    12da:	8556                	mv	a0,s5
    12dc:	00000097          	auipc	ra,0x0
    12e0:	e8e080e7          	jalr	-370(ra) # 116a <printint>
    12e4:	8b4a                	mv	s6,s2
      state = 0;
    12e6:	4981                	li	s3,0
    12e8:	b771                	j	1274 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    12ea:	008b0913          	addi	s2,s6,8
    12ee:	4681                	li	a3,0
    12f0:	4629                	li	a2,10
    12f2:	000b2583          	lw	a1,0(s6)
    12f6:	8556                	mv	a0,s5
    12f8:	00000097          	auipc	ra,0x0
    12fc:	e72080e7          	jalr	-398(ra) # 116a <printint>
    1300:	8b4a                	mv	s6,s2
      state = 0;
    1302:	4981                	li	s3,0
    1304:	bf85                	j	1274 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1306:	008b0913          	addi	s2,s6,8
    130a:	4681                	li	a3,0
    130c:	4641                	li	a2,16
    130e:	000b2583          	lw	a1,0(s6)
    1312:	8556                	mv	a0,s5
    1314:	00000097          	auipc	ra,0x0
    1318:	e56080e7          	jalr	-426(ra) # 116a <printint>
    131c:	8b4a                	mv	s6,s2
      state = 0;
    131e:	4981                	li	s3,0
    1320:	bf91                	j	1274 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1322:	008b0793          	addi	a5,s6,8
    1326:	f8f43423          	sd	a5,-120(s0)
    132a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    132e:	03000593          	li	a1,48
    1332:	8556                	mv	a0,s5
    1334:	00000097          	auipc	ra,0x0
    1338:	e14080e7          	jalr	-492(ra) # 1148 <putc>
  putc(fd, 'x');
    133c:	85ea                	mv	a1,s10
    133e:	8556                	mv	a0,s5
    1340:	00000097          	auipc	ra,0x0
    1344:	e08080e7          	jalr	-504(ra) # 1148 <putc>
    1348:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    134a:	03c9d793          	srli	a5,s3,0x3c
    134e:	97de                	add	a5,a5,s7
    1350:	0007c583          	lbu	a1,0(a5)
    1354:	8556                	mv	a0,s5
    1356:	00000097          	auipc	ra,0x0
    135a:	df2080e7          	jalr	-526(ra) # 1148 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    135e:	0992                	slli	s3,s3,0x4
    1360:	397d                	addiw	s2,s2,-1
    1362:	fe0914e3          	bnez	s2,134a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    1366:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    136a:	4981                	li	s3,0
    136c:	b721                	j	1274 <vprintf+0x60>
        s = va_arg(ap, char*);
    136e:	008b0993          	addi	s3,s6,8
    1372:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    1376:	02090163          	beqz	s2,1398 <vprintf+0x184>
        while(*s != 0){
    137a:	00094583          	lbu	a1,0(s2)
    137e:	c9a1                	beqz	a1,13ce <vprintf+0x1ba>
          putc(fd, *s);
    1380:	8556                	mv	a0,s5
    1382:	00000097          	auipc	ra,0x0
    1386:	dc6080e7          	jalr	-570(ra) # 1148 <putc>
          s++;
    138a:	0905                	addi	s2,s2,1
        while(*s != 0){
    138c:	00094583          	lbu	a1,0(s2)
    1390:	f9e5                	bnez	a1,1380 <vprintf+0x16c>
        s = va_arg(ap, char*);
    1392:	8b4e                	mv	s6,s3
      state = 0;
    1394:	4981                	li	s3,0
    1396:	bdf9                	j	1274 <vprintf+0x60>
          s = "(null)";
    1398:	00000917          	auipc	s2,0x0
    139c:	51890913          	addi	s2,s2,1304 # 18b0 <malloc+0x3d2>
        while(*s != 0){
    13a0:	02800593          	li	a1,40
    13a4:	bff1                	j	1380 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    13a6:	008b0913          	addi	s2,s6,8
    13aa:	000b4583          	lbu	a1,0(s6)
    13ae:	8556                	mv	a0,s5
    13b0:	00000097          	auipc	ra,0x0
    13b4:	d98080e7          	jalr	-616(ra) # 1148 <putc>
    13b8:	8b4a                	mv	s6,s2
      state = 0;
    13ba:	4981                	li	s3,0
    13bc:	bd65                	j	1274 <vprintf+0x60>
        putc(fd, c);
    13be:	85d2                	mv	a1,s4
    13c0:	8556                	mv	a0,s5
    13c2:	00000097          	auipc	ra,0x0
    13c6:	d86080e7          	jalr	-634(ra) # 1148 <putc>
      state = 0;
    13ca:	4981                	li	s3,0
    13cc:	b565                	j	1274 <vprintf+0x60>
        s = va_arg(ap, char*);
    13ce:	8b4e                	mv	s6,s3
      state = 0;
    13d0:	4981                	li	s3,0
    13d2:	b54d                	j	1274 <vprintf+0x60>
    }
  }
}
    13d4:	70e6                	ld	ra,120(sp)
    13d6:	7446                	ld	s0,112(sp)
    13d8:	74a6                	ld	s1,104(sp)
    13da:	7906                	ld	s2,96(sp)
    13dc:	69e6                	ld	s3,88(sp)
    13de:	6a46                	ld	s4,80(sp)
    13e0:	6aa6                	ld	s5,72(sp)
    13e2:	6b06                	ld	s6,64(sp)
    13e4:	7be2                	ld	s7,56(sp)
    13e6:	7c42                	ld	s8,48(sp)
    13e8:	7ca2                	ld	s9,40(sp)
    13ea:	7d02                	ld	s10,32(sp)
    13ec:	6de2                	ld	s11,24(sp)
    13ee:	6109                	addi	sp,sp,128
    13f0:	8082                	ret

00000000000013f2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    13f2:	715d                	addi	sp,sp,-80
    13f4:	ec06                	sd	ra,24(sp)
    13f6:	e822                	sd	s0,16(sp)
    13f8:	1000                	addi	s0,sp,32
    13fa:	e010                	sd	a2,0(s0)
    13fc:	e414                	sd	a3,8(s0)
    13fe:	e818                	sd	a4,16(s0)
    1400:	ec1c                	sd	a5,24(s0)
    1402:	03043023          	sd	a6,32(s0)
    1406:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    140a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    140e:	8622                	mv	a2,s0
    1410:	00000097          	auipc	ra,0x0
    1414:	e04080e7          	jalr	-508(ra) # 1214 <vprintf>
}
    1418:	60e2                	ld	ra,24(sp)
    141a:	6442                	ld	s0,16(sp)
    141c:	6161                	addi	sp,sp,80
    141e:	8082                	ret

0000000000001420 <printf>:

void
printf(const char *fmt, ...)
{
    1420:	711d                	addi	sp,sp,-96
    1422:	ec06                	sd	ra,24(sp)
    1424:	e822                	sd	s0,16(sp)
    1426:	1000                	addi	s0,sp,32
    1428:	e40c                	sd	a1,8(s0)
    142a:	e810                	sd	a2,16(s0)
    142c:	ec14                	sd	a3,24(s0)
    142e:	f018                	sd	a4,32(s0)
    1430:	f41c                	sd	a5,40(s0)
    1432:	03043823          	sd	a6,48(s0)
    1436:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    143a:	00840613          	addi	a2,s0,8
    143e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1442:	85aa                	mv	a1,a0
    1444:	4505                	li	a0,1
    1446:	00000097          	auipc	ra,0x0
    144a:	dce080e7          	jalr	-562(ra) # 1214 <vprintf>
}
    144e:	60e2                	ld	ra,24(sp)
    1450:	6442                	ld	s0,16(sp)
    1452:	6125                	addi	sp,sp,96
    1454:	8082                	ret

0000000000001456 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1456:	1141                	addi	sp,sp,-16
    1458:	e422                	sd	s0,8(sp)
    145a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    145c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1460:	00000797          	auipc	a5,0x0
    1464:	4807b783          	ld	a5,1152(a5) # 18e0 <freep>
    1468:	a805                	j	1498 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    146a:	4618                	lw	a4,8(a2)
    146c:	9db9                	addw	a1,a1,a4
    146e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1472:	6398                	ld	a4,0(a5)
    1474:	6318                	ld	a4,0(a4)
    1476:	fee53823          	sd	a4,-16(a0)
    147a:	a091                	j	14be <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    147c:	ff852703          	lw	a4,-8(a0)
    1480:	9e39                	addw	a2,a2,a4
    1482:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    1484:	ff053703          	ld	a4,-16(a0)
    1488:	e398                	sd	a4,0(a5)
    148a:	a099                	j	14d0 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    148c:	6398                	ld	a4,0(a5)
    148e:	00e7e463          	bltu	a5,a4,1496 <free+0x40>
    1492:	00e6ea63          	bltu	a3,a4,14a6 <free+0x50>
{
    1496:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1498:	fed7fae3          	bgeu	a5,a3,148c <free+0x36>
    149c:	6398                	ld	a4,0(a5)
    149e:	00e6e463          	bltu	a3,a4,14a6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14a2:	fee7eae3          	bltu	a5,a4,1496 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    14a6:	ff852583          	lw	a1,-8(a0)
    14aa:	6390                	ld	a2,0(a5)
    14ac:	02059813          	slli	a6,a1,0x20
    14b0:	01c85713          	srli	a4,a6,0x1c
    14b4:	9736                	add	a4,a4,a3
    14b6:	fae60ae3          	beq	a2,a4,146a <free+0x14>
    bp->s.ptr = p->s.ptr;
    14ba:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    14be:	4790                	lw	a2,8(a5)
    14c0:	02061593          	slli	a1,a2,0x20
    14c4:	01c5d713          	srli	a4,a1,0x1c
    14c8:	973e                	add	a4,a4,a5
    14ca:	fae689e3          	beq	a3,a4,147c <free+0x26>
  } else
    p->s.ptr = bp;
    14ce:	e394                	sd	a3,0(a5)
  freep = p;
    14d0:	00000717          	auipc	a4,0x0
    14d4:	40f73823          	sd	a5,1040(a4) # 18e0 <freep>
}
    14d8:	6422                	ld	s0,8(sp)
    14da:	0141                	addi	sp,sp,16
    14dc:	8082                	ret

00000000000014de <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    14de:	7139                	addi	sp,sp,-64
    14e0:	fc06                	sd	ra,56(sp)
    14e2:	f822                	sd	s0,48(sp)
    14e4:	f426                	sd	s1,40(sp)
    14e6:	f04a                	sd	s2,32(sp)
    14e8:	ec4e                	sd	s3,24(sp)
    14ea:	e852                	sd	s4,16(sp)
    14ec:	e456                	sd	s5,8(sp)
    14ee:	e05a                	sd	s6,0(sp)
    14f0:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14f2:	02051493          	slli	s1,a0,0x20
    14f6:	9081                	srli	s1,s1,0x20
    14f8:	04bd                	addi	s1,s1,15
    14fa:	8091                	srli	s1,s1,0x4
    14fc:	0014899b          	addiw	s3,s1,1
    1500:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1502:	00000517          	auipc	a0,0x0
    1506:	3de53503          	ld	a0,990(a0) # 18e0 <freep>
    150a:	c515                	beqz	a0,1536 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    150c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    150e:	4798                	lw	a4,8(a5)
    1510:	02977f63          	bgeu	a4,s1,154e <malloc+0x70>
    1514:	8a4e                	mv	s4,s3
    1516:	0009871b          	sext.w	a4,s3
    151a:	6685                	lui	a3,0x1
    151c:	00d77363          	bgeu	a4,a3,1522 <malloc+0x44>
    1520:	6a05                	lui	s4,0x1
    1522:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1526:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    152a:	00000917          	auipc	s2,0x0
    152e:	3b690913          	addi	s2,s2,950 # 18e0 <freep>
  if(p == (char*)-1)
    1532:	5afd                	li	s5,-1
    1534:	a895                	j	15a8 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    1536:	00001797          	auipc	a5,0x1
    153a:	88a78793          	addi	a5,a5,-1910 # 1dc0 <base>
    153e:	00000717          	auipc	a4,0x0
    1542:	3af73123          	sd	a5,930(a4) # 18e0 <freep>
    1546:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1548:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    154c:	b7e1                	j	1514 <malloc+0x36>
      if(p->s.size == nunits)
    154e:	02e48c63          	beq	s1,a4,1586 <malloc+0xa8>
        p->s.size -= nunits;
    1552:	4137073b          	subw	a4,a4,s3
    1556:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1558:	02071693          	slli	a3,a4,0x20
    155c:	01c6d713          	srli	a4,a3,0x1c
    1560:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1562:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1566:	00000717          	auipc	a4,0x0
    156a:	36a73d23          	sd	a0,890(a4) # 18e0 <freep>
      return (void*)(p + 1);
    156e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1572:	70e2                	ld	ra,56(sp)
    1574:	7442                	ld	s0,48(sp)
    1576:	74a2                	ld	s1,40(sp)
    1578:	7902                	ld	s2,32(sp)
    157a:	69e2                	ld	s3,24(sp)
    157c:	6a42                	ld	s4,16(sp)
    157e:	6aa2                	ld	s5,8(sp)
    1580:	6b02                	ld	s6,0(sp)
    1582:	6121                	addi	sp,sp,64
    1584:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    1586:	6398                	ld	a4,0(a5)
    1588:	e118                	sd	a4,0(a0)
    158a:	bff1                	j	1566 <malloc+0x88>
  hp->s.size = nu;
    158c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1590:	0541                	addi	a0,a0,16
    1592:	00000097          	auipc	ra,0x0
    1596:	ec4080e7          	jalr	-316(ra) # 1456 <free>
  return freep;
    159a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    159e:	d971                	beqz	a0,1572 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    15a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    15a2:	4798                	lw	a4,8(a5)
    15a4:	fa9775e3          	bgeu	a4,s1,154e <malloc+0x70>
    if(p == freep)
    15a8:	00093703          	ld	a4,0(s2)
    15ac:	853e                	mv	a0,a5
    15ae:	fef719e3          	bne	a4,a5,15a0 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    15b2:	8552                	mv	a0,s4
    15b4:	00000097          	auipc	ra,0x0
    15b8:	b74080e7          	jalr	-1164(ra) # 1128 <sbrk>
  if(p == (char*)-1)
    15bc:	fd5518e3          	bne	a0,s5,158c <malloc+0xae>
        return 0;
    15c0:	4501                	li	a0,0
    15c2:	bf45                	j	1572 <malloc+0x94>
