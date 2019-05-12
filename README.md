# edit-distance

[![Build Status](https://travis-ci.org/vmchale/edit-distance.svg?branch=master)](https://travis-ci.org/vmchale/edit-distance)

The Levenshtein edit distance, packaged for ATS. This implementation is written
in safe ATS and is performant.

## Building

### For Hacking

To run the test suite, first install
[atspkg](http://hackage.haskell.org/package/ats-pkg). The simplest way to do so
is to run

```
curl -sSl https://raw.githubusercontent.com/vmchale/atspkg/master/bash/install.sh | sh -s
```

Thereafter, you can run

```
atspkg test
```

to hack on the library.

### For Use

You can use the `edit-distance` package in `atspkg` projects with something like
the example in
[polyglot](https://github.com/vmchale/polyglot/blob/master/atspkg.dhall#L73).

Currently, there is no NPM release for this package; however, there is nothing
stopping you from using the tarballs or git repository to use this package
conventionally using NPM.

## Benchmarks

| Language | Library | Unicode | Time |
| -------- | ------- | ------- | ---- |
| ATS | `edit-distance` |  | 67.61 ns |
| Rust | `levenshtein-rs` | X | 137.4 ns
| Rust | `strsim` | X | 140.4 ns
| Haskell | `edit-distance` | X | 413.5 ns |
| C | n/a |  | 93.70 ns |

Note that these benchmarks use `libgc` for ATS and C and thus ATS and
C functions may be faster if you use manual memory management.
