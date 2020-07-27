from functools import cached_property
from statistics import stdev, variance
from typing import List

Numbers = List[float]

## Note that this wrapper requires python 3.8._

class DataSet:
    def __init__(self, sequence_of_numbers : Numbers) -> None:
        self._data = sequence_of_numbers

    @cached_property
    def stdev(self) -> float:
        return stdev(self._data)

    @cached_property
    def variance(self) -> float:
        return variance(self._data)
