#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
    int val=atoi(argv[1]);
    int pid=0;
    int i;
    for(i=2;i<argc;i++){
        pid=atoi(argv[i]);
        renice(pid,val);
        printf(1,"chnage successfullly\n");
    }
	

    exit();
}
