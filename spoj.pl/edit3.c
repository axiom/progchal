#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 2048000

static char text[MAX];

int main()
{
	int cases, ops, arg, cur, mc, i, size;

	scanf("%u", &cases);

	while (cases--) {
		scanf("%u", &ops);
		cur = 0;
		mc  = 0;

		while (ops--) {
			switch (getchar()) {
				case ' ':
				case '\n':
					ops++;
					continue;

				case 'I':
					scanf("nsert %u", &arg);

					memmove((text + cur + arg), (text + cur), (mc - cur));
					getchar();

					for (i = cur; i < cur + arg; i++) {
						text[i] = getchar();
						if (text[i] == '\n') i--;
					}

					mc += arg;
					continue;

				case 'D':
					scanf("elete %u", &arg);
					mc -= arg;
					memmove((text + cur), (text + cur + arg), (mc - cur));
					continue;

				case 'G':
					scanf("et %u", &arg);
					printf("%.*s\n", arg, (text + cur));
					continue;

				case 'M':
					scanf("ove %u", &arg);
					cur = arg;
					continue;

				case 'N':
					fseek(stdin, 3, SEEK_CUR);
					cur++;
					continue;

				case 'P':
					fseek(stdin, 3, SEEK_CUR);
					cur--;
					continue;
			}
		}
	}

	return 0;
}
