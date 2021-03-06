import types
from copy import deepcopy
from functools import wraps
import dis

class TypeCheck(type):

    @classmethod
    def greeting(cls, fn):
        def wrapper(*args, **kwargs):
            print(f"\ngreetings! thanks for choosing to call {fn.__code__.co_name}!\n")
            return fn(*args, **kwargs)
        return wrapper

    @classmethod
    def __construct__default__(cls, fn, __vars__):
        if fn.__defaults__:
            __default__ = dict(zip(__vars__[len(__vars__) - len(fn.__defaults__):], fn.__defaults__))
        else:
            __default__ = None
        return __default__

    @classmethod
    def __collect_kwargs__(cls, __kwargs__, __compiled_args__, annotations):
        for key, _ in annotations.items():
            __compiled_args__[key] = __kwargs__.pop(key) if key in __kwargs__.keys() else None

    @classmethod
    def __collect_args__(cls, __args__, __compiled_args__):
        for key, value in __compiled_args__.items():
             if value == None and len(__args__) > 0:
                 __compiled_args__[key] = __args__.pop(0)

    @classmethod
    def __collect_defaults__(cls, __default__, __compiled_args__):
        for key, value in __compiled_args__.items():
            if value == None and key != 'return' and __default__:
                __compiled_args__[key] = __default__.pop(key)

    @classmethod
    def __type_check_args__(cls, __vars__, annotations, __compiled_args__):
        for var in __vars__:
            if var not in annotations.keys():
                raise TypeError(f"parameter {var} must be strictly typed")
            elif isinstance(__compiled_args__[var], annotations[var]):
                continue
            else:
                raise TypeError(\
                        f"parameter {var} = {__compiled_args__[var]} is of type {type(__compiled_args__[var])} change to type {annotations[var]}")


    @classmethod
    def __type_check_retval__(cls, retval, annotations):
        if not isinstance(retval, annotations['return']):
            raise TypeError(f"retval = {retval} {type(retval)} : {annotations[var]}")

    @classmethod
    def runtime_type_check(cls, fn):
        @wraps(fn)
        def wrapper(*args, **kwargs):

            annotations  = fn.__annotations__
            _, *__vars__ = fn.__code__.co_varnames
            _, *__args__ = args
            __kwargs__ = deepcopy(kwargs)

            __default__ = TypeCheck.__construct__default__(fn, __vars__)

            __compiled_args__ = {}
            TypeCheck.__collect_kwargs__(__kwargs__, __compiled_args__, annotations)
            TypeCheck.__collect_args__(__args__, __compiled_args__)
            TypeCheck.__collect_defaults__(__default__, __compiled_args__)

            TypeCheck.__type_check_args__(__vars__, annotations, __compiled_args__)
            retval = fn(*args, **kwargs)
            TypeCheck.__type_check_retval__(retval, annotations)

            return retval
        return wrapper

    @classmethod
    def parsetime_type_check(cls, fn):
        @wraps(fn)
        def wrapper():

            annotations  = fn.__annotations__
            _, *__vars__ = fn.__code__.co_varnames
            __vars__ += ['return']

            for name in __vars__:
                if name not in annotations.keys():
                    import pdb;pdb.set_trace()
                    raise TypeError(f"{fn.__module__}.{fn.__name__} @ {fn.__code__.co_filename} : line {fn.__code__.co_firstlineno} must be strictly typed. Update parameter '{name}' with a type")

        return wrapper

    @classmethod
    def __prepare__(cls, name, bases, **kwargs):
        return {}

    def __new__(cls, name, bases, attrs, **kwargs):
        for ident, value in attrs.items():
            if isinstance(value, (types.FunctionType, types.MethodType)):
                if (ident in attrs['__type_check__']):
                    TypeCheck.parsetime_type_check(value)()
                    attrs[ident] = TypeCheck.runtime_type_check(value)
        return super().__new__(cls, name, bases, attrs)

    def __init__(cls, name, bases, attrs, **kwargs):
        return super().__init__(name, bases, attrs)

    def __call__(cls, *args, **kwargs):
        return super().__call__(*args, **kwargs)
