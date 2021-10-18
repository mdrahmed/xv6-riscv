
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
  42:	6ba080e7          	jalr	1722(ra) # 6f8 <pipe>
  46:	57fd                	li	a5,-1
  48:	04f50c63          	beq	a0,a5,a0 <main+0xa0>
        printf("An error occured while creating the pipe\n");
        exit(1); 
    }

    int cid = fork(); //Creating the child process;
  4c:	00000097          	auipc	ra,0x0
  50:	694080e7          	jalr	1684(ra) # 6e0 <fork>

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
  62:	6b2080e7          	jalr	1714(ra) # 710 <close>
        int received_data[SIZE] = {0}; //Declaring receiving data and initializing it to 0
  66:	20000613          	li	a2,512
  6a:	4581                	li	a1,0
  6c:	d8840513          	addi	a0,s0,-632
  70:	00000097          	auipc	ra,0x0
  74:	47c080e7          	jalr	1148(ra) # 4ec <memset>

        current_time = uptime(); //getting the current time in the parent process
  78:	00000097          	auipc	ra,0x0
  7c:	708080e7          	jalr	1800(ra) # 780 <uptime>
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
  90:	c04b8b93          	addi	s7,s7,-1020 # c90 <malloc+0x16a>
                    check = 1; // Value of check will be changed to 1 if any byte went missing
  94:	4b05                	li	s6,1
        for(int i=0; i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
  96:	00280cb7          	lui	s9,0x280
  9a:	080c8c93          	addi	s9,s9,128 # 280080 <__global_pointer$+0x27eaf7>
  9e:	a0ed                	j	188 <main+0x188>
        printf("An error occured while creating the pipe\n");
  a0:	00001517          	auipc	a0,0x1
  a4:	b7050513          	addi	a0,a0,-1168 # c10 <malloc+0xea>
  a8:	00001097          	auipc	ra,0x1
  ac:	9c0080e7          	jalr	-1600(ra) # a68 <printf>
        exit(1); 
  b0:	4505                	li	a0,1
  b2:	00000097          	auipc	ra,0x0
  b6:	636080e7          	jalr	1590(ra) # 6e8 <exit>
        close(fd[0]); //closing read function of child process
  ba:	f8842503          	lw	a0,-120(s0)
  be:	00000097          	auipc	ra,0x0
  c2:	652080e7          	jalr	1618(ra) # 710 <close>
        int sending_data[SIZE] = {0}; //Declaring data of 128 size to send and initializing with value 0
  c6:	20000613          	li	a2,512
  ca:	4581                	li	a1,0
  cc:	d8840513          	addi	a0,s0,-632
  d0:	00000097          	auipc	ra,0x0
  d4:	41c080e7          	jalr	1052(ra) # 4ec <memset>
  d8:	08000493          	li	s1,128
            if(write(fd[1], sending_data, 512) == -1){ //sends data to parent process as well as checks for exception
  dc:	59fd                	li	s3,-1
        for(int i=0;i<(1024*20); i++){ //1024*20*(128*4) = 10485760 which is 10 MB
  de:	00280937          	lui	s2,0x280
  e2:	08090913          	addi	s2,s2,128 # 280080 <__global_pointer$+0x27eaf7>
  e6:	a00d                	j	108 <main+0x108>
            if(write(fd[1], sending_data, 512) == -1){ //sends data to parent process as well as checks for exception
  e8:	20000613          	li	a2,512
  ec:	d8840593          	addi	a1,s0,-632
  f0:	f8c42503          	lw	a0,-116(s0)
  f4:	00000097          	auipc	ra,0x0
  f8:	614080e7          	jalr	1556(ra) # 708 <write>
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
 124:	b2050513          	addi	a0,a0,-1248 # c40 <malloc+0x11a>
 128:	00001097          	auipc	ra,0x1
 12c:	940080e7          	jalr	-1728(ra) # a68 <printf>
                exit(1);
 130:	4505                	li	a0,1
 132:	00000097          	auipc	ra,0x0
 136:	5b6080e7          	jalr	1462(ra) # 6e8 <exit>
        close(fd[1]); //closing write end after wrting
 13a:	f8c42503          	lw	a0,-116(s0)
 13e:	00000097          	auipc	ra,0x0
 142:	5d2080e7          	jalr	1490(ra) # 710 <close>
 146:	a86d                	j	200 <main+0x200>
                printf("An error occurred while reading\n"); 
 148:	00001517          	auipc	a0,0x1
 14c:	b2050513          	addi	a0,a0,-1248 # c68 <malloc+0x142>
 150:	00001097          	auipc	ra,0x1
 154:	918080e7          	jalr	-1768(ra) # a68 <printf>
                exit(1);
 158:	4505                	li	a0,1
 15a:	00000097          	auipc	ra,0x0
 15e:	58e080e7          	jalr	1422(ra) # 6e8 <exit>
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
 178:	8f4080e7          	jalr	-1804(ra) # a68 <printf>
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
 198:	56c080e7          	jalr	1388(ra) # 700 <read>
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
 1b8:	53c080e7          	jalr	1340(ra) # 6f0 <wait>
        
        // Now, the total byte data sent will be printed which is 10485760 or 10 MB
        
        printf("Total byte data sent: %d byte\n",count);
 1bc:	85e2                	mv	a1,s8
 1be:	00001517          	auipc	a0,0x1
 1c2:	afa50513          	addi	a0,a0,-1286 # cb8 <malloc+0x192>
 1c6:	00001097          	auipc	ra,0x1
 1ca:	8a2080e7          	jalr	-1886(ra) # a68 <printf>

        // if the data received correctly then it will print 0 otherwise 1
        if(check == 0)
 1ce:	020a9e63          	bnez	s5,20a <main+0x20a>
            printf("Data received correctly as flag value is %d\n", check);
 1d2:	85d6                	mv	a1,s5
 1d4:	00001517          	auipc	a0,0x1
 1d8:	b0450513          	addi	a0,a0,-1276 # cd8 <malloc+0x1b2>
 1dc:	00001097          	auipc	ra,0x1
 1e0:	88c080e7          	jalr	-1908(ra) # a68 <printf>
        else
            printf("A byte went missing as flag value is %d\n", check);

        //The total time taken for sending and receiving data is printed
        elasped_time = uptime()-current_time;
 1e4:	00000097          	auipc	ra,0x0
 1e8:	59c080e7          	jalr	1436(ra) # 780 <uptime>
        printf("The total ticks are %d\n",elasped_time);
 1ec:	41b505bb          	subw	a1,a0,s11
 1f0:	00001517          	auipc	a0,0x1
 1f4:	b4850513          	addi	a0,a0,-1208 # d38 <malloc+0x212>
 1f8:	00001097          	auipc	ra,0x1
 1fc:	870080e7          	jalr	-1936(ra) # a68 <printf>
    else{ 
        printf("An error occurred while forking");
        exit(1);
    }

    exit(0); //Exiting with 0 error
 200:	4501                	li	a0,0
 202:	00000097          	auipc	ra,0x0
 206:	4e6080e7          	jalr	1254(ra) # 6e8 <exit>
            printf("A byte went missing as flag value is %d\n", check);
 20a:	85d6                	mv	a1,s5
 20c:	00001517          	auipc	a0,0x1
 210:	afc50513          	addi	a0,a0,-1284 # d08 <malloc+0x1e2>
 214:	00001097          	auipc	ra,0x1
 218:	854080e7          	jalr	-1964(ra) # a68 <printf>
 21c:	b7e1                	j	1e4 <main+0x1e4>
        printf("An error occurred while forking");
 21e:	00001517          	auipc	a0,0x1
 222:	b3250513          	addi	a0,a0,-1230 # d50 <malloc+0x22a>
 226:	00001097          	auipc	ra,0x1
 22a:	842080e7          	jalr	-1982(ra) # a68 <printf>
        exit(1);
 22e:	4505                	li	a0,1
 230:	00000097          	auipc	ra,0x0
 234:	4b8080e7          	jalr	1208(ra) # 6e8 <exit>

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

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 264:	7139                	addi	sp,sp,-64
 266:	fc06                	sd	ra,56(sp)
 268:	f822                	sd	s0,48(sp)
 26a:	f426                	sd	s1,40(sp)
 26c:	f04a                	sd	s2,32(sp)
 26e:	ec4e                	sd	s3,24(sp)
 270:	e852                	sd	s4,16(sp)
 272:	e456                	sd	s5,8(sp)
 274:	e05a                	sd	s6,0(sp)
 276:	0080                	addi	s0,sp,64
 278:	8a2a                	mv	s4,a0
 27a:	89ae                	mv	s3,a1
 27c:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 27e:	4785                	li	a5,1
 280:	00001497          	auipc	s1,0x1
 284:	b2848493          	addi	s1,s1,-1240 # da8 <rings+0x8>
 288:	00001917          	auipc	s2,0x1
 28c:	c1090913          	addi	s2,s2,-1008 # e98 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 290:	00001b17          	auipc	s6,0x1
 294:	b00b0b13          	addi	s6,s6,-1280 # d90 <vm_addr>
  if(open_close == 1){
 298:	04f59063          	bne	a1,a5,2d8 <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 29c:	00001497          	auipc	s1,0x1
 2a0:	b144a483          	lw	s1,-1260(s1) # db0 <rings+0x10>
 2a4:	c099                	beqz	s1,2aa <create_or_close_the_buffer_user+0x46>
 2a6:	4481                	li	s1,0
 2a8:	a899                	j	2fe <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 2aa:	865a                	mv	a2,s6
 2ac:	4585                	li	a1,1
 2ae:	00000097          	auipc	ra,0x0
 2b2:	4da080e7          	jalr	1242(ra) # 788 <ringbuf>
        rings[i].book->write_done = 0;
 2b6:	00001797          	auipc	a5,0x1
 2ba:	aea78793          	addi	a5,a5,-1302 # da0 <rings>
 2be:	6798                	ld	a4,8(a5)
 2c0:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 2c4:	6798                	ld	a4,8(a5)
 2c6:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 2ca:	4b98                	lw	a4,16(a5)
 2cc:	2705                	addiw	a4,a4,1
 2ce:	cb98                	sw	a4,16(a5)
        break;
 2d0:	a03d                	j	2fe <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 2d2:	04e1                	addi	s1,s1,24
 2d4:	03248463          	beq	s1,s2,2fc <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 2d8:	449c                	lw	a5,8(s1)
 2da:	dfe5                	beqz	a5,2d2 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 2dc:	865a                	mv	a2,s6
 2de:	85ce                	mv	a1,s3
 2e0:	8552                	mv	a0,s4
 2e2:	00000097          	auipc	ra,0x0
 2e6:	4a6080e7          	jalr	1190(ra) # 788 <ringbuf>
        rings[i].book->write_done = 0;
 2ea:	609c                	ld	a5,0(s1)
 2ec:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 2f0:	609c                	ld	a5,0(s1)
 2f2:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 2f6:	0004a423          	sw	zero,8(s1)
 2fa:	bfe1                	j	2d2 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 2fc:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 2fe:	00001797          	auipc	a5,0x1
 302:	a927b783          	ld	a5,-1390(a5) # d90 <vm_addr>
 306:	00fab023          	sd	a5,0(s5)
  return i;
}
 30a:	8526                	mv	a0,s1
 30c:	70e2                	ld	ra,56(sp)
 30e:	7442                	ld	s0,48(sp)
 310:	74a2                	ld	s1,40(sp)
 312:	7902                	ld	s2,32(sp)
 314:	69e2                	ld	s3,24(sp)
 316:	6a42                	ld	s4,16(sp)
 318:	6aa2                	ld	s5,8(sp)
 31a:	6b02                	ld	s6,0(sp)
 31c:	6121                	addi	sp,sp,64
 31e:	8082                	ret

0000000000000320 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 320:	1101                	addi	sp,sp,-32
 322:	ec06                	sd	ra,24(sp)
 324:	e822                	sd	s0,16(sp)
 326:	e426                	sd	s1,8(sp)
 328:	1000                	addi	s0,sp,32
 32a:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 32c:	00001797          	auipc	a5,0x1
 330:	a647b783          	ld	a5,-1436(a5) # d90 <vm_addr>
 334:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 336:	421c                	lw	a5,0(a2)
 338:	e79d                	bnez	a5,366 <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 33a:	00001697          	auipc	a3,0x1
 33e:	a6668693          	addi	a3,a3,-1434 # da0 <rings>
 342:	669c                	ld	a5,8(a3)
 344:	6398                	ld	a4,0(a5)
 346:	67c1                	lui	a5,0x10
 348:	9fb9                	addw	a5,a5,a4
 34a:	00151713          	slli	a4,a0,0x1
 34e:	953a                	add	a0,a0,a4
 350:	050e                	slli	a0,a0,0x3
 352:	9536                	add	a0,a0,a3
 354:	6518                	ld	a4,8(a0)
 356:	6718                	ld	a4,8(a4)
 358:	9f99                	subw	a5,a5,a4
 35a:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 35c:	60e2                	ld	ra,24(sp)
 35e:	6442                	ld	s0,16(sp)
 360:	64a2                	ld	s1,8(sp)
 362:	6105                	addi	sp,sp,32
 364:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 366:	00151793          	slli	a5,a0,0x1
 36a:	953e                	add	a0,a0,a5
 36c:	050e                	slli	a0,a0,0x3
 36e:	00001797          	auipc	a5,0x1
 372:	a3278793          	addi	a5,a5,-1486 # da0 <rings>
 376:	953e                	add	a0,a0,a5
 378:	6508                	ld	a0,8(a0)
 37a:	0521                	addi	a0,a0,8
 37c:	00000097          	auipc	ra,0x0
 380:	ed0080e7          	jalr	-304(ra) # 24c <load>
 384:	c088                	sw	a0,0(s1)
}
 386:	bfd9                	j	35c <ringbuf_start_write+0x3c>

0000000000000388 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 388:	1141                	addi	sp,sp,-16
 38a:	e406                	sd	ra,8(sp)
 38c:	e022                	sd	s0,0(sp)
 38e:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 390:	00151793          	slli	a5,a0,0x1
 394:	97aa                	add	a5,a5,a0
 396:	078e                	slli	a5,a5,0x3
 398:	00001517          	auipc	a0,0x1
 39c:	a0850513          	addi	a0,a0,-1528 # da0 <rings>
 3a0:	97aa                	add	a5,a5,a0
 3a2:	6788                	ld	a0,8(a5)
 3a4:	0035959b          	slliw	a1,a1,0x3
 3a8:	0521                	addi	a0,a0,8
 3aa:	00000097          	auipc	ra,0x0
 3ae:	e8e080e7          	jalr	-370(ra) # 238 <store>
}
 3b2:	60a2                	ld	ra,8(sp)
 3b4:	6402                	ld	s0,0(sp)
 3b6:	0141                	addi	sp,sp,16
 3b8:	8082                	ret

00000000000003ba <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 3ba:	1101                	addi	sp,sp,-32
 3bc:	ec06                	sd	ra,24(sp)
 3be:	e822                	sd	s0,16(sp)
 3c0:	e426                	sd	s1,8(sp)
 3c2:	1000                	addi	s0,sp,32
 3c4:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 3c6:	00151793          	slli	a5,a0,0x1
 3ca:	97aa                	add	a5,a5,a0
 3cc:	078e                	slli	a5,a5,0x3
 3ce:	00001517          	auipc	a0,0x1
 3d2:	9d250513          	addi	a0,a0,-1582 # da0 <rings>
 3d6:	97aa                	add	a5,a5,a0
 3d8:	6788                	ld	a0,8(a5)
 3da:	0521                	addi	a0,a0,8
 3dc:	00000097          	auipc	ra,0x0
 3e0:	e70080e7          	jalr	-400(ra) # 24c <load>
 3e4:	c088                	sw	a0,0(s1)
}
 3e6:	60e2                	ld	ra,24(sp)
 3e8:	6442                	ld	s0,16(sp)
 3ea:	64a2                	ld	s1,8(sp)
 3ec:	6105                	addi	sp,sp,32
 3ee:	8082                	ret

00000000000003f0 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 3f0:	1101                	addi	sp,sp,-32
 3f2:	ec06                	sd	ra,24(sp)
 3f4:	e822                	sd	s0,16(sp)
 3f6:	e426                	sd	s1,8(sp)
 3f8:	1000                	addi	s0,sp,32
 3fa:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 3fc:	00151793          	slli	a5,a0,0x1
 400:	97aa                	add	a5,a5,a0
 402:	078e                	slli	a5,a5,0x3
 404:	00001517          	auipc	a0,0x1
 408:	99c50513          	addi	a0,a0,-1636 # da0 <rings>
 40c:	97aa                	add	a5,a5,a0
 40e:	6788                	ld	a0,8(a5)
 410:	611c                	ld	a5,0(a0)
 412:	ef99                	bnez	a5,430 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 414:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 416:	41f7579b          	sraiw	a5,a4,0x1f
 41a:	01d7d79b          	srliw	a5,a5,0x1d
 41e:	9fb9                	addw	a5,a5,a4
 420:	4037d79b          	sraiw	a5,a5,0x3
 424:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 426:	60e2                	ld	ra,24(sp)
 428:	6442                	ld	s0,16(sp)
 42a:	64a2                	ld	s1,8(sp)
 42c:	6105                	addi	sp,sp,32
 42e:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 430:	00000097          	auipc	ra,0x0
 434:	e1c080e7          	jalr	-484(ra) # 24c <load>
    *bytes /= 8;
 438:	41f5579b          	sraiw	a5,a0,0x1f
 43c:	01d7d79b          	srliw	a5,a5,0x1d
 440:	9d3d                	addw	a0,a0,a5
 442:	4035551b          	sraiw	a0,a0,0x3
 446:	c088                	sw	a0,0(s1)
}
 448:	bff9                	j	426 <ringbuf_start_read+0x36>

