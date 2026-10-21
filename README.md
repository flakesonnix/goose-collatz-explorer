# Collatz Explorer

Examines Collatz sequences over a range of numbers and finds the number with the most steps, using recursion.

## Build & Run

```bash
goose build explore.goose && ./explore
```

Or directly in the compiler (JIT):

```bash
goose explore.goose
```

## Expected Output

```
Number with the most steps (1..10000): 6171
Steps: 261
```

## Features

- `recursive fn` for both `collatz_steps` and `explore_best`
- `collatz_steps` computes steps recursively with base case `n == 1`
- `explore_best` walks the range recursively, tracking `best` and `best_steps`
- Multiple return values: `explore_best` returns `(best, best_steps)`
- No allocation — everything on the stack
