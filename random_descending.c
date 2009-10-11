#include <stdio.h>
#include <math.h>

int main()
{
	char c; int n; float e = 0; unsigned char h = 0;
	for (;;) {
		if (1 == scanf("%i", &n)) e += n * pow(0.5,h);
		else if (1 == scanf("%c", &c)) h+=(c=='('?1:-1);
		else break;
	}
	printf("%.2f\n", e); return 0;
}
