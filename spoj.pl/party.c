#include <stdio.h>
#include <stdlib.h>

static int table[500][100];
static int parties[100][2];

void prep();
void sort(int);
int optimal(int, int);
int backtrack(int, int);

int main()
{
	int i, c, f, w, n, o, b;

	while (1) {
		if (2 != scanf("%u %u", &w, &n)) return -1;
		if (w == 0 && n == 0) break;

		prep();

		for (i = 0; i < n; i++) {
			if (2 != scanf("%u %u", &c, &f)) return -1;
			parties[i][0] = c;
			parties[i][1] = f;
		}

		sort(n);

		for (o = 0; o < n; o++) {
			for (b = 0; b < w; b++) {
				optimal(o, b);
			}
		}

		o =   optimal(n - 1, w);
		b = backtrack(n - 1, w);
		printf("%d %d\n", b, o);
	}

	return 0;
}

int compparty(const void* r, const void* s)
{
	int* a = (int*) r;
	int* b = (int*) s;

	if (*a < *b) return -1;
	else if (*a == *b) return 0;
	else return 1;
}

void sort(int i)
{
	qsort(parties, i, 2 * sizeof(int), compparty);
}

int optimal(int i, int w)
{
	if (i < 0 || w < 0)    return 0;
	if (table[i][w] != -1) return table[i][w];

	int co = parties[i][0];
	int fo = parties[i][1];
	int c1 = optimal(i - 1, w);

	if (co > w) {
		table[i][w] = c1;
	} else if (c1 < (fo + optimal(i - 1, w - co))) {
		table[i][w] = fo + optimal(i - 1, w - co);
	} else {
		table[i][w] = c1;
	}

	return table[i][w];
}

int backtrack(int n, int w)
{
	if (n < 0 || w < 0) return 0;

	int c1, c2, co, fo;

	co = parties[n][0];
	fo = parties[n][1];
	c1 = optimal(n - 1, w);
	c2 = optimal(n - 1, w - co);

	if (co > w) {
		return backtrack(n - 1, w);
	} else if (c1 < (fo + c2)) {
		return (co + backtrack(n - 1, w - co));
	} else {
		return backtrack(n - 1, w);
	}
}

void prep()
{
	int i, j;
	for (i = 0; i < 500; i++) {
		for (j = 0; j < 100; j++) {
			parties[j][0] = -1;
			parties[j][1] = -1;
			table[i][j]   = -1;
		}
	}
}
