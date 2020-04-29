#include "organizing_data.h"
#include "organizing_computations.h"

int main()
{
	return 0;
}


double grade(Student& s, Class& c)
{
	std::map<std::string,int> course_assignments;

	for
	(
	 	std::vector<std::string>::iterator it = c.assignment_type.begin(); 
		it != c.assignment_type.end();
		++it
	)
	{
		course_assignments.insert(std::pair<std::string, int> (*it, 0));
	}

	int homework, test, term;
	int homework_count, test_count, term_count;
	for 
	(
	 	std::vector<Work>::iterator it = s.assignments.begin(); 
		it != s.assignments.end();
		++it
	)
	{
		auto assignment_type = course_assignments.find(it->type);
		if (it->type == "homemork" && it->course.name == c.name)
		{
			homework += it->grade;
			homework_count += 1;
		}
		else if (it->type == "test")
		{
			test += it->grade;
			test_count += 1;
		}
		else if (it->type == "term")
		{
			term += it->grade;
			term_count += 1;
		}
	}	
	return .6 * (homework / homework_count) +
		.2 * (test / test_count) +
		 .2 * (term / term_count);
}
