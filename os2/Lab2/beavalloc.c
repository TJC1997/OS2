#include <stddef.h>
#include <stdint.h>
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <string.h>
#include <sys/types.h>
#include <stdbool.h>
#include "beavalloc.h"


#define maxSize 1024

struct LS{
    struct LS* prev;
    struct LS* next;
    int maxCapacity;
    bool free;
    void* data;
};

void calMem(void);

struct LS* head=NULL;
struct LS* prev=NULL;
struct LS* iter=NULL;
struct LS* move=NULL;
int structSize=sizeof(struct LS);
void*begin=NULL;
void*top_block=NULL;
void*status=NULL;
int memory_Capacity=0;
int used_Memory=0; //including both data memory and struct memory
int empty_Memory=0;
struct LS* newBlock=NULL;
uint8_t isVerbose = FALSE;
int numOfBlock=0;
int totalsize=0;

void calMem(void){
    move=head;
    numOfBlock=0;
    while(move!=NULL){
        numOfBlock++;
        move=move->next;
    }
}

// The basic memory allocator.
// If you pass NULL or 0, then NULL is returned.
// If, for some reason, the system cannot allocate the requested
//   memory, set errno to ENOMEM and return NULL.
// You must use sbrk() or brk() in requesting more memory for your
//   beavalloc() routine to manage.
// When calling sbrk() for more memory, always request 1024 bytes. It
//   is best if you use a macro for this value, in case it needs to change.
void *beavalloc(size_t size){

    if(isVerbose){
            fprintf(stderr, "Request to allocate a memory block with size of %zu\n",size);
    }

    if(size<=0){
        return NULL;
    }
    if(begin==NULL){  //first time
        begin=sbrk(0);   
        top_block=begin;
        status=(void*)sbrk(maxSize);                //initialize the memory

        if(status==(void*)-1){     //error when i initialize the memory
            errno = ENOMEM;  
            return NULL;
        }
        memory_Capacity=maxSize;
        used_Memory=0;
        empty_Memory=maxSize;
        if(isVerbose){
            fprintf(stderr, "first time to allocate memory\n");
            fprintf(stderr, "The base is %p\n",begin);
        }
    }
    totalsize=size+structSize;
    if(head!=NULL){
        iter=head;
        while(iter!=NULL){

            if(iter->free==true&&iter->maxCapacity>totalsize){ //if we find a free block that is big enough 
                newBlock=(void*)iter+structSize+size;
                newBlock->free=true;
                newBlock->data=(void*)newBlock+structSize;
                newBlock->maxCapacity=iter->maxCapacity-totalsize;
                newBlock->prev=iter;
                newBlock->next=iter->next;
                if(newBlock->next!=NULL){
                    newBlock->next->prev=newBlock;
                }
                iter->next=newBlock;
                iter->free=false;
                iter->maxCapacity=size;
                if(isVerbose){
                    fprintf(stderr, "we found a exist block to store memory and split it to 2 parts\n");
                }
                return iter->data;            
            }
            iter=iter->next;
        }
    }

    //if we dont find any exist block which can store the size
    // printf("empty mem: %d\n",empty_Memory);
    // printf("total size: %d\n",totalsize);
    while(empty_Memory<totalsize){  //if we dont have enough memory
        status=(void*)sbrk(maxSize);                //initialize the memory
        if(status==(void*)-1){     //error when i initialize the memory
            errno = ENOMEM;  
            return NULL;
        }
        memory_Capacity=memory_Capacity+maxSize;
        empty_Memory=empty_Memory+maxSize;
    }

    newBlock=(struct LS*)top_block;
    newBlock->free=false;
    newBlock->maxCapacity=size;
    newBlock->data=(void*)newBlock+structSize;
    newBlock->next=NULL;
    if(head==NULL){
        newBlock->prev=NULL;
        head=newBlock;
        prev=newBlock;
    }
    else
    {
        newBlock->prev=prev;
        prev->next=newBlock;
        prev=newBlock;
    }
    top_block=(void*)top_block+totalsize;

    used_Memory=used_Memory+structSize+size;
    empty_Memory=memory_Capacity-used_Memory;

    if(isVerbose){
        fprintf(stderr, "we made a new block to store data\n");
    }

    return newBlock->data;
}


