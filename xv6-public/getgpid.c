#include "types.h"
#include "defs.h"
#include "mmu.h"
#include "param.h"
#include "proc.h"

int getgpid() {
	// TODO: implement grand parent process id

	return myproc()->parent->parent->pid;
	//return 0;
}

int sys_getgpid() {
	// TODO: check to exist grand parent
	return getgpid();

}
