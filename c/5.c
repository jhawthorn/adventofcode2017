#include <stdio.h>

#include "5.h"

int main() {
	int iterations = 0;

	for(pc = mem; pc >= mem && pc < mem + (sizeof(mem) / sizeof(mem[0])); iterations++) {
		if (*pc >= 3)
			pc += (*pc)--;
		else
			pc += (*pc)++;
	}

	printf("%i\n", iterations);
}
