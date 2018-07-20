#include "share/atspre_staload.hats"
#include "DATS/edit-distance.dats"
#include "$PATSHOMELOCS/specats-0.4.0/mylibies.hats"

implement main0 () =
  {
    var actual0 = levenshtein("abcd", "abdc")
    var expected0 = levenshtein("abcd", "abdc")
    var b0 = actual0 = 2
    var n0 = @{ test_name = "levenshtein", test_result = b0 }
    var actual1 = levenshtein("exclude", "excude")
    var expected1 = 1
    var b1 = actual1 = expected1
    var n1 = @{ test_name = "levenshtein_ats", test_result = b1 }
    var xs = n1 :: n0 :: nil
    var total = list_vt_length(xs)
    val g = @{ group = "Edit distance", leaves = xs } : test_tree
    val _ = iterate_list(g, 0, total)
  }
