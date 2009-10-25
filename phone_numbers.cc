#include <algorithm>
#include <iostream>
#include <limits.h>
#include <map>
#include <string>
#include <vector>

#define LONGEST_WORD 50

using namespace std;

// Setup, i/o and tear down.
void run();
void clean();

// String and number conversion.
char char2digit(char);
string word2digits(string);

// Computing and printing solutions.
unsigned int iterative_computeOPT();
unsigned int computeOPT(int);
void printSolution(int);

int plen; // Phone number length.
multimap<int, int> offset_words;
string *numbers;
string *words;
string phone_number;
unsigned int *OPT; // Optimal solutions for each offset.
unsigned int num_of_words; // Number of possible words that can be used.

void run()
{
	cin >> phone_number >> num_of_words;
	if (phone_number == "-1") return;

	plen = phone_number.length();

	// We need room for the full phone number, but also room to check the
	// hypothetical indexes extending a maximum of the LONGEST_WORD beyond the
	// phone_number. This was the BIG GOTCHA!
	OPT = new unsigned int[plen + LONGEST_WORD];
	fill_n(OPT, plen + LONGEST_WORD, 0);
	fill_n(OPT, plen, INT_MAX);

	words   = new string[num_of_words];
	numbers = new string[num_of_words];

	string temp;
	int loc;

	for (int i = 0; i < num_of_words; i++) {
		cin >> words[i];
		numbers[i] = word2digits(words[i]);

		loc = 0;
		do {
			loc = (int) phone_number.find(numbers[i], loc);
			if (loc != string::npos) offset_words.insert(pair<int, int>(loc, i));
		} while (loc++ != string::npos);
	}

	// computeOPT(0);
	iterative_computeOPT();
	printSolution(0);
	clean();
}


void clean()
{
	offset_words.clear();
	delete [] OPT;
	delete [] words;
	delete [] numbers;
}


unsigned int iterative_computeOPT()
{
	// To iterate through possible words at each offset.
	pair<multimap<int,int>::iterator,multimap<int,int>::iterator> ret;
	multimap<int,int>::iterator iter;

	unsigned int minimum;
	int wlen, i;

	for (i = plen - 1; i >= 0; i--) {
		minimum = INT_MAX;

		ret = offset_words.equal_range(i);
		for (iter = ret.first; iter != ret.second; iter++) {
			wlen = words[iter->second].length();
			minimum = min(minimum, 1 + OPT[i + wlen]);
		}

		OPT[i] = minimum;
	}

	return OPT[0];
}


unsigned int computeOPT(int offset)
{
	// If the size of the number is zero, there can be no words, hence zero
	// cost.
	if (offset > plen - 1) return 0;

	// Return if already defined.
	if (OPT[offset] != INT_MAX) return OPT[offset];

	// If there are no matching words...
	if (offset_words.count(offset) == 0) return INT_MAX;

	pair<multimap<int,int>::iterator,multimap<int,int>::iterator> ret;
	multimap<int,int>::iterator iter;

	ret = offset_words.equal_range(offset);
	for (iter = ret.first; iter != ret.second; iter++) {
		int wlen = words[iter->second].length();
		OPT[offset] = min(OPT[offset], 1 + computeOPT(offset + wlen));
	}

	return OPT[offset];
}


void printSolution(int offset)
{
	if (OPT[offset] == INT_MAX) {
		cout << "No solution.";
		return;
	}

	// No need to compute beyond phone number length.
	if (offset >= plen) return;

	// Spacing between words
	if (offset > 0) cout << " ";

	unsigned int mini, prev;
	int word_i;
	prev = mini = INT_MAX;

	pair<multimap<int,int>::iterator,multimap<int,int>::iterator> ret;
	multimap<int,int>::iterator iter;
	ret = offset_words.equal_range(offset);

	for (iter = ret.first; iter != ret.second; iter++, prev = mini) {
		mini = min(mini, 1 + OPT[offset + words[iter->second].length()]);
		if (mini != prev) word_i = iter->second;
	}

	cout << words[word_i];
	printSolution(offset + words[word_i].length());
}


string word2digits(string word)
{
	string digits = string(word);
	unsigned int i, wl;
	for (i = 0, wl = word.length(); i < wl; i++) {
		digits[i] = char2digit(word[i]);
	}

	return digits;
}


char char2digit(char c)
{
	// Keypad layout
	//
	// 1 ij    2 abc   3 def
	// 4 gh    5 kl    6 mn
	// 7 prs   8 tuv   9 wxy
	//         0 oqz

	switch (c) {
		case 'i': case 'j':           return '1';
		case 'a': case 'b': case 'c': return '2';
		case 'd': case 'e': case 'f': return '3';
		case 'g': case 'h':           return '4';
		case 'k': case 'l':           return '5';
		case 'm': case 'n':           return '6';
		case 'p': case 'r': case 's': return '7';
		case 't': case 'u': case 'v': return '8';
		case 'w': case 'x': case 'y': return '9';
		case 'o': case 'q': case 'z': return '0';
	}

	return '\0';
}


int main()
{
	while (true) {
		run();

		// Bail if we're out of input.
		if (cin.eof()) return 0;

		cout << endl;
	}
}
