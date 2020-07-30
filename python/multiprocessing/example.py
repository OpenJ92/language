from multiprocessing import Process
import time; import os;

def function(sec):
    time.sleep(sec)

if __name__ == "__main__":
    info("main line")
    start = time.perf_counter()

    processes = [Process(target = function, args = [6]) for _ in range(100)]
    starts = [process.start() for process in processes]


    ## Wait @ this line for process to complete.
    joins = [process.join() for process in processes]

    finish = time.perf_counter()

    print(f"\n\tFinished in {finish - start} seconds;")
