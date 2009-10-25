#include <iostream>
#include <algorithm>
#include <vector>
#include <set>

using namespace std;

int main()
{
	vector<unsigned int> a, b;
	set<unsigned int> isec;
	unsigned int temp;

	while (1 == scanf("%i", &temp) && temp != -1)
		a.push_back(temp);

	while (1 == scanf("%i", &temp) && temp != -1)
		b.push_back(temp);

	sort(a.begin(), a.end());
	sort(b.begin(), b.end());

	int x,y,i,j;
	x = y = i = j = 0;

	while (i < a.size() && j < b.size()) {
		x = a.at(i);
		y = b.at(j);

		if (x < y) i++;
		else if (x > y) j++;
		else {
			isec.insert(x);
			i++;
			j++;
		}
	}

	set<unsigned int>::iterator k;
	for (k = isec.begin(); k != isec.end(); k++)
		printf("%d ", *k);

	if (isec.size() == 0)
		printf("empty\n");

	return 0;
}
