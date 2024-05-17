

// process queue
// Do not use zero index for convenience of implement
struct procq {
	struct proc* que[NPROC+1];
	int st; // start point
	int en; // end point
	int ispq; // is priority queue
};

