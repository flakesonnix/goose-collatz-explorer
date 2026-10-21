// collatz_explorer.goose — finds the number with the most Collatz steps in a range (recursive)

recursive fn collatz_steps(n: i64) -> i64 {
    if n == 1 { return 0; }
    if n % 2 == 0 {
        return 1 + collatz_steps(n / 2);
    } else {
        return 1 + collatz_steps(3 * n + 1);
    }
}

recursive fn explore_best(n: i64, end: i64, best: i64, best_steps: i64) -> i64, i64 {
    if n >= end { return best, best_steps; }
    let s = collatz_steps(n);
    if s > best_steps {
        return explore_best(n + 1, end, n, s);
    } else {
        return explore_best(n + 1, end, best, best_steps);
    }
}

fn main() {
    let b, bs = explore_best(1, 10000, 1, 0);
    print("Number with the most steps (1..10000): ", b);
    print("Steps: ", bs);
}
