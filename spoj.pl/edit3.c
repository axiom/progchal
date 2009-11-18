#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 2048000

int main()
{
	unsigned int cases, ops, arg, cur, mc, i;
	char text[MAX];

	scanf("%u", &cases);

	while (cases--) {
		scanf("%u", &ops);
		getchar(); // Munch up newline character.

		cur = 0;
		mc  = 0;

		while (ops--) {
			switch (getchar()) {

				case 'I':
					scanf("nsert %u", &arg);

					memmove((text + cur + arg), (text + cur), (mc - cur));
					getchar();

					for (i = cur; i < cur + arg; i++) {
						text[i] = getchar();
						if (text[i] == '\n') i--;
					}

					mc += arg;
					getchar();
					continue;

				case 'D':
					scanf("elete %u", &arg);
					mc -= arg;
					memmove((text + cur), (text + cur + arg), (mc - cur));
					getchar();
					continue;

				case 'G':
					scanf("et %u", &arg);
					printf("%.*s\n", arg, (text + cur));
					getchar();
					continue;

				case 'M':
					scanf("ove %u", &arg);
					cur = arg;
					getchar();
					continue;

				case 'N':
					fseek(stdin, 4, SEEK_CUR);
					cur++;
					continue;

				case 'P':
					fseek(stdin, 4, SEEK_CUR);
					cur--;
					continue;
			}
		}

		getchar(); // Munch up newline character.
	}

	return 0;
}
