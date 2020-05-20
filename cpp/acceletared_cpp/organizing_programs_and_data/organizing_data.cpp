#include "organizing_data.h"

int main()
{
	std::vector<Class> classes{
					Class{"F",std::map<std::string,float>{{"homework", .40}, {"final", .30}, {"midterm", .30}}}, 
			                Class{"E",std::map<std::string,float>{{"homework", .40}, {"final", .30}, {"midterm", .30}}}, 
					Class{"D",std::map<std::string,float>{{"homework", .10}, {"final", .60}, {"midterm", .30}}}, 
					Class{"C",std::map<std::string,float>{{"homework", .40}, {"final", .30}, {"midterm", .30}}}, 
					Class{"B",std::map<std::string,float>{{"homework", .40}, {"final", .30}, {"midterm", .30}}}, 
					Class{"A",std::map<std::string,float>{{"homework", .40}, {"final", .30}, {"midterm", .30}}}
	                          };
	std::vector<Teacher> teachers{
					Teacher{"A", classes}, 
					Teacher{"B", classes}, 
					Teacher{"C", classes}
	                             };
	std::vector<Work> assignments{
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 83},
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 60},
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 80},
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 80},
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 70},
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 32},
					Work{"A", "homework", "sdaf;lkajsdf", classes[2], 32},
					Work{"A", "homework", "sdaf;lkajsdf", classes[2], 80},
					Work{"A", "homework", "sdaf;lkajsdf", classes[2], 82},
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 85},
					Work{"A", "homework", "sdaf;lkajsdf", classes[1], 80},
					Work{"A", "midterm", "sdaf;lkajsdf", classes[1], 70},
					Work{"A", "final", "sdaf;lkajsdf", classes[1], 90},
					Work{"A", "midterm", "sdaf;lkajsdf", classes[2], 70},
					Work{"A", "final", "sdaf;lkajsdf", classes[2], 90}
				     };
	Student student{"Jacob Vartuli-Schonberg", assignments, classes};

	std::cout << grade(student, classes[2]);
	return 0;
}

void populate(Teacher& t, Class& c)
{
	t.classes.push_back(c);
}


void populate(Student& s, Work& w)
{
	s.assignments.push_back(w);
}

void populate(Student& s, Class& c)
{
	s.courses.push_back(c);
}

void populate(Teacher& t, std::vector<Class> cs)
{
	for 
	(
		std::vector<Class>::iterator it = cs.begin(); 	
		it != cs.end();
		++it
	)
	{
		populate(t, *it);
	}
}

void populate(Student& s, std::vector<Work> ws)
{
	for 
	(
		std::vector<Work>::iterator it = ws.begin(); 	
		it != ws.end();
		++it
	)
	{
		populate(s, *it);
	}
}


void populate(Student& s, std::vector<Class> cs)
{
	for 
	(
		std::vector<Class>::iterator it = cs.begin(); 	
		it != cs.end();
		++it
	)
	{
		populate(s, *it);
	}
}

double grade(Student& s, Class& c)
{
	std::map< std::string, std::pair<int, int> > course_assignments;

	// create initial structure to store total grade and number of number of 
	// course's assignment types.
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

	// populate above DS with data.
	for 
	(
	 	std::vector<Work>::iterator it = s.assignments.begin(); 
		it != s.assignments.end();
		++it
	)
	{
		if (it->course.name == c.name)
		{
			course_assignments.find(it->type)->second.first += it->grade;
			course_assignments.find(it->type)->second.second += 1;
		}
	}	

	// construct float from the average of the assignment types and the associated
	// weight of that average for the class.
	double total = 0;
	for 
	(
	 	std::map< std::string, std::pair<int, int> >::iterator it = course_assignments.begin();
		it != course_assignments.end();
		++it
	)
	{
		total += c.assignment_type.find(it->first)->second * (it->second.first / it->second.second);
	}

	return total;
}
