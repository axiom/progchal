#include <iostream>
#include <cmath>

using namespace std;

struct Tree {
	Tree *parent;
	Tree *left;
	Tree *right;
	long long int value;
};

Tree *newTree();
long double valueUp(Tree *);

int main()
{
	long long int leaf;
	double sum;
	char curr_c;

	Tree *tmp = NULL;
	Tree *root = NULL;
	Tree *pt = newTree();

	sum = 0;

	while (scanf("%c", &curr_c) == 1) {
		switch (curr_c) {

			// Create a new tree and attach it as a child to the current tree.
			case '(':
				tmp = newTree();
				tmp->parent = pt;

				// Attach tree to parent.
				if (pt->left == NULL) pt->left = tmp;
				else pt->right = tmp;

				pt = tmp;
				break;

			// Step out of the current tree.
			case ')':
				pt = pt->parent;
				break;

			default:
				ungetc(curr_c, stdin);

				if (scanf("%lli", &leaf) < 0) {
					cerr << "did not find value" << endl;
					break;
				}

				cerr << "leaf with value " << leaf << endl;
				pt->value = leaf;
		}

		if (root == NULL) root = pt;
	}

	cout << endl << valueUp(root) << endl;
	return 0;
}

Tree *newTree()
{
	Tree temp;
	temp.parent = NULL;
	temp.left = NULL;
	temp.right = NULL;
	temp.value = 0;
	return new Tree;
}

long double valueUp(Tree *t)
{
	// Actual leaf.
	if (t->left == NULL && t->right == NULL) {
		cout << t->value;
		return t->value;
	}

	long long int temp = 0;

	cout << " ( ";
	temp += valueUp(t->left);

	temp += valueUp(t->right);
	cout << " ) ";

	return temp / 2.0;
}
