#include "exercises.h"

int main()
{
	std::cout << question_one("Jacob", 10) << std::endl;
	question_two();
	return 0;
}

std::string question_one(std::string name, int buffer)
{
	// construct greeting given the name and the number of 
	// spaces in the frame.

	int count = 0;

	std::string greeting = construct_greeting(name);
	std::string border = construct_border(greeting);
	std::string space;

	while (count < buffer)
	{
		space += construct_buffer(greeting) + "\n";
		count++;
	}

	std::string frame = construct_frame(greeting, border, space);
	return frame;

}

std::string construct_greeting(std::string name)
{
	std::string greeting = "* Hello, " + name + " *";
	return greeting;
}

std::string construct_buffer(std::string greeting)
{
	std::string::size_type size = greeting.size()-2;
	std::string spaces(size, ' ');
	std::string buffer = "*" + spaces + "*";
	return buffer;
}

std::string construct_border(std::string greeting)
{
	std::string::size_type size = greeting.size();
	std::string stars(size, '*');
	return stars;
}

std::string construct_frame
(
 	 std::string greeting, 
 	 std::string border, 
 	 std::string buffer
)
{
	return border + "\n" + buffer + greeting + "\n" + buffer + border;
}

void question_two()
{
	std::cout << construct_rectangle(10, 5) << std::endl;
	std::cout << construct_square(5) << std::endl;
	std::cout << construct_triangle(20, 15) << std::endl;
}

std::string construct_rectangle(int base, int height)
{
	int row = 0; std::string output;
	std::string stars(base, '*');
	while (row < height)
	{
		output += stars + "\n"; row++;
	}
	return output;
}

std::string construct_square(int base)
{
	return construct_rectangle(base,base);
}

std::string construct_triangle(int base, int height)
{
	int row = 0; std::string output;
	while (row < height)
	{
		std::string stars(row + 1, '*');
		output += stars + "\n"; row++;
	}
	return output;
}
