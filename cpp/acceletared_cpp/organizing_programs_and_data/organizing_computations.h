#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

double grade(double _midterm, double _final, double _homework);
double grade(double _midterm, double _final, const std::vector<double>& hw);
double median(std::vector<double> vec);
std::istream& read_hw(std::istream& in , std::vector<double>& hw);
