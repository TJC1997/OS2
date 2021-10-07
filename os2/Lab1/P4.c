/*Write a C program using fork(). The child process should print “hello” to stdout; the parent
process should print “goodbye” to stdout. Make sure that the child process always prints first.
Can you do this without the parent calling wait() in the parent (and NOT using some big loop in
the parent)?
	I was trying to think some other ways, i found that online said you can use pipe to delay parent's process, but i dont remember how to do it
*/

#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>
#include<stdlib.h>

void P4(){
   	int id=fork();
	if(id==-1){
		perror("Fail to create child\n");
		exit(1);
	}
	else if(id==0){//child
		printf("hello\n");
	}
	else{//parent
	   	int status;
		id=wait(&status);//wait for child to finish
		printf("goodbye\n");
	}
}

int main(){
   	P4();	
	return 0;

}
