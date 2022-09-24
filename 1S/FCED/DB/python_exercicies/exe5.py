from re import X


def sum_numbers(n):
    x = 0
    n = int(input('Hey, choose a number: '))
    for i in range(1,n+1):
        x += i
    print('Sum of all numbers: ', x)

sum_numbers(3)