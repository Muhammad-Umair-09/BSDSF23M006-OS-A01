
CC     = gcc
CFLAGS = -Wall -g -Iinclude
TARGET = ./bin/client
OBJS   = src/mystrfunctions.o src/myfilefunctions.o src/main.o

all: $(TARGET)

$(TARGET): $(OBJS)
	@$(CC) $(OBJS) -o $(TARGET)
	@echo "Build complete: $(TARGET)"


$(OBJS):
	@$(MAKE) -C src

clean:
	@$(MAKE) -C src clean
	@rm -f $(TARGET)
	@echo "Cleaned project root"




