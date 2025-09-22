# REPORT.md  
**Project: Operating Systems — Multi-Feature Build System**  
**Author:** Muhammad Umair  
**Final Version:** v0.4.1-final  

---

## 📑 Table of Contents
- [Feature-1: Multi-file Build Basics](#-feature-1-multi-file-build-basics)  
- [Feature-2: Multi-file Project Structure](#-feature-2-multi-file-project-structure)  
- [Feature-3: Creating and Using Static Library](#-feature-3-creating-and-using-static-library)  
- [Feature-4: Creating and Using Dynamic Library](#-feature-4-creating-and-using-dynamic-library)  
- [Feature-5: Creating and Accessing Man Pages](#-feature-5-creating-and-accessing-man-pages)  
- [Conclusion](#-conclusion)  

---

## 📌 Feature-1: Multi-file Build Basics

### Q1: Explain the linking rule in this part's Makefile: `$(TARGET): $(OBJECTS)`. How does it differ from a Makefile rule that links against a library?
- The rule `$(TARGET): $(OBJECTS)` means the final executable (`$(TARGET)`) depends on object files (`$(OBJECTS)`), typically `.o` files.  
- When the rule runs, the compiler links these object files together into one executable.  
- **Difference from linking against a library:**  
  - In `$(TARGET): $(OBJECTS)`, only your object files are linked directly.  
  - If using a library, you specify `-l<library>` and `-L<path>` so the linker can resolve symbols from that library.  
  - For example: `gcc main.o -Llib -lmyutils -o client` would link against `libmyutils.a` or `libmyutils.so`.

### Q2: What is a git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?
- A **git tag** is a marker pointing to a specific commit, often used to mark releases (e.g., `v1.0`).  
- **Simple tag:** Lightweight pointer with no extra metadata, just a commit reference.  
- **Annotated tag:** Includes metadata (author, date, message) and is signed/stored in Git history. It is better for versioning software releases.  

### Q3: What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries (like your client executable) to it?
- GitHub Releases make it easier to distribute software versions to users.  
- Attaching binaries means end-users don’t need to build from source; they can directly download and run pre-compiled executables.  

---

## 📌 Feature-2: Multi-file Project Structure

### Q: Compare the Makefile from Part 1 and Part 2. What are the key differences in the variables and rules that enable modularity?
- **Part 1 Makefile:** Linked all files directly in one place.  
- **Part 2 Makefile:** Introduced variables for source, object, include, lib, and bin directories.  
- Used pattern rules like `$(SRCDIR)/%.o: $(SRCDIR)/%.c $(INCDIR)/%.h` for modular compilation.  
- This modular approach makes the build system more scalable and reusable across features.  

---

## 📌 Feature-3: Creating and Using Static Library

### Q1: Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?
- **Part 2:** Only compiled `.o` files and linked them directly.  
- **Part 3:** Added rules to build `libmyutils.a` using `ar` and `ranlib`.  
- Linking step changed to `-L$(LIBDIR) -lmyutils` instead of directly using object files.  

### Q2: What is the purpose of the `ar` command? Why is `ranlib` often used immediately after it?
- `ar` (archiver) creates static libraries (`.a`) by bundling multiple `.o` files.  
- `ranlib` generates an index inside the library to speed up symbol lookup during linking.  

### Q3: When you run `nm` on your `client_static` executable, are the symbols for functions like `mystrlen` present? What does this tell you about how static linking works?
- No, the function symbols are not visible because they were copied directly from the library into the final executable.  
- This shows static linking embeds the library’s code into the executable, making it self-contained but larger in size.  

---

## 📌 Feature-4: Creating and Using Dynamic Library

### Q1: What is Position-Independent Code (`-fPIC`) and why is it a fundamental requirement for creating shared libraries?
- **Position-Independent Code (PIC):** Code that can run at any memory address without modification.  
- Required for shared libraries because the OS may load them at different addresses in different programs.  

### Q2: Explain the difference in file size between your static and dynamic clients. Why does this difference exist?
- `client_static` is **larger** because all library code is copied into it.  
- `client_dynamic` is **smaller** because it only stores references to functions, with actual code loaded at runtime from `libmyutils.so`.  

### Q3: What is the `LD_LIBRARY_PATH` environment variable? Why was it necessary to set it for your program to run, and what does this tell you about the responsibilities of the operating system's dynamic loader?
- `LD_LIBRARY_PATH` tells the dynamic loader where to look for shared libraries.  
- It was necessary to add `./lib` to this variable because the system doesn’t know by default where custom `.so` files are stored.  
- This shows the OS loader is responsible for locating and loading dynamic libraries at runtime.  

---

## 📌 Feature-5: Creating and Accessing Man Pages

### Q1: What is the purpose of man pages, and how are they structured?
- Man pages are standard Linux documentation files that help users understand commands and functions.  
- Structure:  
  - `.TH` (title),  
  - `.SH NAME`,  
  - `.SH SYNOPSIS`,  
  - `.SH DESCRIPTION`,  
  - `.SH AUTHOR`.  

### Q2: Why did we create an `install` target in the Makefile, and how does it help users?
- The `install` target simulates system-wide installation by copying the executable to `/usr/local/bin` and man pages to `/usr/local/share/man`.  
- This allows users to run the program by simply typing `client` and access docs using `man mycat`, without needing project paths.  

### Q3: After running `make install`, why is `man mycat` accessible from anywhere?
- Because the man page was copied to the global man directory and indexed with `mandb`.  
- This integrates documentation with the Linux manual system, making it available like any other standard command.  

---

# ✅ Conclusion
Through Features 1–5, we progressively evolved the project:
1. Multi-file compilation.  
2. Modular build structure.  
3. Static library usage.  
4. Dynamic library usage.  
5. Professional documentation & installation with man pages.  

This complete workflow mirrors real-world software development practices: modularization, library management, version tagging, releases, and proper user documentation.
