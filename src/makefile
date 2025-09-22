CC     = gcc
CFLAGS = -Wall -g -I../include
OBJS   = mystrfunctions.o myfilefunctions.o main.o

obj: $(OBJS)
	@echo "Built all object files in src/"

mystrfunctions.o: mystrfunctions.c ../include/mystrfunctions.h
	@$(CC) $(CFLAGS) -c mystrfunctions.c

myfilefunctions.o: myfilefunctions.c ../include/myfilefunctions.h
	@$(CC) $(CFLAGS) -c myfilefunctions.c

main.o: main.c ../include/mystrfunctions.h ../include/myfilefunctions.h
	@$(CC) $(CFLAGS) -c main.c

clean:
	@rm -f $(OBJS)
	@echo "Cleaned src/"