000000000000044a <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 44a:	1141                	addi	sp,sp,-16
 44c:	e406                	sd	ra,8(sp)
 44e:	e022                	sd	s0,0(sp)
 450:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 452:	00151793          	slli	a5,a0,0x1
 456:	97aa                	add	a5,a5,a0
 458:	078e                	slli	a5,a5,0x3
 45a:	00001517          	auipc	a0,0x1
 45e:	94650513          	addi	a0,a0,-1722 # da0 <rings>
 462:	97aa                	add	a5,a5,a0
 464:	0035959b          	slliw	a1,a1,0x3
 468:	6788                	ld	a0,8(a5)
 46a:	00000097          	auipc	ra,0x0
 46e:	dce080e7          	jalr	-562(ra) # 238 <store>
}
 472:	60a2                	ld	ra,8(sp)
 474:	6402                	ld	s0,0(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret

000000000000047a <strcpy>:



char*
strcpy(char *s, const char *t)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 480:	87aa                	mv	a5,a0
 482:	0585                	addi	a1,a1,1
 484:	0785                	addi	a5,a5,1
 486:	fff5c703          	lbu	a4,-1(a1)
 48a:	fee78fa3          	sb	a4,-1(a5)
 48e:	fb75                	bnez	a4,482 <strcpy+0x8>
    ;
  return os;
}
 490:	6422                	ld	s0,8(sp)
 492:	0141                	addi	sp,sp,16
 494:	8082                	ret

