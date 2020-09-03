from typing import List, Union
from __kablam__ import TypeCheck

class Rectangle(metaclass = TypeCheck):
    __type_check__ = []

    def __init__(self, width : int = 10, height : int = 10) -> type(None):
        self._width : int = width
        self._height : int = height

    def perimiter(self) -> int:
        return 2*(self._width + self._height)

    def area(self) -> int:
        return self._width*self._height

class Square(Rectangle):
    __type_check__ = ['hello', 'there']
    def __init__(self, length : int) -> type(None):
        Rectangle.__init__(self, length, length)

    def hello(self, a : int, b : int, c : int = 10, d : int = 32) -> int:
        return a + b + c + d

    def there(self, how : str) -> str:
        return how + " are you?"

if __name__ == "__main__":
    print("\n\tCOMPLETE: Class Instance Construction\n")
    example_rectangle = Rectangle("Hello", 12)
    example_square = Square(10)
