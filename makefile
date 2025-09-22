CC = gcc
CFLAGS = -Iinclude -Wall
AR = ar
ARFLAGS = rcs

# Directories
BINDIR = bin
LIBDIR = lib
SRCDIR = src
INCDIR = include

# Targets
STATIC_TARGET = $(BINDIR)/client_static
DYNAMIC_TARGET = $(BINDIR)/client_dynamic
STATIC_LIB = $(LIBDIR)/libmyutils.a
DYNAMIC_LIB = $(LIBDIR)/libmyutils.so

# Objects
OBJS = $(SRCDIR)/main.o
UTIL_OBJS = $(SRCDIR)/mystrfunctions.o $(SRCDIR)/myfilefunctions.o

# Default build (both static + dynamic)
all: $(STATIC_TARGET) $(DYNAMIC_TARGET)

# --- Static build ---
$(STATIC_TARGET): $(OBJS) $(STATIC_LIB)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -L$(LIBDIR) -lmyutils

$(STATIC_LIB): $(UTIL_OBJS)
	$(AR) $(ARFLAGS) $@ $^
	ranlib $@

# --- Dynamic build ---
$(DYNAMIC_TARGET): $(OBJS) $(DYNAMIC_LIB)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -L$(LIBDIR) -lmyutils

$(DYNAMIC_LIB): $(UTIL_OBJS)
	$(CC) -shared -o $@ $^

# --- Compile objects ---
$(SRCDIR)/%.o: $(SRCDIR)/%.c $(INCDIR)/%.h
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

# --- Clean ---
clean:
	rm -f $(SRCDIR)/*.o $(STATIC_TARGET) $(DYNAMIC_TARGET) $(STATIC_LIB) $(DYNAMIC_LIB)
