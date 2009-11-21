#include <stdio.h>
#include <string.h>
#include <stdlib.h>

struct c_element {
	char val;
	struct c_element *next;
	struct c_element *prev;
};

typedef struct c_element item;

void insert(unsigned long int n);
void delete(unsigned long int n);
void get(unsigned long int n);
void move(unsigned long int n);
void next();
void prev();

void init();
void clear();

static item *root;
static item *point;

int main()
{
	unsigned long int cases, ops, arg;

	scanf("%u", &cases);

	while (cases--) {
		scanf("%u", &ops);
		getchar(); // Munch up newline character.

		init();

		while (ops--) {
			switch (getchar()) {

				case 'I':
					scanf("nsert %u", &arg);
					getchar();
					insert(arg);
					getchar();
					continue;

				case 'D':
					scanf("elete %u", &arg);
					delete(arg);
					getchar();
					continue;

				case 'G':
					scanf("et %u", &arg);
					get(arg);
					getchar();
					continue;

				case 'M':
					scanf("ove %u", &arg);
					move(arg);
					getchar();
					continue;

				case 'N':
					fseek(stdin, 4, SEEK_CUR);
					next();
					continue;

				case 'P':
					fseek(stdin, 4, SEEK_CUR);
					prev();
					continue;
			}
		}

		clear();
	}

	return 0;
}

void next()
{
	if (point->next != NULL)
		point = point->next;
}

void prev()
{
	if (point->prev != NULL)
		point = point->prev;
}

void move(unsigned long int n)
{
	point = root;
	while (n--) next();
}

void get(unsigned long int n)
{
	item *prt = point;
	item *old = point;

	while (n-- && prt->next != NULL) {
		prt = prt->next;
		putc(prt->val, stdout);
	}

	putc('\n', stdout);
	point = old;
}

void delete(unsigned long int n)
{
	item *del;

	while (n--) {
		del = point->next;

		if (del != NULL && del->next != NULL) {
			del->next->prev = del->prev;
			del->prev->next = del->next;
			free(del);
		}
	}
}

void insert(unsigned long int n)
{
	char c;
	item *cur, *old;

	cur = NULL;
	old = NULL;

	while (n--) {
		c = getchar();

		// Pretend we don't see newline characters.
		if (c == '\n') {
			n++;
			continue;
		}

		cur = (item *) malloc(sizeof(item));
		cur->val = c;

		// This is not the first character inserted, link this to previous one
		// and vice versa.
		if (old != NULL) {
			cur->prev = old;
			cur->next = old->next;

			if (old->next != NULL)
				old->next->prev = cur;

			old->next = cur;
		}

		// First element inserted this time, link cursor's next to this first
		// character, and it to the cursor.
		else {
			cur->prev = point;
			cur->next = point->next;

			if (point->next != NULL)
				point->next->prev = cur;

			point->next = cur;
		}

		old = cur;
	}
}

void clear()
{
	item *temp = root;

	while (temp) {
		point = temp;
		temp = temp->next;
		free(point);
	}
}

void init()
{
	root = (item *) malloc(sizeof(item));
	root->val = '\0';
	root->prev = NULL;
	root->next = NULL;
	point = root;
}
