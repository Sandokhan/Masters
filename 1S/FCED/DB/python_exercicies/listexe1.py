def maxelement(n):
    max = 0
    for i in n:
        if i > max:
            max = i
    print('Largest element is: ', max)

l = [1,1,1,2,3,4,10, 500]

maxelement(l)