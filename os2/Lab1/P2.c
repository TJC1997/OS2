/*Write a C program that calls fork(). Before calling fork(), have the parent process assign the
value 100 to int called xx. What value is the value of xx in the child process? Have the parent
process assign the value 999 to xx and have the child process assign the value 777 to xx. What
happens to xx variable when both the child and parent change the value of xx? Have both
processes print the value of xx.

What value is the value of xx in the child process? 100
What happens to xx variable when both the child and parent change the value of xx? 
	child is 777, parent is 999. fork() will copy the variable. So parent and child has different memory for xx.
*/

#include<stdio.h>
#include<stdlib.h>
#include<sys/types.h>
#include<unistd.h>

void P2(){
	int xx=100;
	int id=fork();
	if(id==-1){
		perror("Fail to create child\n");
		exit(1);
	}	
	else if(id==0){//child process
	   	printf("Right after fork,child is %d\n",xx);
		xx=777;//assign 777 to xx in child process
	}
	else{//parent process
		xx=999;//assign 999 to xx in parent process
	}
	printf("%d\n",xx);
	exit(0);
}

int main(){
   	P2();
	return 0;


}
