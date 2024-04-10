#include "types.h"
#include "stat.h"
#include "user.h"

int main(){
	int p, i;
	p = fork();
	if(p == 0){
		for(i = 0; i < MAX_LOOP; i++){
			printf(1, "child\n");
			yield();
		}
	}
	else{
		for(i = 0; i < MAX_LOOP; i++){

			printf(1, "parent\n");
			yield();
		}
	}
	return 0;
}
