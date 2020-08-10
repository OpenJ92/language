import types
from functools import wraps

class Meta(type):

    @classmethod
    def greeting(cls, fn):
        def wrapper(*args, **kwargs):
            print(f"\ngreetings! thanks for choosing to call {fn.__code__.co_name}!\n")
            return fn(*args, **kwargs)
        return wrapper

    @classmethod
    def type_check(cls, fn):
        def wrapper(*rgs, **kwargs):
            annotations = fn.__annotations__
            __self__, *__vars__ = fn.__code__.co_varnames
            __self__, *__args__ = rgs
            __kwargs__ = kwargs

            __default__ = dict(zip(__vars__[len(fn.__defaults__):], fn.__defaults__))

            __compiled_args__ = {}
            for key, _ in annotations.items():
                __compiled_args__[key] = __kwargs__[key] if key in __kwargs__.keys() else None

            for key, value in __compiled_args__.items():
                if value == None and len(__args__) > 0:
                    __compiled_args__[key] = __args__.pop(0)

            for key, value in __compiled_args__.items():
                if value == None and key != 'return':
                    __compiled_args__[key] = __default__[key]

            for var in __vars__:
                if var not in annotations.keys():
                    raise TypeError(f"parameter {var} must be strictly typed")
                elif isinstance(__compiled_args__[var], annotations[var]):
                    continue
                else:
                    raise TypeError(\
                            f"""parameter {var} = {__compiled_args__[var]} must be type {annotations[var]}, currently {type(__compiled_args__[var])}""")

            retval = fn(*rgs, **kwargs)

            if not isinstance(retval, annotations['return']):
                raise TypeError(\
                        f"""retval = {retval} must be type {annotations[var]}, currently {type(retval)}""")

            return retval
        return wrapper


    def __prepare__(name, bases, **kwargs):
        return {}

    def __new__(cls, name, bases, attrs, **kwargs):
        for name, value in attrs.items():
            if isinstance(value, (types.FunctionType, types.MethodType)):
                if (name in attrs['__type_check__']):
                    attrs[name] = Meta.type_check(value)

        return super().__new__(cls, name, bases, attrs)

    def __init__(cls, name, bases, attrs, **kwargs):
        return super().__init__(name, bases, attrs)

    def __call__(cls, *args, **kwargs):
        for elmt in args:
            if not isinstance(elmt, (float, int)):
                raise TypeError(f'Argument {elmt} must be a int or float.')
        import pdb;pdb.set_trace()
        return super().__call__(*args, **kwargs)
