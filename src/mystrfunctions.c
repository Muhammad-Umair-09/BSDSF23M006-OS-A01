#include "../include/mystrfunctions.h"
#include <stdio.h>

int mystrlen(const char* s){
	if (s==NULL) return -1;
	int i = 0 ;
	while (s[i]!= '\0'){
		i++;
	}
	return i;
}

int mystrcpy(char* dest, const char* src){
	if (!dest || ! src) return -1;
	int i=0;
	while (src[i]!='\0'){
		dest[i] = src[i];
		i++;
	}
	dest[i] = '\0';
	return i;
}

int mystrncpy(char* dest, const char* src, int n){
	if (!dest || !src || n<=0) return -1;
	int i=0;
	while (i<n && src[i]!='\0'){
		dest[i] = src[i];
		i++;
	}
	dest[i]='\0';
	return i;
}

int mystrcat(char* dest, const char* src){
	if (!dest || !src) return -1;
	int i=0;
	int j=0;
	while (dest[i]!='\0') i++;

	while (src[j]!='\0'){
		dest[i] = src[j];
		i++;
		j++;
	}
	dest[i]='\0';
	return j;
}

