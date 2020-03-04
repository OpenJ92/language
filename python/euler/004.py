def is_palindrome(num):
    """TODO: Docstring for is_palindrome.
    :num: TODO
    :returns: TODO
    """
    digits = get_digits(num)
    len_ = len(digits)
    for element in range(len_):
        print(digits[element] ,digits[len_ - element - 1])
        if digits[element] != digits[len_ - element - 1]:
            return False
    return True

def palindrome_products():
    """TODO: Docstring for palindrome_products.
    :returns: TODO
    """
    palindromes = []
    for i in reversed(range(100, 999)):
        for j in reversed(range(i, 999)):
            if is_palindrome(i*j):
                palindromes.append(i*j)
    return max(palindromes)

def get_digits(num):
    """TODO: Docstring for get_digits.
    :num: TODO
    :returns: TODO
    """
    digits = []
    while True:
        digit = num % 10
        digits.append(digit)
        num = num // 10
        if num < 1:
            break
    return digits

if __name__ == "__main__":
    pal = palindrome_products()
