#!/bin/bash

# Bin directory
BIN_DIR="bin"

# Defining the valid options for each parameter
ALG_OPTIONS="CoarseGrainedListBasedSet HandOverHandListBasedSet LazyLinkedListSortedSet"
THREAD_OPTIONS="1 4 6 8 10 12"
UR_OPTIONS="0 10 100"
SIZE_OPTIONS="100 1000 10000"

# Clear the output file
> output.txt

for alg in $ALG_OPTIONS; do
  for size in $SIZE_OPTIONS; do
    for thread in $THREAD_OPTIONS; do
      output=$(java -cp "$BIN_DIR" contention.benchmark.Test -b linkedlists.lockbased.$alg -t $thread -u 10 -i $size -r $((2 * size)) -W 0 -d 2000 | grep 'Throughput (ops/s):' | awk '{print $3}')
      log="ALG: $alg THREAD: $thread UR: 10 SIZE: $size Throughput (ops/s): $output"
      echo "$log" | tee -a output.txt
    done
  done
done

for alg in $ALG_OPTIONS; do
  for ur in $UR_OPTIONS; do
    for thread in $THREAD_OPTIONS; do
      output=$(java -cp "$BIN_DIR" contention.benchmark.Test -b linkedlists.lockbased.$alg -t $thread -u $ur -i 100 -r 200 -W 0 -d 2000 | grep 'Throughput (ops/s):' | awk '{print $3}')
      log="ALG: $alg THREAD: $thread UR: $ur SIZE: 100 Throughput (ops/s): $output"
      echo "$log" | tee -a output.txt
    done
  done
done

for alg in $ALG_OPTIONS; do
  for thread in $THREAD_OPTIONS; do
    output=$(java -cp "$BIN_DIR" contention.benchmark.Test -b linkedlists.lockbased.$alg -t $thread -u 10 -i 1000 -r 2000 -W 0 -d 2000 | grep 'Throughput (ops/s):' | awk '{print $3}')
    log="ALG: $alg THREAD: $thread UR: 10 SIZE: 1000 Throughput (ops/s): $output"
    echo "$log" | tee -a output.txt
  done
done
