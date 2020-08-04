from functools import wraps

## class Meta(type):
## 
##     @classmethod
##     def demo(fn):
##         @wraps
##         def wrapper(*args, **kwargs):
##             print(dir(fn))
##             fn(args, kwargs)
## 
##     def __new__(cls, name, bases, dct):
##         print("In __new__", cls, name, bases, dct)
##         import pdb;pdb.set_trace()
##         return super().__new__(cls, name, bases, dct)
## 
##     def __prepare__(name, bases):
##         print("In __prepare__", name, bases)
##         import pdb;pdb.set_trace()
##         return {"prepare__": lambda x: x + 1, "prepare___": lambda x: x - 1}
## 
##     def __call__(cls, *args, **kwargs):
##         print(f"In __call__: *args = {args}, **kwargs = {kwargs}")
##         import pdb;pdb.set_trace()
##         return super().__call__(*args, **kwargs)

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

class Class(metaclass=Meta, extra=1):

    def __new__(cls, myarg):
        print('  Class.__new__(cls=%s, myarg=%s)' % (cls, myarg))
        return super().__new__(cls)

    def __init__(self, myarg):
        print('  Class.__init__(self=%s, myarg=%s)' % (self, myarg))
        self.myarg = myarg
        return super().__init__()

    def __str__(self):
        return "<instance of Class; myargs=%s>" % ( getattr(self, 'myarg', 'MISSING'),)
