#include "organizing_computations.h"

// int main()
// {
// 	std::vector<double> homework;
// 	read_hw(std::cin, homework);
// 	std::cout << grade(100, 80, homework);
// 	return 0;
// }

double grade(double _midterm, double _final, double _homework)
{
	return _midterm * .2 + _final * .4 + _homework * .4;
}

double grade
(
 	double _midterm, 
	double _final, 
	const std::vector<double>& hw
)
{
	return _midterm * .2 + _final * .4 + median(hw) * .4;
}

double median(std::vector<double> vec)
{
	std::vector<double>::size_type size = vec.size();
	if (size == 0)
	{
		throw std::domain_error("median of an empty array D.N.E.");
	}

	sort(vec.begin(), vec.end());
	std::vector<double>::size_type mid = size / 2;
	return size % 2 == 0 ? (vec[mid] + vec[mid+1]) / 2 : vec[mid];
}

std::istream& read_hw(std::istream& in , std::vector<double>& hw)
{
	if (in)
	{
		hw.clear();
		double x;
		while (in >> x)
		{
			hw.push_back(x);
		}
		in.clear();
	}
	return in;
}

