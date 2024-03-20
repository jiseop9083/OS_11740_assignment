#include "types.h"
#include "stat.h"
#include "user.h"


int main() {
	printf(1, "My student id is 2020052633\n");
	printf(1, "My pid is %d\n", getpid());
	printf(1, "My gpid is %d\n", getgpid());

	return 0;
}
