#include <iostream>
#include <map>

using namespace std;

int cycle(unsigned int);
map<unsigned int, unsigned int> lookup;

int main()
{
	lookup[0] = 0;
	lookup[1] = 1;

	int longest, a, b, i, j;

	while (!cin.eof()) {
		longest = 0;
		cin >> a >> b;
		cin.get();
		cin.peek();

		i = min(a,b);
		j = max(a,b);

		for (int n = i; n <= j; n++) {
			longest = max(longest, cycle(n));
		}

		cout << a << " " << b << " " << longest << endl;
	}
	return 0;
}

int cycle(unsigned int n)
{
	// Check if we already know the answer.
	if (lookup[n] != NULL)
		return lookup[n];

	if (n % 2 == 0)
		lookup[n] = 1 + cycle(n / 2);
	else
		lookup[n] = 1 + cycle(3 * n + 1);

	return lookup[n];
}
