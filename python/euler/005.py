from math import sqrt

def construct_minimal_int(factors):
    """TODO: Docstring for construct_minimal_int.
    :factors: TODO
    :returns: TODO
    """
    pass

def is_prime(num):
    """TODO: Docstring for is_prime.
    :num: TODO
    :returns: TODO
    """
    if num == 2: return True
    if num % 2 == 0: return False
    sq = sqrt(num)
    for i in range(3, int(round(sq)), 2):
        if num%i==0: return False
    return True

def prime_factor(num, factor=2, factors=[1]):
    """TODO: Docstring for prime_factor.
    :num: TODO
    :factor: TODO
    :factors: TODO
    :returns: TODO
    """
    if is_prime(num):
        factors.append(num)
        return factors
    elif (num % factor == 0) and is_prime(factor):
        num = num//factor
        factors.append(factor)
        return prime_factor(num, factor, factors)
    else:
        factor += 1
        return prime_factor(num, factor, factors)

if __name__ == "__main__":
    pass
