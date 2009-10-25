#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

int main()
{
	vector<double> numbers;
	double temp;

	while (1 == scanf("%lf", &temp))
		numbers.push_back(sqrt(temp));

	for (int i = numbers.size() - 1; i >= 0; i--)
		printf("%.4f\n", numbers.at(i));

	return 0;
}
