from functools import partial

## This function from the functools stdlib package
## allows for partial application of functions in
## python as is seen in languages like Haskell.

def hello(name, feeling = "!"):
    return f"Hello, {name}{feeling}"

confused_hello = partial(hello, feeling = "?")
hello_jacob = partial(hello, "Jacob")