0000000000000496 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 496:	1141                	addi	sp,sp,-16
 498:	e422                	sd	s0,8(sp)
 49a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 49c:	00054783          	lbu	a5,0(a0)
 4a0:	cb91                	beqz	a5,4b4 <strcmp+0x1e>
 4a2:	0005c703          	lbu	a4,0(a1)
 4a6:	00f71763          	bne	a4,a5,4b4 <strcmp+0x1e>
    p++, q++;
 4aa:	0505                	addi	a0,a0,1
 4ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 4ae:	00054783          	lbu	a5,0(a0)
 4b2:	fbe5                	bnez	a5,4a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 4b4:	0005c503          	lbu	a0,0(a1)
}
 4b8:	40a7853b          	subw	a0,a5,a0
 4bc:	6422                	ld	s0,8(sp)
 4be:	0141                	addi	sp,sp,16
 4c0:	8082                	ret

00000000000004c2 <strlen>:

uint
strlen(const char *s)
{
 4c2:	1141                	addi	sp,sp,-16
 4c4:	e422                	sd	s0,8(sp)
 4c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4c8:	00054783          	lbu	a5,0(a0)
 4cc:	cf91                	beqz	a5,4e8 <strlen+0x26>
 4ce:	0505                	addi	a0,a0,1
 4d0:	87aa                	mv	a5,a0
 4d2:	4685                	li	a3,1
 4d4:	9e89                	subw	a3,a3,a0
 4d6:	00f6853b          	addw	a0,a3,a5
 4da:	0785                	addi	a5,a5,1
 4dc:	fff7c703          	lbu	a4,-1(a5)
 4e0:	fb7d                	bnez	a4,4d6 <strlen+0x14>
    ;
  return n;
}
 4e2:	6422                	ld	s0,8(sp)
 4e4:	0141                	addi	sp,sp,16
 4e6:	8082                	ret
  for(n = 0; s[n]; n++)
 4e8:	4501                	li	a0,0
 4ea:	bfe5                	j	4e2 <strlen+0x20>

