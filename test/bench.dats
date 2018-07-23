#define ALLOCA

#include "$PATSHOMELOCS/ats-bench-0.2.3/bench.dats"
#include "DATS/edit-distance.dats"

%{^
#define MIN3(a, b, c)                                                          \
  ((a) < (b) ? ((a) < (c) ? (a) : (c)) : ((b) < (c) ? (b) : (c)))

// taken from
// https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance#C
int levenshtein(char *s1, char *s2) {
  unsigned int s1len, s2len, x, y, lastdiag, olddiag;
  s1len = strlen(s1);
  s2len = strlen(s2);
  unsigned int column[s1len + 1];
  for (y = 1; y <= s1len; y++)
    column[y] = y;
  for (x = 1; x <= s2len; x++) {
    column[0] = x;
    for (y = 1, lastdiag = x - 1; y <= s1len; y++) {
      olddiag = column[y];
      column[y] = MIN3(column[y] + 1, column[y - 1] + 1,
                       lastdiag + (s1[y - 1] == s2[x - 1] ? 0 : 1));
      lastdiag = olddiag;
    }
  }
  return (column[s1len]);
}
%}

extern
fun levenshtein_c(string, string) : int =
  "mac#levenshtein"

fun levenshtein_bench() : void =
  { val i = levenshtein("exclude", "excude") }

fun levenshtein_c_bench() : void =
  { val i = levenshtein_c("exclude", "excude") }

val levenshtein_c_delay: io = lam () => levenshtein_c_bench()
val levenshtein_delay: io = lam () => levenshtein_bench()

// GOAL: around 100ns
// ACTUAL: around 300ns
implement main0 () =
  {
    val _ = print_slope("levenshtein", 15, levenshtein_delay)
    val _ = print_slope("levenshtein_c", 15, levenshtein_c_delay)
  }
