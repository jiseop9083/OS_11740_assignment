#include "types.h"
#include "stat.h"
#include "user.h"

int parent;

int fork_children(){
	int p;
	if((p = fork()) == 0){
		sleep(10);
		return getpid();
	}
	return parent;
}

void exit_children()
{
	if(getpid() != parent)
		exit();
	while(wait() != -1);
}

int main(){
	int i,pid;
	parent = getpid();
	pid = fork_children();
	if(pid != parent)
		{
			for(i = 0; i < 10; i++){
				printf(1, "hello\n");
			}

		} else {
			for(i = 0; i < 5; i++){
				printf(1, "hello\n");
			}
			exit();
		}
	exit_children();

	exit();
}