00000000000004ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 4ec:	1141                	addi	sp,sp,-16
 4ee:	e422                	sd	s0,8(sp)
 4f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4f2:	ca19                	beqz	a2,508 <memset+0x1c>
 4f4:	87aa                	mv	a5,a0
 4f6:	1602                	slli	a2,a2,0x20
 4f8:	9201                	srli	a2,a2,0x20
 4fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 502:	0785                	addi	a5,a5,1
 504:	fee79de3          	bne	a5,a4,4fe <memset+0x12>
  }
  return dst;
}
 508:	6422                	ld	s0,8(sp)
 50a:	0141                	addi	sp,sp,16
 50c:	8082                	ret

000000000000050e <strchr>:

char*
strchr(const char *s, char c)
{
 50e:	1141                	addi	sp,sp,-16
 510:	e422                	sd	s0,8(sp)
 512:	0800                	addi	s0,sp,16
  for(; *s; s++)
 514:	00054783          	lbu	a5,0(a0)
 518:	cb99                	beqz	a5,52e <strchr+0x20>
    if(*s == c)
 51a:	00f58763          	beq	a1,a5,528 <strchr+0x1a>
  for(; *s; s++)
 51e:	0505                	addi	a0,a0,1
 520:	00054783          	lbu	a5,0(a0)
 524:	fbfd                	bnez	a5,51a <strchr+0xc>
      return (char*)s;
  return 0;
 526:	4501                	li	a0,0
}
 528:	6422                	ld	s0,8(sp)
 52a:	0141                	addi	sp,sp,16
 52c:	8082                	ret
  return 0;
 52e:	4501                	li	a0,0
 530:	bfe5                	j	528 <strchr+0x1a>

0000000000000532 <gets>:

char*
gets(char *buf, int max)
{
 532:	711d                	addi	sp,sp,-96
 534:	ec86                	sd	ra,88(sp)
 536:	e8a2                	sd	s0,80(sp)
 538:	e4a6                	sd	s1,72(sp)
 53a:	e0ca                	sd	s2,64(sp)
 53c:	fc4e                	sd	s3,56(sp)
 53e:	f852                	sd	s4,48(sp)
 540:	f456                	sd	s5,40(sp)
 542:	f05a                	sd	s6,32(sp)
 544:	ec5e                	sd	s7,24(sp)
 546:	1080                	addi	s0,sp,96
 548:	8baa                	mv	s7,a0
 54a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 54c:	892a                	mv	s2,a0
 54e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 550:	4aa9                	li	s5,10
 552:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 554:	89a6                	mv	s3,s1
 556:	2485                	addiw	s1,s1,1
 558:	0344d863          	bge	s1,s4,588 <gets+0x56>
    cc = read(0, &c, 1);
 55c:	4605                	li	a2,1
 55e:	faf40593          	addi	a1,s0,-81
 562:	4501                	li	a0,0
 564:	00000097          	auipc	ra,0x0
 568:	19c080e7          	jalr	412(ra) # 700 <read>
    if(cc < 1)
 56c:	00a05e63          	blez	a0,588 <gets+0x56>
    buf[i++] = c;
 570:	faf44783          	lbu	a5,-81(s0)
 574:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 578:	01578763          	beq	a5,s5,586 <gets+0x54>
 57c:	0905                	addi	s2,s2,1
 57e:	fd679be3          	bne	a5,s6,554 <gets+0x22>
  for(i=0; i+1 < max; ){
 582:	89a6                	mv	s3,s1
 584:	a011                	j	588 <gets+0x56>
 586:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 588:	99de                	add	s3,s3,s7
 58a:	00098023          	sb	zero,0(s3)
  return buf;
}
 58e:	855e                	mv	a0,s7
 590:	60e6                	ld	ra,88(sp)
 592:	6446                	ld	s0,80(sp)
 594:	64a6                	ld	s1,72(sp)
 596:	6906                	ld	s2,64(sp)
 598:	79e2                	ld	s3,56(sp)
 59a:	7a42                	ld	s4,48(sp)
 59c:	7aa2                	ld	s5,40(sp)
 59e:	7b02                	ld	s6,32(sp)
 5a0:	6be2                	ld	s7,24(sp)
 5a2:	6125                	addi	sp,sp,96
 5a4:	8082                	ret

00000000000005a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 5a6:	1101                	addi	sp,sp,-32
 5a8:	ec06                	sd	ra,24(sp)
 5aa:	e822                	sd	s0,16(sp)
 5ac:	e426                	sd	s1,8(sp)
 5ae:	e04a                	sd	s2,0(sp)
 5b0:	1000                	addi	s0,sp,32
 5b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5b4:	4581                	li	a1,0
 5b6:	00000097          	auipc	ra,0x0
 5ba:	172080e7          	jalr	370(ra) # 728 <open>
  if(fd < 0)
 5be:	02054563          	bltz	a0,5e8 <stat+0x42>
 5c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 5c4:	85ca                	mv	a1,s2
 5c6:	00000097          	auipc	ra,0x0
 5ca:	17a080e7          	jalr	378(ra) # 740 <fstat>
 5ce:	892a                	mv	s2,a0
  close(fd);
 5d0:	8526                	mv	a0,s1
 5d2:	00000097          	auipc	ra,0x0
 5d6:	13e080e7          	jalr	318(ra) # 710 <close>
  return r;
}
 5da:	854a                	mv	a0,s2
 5dc:	60e2                	ld	ra,24(sp)
 5de:	6442                	ld	s0,16(sp)
 5e0:	64a2                	ld	s1,8(sp)
 5e2:	6902                	ld	s2,0(sp)
 5e4:	6105                	addi	sp,sp,32
 5e6:	8082                	ret
    return -1;
 5e8:	597d                	li	s2,-1
 5ea:	bfc5                	j	5da <stat+0x34>

00000000000005ec <atoi>:

int
atoi(const char *s)
{
 5ec:	1141                	addi	sp,sp,-16
 5ee:	e422                	sd	s0,8(sp)
 5f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5f2:	00054603          	lbu	a2,0(a0)
 5f6:	fd06079b          	addiw	a5,a2,-48
 5fa:	0ff7f793          	zext.b	a5,a5
 5fe:	4725                	li	a4,9
 600:	02f76963          	bltu	a4,a5,632 <atoi+0x46>
 604:	86aa                	mv	a3,a0
  n = 0;
 606:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 608:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 60a:	0685                	addi	a3,a3,1
 60c:	0025179b          	slliw	a5,a0,0x2
 610:	9fa9                	addw	a5,a5,a0
 612:	0017979b          	slliw	a5,a5,0x1
 616:	9fb1                	addw	a5,a5,a2
 618:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 61c:	0006c603          	lbu	a2,0(a3)
 620:	fd06071b          	addiw	a4,a2,-48
 624:	0ff77713          	zext.b	a4,a4
 628:	fee5f1e3          	bgeu	a1,a4,60a <atoi+0x1e>
  return n;
}
 62c:	6422                	ld	s0,8(sp)
 62e:	0141                	addi	sp,sp,16
 630:	8082                	ret
  n = 0;
 632:	4501                	li	a0,0
 634:	bfe5                	j	62c <atoi+0x40>

