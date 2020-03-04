def fib(a = 1, b = 1, accumulator = 0):
    c = a + b
    if c >= 4e6: return accumulator
    accumulator += c if c%2==0 else 0
    return fib(b, c, accumulator)

if __name__ == "__main__":
    A = fib()
    print(f"fib() = {A}")