// A pointer returned from a previous call to beavalloc() must
//   be passed.
// If a pointer is passed to a block than is already free, 
//   simply return.
// If NULL is passed, just return.
// Blocks must be coalesced, where possible, as they are free'ed.
void beavfree(void *ptr){
    struct LS* LSptr;
    struct LS* nextBlock;
    struct LS* lastBlock;
    struct LS* beforeNull;
    int currentMaxMem;
    if(isVerbose){
        fprintf(stderr, "Free request come in and the pointer address is %p\n",ptr);
    }
    if(ptr==NULL){
        if(isVerbose){
            fprintf(stderr, "It's a null pointer and we cannot free it\n");
        }
        return;
    }
    LSptr=ptr;
    LSptr=(void*)LSptr-structSize;
    if(LSptr->free==true){
        if(isVerbose){
            fprintf(stderr, "We have already free it\n");
        }
        return;
    }
    else{
        LSptr->free=true;
        nextBlock=LSptr->next;
        
        while(nextBlock!=NULL&&nextBlock->free==true){
            LSptr->maxCapacity=LSptr->maxCapacity+nextBlock->maxCapacity+structSize;
            
            nextBlock=nextBlock->next;
            
        }
        LSptr->next=nextBlock;
        if(LSptr->next!=NULL){
            LSptr->next->prev=LSptr;
        }

        
        lastBlock=LSptr->prev;
        if(lastBlock!=NULL&& lastBlock->free==true){
            currentMaxMem=LSptr->maxCapacity;
            while(lastBlock!=NULL && lastBlock->free==true){
                currentMaxMem=currentMaxMem+structSize+lastBlock->maxCapacity;
                beforeNull=lastBlock;
                lastBlock=lastBlock->prev;
            }
            if(lastBlock==NULL){
                lastBlock=beforeNull;
            }
            lastBlock->next=LSptr->next;
            lastBlock->maxCapacity=currentMaxMem;
            if(lastBlock->next!=NULL){
                lastBlock->next->prev=lastBlock;
            }
        }
        if(isVerbose){
            fprintf(stderr, "we free it successfully and coalsec blocks\n");
        }
        return;
    }

}

// Completely reset your heap back to zero bytes allocated.
// You are going to like being able to do this.
// Implementation can be done in as few as 1 line, though
//   you will probably use more to reset the stats you keep
//   about heap.
// After you've called this function, everything you had in
//   the heap is just __GONE__!!!
// You should be able to call beavalloc() after calling beavalloc_reset()
//   to restart building the heap again.
void beavalloc_reset(void){
    brk(begin);
    head=NULL;
    prev=NULL;
    iter=NULL;
    begin=NULL;
    top_block=NULL;
    status=NULL;
    memory_Capacity=0;
    used_Memory=0; //including both data memory and struct memory
    empty_Memory=0;
    newBlock=NULL;
    isVerbose = FALSE;
    numOfBlock=0;
    totalsize=0;

    if(isVerbose){
            fprintf(stderr, "reset successfully\n");
    }
}

// Set the verbosity of your beavalloc() code (and related functions).
// This should modify a variable that is static to your C module.
void beavalloc_set_verbose(uint8_t ver){
    isVerbose=ver;
    if(ver==true){
        fprintf(stderr, "verbose is on!!!!!!!\n\n\n\n\n\n\n");
    }
    else
    {
        fprintf(stderr, "verbose is off!!!!!!!\n\n\n\n\n\n\n");
    }
    
}

