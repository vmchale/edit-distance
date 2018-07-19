#include "share/atspre_staload.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "DATS/edit-distance.dats"
#include "$PATSHOMELOCS/specats-0.2.3/mylibies.hats"

implement main0 () =
  {
    var actual0 = levenshtein("exclude", "excude")
    var expected0 = 1
    var b0 = actual0 = expected0
    var n0 = @{ fst = "levenshtein", snd = b0 }
    var actual1 = levenshtein_ats("exclude", "excude")
    val () = println!(actual1)
    var expected1 = 1
    var b1 = actual1 = expected1
    var n1 = @{ fst = "levenshtein_ats", snd = b1 }
    var xs = n1 :: n0 :: nil
    var total = list_vt_length(xs)
    val g = @{ group = "Edit distance", leaves = xs } : test_tree
    val _ = iterate_list(g, 0, total)
  }
