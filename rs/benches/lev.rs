#[macro_use]
extern crate criterion;
extern crate levenshtein;
extern crate strsim;

use criterion::Criterion;

fn criterion_benchmark(c: &mut Criterion) {
    c.bench_function("levenshtein-rs", |b| {
        b.iter(|| levenshtein::levenshtein("exclude", "excude"))
    });
}

fn criterion_benchmark_2(c: &mut Criterion) {
    c.bench_function("strsim", |b| {
        b.iter(|| strsim::levenshtein("exclude", "excude"))
    });
}

criterion_group!(benches, criterion_benchmark, criterion_benchmark_2);
criterion_main!(benches);
