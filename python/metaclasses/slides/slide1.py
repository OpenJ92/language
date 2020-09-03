class Rectangle():

    def __init__(self, width : int = 10, height : int = 10) -> type(None):
        self._width : int = width
        self._height : int = height

    def perimiter(self) -> int:
        return 2*(self._width + self._height)

    def area(self) -> int:
        return self._width*self._height

    def say(self, name):
        return f"Hello, {name}!"

class Couches():
    def __init__(self, height, width, depth, softness, pillows, cushions):
        self._pillow = pillows
        self._cushions = cushions
        self._softeness = softness

    def comfy(self):
        return self._pillow ** self._cushions / self._softeness

if __name__ == "__main__":
    example_rectangle = Rectangle(10, 12)

## goto: slide2
