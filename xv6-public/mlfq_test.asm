
_mlfq_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
		exit();
	while(wait() != -1);
}

int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	56                   	push   %esi
  12:	53                   	push   %ebx
  13:	51                   	push   %ecx
  14:	83 ec 2c             	sub    $0x2c,%esp
	int i, pid;
	int count[MAX_LEVEL] = {0};
  17:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  1e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  25:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  2c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  33:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	parent = getpid();
  3a:	e8 74 07 00 00       	call   7b3 <getpid>

	printf(1, "MLFQ test start\n");
  3f:	83 ec 08             	sub    $0x8,%esp
  42:	68 5a 0c 00 00       	push   $0xc5a
  47:	6a 01                	push   $0x1
	parent = getpid();
  49:	a3 c4 10 00 00       	mov    %eax,0x10c4
	printf(1, "MLFQ test start\n");
  4e:	e8 6d 08 00 00       	call   8c0 <printf>

	printf(1, "[Test 1] default\n");
  53:	5e                   	pop    %esi
  54:	58                   	pop    %eax
  55:	68 6b 0c 00 00       	push   $0xc6b
  5a:	6a 01                	push   $0x1
  5c:	e8 5f 08 00 00       	call   8c0 <printf>
	pid = fork_children();
  61:	e8 ca 02 00 00       	call   330 <fork_children>

	if(pid != parent)
  66:	83 c4 10             	add    $0x10,%esp
  69:	39 05 c4 10 00 00    	cmp    %eax,0x10c4
  6f:	74 79                	je     ea <main+0xea>
  71:	89 c6                	mov    %eax,%esi
  73:	bb 10 27 00 00       	mov    $0x2710,%ebx
  78:	eb 18                	jmp    92 <main+0x92>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for(i = 0; i < NUM_LOOP; i++)
		{
			int x = getlev();
			if(x < 0 || x > 3)
			{
				if(x != 99){
  80:	83 f8 63             	cmp    $0x63,%eax
  83:	0f 85 c7 00 00 00    	jne    150 <main+0x150>
					printf(1, "Wrong level: %d\n", x);
					exit();
				}
			}
			if(x == 99) count[4]++;
  89:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
		for(i = 0; i < NUM_LOOP; i++)
  8d:	83 eb 01             	sub    $0x1,%ebx
  90:	74 14                	je     a6 <main+0xa6>
			int x = getlev();
  92:	e8 44 07 00 00       	call   7db <getlev>
			if(x < 0 || x > 3)
  97:	83 f8 03             	cmp    $0x3,%eax
  9a:	77 e4                	ja     80 <main+0x80>
			else count[x]++;
  9c:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
		for(i = 0; i < NUM_LOOP; i++)
  a1:	83 eb 01             	sub    $0x1,%ebx
  a4:	75 ec                	jne    92 <main+0x92>
		}
		printf(1, "Process %d\n", pid);
  a6:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
  a7:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
  a9:	56                   	push   %esi
  aa:	8d 75 d4             	lea    -0x2c(%ebp),%esi
  ad:	68 8e 0c 00 00       	push   $0xc8e
  b2:	6a 01                	push   $0x1
  b4:	e8 07 08 00 00       	call   8c0 <printf>
  b9:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
  bc:	ff 34 9e             	pushl  (%esi,%ebx,4)
  bf:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
  c0:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
  c3:	68 9a 0c 00 00       	push   $0xc9a
  c8:	6a 01                	push   $0x1
  ca:	e8 f1 07 00 00       	call   8c0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
  cf:	83 c4 10             	add    $0x10,%esp
  d2:	83 fb 04             	cmp    $0x4,%ebx
  d5:	75 e5                	jne    bc <main+0xbc>
		printf(1, "MoQ: %d\n", count[4]);
  d7:	51                   	push   %ecx
  d8:	ff 75 e4             	pushl  -0x1c(%ebp)
  db:	68 a3 0c 00 00       	push   $0xca3
  e0:	6a 01                	push   $0x1
  e2:	e8 d9 07 00 00       	call   8c0 <printf>
  e7:	83 c4 10             	add    $0x10,%esp
	}
	exit_children();
  ea:	e8 a1 03 00 00       	call   490 <exit_children>
	printf(1, "[Test 1] finished\n");
  ef:	56                   	push   %esi
  f0:	56                   	push   %esi
  f1:	68 ac 0c 00 00       	push   $0xcac
  f6:	6a 01                	push   $0x1
  f8:	e8 c3 07 00 00       	call   8c0 <printf>

	printf(1, "[Test 2] priorities\n");
  fd:	58                   	pop    %eax
  fe:	5a                   	pop    %edx
  ff:	68 bf 0c 00 00       	push   $0xcbf
 104:	6a 01                	push   $0x1
 106:	e8 b5 07 00 00       	call   8c0 <printf>
	pid = fork_children2();
 10b:	e8 70 02 00 00       	call   380 <fork_children2>

	if(pid != parent)
 110:	83 c4 10             	add    $0x10,%esp
	pid = fork_children2();
 113:	89 c6                	mov    %eax,%esi
	if(pid != parent)
 115:	39 05 c4 10 00 00    	cmp    %eax,0x10c4
 11b:	0f 84 88 00 00 00    	je     1a9 <main+0x1a9>
 121:	bb 10 27 00 00       	mov    $0x2710,%ebx
 126:	eb 16                	jmp    13e <main+0x13e>
 128:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12f:	90                   	nop
		for(i = 0; i < NUM_LOOP; i++)
		{
			int x = getlev();
			if(x < 0 || x > 3)
			{
				if(x != 99){
 130:	83 f8 63             	cmp    $0x63,%eax
 133:	75 1b                	jne    150 <main+0x150>
					printf(1, "Wrong level: %d\n", x);
					exit();
				}
			}
			if(x == 99) count[4]++;
 135:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
		for(i = 0; i < NUM_LOOP; i++)
 139:	83 eb 01             	sub    $0x1,%ebx
 13c:	74 27                	je     165 <main+0x165>
			int x = getlev();
 13e:	e8 98 06 00 00       	call   7db <getlev>
			if(x < 0 || x > 3)
 143:	83 f8 03             	cmp    $0x3,%eax
 146:	77 e8                	ja     130 <main+0x130>
			else count[x]++;
 148:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
 14d:	eb ea                	jmp    139 <main+0x139>
 14f:	90                   	nop
			int x = getlev();
			if(x < 0 || x > 3)
			{
				if(x != 99)
				{
					printf(1, "Wrong level: %d\n", x);
 150:	83 ec 04             	sub    $0x4,%esp
 153:	50                   	push   %eax
 154:	68 7d 0c 00 00       	push   $0xc7d
 159:	6a 01                	push   $0x1
 15b:	e8 60 07 00 00       	call   8c0 <printf>
					exit();
 160:	e8 ce 05 00 00       	call   733 <exit>
		printf(1, "Process %d\n", pid);
 165:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 166:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
 168:	56                   	push   %esi
 169:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 16c:	68 8e 0c 00 00       	push   $0xc8e
 171:	6a 01                	push   $0x1
 173:	e8 48 07 00 00       	call   8c0 <printf>
 178:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
 17b:	ff 34 9e             	pushl  (%esi,%ebx,4)
 17e:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 17f:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
 182:	68 9a 0c 00 00       	push   $0xc9a
 187:	6a 01                	push   $0x1
 189:	e8 32 07 00 00       	call   8c0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
 18e:	83 c4 10             	add    $0x10,%esp
 191:	83 fb 04             	cmp    $0x4,%ebx
 194:	75 e5                	jne    17b <main+0x17b>
		printf(1, "MoQ: %d\n", count[4]);
 196:	51                   	push   %ecx
 197:	ff 75 e4             	pushl  -0x1c(%ebp)
 19a:	68 a3 0c 00 00       	push   $0xca3
 19f:	6a 01                	push   $0x1
 1a1:	e8 1a 07 00 00       	call   8c0 <printf>
 1a6:	83 c4 10             	add    $0x10,%esp
	exit_children();
 1a9:	e8 e2 02 00 00       	call   490 <exit_children>
	printf(1, "[Test 2] finished\n");
 1ae:	50                   	push   %eax
 1af:	50                   	push   %eax
 1b0:	68 d4 0c 00 00       	push   $0xcd4
 1b5:	6a 01                	push   $0x1
 1b7:	e8 04 07 00 00       	call   8c0 <printf>
	printf(1, "[Test 3] sleep\n");
 1bc:	58                   	pop    %eax
 1bd:	5a                   	pop    %edx
 1be:	68 e7 0c 00 00       	push   $0xce7
 1c3:	6a 01                	push   $0x1
 1c5:	e8 f6 06 00 00       	call   8c0 <printf>
	pid = fork_children2();
 1ca:	e8 b1 01 00 00       	call   380 <fork_children2>
	if(pid != parent)
 1cf:	83 c4 10             	add    $0x10,%esp
	pid = fork_children2();
 1d2:	89 c6                	mov    %eax,%esi
	if(pid != parent)
 1d4:	39 05 c4 10 00 00    	cmp    %eax,0x10c4
 1da:	0f 84 84 00 00 00    	je     264 <main+0x264>
 1e0:	bb f4 01 00 00       	mov    $0x1f4,%ebx
 1e5:	eb 28                	jmp    20f <main+0x20f>
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax
				if(x != 99){
 1f0:	83 f8 63             	cmp    $0x63,%eax
 1f3:	0f 85 57 ff ff ff    	jne    150 <main+0x150>
			if(x == 99) count[4]++;
 1f9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
			sleep(1);
 1fd:	83 ec 0c             	sub    $0xc,%esp
 200:	6a 01                	push   $0x1
 202:	e8 bc 05 00 00       	call   7c3 <sleep>
		for(i = 0; i < NUM_SLEEP; i++)
 207:	83 c4 10             	add    $0x10,%esp
 20a:	83 eb 01             	sub    $0x1,%ebx
 20d:	74 11                	je     220 <main+0x220>
			int x = getlev();
 20f:	e8 c7 05 00 00       	call   7db <getlev>
			if(x < 0 || x > 3)
 214:	83 f8 03             	cmp    $0x3,%eax
 217:	77 d7                	ja     1f0 <main+0x1f0>
			else count[x]++;
 219:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
 21e:	eb dd                	jmp    1fd <main+0x1fd>
		printf(1, "Process %d\n", pid);
 220:	50                   	push   %eax
		for(i = 0; i < MAX_LEVEL - 1; i++)
 221:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
 223:	56                   	push   %esi
 224:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 227:	68 8e 0c 00 00       	push   $0xc8e
 22c:	6a 01                	push   $0x1
 22e:	e8 8d 06 00 00       	call   8c0 <printf>
 233:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
 236:	ff 34 9e             	pushl  (%esi,%ebx,4)
 239:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 23a:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
 23d:	68 9a 0c 00 00       	push   $0xc9a
 242:	6a 01                	push   $0x1
 244:	e8 77 06 00 00       	call   8c0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
 249:	83 c4 10             	add    $0x10,%esp
 24c:	83 fb 04             	cmp    $0x4,%ebx
 24f:	75 e5                	jne    236 <main+0x236>
		printf(1, "MoQ: %d\n", count[4]);
 251:	50                   	push   %eax
 252:	ff 75 e4             	pushl  -0x1c(%ebp)
 255:	68 a3 0c 00 00       	push   $0xca3
 25a:	6a 01                	push   $0x1
 25c:	e8 5f 06 00 00       	call   8c0 <printf>
 261:	83 c4 10             	add    $0x10,%esp
	exit_children();
 264:	e8 27 02 00 00       	call   490 <exit_children>
	printf(1, "[Test 3] finished\n");
 269:	53                   	push   %ebx
 26a:	53                   	push   %ebx
 26b:	68 f7 0c 00 00       	push   $0xcf7
 270:	6a 01                	push   $0x1
 272:	e8 49 06 00 00       	call   8c0 <printf>
	printf(1, "[Test 4] MoQ\n");
 277:	5e                   	pop    %esi
 278:	58                   	pop    %eax
 279:	68 0a 0d 00 00       	push   $0xd0a
 27e:	6a 01                	push   $0x1
 280:	e8 3b 06 00 00       	call   8c0 <printf>
	pid = fork_children3();
 285:	e8 66 01 00 00       	call   3f0 <fork_children3>
	if(pid != parent)
 28a:	83 c4 10             	add    $0x10,%esp
	pid = fork_children3();
 28d:	89 c6                	mov    %eax,%esi
	if(pid != parent)
 28f:	39 05 c4 10 00 00    	cmp    %eax,0x10c4
 295:	74 7b                	je     312 <main+0x312>
		if(pid == 36)
 297:	bb 10 27 00 00       	mov    $0x2710,%ebx
 29c:	83 f8 24             	cmp    $0x24,%eax
 29f:	75 1c                	jne    2bd <main+0x2bd>
			monopolize();
 2a1:	e8 4d 05 00 00       	call   7f3 <monopolize>
			exit();
 2a6:	e8 88 04 00 00       	call   733 <exit>
				if(x != 99)
 2ab:	83 f8 63             	cmp    $0x63,%eax
 2ae:	0f 85 9c fe ff ff    	jne    150 <main+0x150>
				}
			}
			if(x == 99) count[4]++;
 2b4:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
		for(i = 0; i < NUM_LOOP; i++)
 2b8:	83 eb 01             	sub    $0x1,%ebx
 2bb:	74 11                	je     2ce <main+0x2ce>
			int x = getlev();
 2bd:	e8 19 05 00 00       	call   7db <getlev>
			if(x < 0 || x > 3)
 2c2:	83 f8 03             	cmp    $0x3,%eax
 2c5:	77 e4                	ja     2ab <main+0x2ab>
			else count[x]++;
 2c7:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
 2cc:	eb ea                	jmp    2b8 <main+0x2b8>
		}
		printf(1, "Process %d\n", pid);
 2ce:	51                   	push   %ecx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 2cf:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
 2d1:	56                   	push   %esi
 2d2:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 2d5:	68 8e 0c 00 00       	push   $0xc8e
 2da:	6a 01                	push   $0x1
 2dc:	e8 df 05 00 00       	call   8c0 <printf>
 2e1:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
 2e4:	ff 34 9e             	pushl  (%esi,%ebx,4)
 2e7:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 2e8:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
 2eb:	68 9a 0c 00 00       	push   $0xc9a
 2f0:	6a 01                	push   $0x1
 2f2:	e8 c9 05 00 00       	call   8c0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
 2f7:	83 c4 10             	add    $0x10,%esp
 2fa:	83 fb 04             	cmp    $0x4,%ebx
 2fd:	75 e5                	jne    2e4 <main+0x2e4>
		printf(1, "MoQ: %d\n", count[4]);
 2ff:	52                   	push   %edx
 300:	ff 75 e4             	pushl  -0x1c(%ebp)
 303:	68 a3 0c 00 00       	push   $0xca3
 308:	6a 01                	push   $0x1
 30a:	e8 b1 05 00 00       	call   8c0 <printf>
 30f:	83 c4 10             	add    $0x10,%esp
	}
	exit_children();
 312:	e8 79 01 00 00       	call   490 <exit_children>
	printf(1, "[Test 4] finished\n");
 317:	50                   	push   %eax
 318:	50                   	push   %eax
 319:	68 18 0d 00 00       	push   $0xd18
 31e:	6a 01                	push   $0x1
 320:	e8 9b 05 00 00       	call   8c0 <printf>

	exit();
 325:	e8 09 04 00 00       	call   733 <exit>
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <fork_children>:
{
 330:	f3 0f 1e fb          	endbr32 
 334:	55                   	push   %ebp
 335:	89 e5                	mov    %esp,%ebp
 337:	53                   	push   %ebx
 338:	bb 08 00 00 00       	mov    $0x8,%ebx
 33d:	83 ec 04             	sub    $0x4,%esp
		if((p = fork()) == 0)
 340:	e8 e6 03 00 00       	call   72b <fork>
 345:	85 c0                	test   %eax,%eax
 347:	74 17                	je     360 <fork_children+0x30>
	for(i = 0; i < NUM_THREAD; i++)
 349:	83 eb 01             	sub    $0x1,%ebx
 34c:	75 f2                	jne    340 <fork_children+0x10>
}
 34e:	a1 c4 10 00 00       	mov    0x10c4,%eax
 353:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 356:	c9                   	leave  
 357:	c3                   	ret    
 358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop
			sleep(10);
 360:	83 ec 0c             	sub    $0xc,%esp
 363:	6a 0a                	push   $0xa
 365:	e8 59 04 00 00       	call   7c3 <sleep>
}
 36a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
			return getpid();
 36d:	83 c4 10             	add    $0x10,%esp
}
 370:	c9                   	leave  
			return getpid();
 371:	e9 3d 04 00 00       	jmp    7b3 <getpid>
 376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi

