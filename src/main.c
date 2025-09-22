// File: src/main.c
#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("=== Testing String Functions ===\n");

    // --- mystrlen ---
    const char* testStr = "Hello, World!";
    int len = mystrlen(testStr);
    printf("mystrlen(\"%s\") = %d\n", testStr, len);

    // --- mystrcpy ---
    char dest1[50];
    mystrcpy(dest1, testStr);
    printf("mystrcpy(dest1, \"%s\") -> dest1 = \"%s\"\n", testStr, dest1);

    // --- mystrncpy ---
    char dest2[50];
    mystrncpy(dest2, testStr, 5);
    printf("mystrncpy(dest2, \"%s\", 5) -> dest2 = \"%s\"\n", testStr, dest2);

    // --- mystrcat ---
    char dest3[50] = "Hello";
    mystrcat(dest3, ", C!");
    printf("mystrcat(dest3, \", C!\") -> dest3 = \"%s\"\n", dest3);

    printf("\n=== Testing File Functions ===\n");

    // Prepare a test file
    FILE* fp = fopen("testfile.txt", "w+");
    if(!fp) {
        perror("Error creating test file");
        return 1;
    }
    fprintf(fp, "Hello World\nThis is a test file.\nC programming is fun.\n");
    fflush(fp);
    rewind(fp); // reset file pointer

    // --- wordCount ---
    int lines = 0, words = 0, chars = 0;
    if(wordCount(fp, &lines, &words, &chars) == 0) {
        printf("wordCount: lines=%d, words=%d, chars=%d\n", lines, words, chars);
    } else {
        printf("wordCount failed!\n");
    }

    // --- mygrep ---
    rewind(fp); // reset file pointer
    char** matches = NULL;
    int matchCount = mygrep(fp, "test", &matches);
    if(matchCount >= 0) {
        printf("mygrep: Found %d match(es)\n", matchCount);
        for(int i = 0; i < matchCount; i++) {
            printf("Match %d: %s\n", i+1, matches[i]);
            free(matches[i]); // free each line
        }
        free(matches); // free array
    } else {
        printf("mygrep failed!\n");
    }

    fclose(fp);
    remove("testfile.txt"); // cleanup test file

    return 0;
}