void *beavcalloc(size_t nmemb, size_t size){
    struct LS*ptr;
    totalsize=nmemb*size;
    if(totalsize==0){
        return NULL;
    }
    else{
        ptr=beavalloc(totalsize);
        memset(ptr,0,totalsize);
        return ptr;
    }
}
void *beavrealloc(void *ptr, size_t size){
    struct LS* oldLSptr;
    struct LS* newLSptr;

    oldLSptr=ptr;
    if(size==0){
        return NULL;
    }
    if(oldLSptr==NULL){
        oldLSptr=beavalloc(size);
        return oldLSptr;
    }
    else{
        oldLSptr=(void*)ptr-32;
        if(oldLSptr->maxCapacity>=size){
            return oldLSptr->data;
        }
        else{
            newLSptr=beavalloc(size)-32;
            oldLSptr=(void*)ptr-32;
            memcpy(newLSptr->data,oldLSptr->data,oldLSptr->maxCapacity);
            //
            //beavfree(oldLSptr);
            oldLSptr->free=true;
            return (void*)newLSptr+32;
        }
    }

    
   // memccpy(newLSptr->data,oldLSptr->data,)
}

void beavalloc_dump(uint leaks_only)
{
    struct LS *curr = NULL;
    uint i = 0;
    uint leak_count = 0;
    uint user_bytes = 0;
    uint capacity_bytes = 0;
    uint block_bytes = 0;
    uint used_blocks = 0;
    uint free_blocks = 0;
    calMem();

   // printf("MEM cap: %d\n",memory_Capacity);

    if (leaks_only) {
        fprintf(stderr, "heap lost blocks\n");
    }
    else {
        fprintf(stderr, "heap map\n");
    }
    fprintf(stderr
            , "  %s\t%s\t%s\t%s\t%s" 
            "\t%s\t%s\t%s\t%s\t%s\t%s"
            "\n"
            , "blk no  "
            , "block add "
            , "next add  "
            , "prev add  "
            , "data add  "
            
            , "blk off  "
            , "dat off  "
            , "capacity "
            , "size     "
            , "blk size "
            , "status   "
        );
    for (curr = head, i = 0; curr != NULL; curr = curr->next, i++) {
        if (leaks_only == FALSE || (leaks_only == TRUE && curr->free == FALSE)) {
            fprintf(stderr
                    , "  %u\t\t%9p\t%9p\t%9p\t%9p\t%u\t\t%u\t\t"
                      "%u\t\t%u\t\t%u\t\t%s\t%c\n"
                    , i
                    , curr
                    , curr->next
                    , curr->prev
                    , curr->data
                    , (unsigned) ((void *) curr - begin)
                    , (unsigned) ((void *) curr->data - begin)
                    , (unsigned) empty_Memory //capacity
                    , (unsigned) curr->maxCapacity          //size
                    , (unsigned) memory_Capacity               //blk size
                    , curr->free ? "free  " : "in use"
                    , curr->free ? '*' : ' '
                );
            user_bytes += curr->maxCapacity;
            capacity_bytes += empty_Memory;
            block_bytes +=  memory_Capacity;
            if (curr->free == FALSE && leaks_only == TRUE) {
                leak_count++;
            }
            if (curr->free == TRUE) {
                free_blocks++;
            }
            else {
                used_blocks++;
            }
        }
    }
    if (leaks_only) {
        if (leak_count == 0) {
            fprintf(stderr, "  *** No leaks found!!! That does NOT mean no leaks are possible. ***\n");
        }
        else {
            fprintf(stderr
                    , "  %s\t\t\t\t\t\t\t\t\t\t\t\t"
                      "%u\t\t%u\t\t%u\n"
                    , "Total bytes lost"
                    , capacity_bytes
                    , user_bytes
                    , block_bytes
                );
        }
    }
    else {
        fprintf(stderr
                , "  %s\t\t\t\t\t\t\t\t\t\t\t\t"
                "%u\t\t%u\t\t%u\n"
                , "Total bytes used"
                , capacity_bytes
                , user_bytes
                , block_bytes
            );
        fprintf(stderr, "  Used blocks: %u  Free blocks: %u  "
             "Min heap: %p    Max heap: %p\n"
               , used_blocks, free_blocks
               , begin, top_block
            );
    }
}