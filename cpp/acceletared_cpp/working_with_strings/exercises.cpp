#include "exercises.h"

int main()
{
	question_one();
	//question_two();
	return 0;
}

void question_one()
{
	// Are the following definitions valid? Why?
	const std::string hello = "Hello"; // Valid == assignment to string type variable 
	const std::string message = hello + ", world!" + "!"; // Valid use of hello and concat
}

//void question_two()
//{
//	const std::string exclam = "!"; // This is incorrect. There is no operation between 
//					// char[n] + char[m]. Summation as concatonation is 
//					// defined on std::string + std::string.
//	const std::string message = "Hello" + ", world" + exclam;
//}
