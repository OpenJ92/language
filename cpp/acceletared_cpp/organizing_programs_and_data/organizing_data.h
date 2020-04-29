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
	std::string title;
	std::string type;
	std::string content;
	Class& course;
	Student& student;
	int grade;
};

struct Student
{
	std::string name;
	std::vector<Work> assignments;
	std::vector<Class> courses;
	double _final, _midterm;
	std::vector<double> homework;
};

struct Teacher
{
	std::string name;
	std::vector<Class*> classes;
};

struct Class
{
	std::string name;
	std::map<std::string, float> assignment_type;
	std::vector<Student> students;
	std::vector<Teacher> teachers;
};

double grade(Student& s, Class& c);
