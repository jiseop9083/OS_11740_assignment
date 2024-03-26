#include "types.h"
#include "defs.h"
#include "mmu.h"
#include "param.h"
#include "proc.h"

int getgpid() {
	if(myproc()->pid == 1 || myproc()->parent->pid == 1)
		return -1;
	return myproc()->parent->parent->pid;
}

int sys_getgpid() {
	return getgpid();

}
