#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

// Each row is a digit with either turned on or turned off segments.
const bool SEGMENTS[10][7] = {
	{1,1,1,0,1,1,1}, // 0
	{0,0,1,0,0,1,0}, // 1
	{1,0,1,1,1,0,1}, // 2
	{1,0,1,1,0,1,1}, // 3
	{0,1,1,1,0,1,0}, // 4
	{1,1,0,1,0,1,1}, // 5
	{1,1,0,1,1,1,1}, // 6
	{1,0,1,0,0,1,0}, // 7
	{1,1,1,1,1,1,1}, // 8
	{1,1,1,1,0,1,1}  // 9
};

vector<int> number2digits(int);
void asciify(int, int);


int main()
{
	unsigned int s, n;
	while (cin >> s >> n && !(s == 0 && n == 0)) {
		asciify(s, n);
		cout << endl;
		cin.peek();
	}

	return 0;
}

vector<int> number2digits(int number)
{
	int number_of_digits = 0;
	int number_copy = number;

	while (number_copy > 0) {
		number_of_digits++;
		number_copy /= 10;
	}

	vector<int> digits;
	digits.clear();

	int pounce;
	for (int i = number_of_digits - 1; i >= 0; i--) {
		pounce = (int) pow((double) 10, (double) i);
		digits.push_back(number / pounce);
		number = number % pounce;
	}

	return digits;
}

void asciify(int size, int number)
{
	vector<int> digits;
	if (number == 0)
		digits.push_back(0);
	else
		digits = number2digits(number);

	int number_of_digits = digits.size();

	// Paint all digits row by row.
	for (int row = 0; row < 2 * size + 3; row++) {

		// Paint this row of each digit.
		for (int d = 0; d < number_of_digits; d++) {

			int digit = digits.at(d);
			char digit_line[size + 2];
			fill_n(digit_line, size + 2, ' ');

			// Top horizontal segment
			if (row == 0) {
				for (int c = 1; c < size + 1 && SEGMENTS[digit][0]; c++)
					digit_line[c] = '-';
			}

			// Middle vertical segments
			else if (row < size + 1) {
				if (SEGMENTS[digit][1])
					digit_line[0] = '|';
				if (SEGMENTS[digit][2])
					digit_line[size + 1] = '|';
			}

			// Middle horizontal segment
			else if (row < size + 2) {
				for (int c = 1; c < size + 1 && SEGMENTS[digit][3]; c++)
					digit_line[c] = '-';
			}

			// Bottom vertical segments
			else if (row < 2 * size + 2) {
				if (SEGMENTS[digit][4])
					digit_line[0] = '|';
				if (SEGMENTS[digit][5])
					digit_line[size + 1] = '|';
			}

			// Bottom horizontal segment
			else if (row < 2 * size + 3) {
				for (int c = 1; c < size + 1 && SEGMENTS[digit][6]; c++)
					digit_line[c] = '-';
			}

			for (int c = 0; c < size + 2; c++)
				cout << digit_line[c];

			if (d + 1 < number_of_digits)
				cout << " ";

		}

		cout << endl;
	}
}
