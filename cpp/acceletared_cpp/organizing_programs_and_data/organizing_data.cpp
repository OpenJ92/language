#include "organizing_data.h"

int main()
{
	return 0;
}


double grade(Student& s, Class& c)
{
	std::map< std::string, std::pair<int, int> > course_assignments;

	for
	(
	 	std::map<std::string, float>::iterator it = c.assignment_type.begin(); 
		it != c.assignment_type.end();
		++it
	)
	{
		std::pair<int, int> data(0, 0);
		course_assignments.insert(std::pair<std::string, std::pair<int, int> > (it->first, data));
	}

	for 
	(
	 	std::vector<Work>::iterator it = s.assignments.begin(); 
		it != s.assignments.end();
		++it
	)
	{
		std::pair<std::string, std::pair<int, int> > assignment_type = *course_assignments.find(it->type);
		assignment_type.second.first += it->grade;
		assignment_type.second.second += 1;
	}	

	return 0;
}
