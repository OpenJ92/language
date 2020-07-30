from multiprocessing import Process
import time; import os;

def info(title):
    print(title)
    print('module name:', __name__)
    print('parent process:', os.getppid())
    print('process id:', os.getpid())
    print('______\n')

def function():
    info("function")
    time.sleep(2)

if __name__ == "__main__":
    info("main line")
    start = time.perf_counter()

    process_one = Process(target = function)
    process_two = Process(target = function)
    process_thr = Process(target = function)

    process_one.start()
    process_two.start()
    process_thr.start()

    ## Wait @ this line for process to complete.
    process_one.join()
    process_two.join()
    process_thr.join()

    finish = time.perf_counter()

    print(f"\n\tFinished in {finish - start} seconds;")
