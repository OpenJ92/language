#include "organizing_data.h"
#include "organizing_computations.h"

int main()
{
	return 0;
}


double grade(Student& s)
{
	return grade(s._midterm, s._final, s.homework);
}

std::istream& read(std::istream& in, Student& s)
{
	in >> s.name >> s._midterm >> s._final;
	read_hw(in, s.homework);
	return in;
}

bool insert_work(Student& student, Work& work)
{
	student.assignments.push_back(work);
	return true;
}
