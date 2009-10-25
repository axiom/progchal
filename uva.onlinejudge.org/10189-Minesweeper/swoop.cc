#include <iostream>

using namespace std;

int main()
{
	bool* mines;
	int* sweep;
	int rows, columns;
	int game = 1;

	// Continue until there is a field of size 0x0.
	while (cin >> rows >> columns && !(rows == 0 && columns == 0)) {
		cin.ignore(); // Eat the line ending.

		mines = new bool[rows * columns];
		sweep = new int [rows * columns];

		// Get the mine positions.
		for (int row = 0; row < rows; row++) {
			char line[columns];
			cin.getline(line, columns + 1); // Eat the eol character.
			for (int column = 0; column < columns; column++)
				mines[row * columns + column] = line[column] == '*';
		}

		// Calculate number hints.
		for (int pos = 0; pos < rows * columns; pos++) {
			int row    = pos / columns;
			int column = pos % columns;
			int count  = 0; // Number of neighbouring mines.

			// Over and under.
			count += row > 0        && mines[pos - columns];
			count += row < rows - 1 && mines[pos + columns];

			// Left column
			if (column > 0) {
				count += mines[pos - 1];
				count += row > 0        && mines[pos - columns - 1];
				count += row < rows - 1 && mines[pos + columns - 1];
			}

			// Right column
			if (column < columns - 1) {
				count += mines[pos + 1];
				count += row > 0        && mines[pos - columns + 1];
				count += row < rows - 1 && mines[pos + columns + 1];
			}

			sweep[pos] = count;
		}

		// Separate games with newline
		if (game > 1)
			cout << endl;

		cout << "Field #" << game++ << ":" << endl;
		for (int row = 0; row < rows; row++) {
			for (int column = 0; column < columns; column++) {
				if (mines[row * columns + column])
					cout << '*';
				else
					cout << sweep[row * columns + column];
			}
			cout << endl;
		}
	}
	return 0;
}
