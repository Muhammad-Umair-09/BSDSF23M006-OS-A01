#include "../include/myfilefunctions.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>   // for malloc, free, realloc

int wordCount(FILE* file, int* lines, int* words, int* chars){
	if (!file ) return -1;
	*lines = *words = *chars = 0;
	int c, inword = 0;

	while ((c = fgetc(file)) != EOF) {
		(*chars) ++;
		if (c == '\n') (*lines)++;

		if (c == ' ' || c=='\n' || c== '\t') {
			inword = 0;
		} else if (!inword) {
			inword = 1;
			(*words)++;
		}
	}
	return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp || !search_str || !matches) return -1;  
    char line[256];
    int count = 0;
    char** results = NULL;

    while (fgets(line, sizeof(line), fp)) {
        if (strstr(line, search_str)) {
            char* copy = strdup(line);
            if (!copy) { 
                for (int i = 0; i < count; i++) free(results[i]);
                free(results);
                return -1;
            }
            results = realloc(results, (count + 1) * sizeof(char*));
            if (!results) return -1;
            results[count] = copy;
            count++;
        }
    }

    *matches = results;
    return count;
}


