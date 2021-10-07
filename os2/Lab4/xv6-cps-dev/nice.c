#include "types.h"
#include "user.h"
int
main(int argc, char *argv[])
{
    int val=atoi(argv[1]);
    int pid=getpid();
    renice(pid,val);
    char* command=argv[2];
    char**arg=&command;
    exec(command,arg);
    exit();
}
