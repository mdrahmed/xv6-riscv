
user/_pipetest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
The size of an integer is 4 bytes. So, I am sending 4*128 = 512 bytes at 
a time. */
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
    /* Declaring count variable to see how much has been passed and 
    check variable will check if the data are recieved correctly or not. */
    int fd[2], current_time=0, elasped_time = 0, count=0, check=0;

    if(pipe(fd) == -1){ //creating pipe and checking for error
  3a:	f8840513          	addi	a0,s0,-120
  3e:	00000097          	auipc	ra,0x0
  42:	6a2080e7          	jalr	1698(ra) # 6e0 <pipe>
  46:	57fd                	li	a5,-1
  48:	04f50c63          	beq	a0,a5,a0 <main+0xa0>
        printf("An error occured while creating the pipe\n");
        exit(1); 
    }

    int cid = fork(); //Creating the child process;
  4c:	00000097          	auipc	ra,0x0
  50:	67c080e7          	jalr	1660(ra) # 6c8 <fork>

    if(cid == 0){ //This is the child process as fork returns 0 to child
  54:	c13d                	beqz	a0,ba <main+0xba>
        }

        close(fd[1]); //closing write end after wrting
    }

    else if(cid > 0){ // This is the parent process as fork returns child id to parent
  56:	1ca05463          	blez	a0,21e <main+0x21e>
        close(fd[1]); //closing the write function of the parent
  5a:	f8c42503          	lw	a0,-116(s0)
  5e:	00000097          	auipc	ra,0x0
  62:	69a080e7          	jalr	1690(ra) # 6f8 <close>
        int received_data[SIZE] = {0}; //Declaring receiving data and initializing it to 0
  66:	20000613          	li	a2,512
  6a:	4581                	li	a1,0
  6c:	d8840513          	addi	a0,s0,-632
  70:	00000097          	auipc	ra,0x0
  74:	464080e7          	jalr	1124(ra) # 4d4 <memset>

        current_time = uptime(); //getting the current time in the parent process
  78:	00000097          	auipc	ra,0x0
  7c:	6f0080e7          	jalr	1776(ra) # 768 <uptime>
  80:	8daa                	mv	s11,a0
  82:	08000a13          	li	s4,128
    int fd[2], current_time=0, elasped_time = 0, count=0, check=0;
  86:	4a81                	li	s5,0
  88:	4c01                	li	s8,0
        for(int i=0; i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
            int read_data =  read(fd[0], received_data, 512); //Receiving data with read function

            count = count+read_data; //Counting the total number of data read

            if(read_data == -1){ //checking if any error occurred while receiving data
  8a:	5d7d                	li	s10,-1
            }

            int k=0;
            for(int j=(i*128); j < ((i+1)*128); j++){
                if(j != received_data[k]){ // I sent the value of j to parent and now checking if the value matches with the received data. 
                    printf("An error occurred while receiving data\n"); // If the received data doesn't match then an error message will be printed
  8c:	00001b97          	auipc	s7,0x1
  90:	becb8b93          	addi	s7,s7,-1044 # c78 <malloc+0x16a>
                    check = 1; // Value of check will be changed to 1 if any byte went missing
  94:	4b05                	li	s6,1
        for(int i=0; i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
  96:	00280cb7          	lui	s9,0x280
  9a:	080c8c93          	addi	s9,s9,128 # 280080 <__global_pointer$+0x27eb0f>
  9e:	a0ed                	j	188 <main+0x188>
        printf("An error occured while creating the pipe\n");
  a0:	00001517          	auipc	a0,0x1
  a4:	b5850513          	addi	a0,a0,-1192 # bf8 <malloc+0xea>
  a8:	00001097          	auipc	ra,0x1
  ac:	9a8080e7          	jalr	-1624(ra) # a50 <printf>
        exit(1); 
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	61e080e7          	jalr	1566(ra) # 6d0 <exit>
        close(fd[0]); //closing read function of child process
  ba:	f8842503          	lw	a0,-120(s0)
  be:	00000097          	auipc	ra,0x0
  c2:	63a080e7          	jalr	1594(ra) # 6f8 <close>
        int sending_data[SIZE] = {0}; //Declaring data of 128 size to send and initializing with value 0
  c6:	20000613          	li	a2,512
  ca:	4581                	li	a1,0
  cc:	d8840513          	addi	a0,s0,-632
  d0:	00000097          	auipc	ra,0x0
  d4:	404080e7          	jalr	1028(ra) # 4d4 <memset>
  d8:	08000493          	li	s1,128
            if(write(fd[1], sending_data, 512) == -1){ //sends data to parent process as well as checks for exception
  dc:	59fd                	li	s3,-1
        for(int i=0;i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
  de:	00280937          	lui	s2,0x280
  e2:	08090913          	addi	s2,s2,128 # 280080 <__global_pointer$+0x27eb0f>
  e6:	a00d                	j	108 <main+0x108>
            if(write(fd[1], sending_data, 512) == -1){ //sends data to parent process as well as checks for exception
  e8:	20000613          	li	a2,512
  ec:	d8840593          	addi	a1,s0,-632
  f0:	f8c42503          	lw	a0,-116(s0)
  f4:	00000097          	auipc	ra,0x0
  f8:	5fc080e7          	jalr	1532(ra) # 6f0 <write>
  fc:	03350263          	beq	a0,s3,120 <main+0x120>
        for(int i=0;i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
 100:	0804849b          	addiw	s1,s1,128
 104:	03248b63          	beq	s1,s2,13a <main+0x13a>
            for(int j=(i*128); j<((i+1)*128); j++){
 108:	f804879b          	addiw	a5,s1,-128
 10c:	d8840713          	addi	a4,s0,-632
 110:	0004869b          	sext.w	a3,s1
                sending_data[k] = j; //This for loop passes unique values to data;
 114:	c31c                	sw	a5,0(a4)
            for(int j=(i*128); j<((i+1)*128); j++){
 116:	2785                	addiw	a5,a5,1
 118:	0711                	addi	a4,a4,4
 11a:	fed7cde3          	blt	a5,a3,114 <main+0x114>
 11e:	b7e9                	j	e8 <main+0xe8>
                printf("An error occurred during writing\n");
 120:	00001517          	auipc	a0,0x1
 124:	b0850513          	addi	a0,a0,-1272 # c28 <malloc+0x11a>
 128:	00001097          	auipc	ra,0x1
 12c:	928080e7          	jalr	-1752(ra) # a50 <printf>
                exit(1);
 130:	4505                	li	a0,1
 132:	00000097          	auipc	ra,0x0
 136:	59e080e7          	jalr	1438(ra) # 6d0 <exit>
        close(fd[1]); //closing write end after wrting
 13a:	f8c42503          	lw	a0,-116(s0)
 13e:	00000097          	auipc	ra,0x0
 142:	5ba080e7          	jalr	1466(ra) # 6f8 <close>
 146:	a86d                	j	200 <main+0x200>
                printf("An error occurred while reading\n"); 
 148:	00001517          	auipc	a0,0x1
 14c:	b0850513          	addi	a0,a0,-1272 # c50 <malloc+0x142>
 150:	00001097          	auipc	ra,0x1
 154:	900080e7          	jalr	-1792(ra) # a50 <printf>
                exit(1);
 158:	4505                	li	a0,1
 15a:	00000097          	auipc	ra,0x0
 15e:	576080e7          	jalr	1398(ra) # 6d0 <exit>
            for(int j=(i*128); j < ((i+1)*128); j++){
 162:	2485                	addiw	s1,s1,1
 164:	0911                	addi	s2,s2,4
 166:	0134dd63          	bge	s1,s3,180 <main+0x180>
                if(j != received_data[k]){ // I sent the value of j to parent and now checking if the value matches with the received data. 
 16a:	00092783          	lw	a5,0(s2)
 16e:	fe978ae3          	beq	a5,s1,162 <main+0x162>
                    printf("An error occurred while receiving data\n"); // If the received data doesn't match then an error message will be printed
 172:	855e                	mv	a0,s7
 174:	00001097          	auipc	ra,0x1
 178:	8dc080e7          	jalr	-1828(ra) # a50 <printf>
                    check = 1; // Value of check will be changed to 1 if any byte went missing
 17c:	8ada                	mv	s5,s6
 17e:	b7d5                	j	162 <main+0x162>
        for(int i=0; i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
 180:	080a0a1b          	addiw	s4,s4,128
 184:	039a0763          	beq	s4,s9,1b2 <main+0x1b2>
            int read_data =  read(fd[0], received_data, 512); //Receiving data with read function
 188:	20000613          	li	a2,512
 18c:	d8840593          	addi	a1,s0,-632
 190:	f8842503          	lw	a0,-120(s0)
 194:	00000097          	auipc	ra,0x0
 198:	554080e7          	jalr	1364(ra) # 6e8 <read>
            count = count+read_data; //Counting the total number of data read
 19c:	01850c3b          	addw	s8,a0,s8
            if(read_data == -1){ //checking if any error occurred while receiving data
 1a0:	fba504e3          	beq	a0,s10,148 <main+0x148>
            for(int j=(i*128); j < ((i+1)*128); j++){
 1a4:	f80a049b          	addiw	s1,s4,-128
 1a8:	d8840913          	addi	s2,s0,-632
 1ac:	000a099b          	sext.w	s3,s4
 1b0:	bf6d                	j	16a <main+0x16a>
                }
                k++;
            }
        }

        cid = wait((int *)0); //The parent will wait for child before exiting
 1b2:	4501                	li	a0,0
 1b4:	00000097          	auipc	ra,0x0
 1b8:	524080e7          	jalr	1316(ra) # 6d8 <wait>
        
        // Now, the total byte data sent will be printed which is 10485760 or 10 MB
        
        printf("Total byte data sent: %d byte\n",count);
 1bc:	85e2                	mv	a1,s8
 1be:	00001517          	auipc	a0,0x1
 1c2:	ae250513          	addi	a0,a0,-1310 # ca0 <malloc+0x192>
 1c6:	00001097          	auipc	ra,0x1
 1ca:	88a080e7          	jalr	-1910(ra) # a50 <printf>

        // if the data received correctly then it will print 0 otherwise 1
        if(check == 0)
 1ce:	020a9e63          	bnez	s5,20a <main+0x20a>
            printf("Data received correctly as flag value is %d\n", check);
 1d2:	85d6                	mv	a1,s5
 1d4:	00001517          	auipc	a0,0x1
 1d8:	aec50513          	addi	a0,a0,-1300 # cc0 <malloc+0x1b2>
 1dc:	00001097          	auipc	ra,0x1
 1e0:	874080e7          	jalr	-1932(ra) # a50 <printf>
        else
            printf("A byte went missing as flag value is %d\n", check);

        //The total time taken for sending and receiving data is printed
        elasped_time = uptime()-current_time;
 1e4:	00000097          	auipc	ra,0x0
 1e8:	584080e7          	jalr	1412(ra) # 768 <uptime>
        printf("The total ticks are %d\n",elasped_time);
 1ec:	41b505bb          	subw	a1,a0,s11
 1f0:	00001517          	auipc	a0,0x1
 1f4:	b3050513          	addi	a0,a0,-1232 # d20 <malloc+0x212>
 1f8:	00001097          	auipc	ra,0x1
 1fc:	858080e7          	jalr	-1960(ra) # a50 <printf>
    else{ 
        printf("An error occurred while forking");
        exit(1);
    }

    exit(0); //Exiting with 0 error
 200:	4501                	li	a0,0
 202:	00000097          	auipc	ra,0x0
 206:	4ce080e7          	jalr	1230(ra) # 6d0 <exit>
            printf("A byte went missing as flag value is %d\n", check);
 20a:	85d6                	mv	a1,s5
 20c:	00001517          	auipc	a0,0x1
 210:	ae450513          	addi	a0,a0,-1308 # cf0 <malloc+0x1e2>
 214:	00001097          	auipc	ra,0x1
 218:	83c080e7          	jalr	-1988(ra) # a50 <printf>
 21c:	b7e1                	j	1e4 <main+0x1e4>
        printf("An error occurred while forking");
 21e:	00001517          	auipc	a0,0x1
 222:	b1a50513          	addi	a0,a0,-1254 # d38 <malloc+0x22a>
 226:	00001097          	auipc	ra,0x1
 22a:	82a080e7          	jalr	-2006(ra) # a50 <printf>
        exit(1);
 22e:	4505                	li	a0,1
 230:	00000097          	auipc	ra,0x0
 234:	4a0080e7          	jalr	1184(ra) # 6d0 <exit>

0000000000000238 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 238:	1141                	addi	sp,sp,-16
 23a:	e422                	sd	s0,8(sp)
 23c:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 23e:	0f50000f          	fence	iorw,ow
 242:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 246:	6422                	ld	s0,8(sp)
 248:	0141                	addi	sp,sp,16
 24a:	8082                	ret

000000000000024c <load>:

int load(uint64 *p) {
 24c:	1141                	addi	sp,sp,-16
 24e:	e422                	sd	s0,8(sp)
 250:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 252:	0ff0000f          	fence
 256:	6108                	ld	a0,0(a0)
 258:	0ff0000f          	fence
}
 25c:	2501                	sext.w	a0,a0
 25e:	6422                	ld	s0,8(sp)
 260:	0141                	addi	sp,sp,16
 262:	8082                	ret

0000000000000264 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 264:	7179                	addi	sp,sp,-48
 266:	f406                	sd	ra,40(sp)
 268:	f022                	sd	s0,32(sp)
 26a:	ec26                	sd	s1,24(sp)
 26c:	e84a                	sd	s2,16(sp)
 26e:	e44e                	sd	s3,8(sp)
 270:	e052                	sd	s4,0(sp)
 272:	1800                	addi	s0,sp,48
 274:	8a2a                	mv	s4,a0
 276:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 278:	4785                	li	a5,1
 27a:	00001497          	auipc	s1,0x1
 27e:	b1648493          	addi	s1,s1,-1258 # d90 <rings+0x10>
 282:	00001917          	auipc	s2,0x1
 286:	bfe90913          	addi	s2,s2,-1026 # e80 <__BSS_END__>
 28a:	04f59563          	bne	a1,a5,2d4 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 28e:	00001497          	auipc	s1,0x1
 292:	b024a483          	lw	s1,-1278(s1) # d90 <rings+0x10>
 296:	c099                	beqz	s1,29c <create_or_close_the_buffer_user+0x38>
 298:	4481                	li	s1,0
 29a:	a899                	j	2f0 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 29c:	00001917          	auipc	s2,0x1
 2a0:	ae490913          	addi	s2,s2,-1308 # d80 <rings>
 2a4:	00093603          	ld	a2,0(s2)
 2a8:	4585                	li	a1,1
 2aa:	00000097          	auipc	ra,0x0
 2ae:	4c6080e7          	jalr	1222(ra) # 770 <ringbuf>
        rings[i].book->write_done = 0;
 2b2:	00893783          	ld	a5,8(s2)
 2b6:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 2ba:	00893783          	ld	a5,8(s2)
 2be:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 2c2:	01092783          	lw	a5,16(s2)
 2c6:	2785                	addiw	a5,a5,1
 2c8:	00f92823          	sw	a5,16(s2)
        break;
 2cc:	a015                	j	2f0 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 2ce:	04e1                	addi	s1,s1,24
 2d0:	01248f63          	beq	s1,s2,2ee <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 2d4:	409c                	lw	a5,0(s1)
 2d6:	dfe5                	beqz	a5,2ce <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 2d8:	ff04b603          	ld	a2,-16(s1)
 2dc:	85ce                	mv	a1,s3
 2de:	8552                	mv	a0,s4
 2e0:	00000097          	auipc	ra,0x0
 2e4:	490080e7          	jalr	1168(ra) # 770 <ringbuf>
        rings[i].exists = 0;
 2e8:	0004a023          	sw	zero,0(s1)
 2ec:	b7cd                	j	2ce <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 2ee:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 2f0:	8526                	mv	a0,s1
 2f2:	70a2                	ld	ra,40(sp)
 2f4:	7402                	ld	s0,32(sp)
 2f6:	64e2                	ld	s1,24(sp)
 2f8:	6942                	ld	s2,16(sp)
 2fa:	69a2                	ld	s3,8(sp)
 2fc:	6a02                	ld	s4,0(sp)
 2fe:	6145                	addi	sp,sp,48
 300:	8082                	ret

0000000000000302 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 302:	1101                	addi	sp,sp,-32
 304:	ec06                	sd	ra,24(sp)
 306:	e822                	sd	s0,16(sp)
 308:	e426                	sd	s1,8(sp)
 30a:	1000                	addi	s0,sp,32
 30c:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 30e:	00151793          	slli	a5,a0,0x1
 312:	97aa                	add	a5,a5,a0
 314:	078e                	slli	a5,a5,0x3
 316:	00001717          	auipc	a4,0x1
 31a:	a6a70713          	addi	a4,a4,-1430 # d80 <rings>
 31e:	97ba                	add	a5,a5,a4
 320:	639c                	ld	a5,0(a5)
 322:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 324:	421c                	lw	a5,0(a2)
 326:	e785                	bnez	a5,34e <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 328:	86ba                	mv	a3,a4
 32a:	671c                	ld	a5,8(a4)
 32c:	6398                	ld	a4,0(a5)
 32e:	67c1                	lui	a5,0x10
 330:	9fb9                	addw	a5,a5,a4
 332:	00151713          	slli	a4,a0,0x1
 336:	953a                	add	a0,a0,a4
 338:	050e                	slli	a0,a0,0x3
 33a:	9536                	add	a0,a0,a3
 33c:	6518                	ld	a4,8(a0)
 33e:	6718                	ld	a4,8(a4)
 340:	9f99                	subw	a5,a5,a4
 342:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 344:	60e2                	ld	ra,24(sp)
 346:	6442                	ld	s0,16(sp)
 348:	64a2                	ld	s1,8(sp)
 34a:	6105                	addi	sp,sp,32
 34c:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 34e:	00151793          	slli	a5,a0,0x1
 352:	953e                	add	a0,a0,a5
 354:	050e                	slli	a0,a0,0x3
 356:	00001797          	auipc	a5,0x1
 35a:	a2a78793          	addi	a5,a5,-1494 # d80 <rings>
 35e:	953e                	add	a0,a0,a5
 360:	6508                	ld	a0,8(a0)
 362:	0521                	addi	a0,a0,8
 364:	00000097          	auipc	ra,0x0
 368:	ee8080e7          	jalr	-280(ra) # 24c <load>
 36c:	c088                	sw	a0,0(s1)
}
 36e:	bfd9                	j	344 <ringbuf_start_write+0x42>

0000000000000370 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 370:	1141                	addi	sp,sp,-16
 372:	e406                	sd	ra,8(sp)
 374:	e022                	sd	s0,0(sp)
 376:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 378:	00151793          	slli	a5,a0,0x1
 37c:	97aa                	add	a5,a5,a0
 37e:	078e                	slli	a5,a5,0x3
 380:	00001517          	auipc	a0,0x1
 384:	a0050513          	addi	a0,a0,-1536 # d80 <rings>
 388:	97aa                	add	a5,a5,a0
 38a:	6788                	ld	a0,8(a5)
 38c:	0035959b          	slliw	a1,a1,0x3
 390:	0521                	addi	a0,a0,8
 392:	00000097          	auipc	ra,0x0
 396:	ea6080e7          	jalr	-346(ra) # 238 <store>
}
 39a:	60a2                	ld	ra,8(sp)
 39c:	6402                	ld	s0,0(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret

00000000000003a2 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 3a2:	1101                	addi	sp,sp,-32
 3a4:	ec06                	sd	ra,24(sp)
 3a6:	e822                	sd	s0,16(sp)
 3a8:	e426                	sd	s1,8(sp)
 3aa:	1000                	addi	s0,sp,32
 3ac:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 3ae:	00151793          	slli	a5,a0,0x1
 3b2:	97aa                	add	a5,a5,a0
 3b4:	078e                	slli	a5,a5,0x3
 3b6:	00001517          	auipc	a0,0x1
 3ba:	9ca50513          	addi	a0,a0,-1590 # d80 <rings>
 3be:	97aa                	add	a5,a5,a0
 3c0:	6788                	ld	a0,8(a5)
 3c2:	0521                	addi	a0,a0,8
 3c4:	00000097          	auipc	ra,0x0
 3c8:	e88080e7          	jalr	-376(ra) # 24c <load>
 3cc:	c088                	sw	a0,0(s1)
}
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	64a2                	ld	s1,8(sp)
 3d4:	6105                	addi	sp,sp,32
 3d6:	8082                	ret

00000000000003d8 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 3d8:	1101                	addi	sp,sp,-32
 3da:	ec06                	sd	ra,24(sp)
 3dc:	e822                	sd	s0,16(sp)
 3de:	e426                	sd	s1,8(sp)
 3e0:	1000                	addi	s0,sp,32
 3e2:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 3e4:	00151793          	slli	a5,a0,0x1
 3e8:	97aa                	add	a5,a5,a0
 3ea:	078e                	slli	a5,a5,0x3
 3ec:	00001517          	auipc	a0,0x1
 3f0:	99450513          	addi	a0,a0,-1644 # d80 <rings>
 3f4:	97aa                	add	a5,a5,a0
 3f6:	6788                	ld	a0,8(a5)
 3f8:	611c                	ld	a5,0(a0)
 3fa:	ef99                	bnez	a5,418 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 3fc:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 3fe:	41f7579b          	sraiw	a5,a4,0x1f
 402:	01d7d79b          	srliw	a5,a5,0x1d
 406:	9fb9                	addw	a5,a5,a4
 408:	4037d79b          	sraiw	a5,a5,0x3
 40c:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 40e:	60e2                	ld	ra,24(sp)
 410:	6442                	ld	s0,16(sp)
 412:	64a2                	ld	s1,8(sp)
 414:	6105                	addi	sp,sp,32
 416:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 418:	00000097          	auipc	ra,0x0
 41c:	e34080e7          	jalr	-460(ra) # 24c <load>
    *bytes /= 8;
 420:	41f5579b          	sraiw	a5,a0,0x1f
 424:	01d7d79b          	srliw	a5,a5,0x1d
 428:	9d3d                	addw	a0,a0,a5
 42a:	4035551b          	sraiw	a0,a0,0x3
 42e:	c088                	sw	a0,0(s1)
}
 430:	bff9                	j	40e <ringbuf_start_read+0x36>

0000000000000432 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 432:	1141                	addi	sp,sp,-16
 434:	e406                	sd	ra,8(sp)
 436:	e022                	sd	s0,0(sp)
 438:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 43a:	00151793          	slli	a5,a0,0x1
 43e:	97aa                	add	a5,a5,a0
 440:	078e                	slli	a5,a5,0x3
 442:	00001517          	auipc	a0,0x1
 446:	93e50513          	addi	a0,a0,-1730 # d80 <rings>
 44a:	97aa                	add	a5,a5,a0
 44c:	0035959b          	slliw	a1,a1,0x3
 450:	6788                	ld	a0,8(a5)
 452:	00000097          	auipc	ra,0x0
 456:	de6080e7          	jalr	-538(ra) # 238 <store>
}
 45a:	60a2                	ld	ra,8(sp)
 45c:	6402                	ld	s0,0(sp)
 45e:	0141                	addi	sp,sp,16
 460:	8082                	ret

0000000000000462 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 462:	1141                	addi	sp,sp,-16
 464:	e422                	sd	s0,8(sp)
 466:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 468:	87aa                	mv	a5,a0
 46a:	0585                	addi	a1,a1,1
 46c:	0785                	addi	a5,a5,1
 46e:	fff5c703          	lbu	a4,-1(a1)
 472:	fee78fa3          	sb	a4,-1(a5)
 476:	fb75                	bnez	a4,46a <strcpy+0x8>
    ;
  return os;
}
 478:	6422                	ld	s0,8(sp)
 47a:	0141                	addi	sp,sp,16
 47c:	8082                	ret

000000000000047e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 47e:	1141                	addi	sp,sp,-16
 480:	e422                	sd	s0,8(sp)
 482:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 484:	00054783          	lbu	a5,0(a0)
 488:	cb91                	beqz	a5,49c <strcmp+0x1e>
 48a:	0005c703          	lbu	a4,0(a1)
 48e:	00f71763          	bne	a4,a5,49c <strcmp+0x1e>
    p++, q++;
 492:	0505                	addi	a0,a0,1
 494:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 496:	00054783          	lbu	a5,0(a0)
 49a:	fbe5                	bnez	a5,48a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 49c:	0005c503          	lbu	a0,0(a1)
}
 4a0:	40a7853b          	subw	a0,a5,a0
 4a4:	6422                	ld	s0,8(sp)
 4a6:	0141                	addi	sp,sp,16
 4a8:	8082                	ret

00000000000004aa <strlen>:

uint
strlen(const char *s)
{
 4aa:	1141                	addi	sp,sp,-16
 4ac:	e422                	sd	s0,8(sp)
 4ae:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4b0:	00054783          	lbu	a5,0(a0)
 4b4:	cf91                	beqz	a5,4d0 <strlen+0x26>
 4b6:	0505                	addi	a0,a0,1
 4b8:	87aa                	mv	a5,a0
 4ba:	4685                	li	a3,1
 4bc:	9e89                	subw	a3,a3,a0
 4be:	00f6853b          	addw	a0,a3,a5
 4c2:	0785                	addi	a5,a5,1
 4c4:	fff7c703          	lbu	a4,-1(a5)
 4c8:	fb7d                	bnez	a4,4be <strlen+0x14>
    ;
  return n;
}
 4ca:	6422                	ld	s0,8(sp)
 4cc:	0141                	addi	sp,sp,16
 4ce:	8082                	ret
  for(n = 0; s[n]; n++)
 4d0:	4501                	li	a0,0
 4d2:	bfe5                	j	4ca <strlen+0x20>

00000000000004d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4d4:	1141                	addi	sp,sp,-16
 4d6:	e422                	sd	s0,8(sp)
 4d8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4da:	ca19                	beqz	a2,4f0 <memset+0x1c>
 4dc:	87aa                	mv	a5,a0
 4de:	1602                	slli	a2,a2,0x20
 4e0:	9201                	srli	a2,a2,0x20
 4e2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4e6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4ea:	0785                	addi	a5,a5,1
 4ec:	fee79de3          	bne	a5,a4,4e6 <memset+0x12>
  }
  return dst;
}
 4f0:	6422                	ld	s0,8(sp)
 4f2:	0141                	addi	sp,sp,16
 4f4:	8082                	ret

00000000000004f6 <strchr>:

char*
strchr(const char *s, char c)
{
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e422                	sd	s0,8(sp)
 4fa:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4fc:	00054783          	lbu	a5,0(a0)
 500:	cb99                	beqz	a5,516 <strchr+0x20>
    if(*s == c)
 502:	00f58763          	beq	a1,a5,510 <strchr+0x1a>
  for(; *s; s++)
 506:	0505                	addi	a0,a0,1
 508:	00054783          	lbu	a5,0(a0)
 50c:	fbfd                	bnez	a5,502 <strchr+0xc>
      return (char*)s;
  return 0;
 50e:	4501                	li	a0,0
}
 510:	6422                	ld	s0,8(sp)
 512:	0141                	addi	sp,sp,16
 514:	8082                	ret
  return 0;
 516:	4501                	li	a0,0
 518:	bfe5                	j	510 <strchr+0x1a>

000000000000051a <gets>:

char*
gets(char *buf, int max)
{
 51a:	711d                	addi	sp,sp,-96
 51c:	ec86                	sd	ra,88(sp)
 51e:	e8a2                	sd	s0,80(sp)
 520:	e4a6                	sd	s1,72(sp)
 522:	e0ca                	sd	s2,64(sp)
 524:	fc4e                	sd	s3,56(sp)
 526:	f852                	sd	s4,48(sp)
 528:	f456                	sd	s5,40(sp)
 52a:	f05a                	sd	s6,32(sp)
 52c:	ec5e                	sd	s7,24(sp)
 52e:	1080                	addi	s0,sp,96
 530:	8baa                	mv	s7,a0
 532:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 534:	892a                	mv	s2,a0
 536:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 538:	4aa9                	li	s5,10
 53a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 53c:	89a6                	mv	s3,s1
 53e:	2485                	addiw	s1,s1,1
 540:	0344d863          	bge	s1,s4,570 <gets+0x56>
    cc = read(0, &c, 1);
 544:	4605                	li	a2,1
 546:	faf40593          	addi	a1,s0,-81
 54a:	4501                	li	a0,0
 54c:	00000097          	auipc	ra,0x0
 550:	19c080e7          	jalr	412(ra) # 6e8 <read>
    if(cc < 1)
 554:	00a05e63          	blez	a0,570 <gets+0x56>
    buf[i++] = c;
 558:	faf44783          	lbu	a5,-81(s0)
 55c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 560:	01578763          	beq	a5,s5,56e <gets+0x54>
 564:	0905                	addi	s2,s2,1
 566:	fd679be3          	bne	a5,s6,53c <gets+0x22>
  for(i=0; i+1 < max; ){
 56a:	89a6                	mv	s3,s1
 56c:	a011                	j	570 <gets+0x56>
 56e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 570:	99de                	add	s3,s3,s7
 572:	00098023          	sb	zero,0(s3)
  return buf;
}
 576:	855e                	mv	a0,s7
 578:	60e6                	ld	ra,88(sp)
 57a:	6446                	ld	s0,80(sp)
 57c:	64a6                	ld	s1,72(sp)
 57e:	6906                	ld	s2,64(sp)
 580:	79e2                	ld	s3,56(sp)
 582:	7a42                	ld	s4,48(sp)
 584:	7aa2                	ld	s5,40(sp)
 586:	7b02                	ld	s6,32(sp)
 588:	6be2                	ld	s7,24(sp)
 58a:	6125                	addi	sp,sp,96
 58c:	8082                	ret

000000000000058e <stat>:

int
stat(const char *n, struct stat *st)
{
 58e:	1101                	addi	sp,sp,-32
 590:	ec06                	sd	ra,24(sp)
 592:	e822                	sd	s0,16(sp)
 594:	e426                	sd	s1,8(sp)
 596:	e04a                	sd	s2,0(sp)
 598:	1000                	addi	s0,sp,32
 59a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 59c:	4581                	li	a1,0
 59e:	00000097          	auipc	ra,0x0
 5a2:	172080e7          	jalr	370(ra) # 710 <open>
  if(fd < 0)
 5a6:	02054563          	bltz	a0,5d0 <stat+0x42>
 5aa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 5ac:	85ca                	mv	a1,s2
 5ae:	00000097          	auipc	ra,0x0
 5b2:	17a080e7          	jalr	378(ra) # 728 <fstat>
 5b6:	892a                	mv	s2,a0
  close(fd);
 5b8:	8526                	mv	a0,s1
 5ba:	00000097          	auipc	ra,0x0
 5be:	13e080e7          	jalr	318(ra) # 6f8 <close>
  return r;
}
 5c2:	854a                	mv	a0,s2
 5c4:	60e2                	ld	ra,24(sp)
 5c6:	6442                	ld	s0,16(sp)
 5c8:	64a2                	ld	s1,8(sp)
 5ca:	6902                	ld	s2,0(sp)
 5cc:	6105                	addi	sp,sp,32
 5ce:	8082                	ret
    return -1;
 5d0:	597d                	li	s2,-1
 5d2:	bfc5                	j	5c2 <stat+0x34>

00000000000005d4 <atoi>:

int
atoi(const char *s)
{
 5d4:	1141                	addi	sp,sp,-16
 5d6:	e422                	sd	s0,8(sp)
 5d8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5da:	00054603          	lbu	a2,0(a0)
 5de:	fd06079b          	addiw	a5,a2,-48
 5e2:	0ff7f793          	zext.b	a5,a5
 5e6:	4725                	li	a4,9
 5e8:	02f76963          	bltu	a4,a5,61a <atoi+0x46>
 5ec:	86aa                	mv	a3,a0
  n = 0;
 5ee:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 5f0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 5f2:	0685                	addi	a3,a3,1
 5f4:	0025179b          	slliw	a5,a0,0x2
 5f8:	9fa9                	addw	a5,a5,a0
 5fa:	0017979b          	slliw	a5,a5,0x1
 5fe:	9fb1                	addw	a5,a5,a2
 600:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 604:	0006c603          	lbu	a2,0(a3)
 608:	fd06071b          	addiw	a4,a2,-48
 60c:	0ff77713          	zext.b	a4,a4
 610:	fee5f1e3          	bgeu	a1,a4,5f2 <atoi+0x1e>
  return n;
}
 614:	6422                	ld	s0,8(sp)
 616:	0141                	addi	sp,sp,16
 618:	8082                	ret
  n = 0;
 61a:	4501                	li	a0,0
 61c:	bfe5                	j	614 <atoi+0x40>

000000000000061e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 61e:	1141                	addi	sp,sp,-16
 620:	e422                	sd	s0,8(sp)
 622:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 624:	02b57463          	bgeu	a0,a1,64c <memmove+0x2e>
    while(n-- > 0)
 628:	00c05f63          	blez	a2,646 <memmove+0x28>
 62c:	1602                	slli	a2,a2,0x20
 62e:	9201                	srli	a2,a2,0x20
 630:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 634:	872a                	mv	a4,a0
      *dst++ = *src++;
 636:	0585                	addi	a1,a1,1
 638:	0705                	addi	a4,a4,1
 63a:	fff5c683          	lbu	a3,-1(a1)
 63e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 642:	fee79ae3          	bne	a5,a4,636 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 646:	6422                	ld	s0,8(sp)
 648:	0141                	addi	sp,sp,16
 64a:	8082                	ret
    dst += n;
 64c:	00c50733          	add	a4,a0,a2
    src += n;
 650:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 652:	fec05ae3          	blez	a2,646 <memmove+0x28>
 656:	fff6079b          	addiw	a5,a2,-1
 65a:	1782                	slli	a5,a5,0x20
 65c:	9381                	srli	a5,a5,0x20
 65e:	fff7c793          	not	a5,a5
 662:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 664:	15fd                	addi	a1,a1,-1
 666:	177d                	addi	a4,a4,-1
 668:	0005c683          	lbu	a3,0(a1)
 66c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 670:	fee79ae3          	bne	a5,a4,664 <memmove+0x46>
 674:	bfc9                	j	646 <memmove+0x28>

0000000000000676 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 676:	1141                	addi	sp,sp,-16
 678:	e422                	sd	s0,8(sp)
 67a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 67c:	ca05                	beqz	a2,6ac <memcmp+0x36>
 67e:	fff6069b          	addiw	a3,a2,-1
 682:	1682                	slli	a3,a3,0x20
 684:	9281                	srli	a3,a3,0x20
 686:	0685                	addi	a3,a3,1
 688:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 68a:	00054783          	lbu	a5,0(a0)
 68e:	0005c703          	lbu	a4,0(a1)
 692:	00e79863          	bne	a5,a4,6a2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 696:	0505                	addi	a0,a0,1
    p2++;
 698:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 69a:	fed518e3          	bne	a0,a3,68a <memcmp+0x14>
  }
  return 0;
 69e:	4501                	li	a0,0
 6a0:	a019                	j	6a6 <memcmp+0x30>
      return *p1 - *p2;
 6a2:	40e7853b          	subw	a0,a5,a4
}
 6a6:	6422                	ld	s0,8(sp)
 6a8:	0141                	addi	sp,sp,16
 6aa:	8082                	ret
  return 0;
 6ac:	4501                	li	a0,0
 6ae:	bfe5                	j	6a6 <memcmp+0x30>

00000000000006b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6b0:	1141                	addi	sp,sp,-16
 6b2:	e406                	sd	ra,8(sp)
 6b4:	e022                	sd	s0,0(sp)
 6b6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 6b8:	00000097          	auipc	ra,0x0
 6bc:	f66080e7          	jalr	-154(ra) # 61e <memmove>
}
 6c0:	60a2                	ld	ra,8(sp)
 6c2:	6402                	ld	s0,0(sp)
 6c4:	0141                	addi	sp,sp,16
 6c6:	8082                	ret

00000000000006c8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6c8:	4885                	li	a7,1
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6d0:	4889                	li	a7,2
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6d8:	488d                	li	a7,3
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6e0:	4891                	li	a7,4
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <read>:
.global read
read:
 li a7, SYS_read
 6e8:	4895                	li	a7,5
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <write>:
.global write
write:
 li a7, SYS_write
 6f0:	48c1                	li	a7,16
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <close>:
.global close
close:
 li a7, SYS_close
 6f8:	48d5                	li	a7,21
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <kill>:
.global kill
kill:
 li a7, SYS_kill
 700:	4899                	li	a7,6
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <exec>:
.global exec
exec:
 li a7, SYS_exec
 708:	489d                	li	a7,7
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <open>:
.global open
open:
 li a7, SYS_open
 710:	48bd                	li	a7,15
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 718:	48c5                	li	a7,17
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 720:	48c9                	li	a7,18
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 728:	48a1                	li	a7,8
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <link>:
.global link
link:
 li a7, SYS_link
 730:	48cd                	li	a7,19
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 738:	48d1                	li	a7,20
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 740:	48a5                	li	a7,9
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <dup>:
.global dup
dup:
 li a7, SYS_dup
 748:	48a9                	li	a7,10
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 750:	48ad                	li	a7,11
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 758:	48b1                	li	a7,12
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 760:	48b5                	li	a7,13
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 768:	48b9                	li	a7,14
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 770:	48d9                	li	a7,22
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 778:	1101                	addi	sp,sp,-32
 77a:	ec06                	sd	ra,24(sp)
 77c:	e822                	sd	s0,16(sp)
 77e:	1000                	addi	s0,sp,32
 780:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 784:	4605                	li	a2,1
 786:	fef40593          	addi	a1,s0,-17
 78a:	00000097          	auipc	ra,0x0
 78e:	f66080e7          	jalr	-154(ra) # 6f0 <write>
}
 792:	60e2                	ld	ra,24(sp)
 794:	6442                	ld	s0,16(sp)
 796:	6105                	addi	sp,sp,32
 798:	8082                	ret

000000000000079a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 79a:	7139                	addi	sp,sp,-64
 79c:	fc06                	sd	ra,56(sp)
 79e:	f822                	sd	s0,48(sp)
 7a0:	f426                	sd	s1,40(sp)
 7a2:	f04a                	sd	s2,32(sp)
 7a4:	ec4e                	sd	s3,24(sp)
 7a6:	0080                	addi	s0,sp,64
 7a8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7aa:	c299                	beqz	a3,7b0 <printint+0x16>
 7ac:	0805c863          	bltz	a1,83c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7b0:	2581                	sext.w	a1,a1
  neg = 0;
 7b2:	4881                	li	a7,0
 7b4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7b8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7ba:	2601                	sext.w	a2,a2
 7bc:	00000517          	auipc	a0,0x0
 7c0:	5a450513          	addi	a0,a0,1444 # d60 <digits>
 7c4:	883a                	mv	a6,a4
 7c6:	2705                	addiw	a4,a4,1
 7c8:	02c5f7bb          	remuw	a5,a1,a2
 7cc:	1782                	slli	a5,a5,0x20
 7ce:	9381                	srli	a5,a5,0x20
 7d0:	97aa                	add	a5,a5,a0
 7d2:	0007c783          	lbu	a5,0(a5)
 7d6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7da:	0005879b          	sext.w	a5,a1
 7de:	02c5d5bb          	divuw	a1,a1,a2
 7e2:	0685                	addi	a3,a3,1
 7e4:	fec7f0e3          	bgeu	a5,a2,7c4 <printint+0x2a>
  if(neg)
 7e8:	00088b63          	beqz	a7,7fe <printint+0x64>
    buf[i++] = '-';
 7ec:	fd040793          	addi	a5,s0,-48
 7f0:	973e                	add	a4,a4,a5
 7f2:	02d00793          	li	a5,45
 7f6:	fef70823          	sb	a5,-16(a4)
 7fa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7fe:	02e05863          	blez	a4,82e <printint+0x94>
 802:	fc040793          	addi	a5,s0,-64
 806:	00e78933          	add	s2,a5,a4
 80a:	fff78993          	addi	s3,a5,-1
 80e:	99ba                	add	s3,s3,a4
 810:	377d                	addiw	a4,a4,-1
 812:	1702                	slli	a4,a4,0x20
 814:	9301                	srli	a4,a4,0x20
 816:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 81a:	fff94583          	lbu	a1,-1(s2)
 81e:	8526                	mv	a0,s1
 820:	00000097          	auipc	ra,0x0
 824:	f58080e7          	jalr	-168(ra) # 778 <putc>
  while(--i >= 0)
 828:	197d                	addi	s2,s2,-1
 82a:	ff3918e3          	bne	s2,s3,81a <printint+0x80>
}
 82e:	70e2                	ld	ra,56(sp)
 830:	7442                	ld	s0,48(sp)
 832:	74a2                	ld	s1,40(sp)
 834:	7902                	ld	s2,32(sp)
 836:	69e2                	ld	s3,24(sp)
 838:	6121                	addi	sp,sp,64
 83a:	8082                	ret
    x = -xx;
 83c:	40b005bb          	negw	a1,a1
    neg = 1;
 840:	4885                	li	a7,1
    x = -xx;
 842:	bf8d                	j	7b4 <printint+0x1a>

0000000000000844 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 844:	7119                	addi	sp,sp,-128
 846:	fc86                	sd	ra,120(sp)
 848:	f8a2                	sd	s0,112(sp)
 84a:	f4a6                	sd	s1,104(sp)
 84c:	f0ca                	sd	s2,96(sp)
 84e:	ecce                	sd	s3,88(sp)
 850:	e8d2                	sd	s4,80(sp)
 852:	e4d6                	sd	s5,72(sp)
 854:	e0da                	sd	s6,64(sp)
 856:	fc5e                	sd	s7,56(sp)
 858:	f862                	sd	s8,48(sp)
 85a:	f466                	sd	s9,40(sp)
 85c:	f06a                	sd	s10,32(sp)
 85e:	ec6e                	sd	s11,24(sp)
 860:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 862:	0005c903          	lbu	s2,0(a1)
 866:	18090f63          	beqz	s2,a04 <vprintf+0x1c0>
 86a:	8aaa                	mv	s5,a0
 86c:	8b32                	mv	s6,a2
 86e:	00158493          	addi	s1,a1,1
  state = 0;
 872:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 874:	02500a13          	li	s4,37
      if(c == 'd'){
 878:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 87c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 880:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 884:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 888:	00000b97          	auipc	s7,0x0
 88c:	4d8b8b93          	addi	s7,s7,1240 # d60 <digits>
 890:	a839                	j	8ae <vprintf+0x6a>
        putc(fd, c);
 892:	85ca                	mv	a1,s2
 894:	8556                	mv	a0,s5
 896:	00000097          	auipc	ra,0x0
 89a:	ee2080e7          	jalr	-286(ra) # 778 <putc>
 89e:	a019                	j	8a4 <vprintf+0x60>
    } else if(state == '%'){
 8a0:	01498f63          	beq	s3,s4,8be <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 8a4:	0485                	addi	s1,s1,1
 8a6:	fff4c903          	lbu	s2,-1(s1)
 8aa:	14090d63          	beqz	s2,a04 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 8ae:	0009079b          	sext.w	a5,s2
    if(state == 0){
 8b2:	fe0997e3          	bnez	s3,8a0 <vprintf+0x5c>
      if(c == '%'){
 8b6:	fd479ee3          	bne	a5,s4,892 <vprintf+0x4e>
        state = '%';
 8ba:	89be                	mv	s3,a5
 8bc:	b7e5                	j	8a4 <vprintf+0x60>
      if(c == 'd'){
 8be:	05878063          	beq	a5,s8,8fe <vprintf+0xba>
      } else if(c == 'l') {
 8c2:	05978c63          	beq	a5,s9,91a <vprintf+0xd6>
      } else if(c == 'x') {
 8c6:	07a78863          	beq	a5,s10,936 <vprintf+0xf2>
      } else if(c == 'p') {
 8ca:	09b78463          	beq	a5,s11,952 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8ce:	07300713          	li	a4,115
 8d2:	0ce78663          	beq	a5,a4,99e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8d6:	06300713          	li	a4,99
 8da:	0ee78e63          	beq	a5,a4,9d6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8de:	11478863          	beq	a5,s4,9ee <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8e2:	85d2                	mv	a1,s4
 8e4:	8556                	mv	a0,s5
 8e6:	00000097          	auipc	ra,0x0
 8ea:	e92080e7          	jalr	-366(ra) # 778 <putc>
        putc(fd, c);
 8ee:	85ca                	mv	a1,s2
 8f0:	8556                	mv	a0,s5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	e86080e7          	jalr	-378(ra) # 778 <putc>
      }
      state = 0;
 8fa:	4981                	li	s3,0
 8fc:	b765                	j	8a4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8fe:	008b0913          	addi	s2,s6,8
 902:	4685                	li	a3,1
 904:	4629                	li	a2,10
 906:	000b2583          	lw	a1,0(s6)
 90a:	8556                	mv	a0,s5
 90c:	00000097          	auipc	ra,0x0
 910:	e8e080e7          	jalr	-370(ra) # 79a <printint>
 914:	8b4a                	mv	s6,s2
      state = 0;
 916:	4981                	li	s3,0
 918:	b771                	j	8a4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 91a:	008b0913          	addi	s2,s6,8
 91e:	4681                	li	a3,0
 920:	4629                	li	a2,10
 922:	000b2583          	lw	a1,0(s6)
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	e72080e7          	jalr	-398(ra) # 79a <printint>
 930:	8b4a                	mv	s6,s2
      state = 0;
 932:	4981                	li	s3,0
 934:	bf85                	j	8a4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 936:	008b0913          	addi	s2,s6,8
 93a:	4681                	li	a3,0
 93c:	4641                	li	a2,16
 93e:	000b2583          	lw	a1,0(s6)
 942:	8556                	mv	a0,s5
 944:	00000097          	auipc	ra,0x0
 948:	e56080e7          	jalr	-426(ra) # 79a <printint>
 94c:	8b4a                	mv	s6,s2
      state = 0;
 94e:	4981                	li	s3,0
 950:	bf91                	j	8a4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 952:	008b0793          	addi	a5,s6,8
 956:	f8f43423          	sd	a5,-120(s0)
 95a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 95e:	03000593          	li	a1,48
 962:	8556                	mv	a0,s5
 964:	00000097          	auipc	ra,0x0
 968:	e14080e7          	jalr	-492(ra) # 778 <putc>
  putc(fd, 'x');
 96c:	85ea                	mv	a1,s10
 96e:	8556                	mv	a0,s5
 970:	00000097          	auipc	ra,0x0
 974:	e08080e7          	jalr	-504(ra) # 778 <putc>
 978:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 97a:	03c9d793          	srli	a5,s3,0x3c
 97e:	97de                	add	a5,a5,s7
 980:	0007c583          	lbu	a1,0(a5)
 984:	8556                	mv	a0,s5
 986:	00000097          	auipc	ra,0x0
 98a:	df2080e7          	jalr	-526(ra) # 778 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 98e:	0992                	slli	s3,s3,0x4
 990:	397d                	addiw	s2,s2,-1
 992:	fe0914e3          	bnez	s2,97a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 996:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 99a:	4981                	li	s3,0
 99c:	b721                	j	8a4 <vprintf+0x60>
        s = va_arg(ap, char*);
 99e:	008b0993          	addi	s3,s6,8
 9a2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 9a6:	02090163          	beqz	s2,9c8 <vprintf+0x184>
        while(*s != 0){
 9aa:	00094583          	lbu	a1,0(s2)
 9ae:	c9a1                	beqz	a1,9fe <vprintf+0x1ba>
          putc(fd, *s);
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	dc6080e7          	jalr	-570(ra) # 778 <putc>
          s++;
 9ba:	0905                	addi	s2,s2,1
        while(*s != 0){
 9bc:	00094583          	lbu	a1,0(s2)
 9c0:	f9e5                	bnez	a1,9b0 <vprintf+0x16c>
        s = va_arg(ap, char*);
 9c2:	8b4e                	mv	s6,s3
      state = 0;
 9c4:	4981                	li	s3,0
 9c6:	bdf9                	j	8a4 <vprintf+0x60>
          s = "(null)";
 9c8:	00000917          	auipc	s2,0x0
 9cc:	39090913          	addi	s2,s2,912 # d58 <malloc+0x24a>
        while(*s != 0){
 9d0:	02800593          	li	a1,40
 9d4:	bff1                	j	9b0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 9d6:	008b0913          	addi	s2,s6,8
 9da:	000b4583          	lbu	a1,0(s6)
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	d98080e7          	jalr	-616(ra) # 778 <putc>
 9e8:	8b4a                	mv	s6,s2
      state = 0;
 9ea:	4981                	li	s3,0
 9ec:	bd65                	j	8a4 <vprintf+0x60>
        putc(fd, c);
 9ee:	85d2                	mv	a1,s4
 9f0:	8556                	mv	a0,s5
 9f2:	00000097          	auipc	ra,0x0
 9f6:	d86080e7          	jalr	-634(ra) # 778 <putc>
      state = 0;
 9fa:	4981                	li	s3,0
 9fc:	b565                	j	8a4 <vprintf+0x60>
        s = va_arg(ap, char*);
 9fe:	8b4e                	mv	s6,s3
      state = 0;
 a00:	4981                	li	s3,0
 a02:	b54d                	j	8a4 <vprintf+0x60>
    }
  }
}
 a04:	70e6                	ld	ra,120(sp)
 a06:	7446                	ld	s0,112(sp)
 a08:	74a6                	ld	s1,104(sp)
 a0a:	7906                	ld	s2,96(sp)
 a0c:	69e6                	ld	s3,88(sp)
 a0e:	6a46                	ld	s4,80(sp)
 a10:	6aa6                	ld	s5,72(sp)
 a12:	6b06                	ld	s6,64(sp)
 a14:	7be2                	ld	s7,56(sp)
 a16:	7c42                	ld	s8,48(sp)
 a18:	7ca2                	ld	s9,40(sp)
 a1a:	7d02                	ld	s10,32(sp)
 a1c:	6de2                	ld	s11,24(sp)
 a1e:	6109                	addi	sp,sp,128
 a20:	8082                	ret

0000000000000a22 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a22:	715d                	addi	sp,sp,-80
 a24:	ec06                	sd	ra,24(sp)
 a26:	e822                	sd	s0,16(sp)
 a28:	1000                	addi	s0,sp,32
 a2a:	e010                	sd	a2,0(s0)
 a2c:	e414                	sd	a3,8(s0)
 a2e:	e818                	sd	a4,16(s0)
 a30:	ec1c                	sd	a5,24(s0)
 a32:	03043023          	sd	a6,32(s0)
 a36:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a3a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a3e:	8622                	mv	a2,s0
 a40:	00000097          	auipc	ra,0x0
 a44:	e04080e7          	jalr	-508(ra) # 844 <vprintf>
}
 a48:	60e2                	ld	ra,24(sp)
 a4a:	6442                	ld	s0,16(sp)
 a4c:	6161                	addi	sp,sp,80
 a4e:	8082                	ret

0000000000000a50 <printf>:

void
printf(const char *fmt, ...)
{
 a50:	711d                	addi	sp,sp,-96
 a52:	ec06                	sd	ra,24(sp)
 a54:	e822                	sd	s0,16(sp)
 a56:	1000                	addi	s0,sp,32
 a58:	e40c                	sd	a1,8(s0)
 a5a:	e810                	sd	a2,16(s0)
 a5c:	ec14                	sd	a3,24(s0)
 a5e:	f018                	sd	a4,32(s0)
 a60:	f41c                	sd	a5,40(s0)
 a62:	03043823          	sd	a6,48(s0)
 a66:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a6a:	00840613          	addi	a2,s0,8
 a6e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a72:	85aa                	mv	a1,a0
 a74:	4505                	li	a0,1
 a76:	00000097          	auipc	ra,0x0
 a7a:	dce080e7          	jalr	-562(ra) # 844 <vprintf>
}
 a7e:	60e2                	ld	ra,24(sp)
 a80:	6442                	ld	s0,16(sp)
 a82:	6125                	addi	sp,sp,96
 a84:	8082                	ret

0000000000000a86 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a86:	1141                	addi	sp,sp,-16
 a88:	e422                	sd	s0,8(sp)
 a8a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a8c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a90:	00000797          	auipc	a5,0x0
 a94:	2e87b783          	ld	a5,744(a5) # d78 <freep>
 a98:	a805                	j	ac8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a9a:	4618                	lw	a4,8(a2)
 a9c:	9db9                	addw	a1,a1,a4
 a9e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 aa2:	6398                	ld	a4,0(a5)
 aa4:	6318                	ld	a4,0(a4)
 aa6:	fee53823          	sd	a4,-16(a0)
 aaa:	a091                	j	aee <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 aac:	ff852703          	lw	a4,-8(a0)
 ab0:	9e39                	addw	a2,a2,a4
 ab2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 ab4:	ff053703          	ld	a4,-16(a0)
 ab8:	e398                	sd	a4,0(a5)
 aba:	a099                	j	b00 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 abc:	6398                	ld	a4,0(a5)
 abe:	00e7e463          	bltu	a5,a4,ac6 <free+0x40>
 ac2:	00e6ea63          	bltu	a3,a4,ad6 <free+0x50>
{
 ac6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac8:	fed7fae3          	bgeu	a5,a3,abc <free+0x36>
 acc:	6398                	ld	a4,0(a5)
 ace:	00e6e463          	bltu	a3,a4,ad6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad2:	fee7eae3          	bltu	a5,a4,ac6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 ad6:	ff852583          	lw	a1,-8(a0)
 ada:	6390                	ld	a2,0(a5)
 adc:	02059813          	slli	a6,a1,0x20
 ae0:	01c85713          	srli	a4,a6,0x1c
 ae4:	9736                	add	a4,a4,a3
 ae6:	fae60ae3          	beq	a2,a4,a9a <free+0x14>
    bp->s.ptr = p->s.ptr;
 aea:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 aee:	4790                	lw	a2,8(a5)
 af0:	02061593          	slli	a1,a2,0x20
 af4:	01c5d713          	srli	a4,a1,0x1c
 af8:	973e                	add	a4,a4,a5
 afa:	fae689e3          	beq	a3,a4,aac <free+0x26>
  } else
    p->s.ptr = bp;
 afe:	e394                	sd	a3,0(a5)
  freep = p;
 b00:	00000717          	auipc	a4,0x0
 b04:	26f73c23          	sd	a5,632(a4) # d78 <freep>
}
 b08:	6422                	ld	s0,8(sp)
 b0a:	0141                	addi	sp,sp,16
 b0c:	8082                	ret

0000000000000b0e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b0e:	7139                	addi	sp,sp,-64
 b10:	fc06                	sd	ra,56(sp)
 b12:	f822                	sd	s0,48(sp)
 b14:	f426                	sd	s1,40(sp)
 b16:	f04a                	sd	s2,32(sp)
 b18:	ec4e                	sd	s3,24(sp)
 b1a:	e852                	sd	s4,16(sp)
 b1c:	e456                	sd	s5,8(sp)
 b1e:	e05a                	sd	s6,0(sp)
 b20:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b22:	02051493          	slli	s1,a0,0x20
 b26:	9081                	srli	s1,s1,0x20
 b28:	04bd                	addi	s1,s1,15
 b2a:	8091                	srli	s1,s1,0x4
 b2c:	0014899b          	addiw	s3,s1,1
 b30:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b32:	00000517          	auipc	a0,0x0
 b36:	24653503          	ld	a0,582(a0) # d78 <freep>
 b3a:	c515                	beqz	a0,b66 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b3c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b3e:	4798                	lw	a4,8(a5)
 b40:	02977f63          	bgeu	a4,s1,b7e <malloc+0x70>
 b44:	8a4e                	mv	s4,s3
 b46:	0009871b          	sext.w	a4,s3
 b4a:	6685                	lui	a3,0x1
 b4c:	00d77363          	bgeu	a4,a3,b52 <malloc+0x44>
 b50:	6a05                	lui	s4,0x1
 b52:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b56:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b5a:	00000917          	auipc	s2,0x0
 b5e:	21e90913          	addi	s2,s2,542 # d78 <freep>
  if(p == (char*)-1)
 b62:	5afd                	li	s5,-1
 b64:	a895                	j	bd8 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b66:	00000797          	auipc	a5,0x0
 b6a:	30a78793          	addi	a5,a5,778 # e70 <base>
 b6e:	00000717          	auipc	a4,0x0
 b72:	20f73523          	sd	a5,522(a4) # d78 <freep>
 b76:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b78:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b7c:	b7e1                	j	b44 <malloc+0x36>
      if(p->s.size == nunits)
 b7e:	02e48c63          	beq	s1,a4,bb6 <malloc+0xa8>
        p->s.size -= nunits;
 b82:	4137073b          	subw	a4,a4,s3
 b86:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b88:	02071693          	slli	a3,a4,0x20
 b8c:	01c6d713          	srli	a4,a3,0x1c
 b90:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b92:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b96:	00000717          	auipc	a4,0x0
 b9a:	1ea73123          	sd	a0,482(a4) # d78 <freep>
      return (void*)(p + 1);
 b9e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ba2:	70e2                	ld	ra,56(sp)
 ba4:	7442                	ld	s0,48(sp)
 ba6:	74a2                	ld	s1,40(sp)
 ba8:	7902                	ld	s2,32(sp)
 baa:	69e2                	ld	s3,24(sp)
 bac:	6a42                	ld	s4,16(sp)
 bae:	6aa2                	ld	s5,8(sp)
 bb0:	6b02                	ld	s6,0(sp)
 bb2:	6121                	addi	sp,sp,64
 bb4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 bb6:	6398                	ld	a4,0(a5)
 bb8:	e118                	sd	a4,0(a0)
 bba:	bff1                	j	b96 <malloc+0x88>
  hp->s.size = nu;
 bbc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bc0:	0541                	addi	a0,a0,16
 bc2:	00000097          	auipc	ra,0x0
 bc6:	ec4080e7          	jalr	-316(ra) # a86 <free>
  return freep;
 bca:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bce:	d971                	beqz	a0,ba2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bd2:	4798                	lw	a4,8(a5)
 bd4:	fa9775e3          	bgeu	a4,s1,b7e <malloc+0x70>
    if(p == freep)
 bd8:	00093703          	ld	a4,0(s2)
 bdc:	853e                	mv	a0,a5
 bde:	fef719e3          	bne	a4,a5,bd0 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 be2:	8552                	mv	a0,s4
 be4:	00000097          	auipc	ra,0x0
 be8:	b74080e7          	jalr	-1164(ra) # 758 <sbrk>
  if(p == (char*)-1)
 bec:	fd5518e3          	bne	a0,s5,bbc <malloc+0xae>
        return 0;
 bf0:	4501                	li	a0,0
 bf2:	bf45                	j	ba2 <malloc+0x94>
