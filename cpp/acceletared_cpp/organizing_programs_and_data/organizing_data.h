#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

struct Student
{
	std::string name;
	double _midterm, _final;
	std::vector<double> homework;
};

double grade(Student& s);
std::istream& read(std::istream& in, Student& s);
