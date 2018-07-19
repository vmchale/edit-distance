#include "share/atspre_staload.hats"
#include "share/HATS/atslib_staload_libats_libc.hats"
#include "DATS/edit-distance.dats"
#include "$PATSHOMELOCS/specats-0.2.3/mylibies.hats"

implement main0 () =
  {
    var actual = levenshtein("exclude", "excude")
    var expected = 1
    var b0 = actual = expected
    var n0 = @{ fst = "levenshtein", snd = b0 }
    var xs = n0 :: nil
    var total = list_vt_length(xs)
    val g = @{ group = "Edit distance", leaves = xs } : test_tree
    val _ = iterate_list(g, 0, total)
  }
