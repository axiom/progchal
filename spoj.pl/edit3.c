#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 2048000

int number();

static char text[MAX];

int main()
{
	int cases, ops, arg, cur, mc, i;

	cases = number();

	while (cases--) {
		ops = number();
		cur = 0;
		mc  = 0;

		while (ops--) {
			switch (getchar()) {

				case 'I': /* Insert 3 abc */
					fseek(stdin, 6, SEEK_CUR);
					arg = number();

					memmove((text + cur + arg), (text + cur), (mc - cur));

					for (i = cur; i < cur + arg; i++) {
						text[i] = getchar();
						if (text[i] == '\n') i--;
					}

					getchar();

					mc += arg;
					continue;

				case 'D': /* Delete 30 */
					fseek(stdin, 6, SEEK_CUR);
					arg = number();
					mc -= arg;
					memmove((text + cur), (text + cur + arg), (mc - cur));
					continue;

				case 'G': /* Get 10 */
					fseek(stdin, 3, SEEK_CUR);
					printf("%.*s\n", number(), (text + cur));
					continue;

				case 'M': /* Move 23 */
					fseek(stdin, 4, SEEK_CUR);
					cur = number();
					continue;

				case 'N': /* Next */
					fseek(stdin, 4, SEEK_CUR);
					cur++;
					continue;

				case 'P': /* Prev */
					fseek(stdin, 4, SEEK_CUR);
					cur--;
					continue;

			}
		}

		getchar();
	}

	return 0;
}

int number()
{
	char c;
	int n = 0;

	while (1) {
		c = getchar();
		if (c >= 48 && c <= 57) {
			n = 10 * n + c - 48;
		} else {
			return n;
		}
	}
}
