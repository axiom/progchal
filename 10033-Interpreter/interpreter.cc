#include <iostream>
#include <algorithm>
#include <cassert>

using namespace std;

#define RAM_SIZE 1000
#define NUM_REGISTERS 10

unsigned int ram[RAM_SIZE];
unsigned int reg[NUM_REGISTERS];

int main()
{
	int rounds;
	cin >> rounds;
	cin.ignore();
	cin.ignore();

	for (int round = 0; round < rounds; round++) {
		// Clear ram and registers.
		fill_n(ram, RAM_SIZE, 0);
		fill_n(reg, NUM_REGISTERS, 0);

		int ops, pc, op, a, b;
		string line;
		pc = 0;

		// Read instructions to ram.
		while (getline(cin, line)) {
			if (line.empty()) break;
			ram[pc++] = atoi(line.c_str()) % 1000;
		}

		pc = 0;
		for (ops = 1;; ops++) {
			op =  ram[pc] / 100;       // Op code
			a  = (ram[pc] % 100) / 10; // First operand
			b  = (ram[pc] % 100) % 10; // Second operand
			pc++;

			assert(pc >= 0);
			assert(pc < RAM_SIZE);
			assert(op >= 0 && op < 10);
			assert(a >= 0 && a < 10);
			assert(b >= 0 && b < 10);

			if (op == 1) break;
			else if (op == 2) reg[a] = b;
			else if (op == 3) reg[a] = (reg[a] + b) % 1000;
			else if (op == 4) reg[a] = (reg[a] * b) % 1000;
			else if (op == 5) reg[a] = reg[b];
			else if (op == 6) reg[a] = (reg[a] + reg[b]) % 1000;
			else if (op == 7) reg[a] = (reg[a] * reg[b]) % 1000;
			else if (op == 8) reg[a] = ram[reg[b]] % 1000;
			else if (op == 9) ram[reg[b]] = reg[a] % 1000;
			else if (op == 0 && reg[b] != 0) pc = (reg[a] % 1000);
		}

		if (round > 0) cout << endl;
		cout << ops << endl;
	}

	return 0;
}
