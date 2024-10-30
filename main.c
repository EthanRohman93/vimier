#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<stdbool.h>

bool check_char(char char_to_check, char *information) {

    char *result = memchr(information, char_to_check, 100);

	if (result != NULL) {return true;}
    else {return false;}
}

int main() {

    char payload[256];
    char *lines[50];
    char staged_info[100] = "";
    char unstaged_info[100] = "";
    int lines_procd = 0;
    bool red, yellow, blue, green;

    while (fgets(payload, 256, stdin) != NULL) {
  	    strncat(unstaged_info, payload + 1, 1);
	    strncat(staged_info, payload, 1);
	}

	//bool check_char(char char_to_check, char *information) {
	red = check_char('M', unstaged_info) || check_char('D', unstaged_info);
	yellow = check_char('?', unstaged_info) || check_char('?', staged_info);
	green = check_char('M', staged_info) || check_char('D', staged_info);
	blue = check_char('A', staged_info);

	if (red) {printf("31");} 
	else if (yellow) {printf("33");}
	else if (green) {printf("32");}
	else if (blue) {printf("34");}
	else {printf("00");}
	
	return 0;
}
