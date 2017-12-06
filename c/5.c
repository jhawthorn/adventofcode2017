#include <stdio.h>

#include "5.h"

int main() {
	int *pc = mem;
	int iterations = 0;

	for(; pc >= mem && pc < mem + (sizeof(mem) / sizeof(mem[0])); iterations++) {
		int offset = *pc;
		if (offset >= 3)
			(*pc)--;
		else
			(*pc)++;

		pc += offset;
	}

	printf("%i\n", iterations);
}
