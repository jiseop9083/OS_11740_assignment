CC = gcc
OBJS = pthread_lock_linux.o
TARGET = pthread_lock_linux

.SUFFIXES : .c .o

all : $(TARGET)

$(TARGET): $(OBJS)
						 $(CC) -o $@ $(OBJS) -lpthread

clean:
			rm -f $(OBJS) $(TARGET)

