def factorial(n):
  if n == 1:
    return 1
  else:
    return n*factorial(n-1)

def fibonacci(n):
  if n == 0:
    return 0
  elif n == 1:
    return 1
  else:
    return fibonacci(n-1)+fibonacci(n-2)

num = float(input("Enter number: "))
print("Factorial: " + str(factorial(num)))
print("Ficonacci number of index: " + str(fibonacci(num)))
