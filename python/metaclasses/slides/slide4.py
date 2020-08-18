class Meta(type):
    @classmethod
    def __prepare__(cls, name, bases, **kwargs):
        print(f"\t{name} Meta.__prepare__")
        import pdb;pdb.set_trace()
        return { "func": lambda self, x : self, "blarg":"wort!" }

    def __new__(cls, name, bases, attrs, **kwargs):
        print(f"\t{name} Meta.__new__")
        import pdb;pdb.set_trace()
        return super().__new__(cls, name, bases, attrs)

    def __init__(cls, name, bases, attrs, **kwargs):
        print(f"\t{name} Meta.__init__\n")
        import pdb;pdb.set_trace()
        return super().__init__(name, bases, attrs)

    def __call__(cls, *args, **kwargs):
        print(f"\t{cls.__name__} Meta.__call__")
        import pdb;pdb.set_trace()
        return super().__call__(*args, **kwargs)

## goback: slide3
## goto:   slide5
