from multiprocessing import Process
import time; import os;

def info(title):
    print(title)
    print('module name:', __name__)
    print('parent process:', os.getppid())
    print('process id:', os.getpid())
    print('______\n')

def function(sec):
    info("function")
    time.sleep(sec)

## Look into locking and sharing of data between processes.
if __name__ == "__main__":
    info("main line")
    start = time.perf_counter()

    processes = [Process(target = function, args = [6]) for _ in range(100)]
    starts    = [process.start() for process in processes]
    joins     = [process.join() for process in processes]

    finish = time.perf_counter()

    print(f"\n\tFinished in {finish - start} seconds;")