00000380 <fork_children2>:
{
 380:	f3 0f 1e fb          	endbr32 
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	53                   	push   %ebx
	for(i = 0; i < NUM_THREAD; i++)
 388:	31 db                	xor    %ebx,%ebx
{
 38a:	83 ec 04             	sub    $0x4,%esp
 38d:	8d 76 00             	lea    0x0(%esi),%esi
		if((p = fork()) == 0)
 390:	e8 96 03 00 00       	call   72b <fork>
 395:	85 c0                	test   %eax,%eax
 397:	74 27                	je     3c0 <fork_children2+0x40>
			int r = setpriority(p, i + 1);
 399:	83 ec 08             	sub    $0x8,%esp
 39c:	83 c3 01             	add    $0x1,%ebx
 39f:	53                   	push   %ebx
 3a0:	50                   	push   %eax
 3a1:	e8 3d 04 00 00       	call   7e3 <setpriority>
			if(r < 0)
 3a6:	83 c4 10             	add    $0x10,%esp
 3a9:	85 c0                	test   %eax,%eax
 3ab:	78 29                	js     3d6 <fork_children2+0x56>
	for(i = 0; i < NUM_THREAD; i++)
 3ad:	83 fb 08             	cmp    $0x8,%ebx
 3b0:	75 de                	jne    390 <fork_children2+0x10>
}
 3b2:	a1 c4 10 00 00       	mov    0x10c4,%eax
 3b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ba:	c9                   	leave  
 3bb:	c3                   	ret    
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			sleep(10);
 3c0:	83 ec 0c             	sub    $0xc,%esp
 3c3:	6a 0a                	push   $0xa
 3c5:	e8 f9 03 00 00       	call   7c3 <sleep>
}
 3ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
			return getpid();
 3cd:	83 c4 10             	add    $0x10,%esp
}
 3d0:	c9                   	leave  
			return getpid();
 3d1:	e9 dd 03 00 00       	jmp    7b3 <getpid>
				printf(1, "setpriority returned %d\n", r);
 3d6:	83 ec 04             	sub    $0x4,%esp
 3d9:	50                   	push   %eax
 3da:	68 28 0c 00 00       	push   $0xc28
 3df:	6a 01                	push   $0x1
 3e1:	e8 da 04 00 00       	call   8c0 <printf>
				exit();
 3e6:	e8 48 03 00 00       	call   733 <exit>
 3eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3ef:	90                   	nop

