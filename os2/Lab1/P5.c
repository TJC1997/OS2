/*Write a C program that calls fork() and then the child process calls each of the following exec()
functions to run the program “ls -l -F -h”: execl(), execlp(), execv(), and
execvp(). The parent process must wait until the child process is complete before it exits.
Describe the differences of the exec functions in your code as comments.

*/

#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>
#include<stdlib.h>

void P5(){
   	int id=fork();
	if(id==-1){
		perror("Fail to create child\n");
		exit(1);
	}
	else if(id==0){//child
		char* argv[]={"ls","-l","-F","-h",(char*)0};
		if(execl("/bin/ls","ls","-l","-F","-h",(char*)0)<0){
			perror("Fail\n");
			exit(1);
		} // l represent that a list of command line arguments is given, you need to pass command one by one insted of all in one vector
	
		if(execlp("ls","ls","-l","-F","-h",(char*)0)<0){
			perror("Fail\n");
			exit(1);
		}; //mostly same with execl but p represnet that PATH will be searched for the executable
	
		if(execv("/bin/ls",argv)<0){
			perror("Fail\n");
			exit(1);
		} //v means that a list of command line arguemtns will be pass in a vector
	
		if(execvp(argv[0],argv)<0){
			perror("Fail\n");
			exit(1);
		} //most same with execv but p represnet that PATH will be searched for the executable
	}
	else{//parent process
	   	int status;
		id=wait(&status);
	}
}

int main(){
   	P5();	
	return 0;
}
