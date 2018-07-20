#include "share/atspre_staload.hats"
#include "share/HATS/atspre_staload_prelude.hats"
#include "share/HATS/atspre_staload_libats_ML.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "$PATSHOMELOCS/ats-bench-0.2.3/bench.dats"
#include "DATS/edit-distance.dats"

fun levenshtein_bench() : void =
  { val i = levenshtein("exclude", "excude") }

val levenshtein_delay: io = lam () => levenshtein_bench()

implement main0 () =
  { val _ = print_slope("levenshtein", 14, levenshtein_delay) }