000003f0 <fork_children3>:
{
 3f0:	f3 0f 1e fb          	endbr32 
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	56                   	push   %esi
 3f8:	53                   	push   %ebx
 3f9:	bb 09 00 00 00       	mov    $0x9,%ebx
 3fe:	eb 05                	jmp    405 <fork_children3+0x15>
	for(i = 0; i <= NUM_THREAD; i++){
 400:	83 eb 01             	sub    $0x1,%ebx
 403:	74 5b                	je     460 <fork_children3+0x70>
		if((p = fork()) == 0)
 405:	e8 21 03 00 00       	call   72b <fork>
 40a:	85 c0                	test   %eax,%eax
 40c:	74 62                	je     470 <fork_children3+0x80>
			if(p % 2 == 1)
 40e:	89 c1                	mov    %eax,%ecx
 410:	c1 e9 1f             	shr    $0x1f,%ecx
 413:	8d 14 08             	lea    (%eax,%ecx,1),%edx
 416:	83 e2 01             	and    $0x1,%edx
 419:	29 ca                	sub    %ecx,%edx
 41b:	83 fa 01             	cmp    $0x1,%edx
 41e:	75 e0                	jne    400 <fork_children3+0x10>
				r = setmonopoly(p, 2020052633);
 420:	83 ec 08             	sub    $0x8,%esp
 423:	68 99 8e 67 78       	push   $0x78678e99
 428:	50                   	push   %eax
 429:	e8 bd 03 00 00       	call   7eb <setmonopoly>
				printf(1, "Number of processes in MoQ: %d\n", r);
 42e:	83 c4 0c             	add    $0xc,%esp
 431:	50                   	push   %eax
				r = setmonopoly(p, 2020052633);
 432:	89 c6                	mov    %eax,%esi
				printf(1, "Number of processes in MoQ: %d\n", r);
 434:	68 2c 0d 00 00       	push   $0xd2c
 439:	6a 01                	push   $0x1
 43b:	e8 80 04 00 00       	call   8c0 <printf>
			if(r < 0)
 440:	83 c4 10             	add    $0x10,%esp
 443:	85 f6                	test   %esi,%esi
 445:	79 b9                	jns    400 <fork_children3+0x10>
				printf(1, "setmonopoly returned %d\n", r);
 447:	50                   	push   %eax
 448:	56                   	push   %esi
 449:	68 41 0c 00 00       	push   $0xc41
 44e:	6a 01                	push   $0x1
 450:	e8 6b 04 00 00       	call   8c0 <printf>
				exit();
 455:	e8 d9 02 00 00       	call   733 <exit>
 45a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
 460:	a1 c4 10 00 00       	mov    0x10c4,%eax
 465:	8d 65 f8             	lea    -0x8(%ebp),%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5d                   	pop    %ebp
 46b:	c3                   	ret    
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			sleep(10);
 470:	83 ec 0c             	sub    $0xc,%esp
 473:	6a 0a                	push   $0xa
 475:	e8 49 03 00 00       	call   7c3 <sleep>
			return getpid();
 47a:	83 c4 10             	add    $0x10,%esp
}
 47d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 480:	5b                   	pop    %ebx
 481:	5e                   	pop    %esi
 482:	5d                   	pop    %ebp
			return getpid();
 483:	e9 2b 03 00 00       	jmp    7b3 <getpid>
 488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop

00000490 <exit_children>:
{
 490:	f3 0f 1e fb          	endbr32 
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	83 ec 08             	sub    $0x8,%esp
	if(getpid() != parent)
 49a:	e8 14 03 00 00       	call   7b3 <getpid>
 49f:	3b 05 c4 10 00 00    	cmp    0x10c4,%eax
 4a5:	75 15                	jne    4bc <exit_children+0x2c>
 4a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ae:	66 90                	xchg   %ax,%ax
	while(wait() != -1);
 4b0:	e8 86 02 00 00       	call   73b <wait>
 4b5:	83 f8 ff             	cmp    $0xffffffff,%eax
 4b8:	75 f6                	jne    4b0 <exit_children+0x20>
}
 4ba:	c9                   	leave  
 4bb:	c3                   	ret    
		exit();
 4bc:	e8 72 02 00 00       	call   733 <exit>
 4c1:	66 90                	xchg   %ax,%ax
 4c3:	66 90                	xchg   %ax,%ax
 4c5:	66 90                	xchg   %ax,%ax
 4c7:	66 90                	xchg   %ax,%ax
 4c9:	66 90                	xchg   %ax,%ax
 4cb:	66 90                	xchg   %ax,%ax
 4cd:	66 90                	xchg   %ax,%ax
 4cf:	90                   	nop

000004d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4d0:	f3 0f 1e fb          	endbr32 
 4d4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4d5:	31 c0                	xor    %eax,%eax
{
 4d7:	89 e5                	mov    %esp,%ebp
 4d9:	53                   	push   %ebx
 4da:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4dd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 4e0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 4e4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 4e7:	83 c0 01             	add    $0x1,%eax
 4ea:	84 d2                	test   %dl,%dl
 4ec:	75 f2                	jne    4e0 <strcpy+0x10>
    ;
  return os;
}
 4ee:	89 c8                	mov    %ecx,%eax
 4f0:	5b                   	pop    %ebx
 4f1:	5d                   	pop    %ebp
 4f2:	c3                   	ret    
 4f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000500 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 500:	f3 0f 1e fb          	endbr32 
 504:	55                   	push   %ebp
 505:	89 e5                	mov    %esp,%ebp
 507:	53                   	push   %ebx
 508:	8b 4d 08             	mov    0x8(%ebp),%ecx
 50b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 50e:	0f b6 01             	movzbl (%ecx),%eax
 511:	0f b6 1a             	movzbl (%edx),%ebx
 514:	84 c0                	test   %al,%al
 516:	75 19                	jne    531 <strcmp+0x31>
 518:	eb 26                	jmp    540 <strcmp+0x40>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 520:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 524:	83 c1 01             	add    $0x1,%ecx
 527:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 52a:	0f b6 1a             	movzbl (%edx),%ebx
 52d:	84 c0                	test   %al,%al
 52f:	74 0f                	je     540 <strcmp+0x40>
 531:	38 d8                	cmp    %bl,%al
 533:	74 eb                	je     520 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 535:	29 d8                	sub    %ebx,%eax
}
 537:	5b                   	pop    %ebx
 538:	5d                   	pop    %ebp
 539:	c3                   	ret    
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 540:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 542:	29 d8                	sub    %ebx,%eax
}
 544:	5b                   	pop    %ebx
 545:	5d                   	pop    %ebp
 546:	c3                   	ret    
 547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54e:	66 90                	xchg   %ax,%ax

