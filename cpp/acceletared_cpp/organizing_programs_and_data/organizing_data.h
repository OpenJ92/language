#ifndef organizing_data
#define organizing_data

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
	std::vector<Student> student;
};

double grade(Student& s, Class& c);
void populate(Student& s, Work& w);
void populate(Student& s, Class& c);
void populate(Teacher& t, Class& c);
void populate(Student& s, std::vector<Work> ws);
void populate(Student& s, std::vector<Class> cs);
void populate(Teacher& t, std::vector<Class> cs);

#endif