0000000000000636 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 636:	1141                	addi	sp,sp,-16
 638:	e422                	sd	s0,8(sp)
 63a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 63c:	02b57463          	bgeu	a0,a1,664 <memmove+0x2e>
    while(n-- > 0)
 640:	00c05f63          	blez	a2,65e <memmove+0x28>
 644:	1602                	slli	a2,a2,0x20
 646:	9201                	srli	a2,a2,0x20
 648:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 64c:	872a                	mv	a4,a0
      *dst++ = *src++;
 64e:	0585                	addi	a1,a1,1
 650:	0705                	addi	a4,a4,1
 652:	fff5c683          	lbu	a3,-1(a1)
 656:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 65a:	fee79ae3          	bne	a5,a4,64e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 65e:	6422                	ld	s0,8(sp)
 660:	0141                	addi	sp,sp,16
 662:	8082                	ret
    dst += n;
 664:	00c50733          	add	a4,a0,a2
    src += n;
 668:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 66a:	fec05ae3          	blez	a2,65e <memmove+0x28>
 66e:	fff6079b          	addiw	a5,a2,-1
 672:	1782                	slli	a5,a5,0x20
 674:	9381                	srli	a5,a5,0x20
 676:	fff7c793          	not	a5,a5
 67a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 67c:	15fd                	addi	a1,a1,-1
 67e:	177d                	addi	a4,a4,-1
 680:	0005c683          	lbu	a3,0(a1)
 684:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 688:	fee79ae3          	bne	a5,a4,67c <memmove+0x46>
 68c:	bfc9                	j	65e <memmove+0x28>

000000000000068e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 68e:	1141                	addi	sp,sp,-16
 690:	e422                	sd	s0,8(sp)
 692:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 694:	ca05                	beqz	a2,6c4 <memcmp+0x36>
 696:	fff6069b          	addiw	a3,a2,-1
 69a:	1682                	slli	a3,a3,0x20
 69c:	9281                	srli	a3,a3,0x20
 69e:	0685                	addi	a3,a3,1
 6a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 6a2:	00054783          	lbu	a5,0(a0)
 6a6:	0005c703          	lbu	a4,0(a1)
 6aa:	00e79863          	bne	a5,a4,6ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 6ae:	0505                	addi	a0,a0,1
    p2++;
 6b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 6b2:	fed518e3          	bne	a0,a3,6a2 <memcmp+0x14>
  }
  return 0;
 6b6:	4501                	li	a0,0
 6b8:	a019                	j	6be <memcmp+0x30>
      return *p1 - *p2;
 6ba:	40e7853b          	subw	a0,a5,a4
}
 6be:	6422                	ld	s0,8(sp)
 6c0:	0141                	addi	sp,sp,16
 6c2:	8082                	ret
  return 0;
 6c4:	4501                	li	a0,0
 6c6:	bfe5                	j	6be <memcmp+0x30>

00000000000006c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6c8:	1141                	addi	sp,sp,-16
 6ca:	e406                	sd	ra,8(sp)
 6cc:	e022                	sd	s0,0(sp)
 6ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 6d0:	00000097          	auipc	ra,0x0
 6d4:	f66080e7          	jalr	-154(ra) # 636 <memmove>
}
 6d8:	60a2                	ld	ra,8(sp)
 6da:	6402                	ld	s0,0(sp)
 6dc:	0141                	addi	sp,sp,16
 6de:	8082                	ret

00000000000006e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6e0:	4885                	li	a7,1
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6e8:	4889                	li	a7,2
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6f0:	488d                	li	a7,3
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6f8:	4891                	li	a7,4
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <read>:
.global read
read:
 li a7, SYS_read
 700:	4895                	li	a7,5
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <write>:
.global write
write:
 li a7, SYS_write
 708:	48c1                	li	a7,16
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <close>:
.global close
close:
 li a7, SYS_close
 710:	48d5                	li	a7,21
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <kill>:
.global kill
kill:
 li a7, SYS_kill
 718:	4899                	li	a7,6
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <exec>:
.global exec
exec:
 li a7, SYS_exec
 720:	489d                	li	a7,7
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <open>:
.global open
open:
 li a7, SYS_open
 728:	48bd                	li	a7,15
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 730:	48c5                	li	a7,17
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 738:	48c9                	li	a7,18
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 740:	48a1                	li	a7,8
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <link>:
.global link
link:
 li a7, SYS_link
 748:	48cd                	li	a7,19
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 750:	48d1                	li	a7,20
 ecall
 752:	00000073          	ecall
 ret
 756:	8082                	ret

0000000000000758 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 758:	48a5                	li	a7,9
 ecall
 75a:	00000073          	ecall
 ret
 75e:	8082                	ret

0000000000000760 <dup>:
.global dup
dup:
 li a7, SYS_dup
 760:	48a9                	li	a7,10
 ecall
 762:	00000073          	ecall
 ret
 766:	8082                	ret

0000000000000768 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 768:	48ad                	li	a7,11
 ecall
 76a:	00000073          	ecall
 ret
 76e:	8082                	ret

0000000000000770 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 770:	48b1                	li	a7,12
 ecall
 772:	00000073          	ecall
 ret
 776:	8082                	ret

0000000000000778 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 778:	48b5                	li	a7,13
 ecall
 77a:	00000073          	ecall
 ret
 77e:	8082                	ret

0000000000000780 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 780:	48b9                	li	a7,14
 ecall
 782:	00000073          	ecall
 ret
 786:	8082                	ret

0000000000000788 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 788:	48d9                	li	a7,22
 ecall
 78a:	00000073          	ecall
 ret
 78e:	8082                	ret

0000000000000790 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 790:	1101                	addi	sp,sp,-32
 792:	ec06                	sd	ra,24(sp)
 794:	e822                	sd	s0,16(sp)
 796:	1000                	addi	s0,sp,32
 798:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 79c:	4605                	li	a2,1
 79e:	fef40593          	addi	a1,s0,-17
 7a2:	00000097          	auipc	ra,0x0
 7a6:	f66080e7          	jalr	-154(ra) # 708 <write>
}
 7aa:	60e2                	ld	ra,24(sp)
 7ac:	6442                	ld	s0,16(sp)
 7ae:	6105                	addi	sp,sp,32
 7b0:	8082                	ret

