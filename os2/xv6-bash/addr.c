#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>

static int unint_data;
static int int_data;
static const char const_data[]="hello";

int main(int argc,char**argv,char**env){

   	int x=3;
	char*heap=sbrk(0);

	printf("unint_data: %p\n",&(unint_data));
	printf("int_data: %p\n",&(int_data));

	printf("const_data: %p\n",&(const_data[0]));
	
	printf("const_data: %p\n",&(const_data));
	
	printf("envp: %p\n",&(env[0]));

	printf("argv0: %p\n",&(argv[0]));
	
	printf("stack: %p\n",&x);
	
	printf("argc: %p\n",&argc);
   	
	printf("argv: %p\n",&argv);

	printf("headheap %p\n",heap);

	printf("heap: %p\n",malloc(1));

	printf("text: %p\n",main);

}
