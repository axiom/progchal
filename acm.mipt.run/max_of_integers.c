#include <stdio.h>
#include <limits.h>

int main()
{
	int temp, max;
	max = INT_MIN;

	while (1 == scanf("%i", &temp))
		max = max > temp ? max : temp;

	printf("%i", max);
	return 0;
}
