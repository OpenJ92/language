from typing import List
from __kablam__ import TypeCheck

class Rectangle(metaclass = TypeCheck):
    __type_check__ = ['function_', '__init__', 'area', 'perimiter']

    def __init__(self, width : int = 10, height : int = 10) -> type(None):
        self._width : int = width
        self._height : int = height

    def perimiter(self) -> int:
        return 2*(self._width + self._height)

    def area(self) -> int:
        return self._width*self._height

    def __str__(self) -> str:
        return f"Rectangle: H - {self._height}, W - {self._width}"

    def function_(self, a:int, b:int, c:int, d:int = 10, e:int = 20, f:int = 30) -> int:
         return a + b + c + d + e + f

if __name__ == "__main__":
    print("\n\tCOMPLETE: Class Construction\n")
    example = Rectangle(10, 12)
    print("\n\tCOMPLETE: Class Instance Construction\n")
