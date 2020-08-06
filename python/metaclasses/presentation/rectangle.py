from __kablam__ import Meta

def A():
    class rectangle(object, metaclass = Meta, this = 1, that = 2):
        __greeting__ = ['area', 'perimiter']

        def __init__(self, width, height):
            print('rectangle.__init__')
            self._width = width
            self._height = height

        def perimiter(self):
            return 2*(self._width + self._height)

        def area(self):
            return self._width*self._height

        def __str__(self):
            return f"Rectangle: H - {self._height}, W - {self._width}"
    return rectangle

if __name__ == "__main__":
    rectangle = A()
    example = rectangle(10, 12)
