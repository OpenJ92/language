from threading import Thread
import time; import os;

def function(sec):
    print("Enter: threaded function")
    time.sleep(sec)
    print("Exit : threaded function")

if __name__ == "__main__":
    start = time.perf_counter()

    threads   = [Thread(target = function, args = [1]) for _ in range(100)]
    starts    = [process.start() for process in threads]
    joins     = [process.join() for process in threads]

    finish = time.perf_counter()

    print(f"\n\tFinished in {finish - start} seconds;")
