import time
import random

def output(parent):
    while True:
        output = [random.uniform(28, 30) for i in range(1)]
        parent.send(output)




