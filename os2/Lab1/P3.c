/*Write a C program that opens a file name “JUNK.txt” (with the fopen() function call). Have
the parent process print “before fork” into the file. The parent process should call fork() to
create a new process. Have the parent process perform a for loop that prints “parent” into the
open file 10 times. Have the child process perform a for loop that prints “child” into the open file
10 times. What happens when they are writing to the file concurrently, i.e., at the same time
(answer this in the comments in your code)?
*/

/*What happens when they are writing to the file concurrently, i.e., at the same time
(answer this in the comments in your code)?
	Base on test, parent process will write into txt file first, and then the child process will write in to txt file.
	for some reason, before fork will be written into file twice, which is werid because "before fork" should only run one time in parent process before fork.
	Once we fork, we don't know which process run first, it depends on OS and other factors.
*/

#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>
#include<stdlib.h>


void P3();

int main(){
   	FILE*fp;
	fp=fopen("JUNK.txt","w");//open file
   	P3(fp);
	fclose(fp);//close file
	printf("JUNK.txt is ready\n");
	return 0;
}
void P3(FILE*fp){
	fputs("before fork\n",fp);
	int id=fork();
	if(id==-1){
		perror("Fail to create child\n");
		exit(1);
	}
	else if(id==0){//child process
		int i=0;
		for(i=0;i<10;i++){
			fputs("child\n",fp);//write child into file
		}
	}
	else{//parent process
		int i=0;
		for(i=0;i<10;i++){
			fputs("parent\n",fp);//write parent into file
		}
		
	}
}