#include "$PATSHOMELOCS/ats-bench-0.2.3/bench.dats"
#include "DATS/edit-distance.dats"

fun levenshtein_bench() : void =
  { val i = levenshtein("exclude", "excude") }

val levenshtein_delay: io = lam () => levenshtein_bench()

// GOAL: around 100ns
// ACTUAL: around 300ns
implement main0 () =
  { val _ = print_slope("levenshtein", 13, levenshtein_delay) }
