#include <stdio.h>
#include <string.h>

static char text[2048000];

int main()
{
	int cases, ops, arg;
	int cur, mc, i;

	scanf("%u", &cases);

	while (cases--) {
		scanf("%u", &ops);
		cur = 0;
		mc  = 0;

		while (ops--) {
			switch (getc(stdin)) {
				case 'N':
					fseek(stdin, 3, SEEK_CUR);
					cur++;
					continue;

				case 'P':
					fseek(stdin, 3, SEEK_CUR);
					cur--;
					continue;

				case 'G':
					scanf("et %u", &arg);
					printf("%.*s\n", arg, (text + cur));
					continue;

				case 'D':
					scanf("elete %u", &arg);
					mc -= arg;
					memmove((text + cur), (text + cur + arg), (mc - cur));
					continue;

				case 'M':
					scanf("ove %u", &arg);
					cur = arg;
					continue;

				case 'I':
					scanf("nsert %u", &arg);
					memmove((text + cur + arg), (text + cur), (mc - cur));
					getc(stdin);

					for (i = cur; i < cur + arg; i++) {
						text[i] = getc(stdin);
						if (text[i] == '\n') i--;
					}

					mc += arg;
					continue;

				case ' ':
				case '\n':
					ops++;
			}
		}
	}

	return 0;
}
