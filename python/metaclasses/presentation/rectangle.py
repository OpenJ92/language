from __kablam__ import Meta

def A():
    class rectangle(object, metaclass = Meta, this = 1, that = 2):
        __type_check__ = ['area', 'perimiter', 'function_']

        def __init__(self:'rectangle', width:int = 10, height:int = 10):
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

    return rectangle

if __name__ == "__main__":
    rectangle = A()
    example = rectangle(10, 12)
