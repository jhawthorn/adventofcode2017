#include <stdio.h>
#include <stdint.h>
#include <assert.h>

int parta(uint32_t a, uint64_t b) {
	int count = 0;

	for(int i = 0; i < 40000000; i++) {
		a = a * 16807 % 2147483647;
		b = b * 48271 % 2147483647;

		if ((a & 0xffff) == (b & 0xffff))
			count++;
	}

	return count;
}

int partb(uint64_t a, uint64_t b) {
	int count = 0;
	for(int i = 0; i < 5000000; i++) {
		do {
			a = a * 16807 % 2147483647;
		} while(a % 4);

		do {
			b = b * 48271 % 2147483647;
		} while(b % 8);

		if ((a & 0xffff) == (b & 0xffff))
			count++;

	}

	return count;
}

int main() {
	//assert(parta(65, 8921) == 588);
	printf("%i\n", parta(699, 124));

	//assert(partb(65, 8921) == 309);
	printf("%i\n", partb(699, 124));
}

//raise unless calculate(65, 8921) == 309
//p calculate(699, 124)
