// #define ALLOCA
#include "$PATSHOMELOCS/ats-bench-0.2.3/bench.dats"
#include "DATS/edit-distance.dats"

%{^
#define MIN3(a, b, c)                                                          \
  ((a) < (b) ? ((a) < (c) ? (a) : (c)) : ((b) < (c) ? (b) : (c)))

char *str_large(int cLen) {
  char *str = malloc(cLen + 1);
  memset(str, 'a', cLen);
  str[cLen] = '\0';
  return str;
}

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
fun str_large {m:nat}(int(m)) : string(m) =
  "mac#"

// extern
// val test_data_blank: string = "mac#"
extern
fun levenshtein_c(string, string) : int =
  "mac#levenshtein"

fun levenshtein_bench() : void =
  { val i = levenshtein("exclude", "excude") }

fun levenshtein_bench_large() : void =
  {
    val s = str_large(1000)
    val _ = levenshtein(s, s)
  }

fun levenshtein_bench_c_large() : void =
  {
    val s = str_large(1000)
    val _ = levenshtein_c(s, s)
  }

fun levenshtein_c_bench() : void =
  { val i = levenshtein_c("exclude", "excude") }

val levenshtein_c_delay: io = lam () => levenshtein_c_bench()
val levenshtein_delay: io = lam () => levenshtein_bench()
val levenshtein_delay_large: io = lam () => levenshtein_bench_large()
val levenshtein_c_delay_large: io = lam () => levenshtein_bench_c_large()

// GOAL: around 100ns
implement main0 () =
  {
    val _ = print_slope("levenshtein", 15, levenshtein_delay)
    val _ = print_slope("levenshtein_c", 15, levenshtein_c_delay)
    val _ = print_slope("levenshtein_large", 2, levenshtein_delay_large)
    val _ = print_slope("levenshtein_c_large", 2, levenshtein_c_delay_large)
  }
