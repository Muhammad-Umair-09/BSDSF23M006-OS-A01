
CC = gcc
CFLAGS = -Iinclude -Wall
AR = ar
ARFLAGS = rcs
TARGET = bin/client_static
LIBDIR = lib
LIB = $(LIBDIR)/libmyutils.a
OBJS = src/main.o
UTIL_OBJS = src/mystrfunctions.o src/myfilefunctions.o

all: $(TARGET)

$(TARGET): $(OBJS) $(LIB)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -L$(LIBDIR) -lmyutils


$(LIB): $(UTIL_OBJS)
	$(AR) $(ARFLAGS) $@ $^
	ranlib $@

src/%.o: src/%.c include/%.h
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f src/*.o $(TARGET) $(LIB)

