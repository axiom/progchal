#include <iostream>
#include <vector>

using namespace std;

double exchange(vector<double>);

int main()
{
	vector<double> money;
	double rows, money_in;
	
	while (cin >> rows && rows != 0) {
		money.clear();
		for (int i = 0; i < rows; i++) {
			cin >> money_in;
			money.push_back(money_in);
		}

		printf("$%.2f\n", exchange(money));
	}
	return 0;
}

double exchange(vector<double> money)
{
	int number_of_students = money.size();

	// Total amount spent by students.
	double total = 0;
	for (int i = 0; i < number_of_students; i++) { total += money[i]; }

	// Equalized amount to be payed.
	double equalized = total / number_of_students;


	double diff;
	double over = 0;
	double under = 0;

	for (int i = 0; i < number_of_students; i++) {
		diff = (double) (long) ((money[i] - equalized) * 100.0) / 100.0;

		if (diff > 0) {
			over += diff;
		} else {
			under += -diff;
		}
	}

	return max(over, under);
}
