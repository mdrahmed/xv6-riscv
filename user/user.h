struct stat;
struct rtcdate;

struct user_ring_buf;
struct book;
// void store(int *, int);
// int load(int *);


// int create_the_buffer(char , int);

// void read_ring(int );
// void write_ring(int , int );

// void ringbuf_start_read(int , char *, int *);
// void ringbuf_finish_read(int , int );

// void ringbuf_start_write(int , char *, int *);
// void ringbuf_finish_write(int , int );


// system calls
int fork(void);
int exit(int) __attribute__((noreturn));
int wait(int*);
int pipe(int*);
int write(int, const void*, int);
int read(int, void*, int);
int close(int);
int kill(int);
int exec(char*, char**);
int open(const char*, int);
int mknod(const char*, short, short);
int unlink(const char*);
int fstat(int fd, struct stat*);
int link(const char*, const char*);
int mkdir(const char*);
int chdir(const char*);
int dup(int);
int getpid(void);
char* sbrk(int);
int sleep(int);
int uptime(void);
int ringbuf(char *, int, uint64 *);

// ulib.c
int stat(const char*, struct stat*);
char* strcpy(char*, const char*);
void *memmove(void*, const void*, int);
char* strchr(const char*, char c);
int strcmp(const char*, const char*);
void fprintf(int, const char*, ...);
void printf(const char*, ...);
char* gets(char*, int max);
uint strlen(const char*);
void* memset(void*, int, uint);
void* malloc(uint);
void free(void*);
int atoi(const char*);
int memcmp(const void *, const void *, uint);
void *memcpy(void *, const void *, uint);

int create_or_close_the_buffer_user(char *, int);
void ringbuf_start_write(int , uint64 *, int *);
void ringbuf_start_read(int , uint64 *, int *);
void ringbuf_finish_write(int , int );
void ringbuf_finish_read(int , int );
void check_bytes_written(int , int *);

