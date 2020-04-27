#include <string>
#include <iostream>

std::string question_one( std::string name,  int buffer);
std::string construct_greeting(std::string name);
std::string construct_buffer(std::string greeting);
std::string construct_border(std::string greeting);
std::string construct_frame
(
 	 std::string greeting, 
 	 std::string border, 
 	 std::string buffer
);

void question_two();
std::string construct_rectangle(int base, int height);
std::string construct_square(int base);
std::string construct_triangle(int base, int height);
