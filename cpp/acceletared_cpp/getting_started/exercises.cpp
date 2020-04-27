#include <iostream>
#include "exercises.h"

int main()
{
	question_one();
	std::cout << question_two(3, 4) << std::endl;
	question_three();
	return 0;
}

void question_one()
{
	std::cout << "Goodbye, world!" << std::endl;
}

int question_two(int x, int y)
{
	return x + y;
}

void question_three()
{
	std::cout << "This (\") is a quote, and this (\\) is a back-slash.";
}