00000000000007b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7b2:	7139                	addi	sp,sp,-64
 7b4:	fc06                	sd	ra,56(sp)
 7b6:	f822                	sd	s0,48(sp)
 7b8:	f426                	sd	s1,40(sp)
 7ba:	f04a                	sd	s2,32(sp)
 7bc:	ec4e                	sd	s3,24(sp)
 7be:	0080                	addi	s0,sp,64
 7c0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7c2:	c299                	beqz	a3,7c8 <printint+0x16>
 7c4:	0805c863          	bltz	a1,854 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7c8:	2581                	sext.w	a1,a1
  neg = 0;
 7ca:	4881                	li	a7,0
 7cc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7d2:	2601                	sext.w	a2,a2
 7d4:	00000517          	auipc	a0,0x0
 7d8:	5a450513          	addi	a0,a0,1444 # d78 <digits>
 7dc:	883a                	mv	a6,a4
 7de:	2705                	addiw	a4,a4,1
 7e0:	02c5f7bb          	remuw	a5,a1,a2
 7e4:	1782                	slli	a5,a5,0x20
 7e6:	9381                	srli	a5,a5,0x20
 7e8:	97aa                	add	a5,a5,a0
 7ea:	0007c783          	lbu	a5,0(a5)
 7ee:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7f2:	0005879b          	sext.w	a5,a1
 7f6:	02c5d5bb          	divuw	a1,a1,a2
 7fa:	0685                	addi	a3,a3,1
 7fc:	fec7f0e3          	bgeu	a5,a2,7dc <printint+0x2a>
  if(neg)
 800:	00088b63          	beqz	a7,816 <printint+0x64>
    buf[i++] = '-';
 804:	fd040793          	addi	a5,s0,-48
 808:	973e                	add	a4,a4,a5
 80a:	02d00793          	li	a5,45
 80e:	fef70823          	sb	a5,-16(a4)
 812:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 816:	02e05863          	blez	a4,846 <printint+0x94>
 81a:	fc040793          	addi	a5,s0,-64
 81e:	00e78933          	add	s2,a5,a4
 822:	fff78993          	addi	s3,a5,-1
 826:	99ba                	add	s3,s3,a4
 828:	377d                	addiw	a4,a4,-1
 82a:	1702                	slli	a4,a4,0x20
 82c:	9301                	srli	a4,a4,0x20
 82e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 832:	fff94583          	lbu	a1,-1(s2)
 836:	8526                	mv	a0,s1
 838:	00000097          	auipc	ra,0x0
 83c:	f58080e7          	jalr	-168(ra) # 790 <putc>
  while(--i >= 0)
 840:	197d                	addi	s2,s2,-1
 842:	ff3918e3          	bne	s2,s3,832 <printint+0x80>
}
 846:	70e2                	ld	ra,56(sp)
 848:	7442                	ld	s0,48(sp)
 84a:	74a2                	ld	s1,40(sp)
 84c:	7902                	ld	s2,32(sp)
 84e:	69e2                	ld	s3,24(sp)
 850:	6121                	addi	sp,sp,64
 852:	8082                	ret
    x = -xx;
 854:	40b005bb          	negw	a1,a1
    neg = 1;
 858:	4885                	li	a7,1
    x = -xx;
 85a:	bf8d                	j	7cc <printint+0x1a>

