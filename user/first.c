#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main()
{  
    fprintf(1, "My first xv6 program\n");  
    fprintf(1, "An int occupies %d bytes.\n", sizeof(int)); 
    exit(0);
}   
