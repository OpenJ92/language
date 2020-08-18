class Rectangle():
    def __init__(self, width : int = 10, height : int = 10) -> type(None):
        self._width : int = width
        self._height : int = height

    def perimiter(self) -> int:
        return 2*(self._width + self._height)

    def area(self) -> int:
        return self._width*self._height

class Foo:
    def __init__(self):
        pass

class Square(Foo, Rectangle):
    def __init__(self, length : int) -> type(None):
        Foo.__init__(self)
        Rectangle.__init__(self, length, length)

if __name__ == "__main__":
    example_rectangle = Rectangle.__call__("Hello", 12)
    example_square = Square(10)

# goback: slide1
# goto:   slide3