000000000000085c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 85c:	7119                	addi	sp,sp,-128
 85e:	fc86                	sd	ra,120(sp)
 860:	f8a2                	sd	s0,112(sp)
 862:	f4a6                	sd	s1,104(sp)
 864:	f0ca                	sd	s2,96(sp)
 866:	ecce                	sd	s3,88(sp)
 868:	e8d2                	sd	s4,80(sp)
 86a:	e4d6                	sd	s5,72(sp)
 86c:	e0da                	sd	s6,64(sp)
 86e:	fc5e                	sd	s7,56(sp)
 870:	f862                	sd	s8,48(sp)
 872:	f466                	sd	s9,40(sp)
 874:	f06a                	sd	s10,32(sp)
 876:	ec6e                	sd	s11,24(sp)
 878:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 87a:	0005c903          	lbu	s2,0(a1)
 87e:	18090f63          	beqz	s2,a1c <vprintf+0x1c0>
 882:	8aaa                	mv	s5,a0
 884:	8b32                	mv	s6,a2
 886:	00158493          	addi	s1,a1,1
  state = 0;
 88a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 88c:	02500a13          	li	s4,37
      if(c == 'd'){
 890:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 894:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 898:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 89c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8a0:	00000b97          	auipc	s7,0x0
 8a4:	4d8b8b93          	addi	s7,s7,1240 # d78 <digits>
 8a8:	a839                	j	8c6 <vprintf+0x6a>
        putc(fd, c);
 8aa:	85ca                	mv	a1,s2
 8ac:	8556                	mv	a0,s5
 8ae:	00000097          	auipc	ra,0x0
 8b2:	ee2080e7          	jalr	-286(ra) # 790 <putc>
 8b6:	a019                	j	8bc <vprintf+0x60>
    } else if(state == '%'){
 8b8:	01498f63          	beq	s3,s4,8d6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 8bc:	0485                	addi	s1,s1,1
 8be:	fff4c903          	lbu	s2,-1(s1)
 8c2:	14090d63          	beqz	s2,a1c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 8c6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 8ca:	fe0997e3          	bnez	s3,8b8 <vprintf+0x5c>
      if(c == '%'){
 8ce:	fd479ee3          	bne	a5,s4,8aa <vprintf+0x4e>
        state = '%';
 8d2:	89be                	mv	s3,a5
 8d4:	b7e5                	j	8bc <vprintf+0x60>
      if(c == 'd'){
 8d6:	05878063          	beq	a5,s8,916 <vprintf+0xba>
      } else if(c == 'l') {
 8da:	05978c63          	beq	a5,s9,932 <vprintf+0xd6>
      } else if(c == 'x') {
 8de:	07a78863          	beq	a5,s10,94e <vprintf+0xf2>
      } else if(c == 'p') {
 8e2:	09b78463          	beq	a5,s11,96a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8e6:	07300713          	li	a4,115
 8ea:	0ce78663          	beq	a5,a4,9b6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8ee:	06300713          	li	a4,99
 8f2:	0ee78e63          	beq	a5,a4,9ee <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8f6:	11478863          	beq	a5,s4,a06 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8fa:	85d2                	mv	a1,s4
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	e92080e7          	jalr	-366(ra) # 790 <putc>
        putc(fd, c);
 906:	85ca                	mv	a1,s2
 908:	8556                	mv	a0,s5
 90a:	00000097          	auipc	ra,0x0
 90e:	e86080e7          	jalr	-378(ra) # 790 <putc>
      }
      state = 0;
 912:	4981                	li	s3,0
 914:	b765                	j	8bc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 916:	008b0913          	addi	s2,s6,8
 91a:	4685                	li	a3,1
 91c:	4629                	li	a2,10
 91e:	000b2583          	lw	a1,0(s6)
 922:	8556                	mv	a0,s5
 924:	00000097          	auipc	ra,0x0
 928:	e8e080e7          	jalr	-370(ra) # 7b2 <printint>
 92c:	8b4a                	mv	s6,s2
      state = 0;
 92e:	4981                	li	s3,0
 930:	b771                	j	8bc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 932:	008b0913          	addi	s2,s6,8
 936:	4681                	li	a3,0
 938:	4629                	li	a2,10
 93a:	000b2583          	lw	a1,0(s6)
 93e:	8556                	mv	a0,s5
 940:	00000097          	auipc	ra,0x0
 944:	e72080e7          	jalr	-398(ra) # 7b2 <printint>
 948:	8b4a                	mv	s6,s2
      state = 0;
 94a:	4981                	li	s3,0
 94c:	bf85                	j	8bc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 94e:	008b0913          	addi	s2,s6,8
 952:	4681                	li	a3,0
 954:	4641                	li	a2,16
 956:	000b2583          	lw	a1,0(s6)
 95a:	8556                	mv	a0,s5
 95c:	00000097          	auipc	ra,0x0
 960:	e56080e7          	jalr	-426(ra) # 7b2 <printint>
 964:	8b4a                	mv	s6,s2
      state = 0;
 966:	4981                	li	s3,0
 968:	bf91                	j	8bc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 96a:	008b0793          	addi	a5,s6,8
 96e:	f8f43423          	sd	a5,-120(s0)
 972:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 976:	03000593          	li	a1,48
 97a:	8556                	mv	a0,s5
 97c:	00000097          	auipc	ra,0x0
 980:	e14080e7          	jalr	-492(ra) # 790 <putc>
  putc(fd, 'x');
 984:	85ea                	mv	a1,s10
 986:	8556                	mv	a0,s5
 988:	00000097          	auipc	ra,0x0
 98c:	e08080e7          	jalr	-504(ra) # 790 <putc>
 990:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 992:	03c9d793          	srli	a5,s3,0x3c
 996:	97de                	add	a5,a5,s7
 998:	0007c583          	lbu	a1,0(a5)
 99c:	8556                	mv	a0,s5
 99e:	00000097          	auipc	ra,0x0
 9a2:	df2080e7          	jalr	-526(ra) # 790 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 9a6:	0992                	slli	s3,s3,0x4
 9a8:	397d                	addiw	s2,s2,-1
 9aa:	fe0914e3          	bnez	s2,992 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 9ae:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	b721                	j	8bc <vprintf+0x60>
        s = va_arg(ap, char*);
 9b6:	008b0993          	addi	s3,s6,8
 9ba:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 9be:	02090163          	beqz	s2,9e0 <vprintf+0x184>
        while(*s != 0){
 9c2:	00094583          	lbu	a1,0(s2)
 9c6:	c9a1                	beqz	a1,a16 <vprintf+0x1ba>
          putc(fd, *s);
 9c8:	8556                	mv	a0,s5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	dc6080e7          	jalr	-570(ra) # 790 <putc>
          s++;
 9d2:	0905                	addi	s2,s2,1
        while(*s != 0){
 9d4:	00094583          	lbu	a1,0(s2)
 9d8:	f9e5                	bnez	a1,9c8 <vprintf+0x16c>
        s = va_arg(ap, char*);
 9da:	8b4e                	mv	s6,s3
      state = 0;
 9dc:	4981                	li	s3,0
 9de:	bdf9                	j	8bc <vprintf+0x60>
          s = "(null)";
 9e0:	00000917          	auipc	s2,0x0
 9e4:	39090913          	addi	s2,s2,912 # d70 <malloc+0x24a>
        while(*s != 0){
 9e8:	02800593          	li	a1,40
 9ec:	bff1                	j	9c8 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 9ee:	008b0913          	addi	s2,s6,8
 9f2:	000b4583          	lbu	a1,0(s6)
 9f6:	8556                	mv	a0,s5
 9f8:	00000097          	auipc	ra,0x0
 9fc:	d98080e7          	jalr	-616(ra) # 790 <putc>
 a00:	8b4a                	mv	s6,s2
      state = 0;
 a02:	4981                	li	s3,0
 a04:	bd65                	j	8bc <vprintf+0x60>
        putc(fd, c);
 a06:	85d2                	mv	a1,s4
 a08:	8556                	mv	a0,s5
 a0a:	00000097          	auipc	ra,0x0
 a0e:	d86080e7          	jalr	-634(ra) # 790 <putc>
      state = 0;
 a12:	4981                	li	s3,0
 a14:	b565                	j	8bc <vprintf+0x60>
        s = va_arg(ap, char*);
 a16:	8b4e                	mv	s6,s3
      state = 0;
 a18:	4981                	li	s3,0
 a1a:	b54d                	j	8bc <vprintf+0x60>
    }
  }
}
 a1c:	70e6                	ld	ra,120(sp)
 a1e:	7446                	ld	s0,112(sp)
 a20:	74a6                	ld	s1,104(sp)
 a22:	7906                	ld	s2,96(sp)
 a24:	69e6                	ld	s3,88(sp)
 a26:	6a46                	ld	s4,80(sp)
 a28:	6aa6                	ld	s5,72(sp)
 a2a:	6b06                	ld	s6,64(sp)
 a2c:	7be2                	ld	s7,56(sp)
 a2e:	7c42                	ld	s8,48(sp)
 a30:	7ca2                	ld	s9,40(sp)
 a32:	7d02                	ld	s10,32(sp)
 a34:	6de2                	ld	s11,24(sp)
 a36:	6109                	addi	sp,sp,128
 a38:	8082                	ret

0000000000000a3a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a3a:	715d                	addi	sp,sp,-80
 a3c:	ec06                	sd	ra,24(sp)
 a3e:	e822                	sd	s0,16(sp)
 a40:	1000                	addi	s0,sp,32
 a42:	e010                	sd	a2,0(s0)
 a44:	e414                	sd	a3,8(s0)
 a46:	e818                	sd	a4,16(s0)
 a48:	ec1c                	sd	a5,24(s0)
 a4a:	03043023          	sd	a6,32(s0)
 a4e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a52:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a56:	8622                	mv	a2,s0
 a58:	00000097          	auipc	ra,0x0
 a5c:	e04080e7          	jalr	-508(ra) # 85c <vprintf>
}
 a60:	60e2                	ld	ra,24(sp)
 a62:	6442                	ld	s0,16(sp)
 a64:	6161                	addi	sp,sp,80
 a66:	8082                	ret

0000000000000a68 <printf>:

void
printf(const char *fmt, ...)
{
 a68:	711d                	addi	sp,sp,-96
 a6a:	ec06                	sd	ra,24(sp)
 a6c:	e822                	sd	s0,16(sp)
 a6e:	1000                	addi	s0,sp,32
 a70:	e40c                	sd	a1,8(s0)
 a72:	e810                	sd	a2,16(s0)
 a74:	ec14                	sd	a3,24(s0)
 a76:	f018                	sd	a4,32(s0)
 a78:	f41c                	sd	a5,40(s0)
 a7a:	03043823          	sd	a6,48(s0)
 a7e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a82:	00840613          	addi	a2,s0,8
 a86:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a8a:	85aa                	mv	a1,a0
 a8c:	4505                	li	a0,1
 a8e:	00000097          	auipc	ra,0x0
 a92:	dce080e7          	jalr	-562(ra) # 85c <vprintf>
}
 a96:	60e2                	ld	ra,24(sp)
 a98:	6442                	ld	s0,16(sp)
 a9a:	6125                	addi	sp,sp,96
 a9c:	8082                	ret

0000000000000a9e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a9e:	1141                	addi	sp,sp,-16
 aa0:	e422                	sd	s0,8(sp)
 aa2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 aa4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa8:	00000797          	auipc	a5,0x0
 aac:	2f07b783          	ld	a5,752(a5) # d98 <freep>
 ab0:	a805                	j	ae0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 ab2:	4618                	lw	a4,8(a2)
 ab4:	9db9                	addw	a1,a1,a4
 ab6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 aba:	6398                	ld	a4,0(a5)
 abc:	6318                	ld	a4,0(a4)
 abe:	fee53823          	sd	a4,-16(a0)
 ac2:	a091                	j	b06 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ac4:	ff852703          	lw	a4,-8(a0)
 ac8:	9e39                	addw	a2,a2,a4
 aca:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 acc:	ff053703          	ld	a4,-16(a0)
 ad0:	e398                	sd	a4,0(a5)
 ad2:	a099                	j	b18 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad4:	6398                	ld	a4,0(a5)
 ad6:	00e7e463          	bltu	a5,a4,ade <free+0x40>
 ada:	00e6ea63          	bltu	a3,a4,aee <free+0x50>
{
 ade:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae0:	fed7fae3          	bgeu	a5,a3,ad4 <free+0x36>
 ae4:	6398                	ld	a4,0(a5)
 ae6:	00e6e463          	bltu	a3,a4,aee <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aea:	fee7eae3          	bltu	a5,a4,ade <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 aee:	ff852583          	lw	a1,-8(a0)
 af2:	6390                	ld	a2,0(a5)
 af4:	02059813          	slli	a6,a1,0x20
 af8:	01c85713          	srli	a4,a6,0x1c
 afc:	9736                	add	a4,a4,a3
 afe:	fae60ae3          	beq	a2,a4,ab2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 b02:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b06:	4790                	lw	a2,8(a5)
 b08:	02061593          	slli	a1,a2,0x20
 b0c:	01c5d713          	srli	a4,a1,0x1c
 b10:	973e                	add	a4,a4,a5
 b12:	fae689e3          	beq	a3,a4,ac4 <free+0x26>
  } else
    p->s.ptr = bp;
 b16:	e394                	sd	a3,0(a5)
  freep = p;
 b18:	00000717          	auipc	a4,0x0
 b1c:	28f73023          	sd	a5,640(a4) # d98 <freep>
}
 b20:	6422                	ld	s0,8(sp)
 b22:	0141                	addi	sp,sp,16
 b24:	8082                	ret

