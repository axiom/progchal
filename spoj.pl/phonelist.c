#include <stdio.h>
#include <stdlib.h>

int main()
{
	unsigned int cases;
	scanf("%u", &cases);

	unsigned char phonebook = 0;

	while (cases--) {
		unsigned int numbers;
		scanf("%u", &numbers);

		while (numbers--) {
			char number[10];
			scanf("%s", number);

			int i;
			for (i = 0; i < 10; i++) {
				phonebook |= 1 << (i * 10 + atoi(&number[i]));
			}
		}
	}

	printf("%d", phonebook);
	return 0;
}
