CC = gcc
CFLAGS = -Iinclude -Wall
AR = ar
ARFLAGS = rcs

# Directories
BINDIR = bin
LIBDIR = lib
SRCDIR = src
INCDIR = include
MAN_DIR = man

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

install: all
	@echo "Installing executables to /usr/local/bin..."
	@sudo cp $(STATIC_TARGET) /usr/local/bin/client-static
	@sudo cp $(DYNAMIC_TARGET) /usr/local/bin/client
	@echo "Installing man pages..."
	@sudo mkdir -p /usr/local/share/man/man1
	@sudo mkdir -p /usr/local/share/man/man3
	@sudo cp $(MAN_DIR)/man1/client.1 /usr/local/share/man/man1/
	@sudo cp $(MAN_DIR)/man3/*.3 /usr/local/share/man/man3/
	@echo "Updating man database..."
	@sudo mandb > /dev/null 2>&1 || true
	@echo "Installation complete. Try running 'client' or 'man client'."

uninstall:
	@echo "Removing executables from /usr/local/bin..."
	@sudo rm -f /usr/local/bin/client
	@sudo rm -f /usr/local/bin/client-static
	@echo "Removing man pages..."
	@sudo rm -f /usr/local/share/man/man1/client.1
	@sudo rm -f /usr/local/share/man/man3/mycat.3 \
	            /usr/local/share/man/man3/mygrep.3 \
	            /usr/local/share/man/man3/mystrcat.3 \
	            /usr/local/share/man/man3/mystrcpy.3 \
	            /usr/local/share/man/man3/mystrlen.3 \
	            /usr/local/share/man/man3/mystrncpy.3 \
	            /usr/local/share/man/man3/wordCount.3
	@echo "Updating man database..."
	@sudo mandb > /dev/null 2>&1 || true
	@echo "🗑️  Uninstall complete. All files removed."

# --- Clean ---
clean:
	rm -f $(SRCDIR)/*.o $(STATIC_TARGET) $(DYNAMIC_TARGET) $(STATIC_LIB) $(DYNAMIC_LIB)

.PHONY: all clean install
