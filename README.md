# SLR206 - Concurrent Data Structures Benchmark Suite

A comprehensive Java-based micro-benchmark suite for evaluating synchronization techniques on concurrent data structures, specifically focusing on optimistic lock-based list implementations.

## Overview

This project is built upon **Synchrobench**, a micro-benchmark framework designed to evaluate synchronization techniques on concurrent data structures. The implementation focuses on comparing different approaches to building thread-safe, high-performance list-based sets in Java.

## Features

### Data Structures Implemented

- **Arrays**: Copy-on-write, lock-based, sequential, and transactional variants
- **Hash Tables**: Lock-based, lock-free, sequential, and transactional implementations
- **Linked Lists**: Multiple synchronization strategies
  - **CoarseGrainedListBasedSet**: Simple coarse-grained locking approach
  - **HandOverHandListBasedSet**: Fine-grained hand-over-hand locking
  - **LazyLinkedListSortedSet**: Lazy synchronization with optimistic validation
- **Queues**: Lock-free, sequential, and transactional versions
- **Skip Lists**: Various synchronization techniques
- **Trees**: Lock-based, lock-free, sequential, and transactional binary trees

### Synchronization Techniques

- **Copy-on-Write**: Immutable data structure approach
- **Lock-based**: Traditional mutex-based synchronization
- **Lock-free**: Non-blocking algorithms using compare-and-swap
- **Transactional Memory**: Software transactional memory using bytecode instrumentation
- **Optimistic Concurrency**: Lazy validation and optimistic updates

## Architecture

### Core Components

```
java/
├── src/                    # Source implementations
│   ├── linkedlists/        # List-based set implementations
│   │   ├── lockbased/      # Lock-based synchronization variants
│   │   ├── lockfree/       # Lock-free implementations
│   │   ├── sequential/     # Non-concurrent baseline
│   │   └── transactional/  # STM-based versions
│   ├── hashtables/         # Hash table implementations
│   ├── trees/              # Binary tree variants
│   └── contention/         # Benchmarking framework
├── bin/                    # Compiled classes
├── lib/                    # Dependencies (Deuce STM, JUnit)
└── scripts/                # Benchmark execution scripts

python/
├── plots.ipynb             # Performance analysis notebook
├── output/                 # Benchmark results
└── charts/                 # Generated performance graphs
```

## Key Algorithms

### 1. Coarse-Grained List-Based Set
- Simple approach using a single global lock
- High contention but easy to implement and reason about
- Best for low-concurrency scenarios

### 2. Hand-Over-Hand List-Based Set
- Fine-grained locking with lock coupling
- Reduces contention by locking only adjacent nodes
- Better scalability than coarse-grained approach

### 3. Lazy Linked List Sorted Set
- Optimistic concurrency with lazy validation
- Based on the algorithm from "A Lazy Concurrent List-Based Set Algorithm" (OPODIS 2005)
- Uses logical deletion with physical cleanup
- Excellent performance under high contention

## Getting Started

### Prerequisites
- Java 8 or higher
- Make
- Python 3.x (for analysis)
- Jupyter Notebook (optional, for visualization)

### Building
```bash
cd java
make
```

### Running Benchmarks
```bash
cd java/scripts
./run.sh
```

### Analyzing Results
```bash
cd python
jupyter notebook plots.ipynb
```

## Benchmark Parameters

- **Threads**: Number of concurrent threads (1, 4, 6, 8, 10, 12)
- **Update Ratio (UR)**: Percentage of update operations (0%, 10%, 100%)
- **List Size (LS)**: Initial size of the data structure (100, 1000, 10000)
- **Duration**: Benchmark runtime (2000ms default)

## Performance Results

The project includes comprehensive performance analysis comparing different algorithms across various scenarios:

- **Low contention** (UR=0%): Read-heavy workloads
- **Medium contention** (UR=10%): Mixed read/write workloads  
- **High contention** (UR=100%): Write-heavy workloads

Results show that:
- **LazyLinkedListSortedSet** performs best under high contention
- **CoarseGrainedListBasedSet** is competitive for small thread counts
- **HandOverHandListBasedSet** provides good middle-ground performance

## Academic Background

This implementation is based on research from leading experts in concurrent programming:

- **Maurice Herlihy** and **Nir Shavit**: "The Art of Multiprocessor Programming"
- **Vincent Gramoli**: Synchrobench framework and concurrent data structure research
- **Heller et al.**: "A Lazy Concurrent List-Based Set Algorithm" (OPODIS 2005)

## Citations

If you use this benchmark suite in your research, please cite:

```
V. Gramoli. More than You Ever Wanted to Know about Synchronization. 
PPoPP 2015. https://sites.google.com/site/synchrobench/
```

## License

See individual source files for copyright notices. This project builds upon the Synchrobench framework and includes implementations from various academic papers.
