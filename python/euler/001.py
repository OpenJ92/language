def divisible_by(list_, factors):
    filtered_list = []
    for element in list_:
        for factor in factors:
            if element % factor == 0:
                filtered_list.append(element)
                break
    return filtered_list

if __name__ == "__main__":
    sum_ = sum(divisible_by(range(0, 1000), [3,5]))
    print(f"sum = {sum_}")
