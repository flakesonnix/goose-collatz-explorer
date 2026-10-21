// Unit test: Collatz Explorer (recursive)
// Checks that the explorer finds the number with the most steps.

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
    // Small range: 1..10 -> 9 has the most steps (19)
    let b1, s1 = explore_best(1, 10, 1, 0);
    assert(b1 == 9);
    assert(s1 == 19);

    // Larger range: 1..100 -> 97 has the most steps (118)
    let b2, s2 = explore_best(1, 100, 1, 0);
    assert(b2 == 97);
    assert(s2 == 118);

    // Full range: 1..10000 -> 6171 has the most steps (261)
    let b3, s3 = explore_best(1, 10000, 1, 0);
    assert(b3 == 6171);
    assert(s3 == 261);

    print("collatz_explorer unit tests passed");
}
