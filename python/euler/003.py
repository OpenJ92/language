from math import sqrt

def prime_factor(num, factor=2, factors=[]):
    if is_prime(num):
        factors.append(num);
        return factors
    elif (num % factor == 0 and is_prime(factor)):
        num = int(num / factor)
        factors.append(factor)
        return prime_factor(num, factor, factors)
    else:
        factor += 1
        return prime_factor(num, factor, factors)

def is_prime(num):
    if num == 2: return True
    if num %  2 == 0: return False
    for i in range(3, int(sqrt(num) + 1), 2):
        if num % i == 0: return False
    return True

if __name__ == "__main__":
    A = prime_factor(27023)
    print(f"prime_factor() = {A}")
