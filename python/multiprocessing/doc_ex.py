import os
import time
import random

from multiprocessing import Process, Queue, current_process, freeze_support

#
# Function run by worker processes
#

def worker(input, output):
    for func, args in iter(input.get, 'STOP'):
        result = calculate(func, args)
        output.put(result)

#
# Function used to calculate result
#

def calculate(func, args):
    result = func(*args)
    return '%s says that %s%s = %s' % \
        (current_process().name, func.__name__, args, result)

#
# Functions referenced by tasks
#

def plus(terms):
    return sum(terms)

#
#
#

def test():
    NUMBER_OF_PROCESSES = 4
    TASKS1 = [(plus, (range(i, 700000000),)) for i in range(20)]
    TASKS2 = [(plus, (range(i, 800000000),)) for i in range(10)]

    # Create queues
    task_queue = Queue()
    done_queue = Queue()

    # Submit tasks
    for task in TASKS1:
        task_queue.put(task)

    # Start worker processes
    for i in range(NUMBER_OF_PROCESSES):
        Process(target=worker, args=(task_queue, done_queue)).start()

    # Get and print results
    print('Unordered results:')
    for i in range(len(TASKS1)):
        print('\t', done_queue.get())

    # Add more tasks using `put()`
    for task in TASKS2:
        task_queue.put(task)

    # Get and print some more results
    for i in range(len(TASKS2)):
        print('\t', done_queue.get())

    # Tell child processes to stop
    for i in range(NUMBER_OF_PROCESSES):
        task_queue.put('STOP')


if __name__ == '__main__':
    start = time.perf_counter()
    freeze_support()
    test()
    finish = time.perf_counter()
    print(f"\n\tFinished in {finish - start} seconds;")

    start = time.perf_counter()
    TASKS1 = [(plus, (range(i, 700000000),)) for i in range(20)]
    TASKS2 = [(plus, (range(i, 800000000),)) for i in range(10)]
    for f, x in TASKS1:
        f(*x)
    finish = time.perf_counter()
    print(f"\n\tFinished in {finish - start} seconds;")
