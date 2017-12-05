#include <stdio.h>

#include "5.h"

int main() {
	int pc = 0;
	int iterations = 0;

	for(; pc >= 0 && pc < 1059; iterations++) {
		int offset = mem[pc];
		if (offset >= 3)
			mem[pc]--;
		else
			mem[pc]++;

		pc += offset;
	}

	printf("%i\n", iterations);
}
