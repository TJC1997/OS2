#include<stdio.h>
#include<time.h>
#include<sys/stat.h>
#include<unistd.h>
#include<sys/types.h>
#include<errno.h>
#include<stdlib.h>
#include<string.h> 
#include<grp.h>
#include<pwd.h>
#include <stdbool.h>

char type='-';

void getStatInfo(char* fileName);
void print_perms(mode_t perms);
void print_perms(mode_t perms) //print permission
    {
        printf("  Mode:\t\t\t\t");
        printf("%c",type);
        printf( (perms & S_IRUSR) ? "r" : "-");
        printf( (perms & S_IWUSR) ? "w" : "-");
        printf( (perms & S_IXUSR) ? "x" : "-");
        printf( (perms & S_IRGRP) ? "r" : "-");
        printf( (perms & S_IWGRP) ? "w" : "-");
        printf( (perms & S_IXGRP) ? "x" : "-");
        printf( (perms & S_IROTH) ? "r" : "-");
        printf( (perms & S_IWOTH) ? "w" : "-");
        printf( (perms & S_IXOTH) ? "x" : "-");
        printf(" (%3o in octal)\n", perms&0777);    //print octal number
    }

void getStatInfo(char* fileName){
    struct stat temp;
    struct passwd* Passwd;
    struct group* Group;
    char mode[100];
    char* format="%Y-%m-%d %H:%M:%S %z (%Z) %a";
    struct tm* a;
    struct tm* b;
    struct tm* c;
    int uid,gid;
    char linkname[100];
    char timea[100];
    char timeb[100];
    char timec[100];

    memset(mode,'\0',100);      //memset
    memset(linkname,'\0',100);
    memset(timea,'\0',100);
    memset(timeb,'\0',100);
    memset(timec,'\0',100);
    if(lstat(fileName,&temp)==-1){          //read the file
        perror("stat return 1");
        exit(1);
    }
    uid=(int)temp.st_uid;
    gid=(int)temp.st_gid;
    Passwd=getpwuid(uid);
    Group=getgrgid(gid);
    
    a=localtime(&(temp.st_atime));      //conver to localtime
    strftime(timea, 100, format, a);    //change the format for time
    b=localtime(&(temp.st_mtime));
    strftime(timeb, 100, format, b); 
    c=localtime(&(temp.st_ctime));
    strftime(timec, 100, format, c); 
    

    printf("File: %s\n",fileName);
    printf("File type:\t\t\t");
    switch (temp.st_mode & S_IFMT) {        //check file type
        case S_IFDIR:  printf("directory\n");     type='d';          break;
        case S_IFLNK:  printf("Symbolic Link-"); type='l';          break;
        case S_IFIFO:  printf("FIFO/pipe\n");     type='p';          break;
        case S_IFREG:  printf("regular file\n");            break;
        case S_IFSOCK: printf("socket\n");        type='s';          break;
        default:       printf("unknown?\n");                break;
    }
    if(type=='l'){
        readlink(fileName,linkname,temp.st_size+1);
        if(strcmp(linkname,"JUNK")==0){             //check if it is broke symbol link
            printf(" with dangling destination\n");
           // haslink=false;
        }
        else{
            printf("-> %s\n",linkname);
            //haslink=true;
        }
        
    }
    printf("  Device ID number:\t\t%d\n",(int)temp.st_dev);
    printf("  I-node number:\t\t%ld\n",(long)temp.st_ino);
    print_perms(temp.st_mode);
    printf("  Link count:\t\t\t%d\n",(int)temp.st_nlink);
    printf("  Owner Id:\t\t\t%s\t(UID = %d)\n",Passwd->pw_name,uid);
    printf("  Group Id:\t\t\t%s\t(GID = %d)\n",Group->gr_name,gid);
    printf("  Preferred I/O block size:\t%d bytes\n",(int)temp.st_blksize);
    printf("  File size:\t\t\t%d bytes\n",(int)temp.st_size);
    printf("  Block allocated:\t\t%d\n",(int)temp.st_blocks);

    printf("  Last file access:\t\t%s (local)\n",timea);
    printf("  Last file modification:\t%s (local)\n",timeb);
    printf("  Last file change:\t\t%s (local)\n",timec);

}


int main(int argc, char **argv)
{
    int i;

    if(argc<2){
        perror("You need to have at least 2 arguments");
        exit(1);
    }
    for(i=1;i<argc;i++){
        getStatInfo(argv[i]);
        printf("\n");
    }
    


    return 0;
}
