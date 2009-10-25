#include <iostream>
#include <algorithm>

using namespace std;

int main()
{
	bool *diffs;
	bool jolly;
	int n, curr, prev;

	while (1 == scanf("%d", &n)) {
		diffs = new bool[n];
		fill_n(diffs, n, false);

		// Read integers and mark diffs.
		for (int i = 0; i < n; i++, prev = curr) {
			scanf("%d", &curr);
			if (i == 0) continue;
			diffs[abs(prev - curr)] = true;
		}

		// Check that each differance from 1 to n - 1 is present.
		jolly = true;
		for (int i = 1; i < n && jolly; i++)
			jolly = diffs[i] && jolly;

		if (jolly) cout << "Jolly"     << endl;
		else       cout << "Not jolly" << endl;

		delete [] diffs;
	}
	return 0;
}