0000000000000b26 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b26:	7139                	addi	sp,sp,-64
 b28:	fc06                	sd	ra,56(sp)
 b2a:	f822                	sd	s0,48(sp)
 b2c:	f426                	sd	s1,40(sp)
 b2e:	f04a                	sd	s2,32(sp)
 b30:	ec4e                	sd	s3,24(sp)
 b32:	e852                	sd	s4,16(sp)
 b34:	e456                	sd	s5,8(sp)
 b36:	e05a                	sd	s6,0(sp)
 b38:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b3a:	02051493          	slli	s1,a0,0x20
 b3e:	9081                	srli	s1,s1,0x20
 b40:	04bd                	addi	s1,s1,15
 b42:	8091                	srli	s1,s1,0x4
 b44:	0014899b          	addiw	s3,s1,1
 b48:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b4a:	00000517          	auipc	a0,0x0
 b4e:	24e53503          	ld	a0,590(a0) # d98 <freep>
 b52:	c515                	beqz	a0,b7e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b54:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b56:	4798                	lw	a4,8(a5)
 b58:	02977f63          	bgeu	a4,s1,b96 <malloc+0x70>
 b5c:	8a4e                	mv	s4,s3
 b5e:	0009871b          	sext.w	a4,s3
 b62:	6685                	lui	a3,0x1
 b64:	00d77363          	bgeu	a4,a3,b6a <malloc+0x44>
 b68:	6a05                	lui	s4,0x1
 b6a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b6e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b72:	00000917          	auipc	s2,0x0
 b76:	22690913          	addi	s2,s2,550 # d98 <freep>
  if(p == (char*)-1)
 b7a:	5afd                	li	s5,-1
 b7c:	a895                	j	bf0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b7e:	00000797          	auipc	a5,0x0
 b82:	31278793          	addi	a5,a5,786 # e90 <base>
 b86:	00000717          	auipc	a4,0x0
 b8a:	20f73923          	sd	a5,530(a4) # d98 <freep>
 b8e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b90:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b94:	b7e1                	j	b5c <malloc+0x36>
      if(p->s.size == nunits)
 b96:	02e48c63          	beq	s1,a4,bce <malloc+0xa8>
        p->s.size -= nunits;
 b9a:	4137073b          	subw	a4,a4,s3
 b9e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ba0:	02071693          	slli	a3,a4,0x20
 ba4:	01c6d713          	srli	a4,a3,0x1c
 ba8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 baa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bae:	00000717          	auipc	a4,0x0
 bb2:	1ea73523          	sd	a0,490(a4) # d98 <freep>
      return (void*)(p + 1);
 bb6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 bba:	70e2                	ld	ra,56(sp)
 bbc:	7442                	ld	s0,48(sp)
 bbe:	74a2                	ld	s1,40(sp)
 bc0:	7902                	ld	s2,32(sp)
 bc2:	69e2                	ld	s3,24(sp)
 bc4:	6a42                	ld	s4,16(sp)
 bc6:	6aa2                	ld	s5,8(sp)
 bc8:	6b02                	ld	s6,0(sp)
 bca:	6121                	addi	sp,sp,64
 bcc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 bce:	6398                	ld	a4,0(a5)
 bd0:	e118                	sd	a4,0(a0)
 bd2:	bff1                	j	bae <malloc+0x88>
  hp->s.size = nu;
 bd4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bd8:	0541                	addi	a0,a0,16
 bda:	00000097          	auipc	ra,0x0
 bde:	ec4080e7          	jalr	-316(ra) # a9e <free>
  return freep;
 be2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 be6:	d971                	beqz	a0,bba <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 be8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bea:	4798                	lw	a4,8(a5)
 bec:	fa9775e3          	bgeu	a4,s1,b96 <malloc+0x70>
    if(p == freep)
 bf0:	00093703          	ld	a4,0(s2)
 bf4:	853e                	mv	a0,a5
 bf6:	fef719e3          	bne	a4,a5,be8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 bfa:	8552                	mv	a0,s4
 bfc:	00000097          	auipc	ra,0x0
 c00:	b74080e7          	jalr	-1164(ra) # 770 <sbrk>
  if(p == (char*)-1)
 c04:	fd5518e3          	bne	a0,s5,bd4 <malloc+0xae>
        return 0;
 c08:	4501                	li	a0,0
 c0a:	bf45                	j	bba <malloc+0x94>
