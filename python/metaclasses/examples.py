import types
from functools import wraps

class Meta(type):

    def __prepare__(name, bases, **kwargs):
        print('  Meta.__prepare__(name=%r, bases=%s, **%s)' % (name, bases, kwargs))
        return {}

    def __new__(cls, name, bases, attrs, **kwargs):
        print('  Meta.__new__(mcs=%s, name=%r, bases=%s, attrs=[%s], **%s)' % (cls, name, bases, ', '.join(attrs), kwargs))
        return super().__new__(cls, name, bases, attrs)

    def __init__(cls, name, bases, attrs, **kwargs):
        print('  Meta.__init__(cls=%s, name=%r, bases=%s, attrs=[%s], **%s)' % (cls, name, bases, ', '.join(attrs), kwargs))
        return super().__init__(name, bases, attrs)

    def __call__(cls, *args, **kwargs):
        print('  Meta.__call__(cls=%s, args=%s, kwargs=%s)' % (cls, args, kwargs))
        return super().__call__(*args, **kwargs)


def notify(fn, *args, **kwargs):

    def fncomposite(*args, **kwargs):
        print("running %s" % fn.__name__)
        rt = fn(*args, **kwargs)
        return rt
    return fncomposite

class Notifies(type):

    def __new__(cls, name, bases, attr, **kwargs):
        for name, value in attr.items():
            print(name, type(value))
            if isinstance(value, (types.FunctionType, types.MethodType)):
                attr[name] = notify(value)

        return super(Notifies, cls).__new__(cls, name, bases, attr)

def __A__():
    class Class(metaclass=Meta, extra=1):

        random = []

        ## @classmethod
        ## def another(cls):
        ##     return None

        ## def __prepare__(name, bases, **kwargs):
        ##     print('  Meta.__prepare__(name=%r, bases=%s, **%s)' % (name, bases, kwargs))
        ##     import pdb;pdb.set_trace()
        ##     return {}

        def __new__(cls, myarg):
            print('  Class.__new__(cls=%s, myarg=%s)' % (cls, myarg))
            return super().__new__(cls)

        def __init__(self, myarg="There"):
            print('  Class.__init__(self=%s, myarg=%s)' % (self, myarg))
            self.myarg = myarg
            return super().__init__()

        def __str__(self):
            return "<instance of Class; myargs=%s>" % ( getattr(self, 'myarg', 'MISSING'),)

        def newfunc(self, arg1, arg2, arg3, arg4, kwarg1 = 10, kwarg2 = 20, kwarg3 = 30):
            return "Hello, there!"
    return Class
