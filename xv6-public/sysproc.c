#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int 
sys_getlev(void)
{
  return myproc()->qlev;
}

int
sys_setpriority(void)
{
  int pid;
  int priority;
  if(argint(0, &pid) < 0)
    return -1;
  argint(1, &priority);
  if(priority < 0 || priority > 10)
    return -2;
  return setpriority(pid, priority);
}

int
sys_setmonopoly(void)
{
  int pid;
  int password;
  if(argint(0, &pid) < 0)
		return -1;
  if(argint(1, &password) < 0)
		return -1;
  if(password != 2020052633)
		return -2;
  if(myproc()->pid == pid)
		return -4;
  return setmonopoly(pid, password);

}

void
sys_monopolize(void)
{
  monopolize();
  return;
}

void
sys_unmonopolize(void)
{
  unmonopolize();
  return;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

void
sys_yield(void){
	yield();
	return;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
