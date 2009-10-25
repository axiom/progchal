#include <iostream>

using namespace std;

struct Athlete {
	unsigned int mass;
	unsigned int strength;
};

int main()
{
	int number_of_athletes;
	scanf("%u", &number_of_athletes);

	Athlete athletes [number_of_athletes];

	unsigned int m, s;
	for (int i = 0; i < number_of_athletes; i++) {
		scanf("%u%u", &m, &s);
		Athlete temp;
		temp.mass = m;
		temp.strength = s;
		athletes[i] = temp;
	}

	return 0;
}