00000550 <strlen>:

uint
strlen(const char *s)
{
 550:	f3 0f 1e fb          	endbr32 
 554:	55                   	push   %ebp
 555:	89 e5                	mov    %esp,%ebp
 557:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 55a:	80 3a 00             	cmpb   $0x0,(%edx)
 55d:	74 21                	je     580 <strlen+0x30>
 55f:	31 c0                	xor    %eax,%eax
 561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 568:	83 c0 01             	add    $0x1,%eax
 56b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 56f:	89 c1                	mov    %eax,%ecx
 571:	75 f5                	jne    568 <strlen+0x18>
    ;
  return n;
}
 573:	89 c8                	mov    %ecx,%eax
 575:	5d                   	pop    %ebp
 576:	c3                   	ret    
 577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 580:	31 c9                	xor    %ecx,%ecx
}
 582:	5d                   	pop    %ebp
 583:	89 c8                	mov    %ecx,%eax
 585:	c3                   	ret    
 586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58d:	8d 76 00             	lea    0x0(%esi),%esi

00000590 <memset>:

void*
memset(void *dst, int c, uint n)
{
 590:	f3 0f 1e fb          	endbr32 
 594:	55                   	push   %ebp
 595:	89 e5                	mov    %esp,%ebp
 597:	57                   	push   %edi
 598:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 59b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 59e:	8b 45 0c             	mov    0xc(%ebp),%eax
 5a1:	89 d7                	mov    %edx,%edi
 5a3:	fc                   	cld    
 5a4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5a6:	89 d0                	mov    %edx,%eax
 5a8:	5f                   	pop    %edi
 5a9:	5d                   	pop    %ebp
 5aa:	c3                   	ret    
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop

000005b0 <strchr>:

char*
strchr(const char *s, char c)
{
 5b0:	f3 0f 1e fb          	endbr32 
 5b4:	55                   	push   %ebp
 5b5:	89 e5                	mov    %esp,%ebp
 5b7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ba:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 5be:	0f b6 10             	movzbl (%eax),%edx
 5c1:	84 d2                	test   %dl,%dl
 5c3:	75 16                	jne    5db <strchr+0x2b>
 5c5:	eb 21                	jmp    5e8 <strchr+0x38>
 5c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ce:	66 90                	xchg   %ax,%ax
 5d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 5d4:	83 c0 01             	add    $0x1,%eax
 5d7:	84 d2                	test   %dl,%dl
 5d9:	74 0d                	je     5e8 <strchr+0x38>
    if(*s == c)
 5db:	38 d1                	cmp    %dl,%cl
 5dd:	75 f1                	jne    5d0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 5df:	5d                   	pop    %ebp
 5e0:	c3                   	ret    
 5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 5e8:	31 c0                	xor    %eax,%eax
}
 5ea:	5d                   	pop    %ebp
 5eb:	c3                   	ret    
 5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005f0 <gets>:

char*
gets(char *buf, int max)
{
 5f0:	f3 0f 1e fb          	endbr32 
 5f4:	55                   	push   %ebp
 5f5:	89 e5                	mov    %esp,%ebp
 5f7:	57                   	push   %edi
 5f8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5f9:	31 f6                	xor    %esi,%esi
{
 5fb:	53                   	push   %ebx
 5fc:	89 f3                	mov    %esi,%ebx
 5fe:	83 ec 1c             	sub    $0x1c,%esp
 601:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 604:	eb 33                	jmp    639 <gets+0x49>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 610:	83 ec 04             	sub    $0x4,%esp
 613:	8d 45 e7             	lea    -0x19(%ebp),%eax
 616:	6a 01                	push   $0x1
 618:	50                   	push   %eax
 619:	6a 00                	push   $0x0
 61b:	e8 2b 01 00 00       	call   74b <read>
    if(cc < 1)
 620:	83 c4 10             	add    $0x10,%esp
 623:	85 c0                	test   %eax,%eax
 625:	7e 1c                	jle    643 <gets+0x53>
      break;
    buf[i++] = c;
 627:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 62b:	83 c7 01             	add    $0x1,%edi
 62e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 631:	3c 0a                	cmp    $0xa,%al
 633:	74 23                	je     658 <gets+0x68>
 635:	3c 0d                	cmp    $0xd,%al
 637:	74 1f                	je     658 <gets+0x68>
  for(i=0; i+1 < max; ){
 639:	83 c3 01             	add    $0x1,%ebx
 63c:	89 fe                	mov    %edi,%esi
 63e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 641:	7c cd                	jl     610 <gets+0x20>
 643:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 645:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 648:	c6 03 00             	movb   $0x0,(%ebx)
}
 64b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 64e:	5b                   	pop    %ebx
 64f:	5e                   	pop    %esi
 650:	5f                   	pop    %edi
 651:	5d                   	pop    %ebp
 652:	c3                   	ret    
 653:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 657:	90                   	nop
 658:	8b 75 08             	mov    0x8(%ebp),%esi
 65b:	8b 45 08             	mov    0x8(%ebp),%eax
 65e:	01 de                	add    %ebx,%esi
 660:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 662:	c6 03 00             	movb   $0x0,(%ebx)
}
 665:	8d 65 f4             	lea    -0xc(%ebp),%esp
 668:	5b                   	pop    %ebx
 669:	5e                   	pop    %esi
 66a:	5f                   	pop    %edi
 66b:	5d                   	pop    %ebp
 66c:	c3                   	ret    
 66d:	8d 76 00             	lea    0x0(%esi),%esi

00000670 <stat>:

int
stat(const char *n, struct stat *st)
{
 670:	f3 0f 1e fb          	endbr32 
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	56                   	push   %esi
 678:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 679:	83 ec 08             	sub    $0x8,%esp
 67c:	6a 00                	push   $0x0
 67e:	ff 75 08             	pushl  0x8(%ebp)
 681:	e8 ed 00 00 00       	call   773 <open>
  if(fd < 0)
 686:	83 c4 10             	add    $0x10,%esp
 689:	85 c0                	test   %eax,%eax
 68b:	78 2b                	js     6b8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 68d:	83 ec 08             	sub    $0x8,%esp
 690:	ff 75 0c             	pushl  0xc(%ebp)
 693:	89 c3                	mov    %eax,%ebx
 695:	50                   	push   %eax
 696:	e8 f0 00 00 00       	call   78b <fstat>
  close(fd);
 69b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 69e:	89 c6                	mov    %eax,%esi
  close(fd);
 6a0:	e8 b6 00 00 00       	call   75b <close>
  return r;
 6a5:	83 c4 10             	add    $0x10,%esp
}
 6a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6ab:	89 f0                	mov    %esi,%eax
 6ad:	5b                   	pop    %ebx
 6ae:	5e                   	pop    %esi
 6af:	5d                   	pop    %ebp
 6b0:	c3                   	ret    
 6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 6b8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 6bd:	eb e9                	jmp    6a8 <stat+0x38>
 6bf:	90                   	nop

000006c0 <atoi>:

int
atoi(const char *s)
{
 6c0:	f3 0f 1e fb          	endbr32 
 6c4:	55                   	push   %ebp
 6c5:	89 e5                	mov    %esp,%ebp
 6c7:	53                   	push   %ebx
 6c8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6cb:	0f be 02             	movsbl (%edx),%eax
 6ce:	8d 48 d0             	lea    -0x30(%eax),%ecx
 6d1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 6d4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 6d9:	77 1a                	ja     6f5 <atoi+0x35>
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
    n = n*10 + *s++ - '0';
 6e0:	83 c2 01             	add    $0x1,%edx
 6e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 6e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 6ea:	0f be 02             	movsbl (%edx),%eax
 6ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 6f0:	80 fb 09             	cmp    $0x9,%bl
 6f3:	76 eb                	jbe    6e0 <atoi+0x20>
  return n;
}
 6f5:	89 c8                	mov    %ecx,%eax
 6f7:	5b                   	pop    %ebx
 6f8:	5d                   	pop    %ebp
 6f9:	c3                   	ret    
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000700 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 700:	f3 0f 1e fb          	endbr32 
 704:	55                   	push   %ebp
 705:	89 e5                	mov    %esp,%ebp
 707:	57                   	push   %edi
 708:	8b 45 10             	mov    0x10(%ebp),%eax
 70b:	8b 55 08             	mov    0x8(%ebp),%edx
 70e:	56                   	push   %esi
 70f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 712:	85 c0                	test   %eax,%eax
 714:	7e 0f                	jle    725 <memmove+0x25>
 716:	01 d0                	add    %edx,%eax
  dst = vdst;
 718:	89 d7                	mov    %edx,%edi
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 720:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 721:	39 f8                	cmp    %edi,%eax
 723:	75 fb                	jne    720 <memmove+0x20>
  return vdst;
}
 725:	5e                   	pop    %esi
 726:	89 d0                	mov    %edx,%eax
 728:	5f                   	pop    %edi
 729:	5d                   	pop    %ebp
 72a:	c3                   	ret    

0000072b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 72b:	b8 01 00 00 00       	mov    $0x1,%eax
 730:	cd 40                	int    $0x40
 732:	c3                   	ret    

00000733 <exit>:
SYSCALL(exit)
 733:	b8 02 00 00 00       	mov    $0x2,%eax
 738:	cd 40                	int    $0x40
 73a:	c3                   	ret    

0000073b <wait>:
SYSCALL(wait)
 73b:	b8 03 00 00 00       	mov    $0x3,%eax
 740:	cd 40                	int    $0x40
 742:	c3                   	ret    

00000743 <pipe>:
SYSCALL(pipe)
 743:	b8 04 00 00 00       	mov    $0x4,%eax
 748:	cd 40                	int    $0x40
 74a:	c3                   	ret    

0000074b <read>:
SYSCALL(read)
 74b:	b8 05 00 00 00       	mov    $0x5,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <write>:
SYSCALL(write)
 753:	b8 10 00 00 00       	mov    $0x10,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <close>:
SYSCALL(close)
 75b:	b8 15 00 00 00       	mov    $0x15,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <kill>:
SYSCALL(kill)
 763:	b8 06 00 00 00       	mov    $0x6,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <exec>:
SYSCALL(exec)
 76b:	b8 07 00 00 00       	mov    $0x7,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <open>:
SYSCALL(open)
 773:	b8 0f 00 00 00       	mov    $0xf,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <mknod>:
SYSCALL(mknod)
 77b:	b8 11 00 00 00       	mov    $0x11,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <unlink>:
SYSCALL(unlink)
 783:	b8 12 00 00 00       	mov    $0x12,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <fstat>:
SYSCALL(fstat)
 78b:	b8 08 00 00 00       	mov    $0x8,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <link>:
SYSCALL(link)
 793:	b8 13 00 00 00       	mov    $0x13,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <mkdir>:
SYSCALL(mkdir)
 79b:	b8 14 00 00 00       	mov    $0x14,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <chdir>:
SYSCALL(chdir)
 7a3:	b8 09 00 00 00       	mov    $0x9,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <dup>:
SYSCALL(dup)
 7ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <getpid>:
SYSCALL(getpid)
 7b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <sbrk>:
SYSCALL(sbrk)
 7bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <sleep>:
SYSCALL(sleep)
 7c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <uptime>:
SYSCALL(uptime)
 7cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <yield>:
SYSCALL(yield)
 7d3:	b8 16 00 00 00       	mov    $0x16,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <getlev>:
SYSCALL(getlev)
 7db:	b8 17 00 00 00       	mov    $0x17,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <setpriority>:
SYSCALL(setpriority)
 7e3:	b8 18 00 00 00       	mov    $0x18,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <setmonopoly>:
SYSCALL(setmonopoly)
 7eb:	b8 19 00 00 00       	mov    $0x19,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <monopolize>:
SYSCALL(monopolize)
 7f3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    

000007fb <unmonopolize>:
SYSCALL(unmonopolize)
 7fb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 800:	cd 40                	int    $0x40
 802:	c3                   	ret    
 803:	66 90                	xchg   %ax,%ax
 805:	66 90                	xchg   %ax,%ax
 807:	66 90                	xchg   %ax,%ax
 809:	66 90                	xchg   %ax,%ax
 80b:	66 90                	xchg   %ax,%ax
 80d:	66 90                	xchg   %ax,%ax
 80f:	90                   	nop

00000810 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 3c             	sub    $0x3c,%esp
 819:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 81c:	89 d1                	mov    %edx,%ecx
{
 81e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 821:	85 d2                	test   %edx,%edx
 823:	0f 89 7f 00 00 00    	jns    8a8 <printint+0x98>
 829:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 82d:	74 79                	je     8a8 <printint+0x98>
    neg = 1;
 82f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 836:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 838:	31 db                	xor    %ebx,%ebx
 83a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 83d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 840:	89 c8                	mov    %ecx,%eax
 842:	31 d2                	xor    %edx,%edx
 844:	89 cf                	mov    %ecx,%edi
 846:	f7 75 c4             	divl   -0x3c(%ebp)
 849:	0f b6 92 54 0d 00 00 	movzbl 0xd54(%edx),%edx
 850:	89 45 c0             	mov    %eax,-0x40(%ebp)
 853:	89 d8                	mov    %ebx,%eax
 855:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 858:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 85b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 85e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 861:	76 dd                	jbe    840 <printint+0x30>
  if(neg)
 863:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 866:	85 c9                	test   %ecx,%ecx
 868:	74 0c                	je     876 <printint+0x66>
    buf[i++] = '-';
 86a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 86f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 871:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 876:	8b 7d b8             	mov    -0x48(%ebp),%edi
 879:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 87d:	eb 07                	jmp    886 <printint+0x76>
 87f:	90                   	nop
 880:	0f b6 13             	movzbl (%ebx),%edx
 883:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 886:	83 ec 04             	sub    $0x4,%esp
 889:	88 55 d7             	mov    %dl,-0x29(%ebp)
 88c:	6a 01                	push   $0x1
 88e:	56                   	push   %esi
 88f:	57                   	push   %edi
 890:	e8 be fe ff ff       	call   753 <write>
  while(--i >= 0)
 895:	83 c4 10             	add    $0x10,%esp
 898:	39 de                	cmp    %ebx,%esi
 89a:	75 e4                	jne    880 <printint+0x70>
    putc(fd, buf[i]);
}
 89c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 89f:	5b                   	pop    %ebx
 8a0:	5e                   	pop    %esi
 8a1:	5f                   	pop    %edi
 8a2:	5d                   	pop    %ebp
 8a3:	c3                   	ret    
 8a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8a8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 8af:	eb 87                	jmp    838 <printint+0x28>
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop

000008c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8c0:	f3 0f 1e fb          	endbr32 
 8c4:	55                   	push   %ebp
 8c5:	89 e5                	mov    %esp,%ebp
 8c7:	57                   	push   %edi
 8c8:	56                   	push   %esi
 8c9:	53                   	push   %ebx
 8ca:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8cd:	8b 75 0c             	mov    0xc(%ebp),%esi
 8d0:	0f b6 1e             	movzbl (%esi),%ebx
 8d3:	84 db                	test   %bl,%bl
 8d5:	0f 84 b4 00 00 00    	je     98f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 8db:	8d 45 10             	lea    0x10(%ebp),%eax
 8de:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 8e1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 8e4:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 8e6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8e9:	eb 33                	jmp    91e <printf+0x5e>
 8eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop
 8f0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 8f3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 8f8:	83 f8 25             	cmp    $0x25,%eax
 8fb:	74 17                	je     914 <printf+0x54>
  write(fd, &c, 1);
 8fd:	83 ec 04             	sub    $0x4,%esp
 900:	88 5d e7             	mov    %bl,-0x19(%ebp)
 903:	6a 01                	push   $0x1
 905:	57                   	push   %edi
 906:	ff 75 08             	pushl  0x8(%ebp)
 909:	e8 45 fe ff ff       	call   753 <write>
 90e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 911:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 914:	0f b6 1e             	movzbl (%esi),%ebx
 917:	83 c6 01             	add    $0x1,%esi
 91a:	84 db                	test   %bl,%bl
 91c:	74 71                	je     98f <printf+0xcf>
    c = fmt[i] & 0xff;
 91e:	0f be cb             	movsbl %bl,%ecx
 921:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 924:	85 d2                	test   %edx,%edx
 926:	74 c8                	je     8f0 <printf+0x30>
      }
    } else if(state == '%'){
 928:	83 fa 25             	cmp    $0x25,%edx
 92b:	75 e7                	jne    914 <printf+0x54>
      if(c == 'd'){
 92d:	83 f8 64             	cmp    $0x64,%eax
 930:	0f 84 9a 00 00 00    	je     9d0 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 936:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 93c:	83 f9 70             	cmp    $0x70,%ecx
 93f:	74 5f                	je     9a0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 941:	83 f8 73             	cmp    $0x73,%eax
 944:	0f 84 d6 00 00 00    	je     a20 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 94a:	83 f8 63             	cmp    $0x63,%eax
 94d:	0f 84 8d 00 00 00    	je     9e0 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 953:	83 f8 25             	cmp    $0x25,%eax
 956:	0f 84 b4 00 00 00    	je     a10 <printf+0x150>
  write(fd, &c, 1);
 95c:	83 ec 04             	sub    $0x4,%esp
 95f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 963:	6a 01                	push   $0x1
 965:	57                   	push   %edi
 966:	ff 75 08             	pushl  0x8(%ebp)
 969:	e8 e5 fd ff ff       	call   753 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 96e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 971:	83 c4 0c             	add    $0xc,%esp
 974:	6a 01                	push   $0x1
 976:	83 c6 01             	add    $0x1,%esi
 979:	57                   	push   %edi
 97a:	ff 75 08             	pushl  0x8(%ebp)
 97d:	e8 d1 fd ff ff       	call   753 <write>
  for(i = 0; fmt[i]; i++){
 982:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 986:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 989:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 98b:	84 db                	test   %bl,%bl
 98d:	75 8f                	jne    91e <printf+0x5e>
    }
  }
}
 98f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 992:	5b                   	pop    %ebx
 993:	5e                   	pop    %esi
 994:	5f                   	pop    %edi
 995:	5d                   	pop    %ebp
 996:	c3                   	ret    
 997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 99e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 10 00 00 00       	mov    $0x10,%ecx
 9a8:	6a 00                	push   $0x0
 9aa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 9ad:	8b 45 08             	mov    0x8(%ebp),%eax
 9b0:	8b 13                	mov    (%ebx),%edx
 9b2:	e8 59 fe ff ff       	call   810 <printint>
        ap++;
 9b7:	89 d8                	mov    %ebx,%eax
 9b9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9bc:	31 d2                	xor    %edx,%edx
        ap++;
 9be:	83 c0 04             	add    $0x4,%eax
 9c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 9c4:	e9 4b ff ff ff       	jmp    914 <printf+0x54>
 9c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 9d0:	83 ec 0c             	sub    $0xc,%esp
 9d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9d8:	6a 01                	push   $0x1
 9da:	eb ce                	jmp    9aa <printf+0xea>
 9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 9e0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 9e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9e6:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 9e8:	6a 01                	push   $0x1
        ap++;
 9ea:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 9ed:	57                   	push   %edi
 9ee:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 9f1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9f4:	e8 5a fd ff ff       	call   753 <write>
        ap++;
 9f9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 9fc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9ff:	31 d2                	xor    %edx,%edx
 a01:	e9 0e ff ff ff       	jmp    914 <printf+0x54>
 a06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a0d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 a10:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 a13:	83 ec 04             	sub    $0x4,%esp
 a16:	e9 59 ff ff ff       	jmp    974 <printf+0xb4>
 a1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a1f:	90                   	nop
        s = (char*)*ap;
 a20:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a23:	8b 18                	mov    (%eax),%ebx
        ap++;
 a25:	83 c0 04             	add    $0x4,%eax
 a28:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 a2b:	85 db                	test   %ebx,%ebx
 a2d:	74 17                	je     a46 <printf+0x186>
        while(*s != 0){
 a2f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 a32:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 a34:	84 c0                	test   %al,%al
 a36:	0f 84 d8 fe ff ff    	je     914 <printf+0x54>
 a3c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a3f:	89 de                	mov    %ebx,%esi
 a41:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a44:	eb 1a                	jmp    a60 <printf+0x1a0>
          s = "(null)";
 a46:	bb 4c 0d 00 00       	mov    $0xd4c,%ebx
        while(*s != 0){
 a4b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a4e:	b8 28 00 00 00       	mov    $0x28,%eax
 a53:	89 de                	mov    %ebx,%esi
 a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a5f:	90                   	nop
  write(fd, &c, 1);
 a60:	83 ec 04             	sub    $0x4,%esp
          s++;
 a63:	83 c6 01             	add    $0x1,%esi
 a66:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a69:	6a 01                	push   $0x1
 a6b:	57                   	push   %edi
 a6c:	53                   	push   %ebx
 a6d:	e8 e1 fc ff ff       	call   753 <write>
        while(*s != 0){
 a72:	0f b6 06             	movzbl (%esi),%eax
 a75:	83 c4 10             	add    $0x10,%esp
 a78:	84 c0                	test   %al,%al
 a7a:	75 e4                	jne    a60 <printf+0x1a0>
 a7c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 a7f:	31 d2                	xor    %edx,%edx
 a81:	e9 8e fe ff ff       	jmp    914 <printf+0x54>
 a86:	66 90                	xchg   %ax,%ax
 a88:	66 90                	xchg   %ax,%ax
 a8a:	66 90                	xchg   %ax,%ax
 a8c:	66 90                	xchg   %ax,%ax
 a8e:	66 90                	xchg   %ax,%ax

00000a90 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a90:	f3 0f 1e fb          	endbr32 
 a94:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a95:	a1 b8 10 00 00       	mov    0x10b8,%eax
{
 a9a:	89 e5                	mov    %esp,%ebp
 a9c:	57                   	push   %edi
 a9d:	56                   	push   %esi
 a9e:	53                   	push   %ebx
 a9f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 aa2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 aa4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa7:	39 c8                	cmp    %ecx,%eax
 aa9:	73 15                	jae    ac0 <free+0x30>
 aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 aaf:	90                   	nop
 ab0:	39 d1                	cmp    %edx,%ecx
 ab2:	72 14                	jb     ac8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab4:	39 d0                	cmp    %edx,%eax
 ab6:	73 10                	jae    ac8 <free+0x38>
{
 ab8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aba:	8b 10                	mov    (%eax),%edx
 abc:	39 c8                	cmp    %ecx,%eax
 abe:	72 f0                	jb     ab0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac0:	39 d0                	cmp    %edx,%eax
 ac2:	72 f4                	jb     ab8 <free+0x28>
 ac4:	39 d1                	cmp    %edx,%ecx
 ac6:	73 f0                	jae    ab8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ac8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 acb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 ace:	39 fa                	cmp    %edi,%edx
 ad0:	74 1e                	je     af0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 ad2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ad5:	8b 50 04             	mov    0x4(%eax),%edx
 ad8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 adb:	39 f1                	cmp    %esi,%ecx
 add:	74 28                	je     b07 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 adf:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 ae1:	5b                   	pop    %ebx
  freep = p;
 ae2:	a3 b8 10 00 00       	mov    %eax,0x10b8
}
 ae7:	5e                   	pop    %esi
 ae8:	5f                   	pop    %edi
 ae9:	5d                   	pop    %ebp
 aea:	c3                   	ret    
 aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 aef:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 af0:	03 72 04             	add    0x4(%edx),%esi
 af3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 af6:	8b 10                	mov    (%eax),%edx
 af8:	8b 12                	mov    (%edx),%edx
 afa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 afd:	8b 50 04             	mov    0x4(%eax),%edx
 b00:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b03:	39 f1                	cmp    %esi,%ecx
 b05:	75 d8                	jne    adf <free+0x4f>
    p->s.size += bp->s.size;
 b07:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b0a:	a3 b8 10 00 00       	mov    %eax,0x10b8
    p->s.size += bp->s.size;
 b0f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b12:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b15:	89 10                	mov    %edx,(%eax)
}
 b17:	5b                   	pop    %ebx
 b18:	5e                   	pop    %esi
 b19:	5f                   	pop    %edi
 b1a:	5d                   	pop    %ebp
 b1b:	c3                   	ret    
 b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b20 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b20:	f3 0f 1e fb          	endbr32 
 b24:	55                   	push   %ebp
 b25:	89 e5                	mov    %esp,%ebp
 b27:	57                   	push   %edi
 b28:	56                   	push   %esi
 b29:	53                   	push   %ebx
 b2a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b30:	8b 3d b8 10 00 00    	mov    0x10b8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b36:	8d 70 07             	lea    0x7(%eax),%esi
 b39:	c1 ee 03             	shr    $0x3,%esi
 b3c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 b3f:	85 ff                	test   %edi,%edi
 b41:	0f 84 a9 00 00 00    	je     bf0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b47:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 b49:	8b 48 04             	mov    0x4(%eax),%ecx
 b4c:	39 f1                	cmp    %esi,%ecx
 b4e:	73 6d                	jae    bbd <malloc+0x9d>
 b50:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 b56:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b5b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b5e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 b65:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 b68:	eb 17                	jmp    b81 <malloc+0x61>
 b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b70:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 b72:	8b 4a 04             	mov    0x4(%edx),%ecx
 b75:	39 f1                	cmp    %esi,%ecx
 b77:	73 4f                	jae    bc8 <malloc+0xa8>
 b79:	8b 3d b8 10 00 00    	mov    0x10b8,%edi
 b7f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b81:	39 c7                	cmp    %eax,%edi
 b83:	75 eb                	jne    b70 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 b85:	83 ec 0c             	sub    $0xc,%esp
 b88:	ff 75 e4             	pushl  -0x1c(%ebp)
 b8b:	e8 2b fc ff ff       	call   7bb <sbrk>
  if(p == (char*)-1)
 b90:	83 c4 10             	add    $0x10,%esp
 b93:	83 f8 ff             	cmp    $0xffffffff,%eax
 b96:	74 1b                	je     bb3 <malloc+0x93>
  hp->s.size = nu;
 b98:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b9b:	83 ec 0c             	sub    $0xc,%esp
 b9e:	83 c0 08             	add    $0x8,%eax
 ba1:	50                   	push   %eax
 ba2:	e8 e9 fe ff ff       	call   a90 <free>
  return freep;
 ba7:	a1 b8 10 00 00       	mov    0x10b8,%eax
      if((p = morecore(nunits)) == 0)
 bac:	83 c4 10             	add    $0x10,%esp
 baf:	85 c0                	test   %eax,%eax
 bb1:	75 bd                	jne    b70 <malloc+0x50>
        return 0;
  }
}
 bb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bb6:	31 c0                	xor    %eax,%eax
}
 bb8:	5b                   	pop    %ebx
 bb9:	5e                   	pop    %esi
 bba:	5f                   	pop    %edi
 bbb:	5d                   	pop    %ebp
 bbc:	c3                   	ret    
    if(p->s.size >= nunits){
 bbd:	89 c2                	mov    %eax,%edx
 bbf:	89 f8                	mov    %edi,%eax
 bc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 bc8:	39 ce                	cmp    %ecx,%esi
 bca:	74 54                	je     c20 <malloc+0x100>
        p->s.size -= nunits;
 bcc:	29 f1                	sub    %esi,%ecx
 bce:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 bd1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 bd4:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 bd7:	a3 b8 10 00 00       	mov    %eax,0x10b8
}
 bdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bdf:	8d 42 08             	lea    0x8(%edx),%eax
}
 be2:	5b                   	pop    %ebx
 be3:	5e                   	pop    %esi
 be4:	5f                   	pop    %edi
 be5:	5d                   	pop    %ebp
 be6:	c3                   	ret    
 be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 bee:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 bf0:	c7 05 b8 10 00 00 bc 	movl   $0x10bc,0x10b8
 bf7:	10 00 00 
    base.s.size = 0;
 bfa:	bf bc 10 00 00       	mov    $0x10bc,%edi
    base.s.ptr = freep = prevp = &base;
 bff:	c7 05 bc 10 00 00 bc 	movl   $0x10bc,0x10bc
 c06:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c09:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 c0b:	c7 05 c0 10 00 00 00 	movl   $0x0,0x10c0
 c12:	00 00 00 
    if(p->s.size >= nunits){
 c15:	e9 36 ff ff ff       	jmp    b50 <malloc+0x30>
 c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 c20:	8b 0a                	mov    (%edx),%ecx
 c22:	89 08                	mov    %ecx,(%eax)
 c24:	eb b1                	jmp    bd7 <malloc+0xb7>
