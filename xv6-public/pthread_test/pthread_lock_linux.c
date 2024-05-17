#include <stdio.h>
#include <pthread.h>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>
#define NUM_ITERS 10000
#define NUM_THREADS 10000
#define NUM_TESTS 10

long long shared_resource = 0;
void lock();
void unlock();

volatile int flag = 0;
struct timespec ts;

bool testAndSet(volatile int *target){
	unsigned char ret;
	__asm__ __volatile__(
			"lock; xchg %0, %1"
			: "=r" (ret), "=m" (*target)
			: "0" (1), "m" (*target)
			: "memory"
	);

	return ret != 0;
}

void flagClear(volatile int *target){
	int zero;
	__asm__ __volatile__(
			"lock; xchg %0, %1"
			: "=r" (zero), "=m" (*target)
			: "0" (0), "m" (*target)
			: "memory"
	);
}

void lock()
{
	while(testAndSet(&flag)) { 
		nanosleep(&ts, NULL);		
		continue;
	}
}

void unlock()
{	
	flagClear(&flag);
}

void* thread_func(void* arg) {
    int tid = *(int*)arg;
    
    lock();
    
        for(int i = 0; i < NUM_ITERS; i++) shared_resource++;

    unlock();  

    pthread_exit(NULL);
}

long long test() {
    int n = NUM_THREADS;
		shared_resource = 0;
		pthread_t threads[n];
    int tids[n];
    
    for (int i = 0; i < n; i++) {
        tids[i] = i;
        pthread_create(&threads[i], NULL, thread_func, &tids[i]);
    }
    
    for (int i = 0; i < n; i++) {
        pthread_join(threads[i], NULL);
    }

    
    return shared_resource;
}


int main() {
	long long answer = NUM_THREADS * NUM_ITERS;
	int isfail = 0;

	ts.tv_sec = 0;
	ts.tv_nsec = 10000; // 0.00001 sec 
	
	struct timespec start_time, end_time;
	double elapsed;

	for(int i = 0; i < NUM_TESTS; i++) {
		clock_gettime(CLOCK_MONOTONIC, &start_time);	
	
		long long ret = test();
		clock_gettime(CLOCK_MONOTONIC, &end_time);
		elapsed = (end_time.tv_sec - start_time.tv_sec) + (end_time.tv_nsec - start_time.tv_nsec) / 1e9;
		if(ret != answer){
			printf("[test%d] returned %lld, but expected %lld\n", i+1, ret, answer);
			isfail = 1;
		} else{
			printf("[test%d]: execution time %.6f seconds\n", i+1, elapsed);
		}
	}
	if(!isfail)
		printf("success!!!\n");
	return 0;
}
