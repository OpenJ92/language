from slide4 import Meta

print("\n(Parsing)+ file")
print("Class Creation!\n")

class Rectangle(metaclass = Meta, db = "DATABASE"):

    def __init__(self, width : int = 10, height : int = 10) \
            -> type(None):
        print("\tRectangle.__init__\n")
        self._width : int = width
        self._height : int = height

    def perimiter(self) -> int:
        return 2*(self._width + self._height)

    def area(self) -> int:
        return self._width*self._height

class Square(Rectangle):
    def __init__(self, length : int) -> type(None):
        print("\tSquare.__init__")
        Rectangle.__init__(self, length, length)

if __name__ == "__main__":
    print("\nEnter __main__")
    print("Instance Creation!\n")
    example_rectangle = Rectangle("Hello", 12)
    example_square = Square(10)

## goback: slide2
## goto:   slide4
