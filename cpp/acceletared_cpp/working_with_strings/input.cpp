#include "input.h"

int main()
{
	println(get_name());
	return 0;
}

std::string get_name()
{
	println("Type your name into the console:\n");
	std::string name; std::cin >> name;
        return name;
}

void println(std::string str)
{
	std::cout << str << std::endl;
}
