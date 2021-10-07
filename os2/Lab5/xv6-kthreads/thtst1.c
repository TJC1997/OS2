#include "types.h"
#include "stat.h"
#include "user.h"
#include "benny_thread.h"

#ifdef KTHREADS
void func1(void *arg);

static int global = 10;

#define IVAL 0x0f0f0f0f
#define FVAL 0Xaeaeaeae

void 
func1(void *arg)
{
    int *i = (int *) ((int *) arg);

    printf(1, "%s %d\n", __FILE__, __LINE__);
    assert(global == 10);
    assert(*i == IVAL);

    printf(1, "%s %d\n", __FILE__, __LINE__);

    // modify the global memory value and the value through the
    // pointer passed to the thread function.
    *i = FVAL;
    global = 100;

    // ta ta for now.
    printf(1, "%s %d\n", __FILE__, __LINE__);
    benny_thread_exit(3);
}
#endif // KTHREADS


int
main(int argc, char **argv)
{
#ifdef KTHREADS
    benny_thread_t bt = NULL;
    int rez = -1;
    int i = IVAL;
    
    printf(1, "global before: %d\n", global);
    printf(1, "i before     : %x\n", i);
    // create the new thread.
    rez = benny_thread_create(&bt, func1, &i);

    sleep(2);

    printf(1, "rez          : %x\n", rez);

    // join back with the thread. this is a blocking call.
    rez = benny_thread_join(bt);

    // once the thread has koined back with the main thread, the values
    // should reflect the changes made within the thread.
    printf(1, "global after : %d\n", global);
    printf(1, "i after      : %x\n", i);
    printf(1, "rez          : %d\n", rez);
    assert(global == 100);
    assert(rez == 0);
    assert(i == FVAL);
#endif // KTHREADS

    exit();
}
