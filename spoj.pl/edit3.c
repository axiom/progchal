#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 2048000

int main()
{
	int cases, ops, arg, cur, mc, i, size;

	size = 5000;
	char *text = (char *) malloc(size);

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

					if (mc + arg >= size) {
						size = (size + arg) * 2;
						text = (char *) realloc(text, size);
					}

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

	free(text);
	return 0;
}
