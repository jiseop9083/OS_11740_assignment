#include "types.h"
#include "param.h"
#include "mmu.h"
#include "memlayout.h"
#include "defs.h"
#include "proc.h"
#include "procq.h"

// init queue
void 
qinit(struct procq *q, int ispq)
{
	q->st = 0;
	q->en = 0;
	q->ispq = ispq;
}


int 
isempty(struct procq *q)
{
	if(q->st == q->en)
		return 1;
	else 
		return 0;
}

void 
enqueue(struct procq *q, struct proc *p)
{
	if(q->st == (q->en+1) % (NPROC+1))
		panic("queue is full\n");
	if(q->ispq){
		int i;
		int next; 
		for(i = q->st; i != q->en; i = next){
			next = (i+1)%(NPROC+1);
			if(q->que[next]->priority < p->priority){
				break;
			} else{
				q->que[i] = q->que[next];
			}
		}
		q->que[i] = p;
		q->st = (q->st+NPROC)%(NPROC+1);
	}
	else {
		q->en = (q->en+1) % (NPROC+1);
		q->que[q->en] = p;
	}
}


struct proc*
dequeue(struct procq *q){
	if(q->st == q->en)
		panic("queue is empty\n");
	q->st = (q->st+1) % (NPROC+1);
	return q->que[q->st];
}

struct proc*
dequeuewithpid(struct procq *q, int pid){
	if(q->st == q->en)
		panic("queue is empty\n");
	struct proc* p;
	int i;
	int next;
	for(i = q->st; i != q->en; i = next){
		next = (i+1) % (NPROC+1);
		if(q->que[next]->pid == pid){
			i = next;
			next = (i+1) % (NPROC+1);
			break;
		}
	}
	p = q->que[i];
	int j;
	for(j = i; j != q->en; j = next){
		next = (j+1) % (NPROC+1);
		q->que[j] = q->que[next];
	}
	q->en = (q->en+NPROC) % (NPROC+1);
	return p;
}

int 
qsize(struct procq *q){
	if(q->st < q->en)
		return q->en - q->st;
	else
		return q->en + NPROC - q->st;
}

