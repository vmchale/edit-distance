# edit-distance

[![Build Status](https://travis-ci.org/vmchale/edit-distance.svg?branch=master)](https://travis-ci.org/vmchale/edit-distance)

The Levenshtein edit distance, packaged for ATS. This implementation is written
in safe ATS and is nearly as fast as the C implementation.

## Benchmarks

| Language | Library | Unicode | Time |
| Haskell | `edit-distance` | X | 479.0 ns |
| Rust | `levenshtein-rs` | X | 137.4 ns
| Rust | `strsim` | X | 140.4 ns
| ATS | `edit-distance` |  | 94.03 ns |
| C | n/a |  | 93.08 ns |
