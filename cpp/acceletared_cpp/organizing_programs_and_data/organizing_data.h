#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>

struct Student;
struct Teacher;
struct Class;
struct Work;

struct Work
{
	const std::string title;
	const std::string type;
	const std::string content;
	Class& course;
	int grade;
};

struct Student
{
	const std::string name;
	std::vector<Work> assignments;
	std::vector<Class> courses;
};

struct Teacher
{
	std::string name;
	std::vector<Class> classes;
};

struct Class
{
	std::string name;
	std::map<std::string, float> assignment_type;
};

double grade(Student& s, Class& c);
