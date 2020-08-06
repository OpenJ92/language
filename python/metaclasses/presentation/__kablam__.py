import types
from functools import wraps

class Meta(type):

    @classmethod
    def greeting(cls, fn):
        def wrapper(*args, **kwargs):
            print(f"\ngreetings! thanks for choosing to call {fn.__code__.co_name}!\n")
            return fn(*args, **kwargs)
        return wrapper

    def __prepare__(name, bases, **kwargs):
        print('Meta.__prepare__')
        import pdb;pdb.set_trace()
        return {"FUNCTION": lambda s, x: print(s, x) }

    def __new__(cls, name, bases, attrs, **kwargs):
        import pdb;pdb.set_trace()
        for name, value in attrs.items():

            if isinstance(value, (types.FunctionType, types.MethodType)):

                if (name in attrs['__greeting__']):
                    attrs[name] = Meta.greeting(value)

        return super().__new__(cls, name, bases, attrs)

    ## def __init__(cls, name, bases, attrs, **kwargs):
    ##     print('Meta.__init__')
    ##     return super().__init__(name, bases, attrs)

    def __call__(cls, *args, **kwargs):
        print('Meta.__call__')
        for elmt in args:
            if not isinstance(elmt, (float, int)):
                raise TypeError(f'Argument {elmt} must be a int or float.')
        import pdb;pdb.set_trace()
        return super().__call__(*args, **kwargs)
