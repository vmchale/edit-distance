%{^
#define MIN3(a, b, c)                                                          \
  ((a) < (b) ? ((a) < (c) ? (a) : (c)) : ((b) < (c) ? (b) : (c)))

// taken from here:
// https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance#C
int levenshtein(char *s1, char *s2) {
  unsigned int s1len, s2len, x, y, lastdiag, olddiag;
  s1len = strlen(s1);
  s2len = strlen(s2);
  unsigned int column[s1len + 1];
  for (y = 1; y <= s1len; y++)
    column[y] = y;
  printf("\n");

  for (x = 1; x <= s2len; x++) {
    column[0] = x;
    for (y = 1, lastdiag = x - 1; y <= s1len; y++) {
      olddiag = column[y];
      column[y] = MIN3(column[y] + 1, column[y - 1] + 1,
                       lastdiag + (s1[y - 1] == s2[x - 1] ? 0 : 1));
      lastdiag = olddiag;
    }
  }
  // for (y = 1; y <= s1len; y++)
  //   printf("%d", column[y]);
  return (column[s1len]);
}
%}

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"
staload "prelude/SATS/string.sats"

fun min_3(x : int, y : int, z : int) : int =
  min(x, (min(y, z)))

fun bool2int(x : char, y : char) : int =
  if x = y then
    0
  else
    1

extern
fun string_unsafe_get(x : string, y : size_t) : char =
  "mac#"

fun levenshtein_ats {m:nat}{n:nat}(s1 : string(m), s2 : string(n)) : int =
  let
    val s1_l: size_t = string_length(s1)
    val s2_l: size_t = string_length(s2)
    val column: arrszref(int) = arrszref_make_elt(s1_l + 1, 0)
    
    fun print_loop {i:nat}(i : int(i)) : void =
      case+ i of
        | 0 => ()
        | k =>> (print_loop(k - 1) ; print!(column[k]))
    
    fun loop1 { i : nat | i <= m }(i : int(i)) : void =
      case+ i of
        | 0 => ()
        | i =>> {
          val () = column[i] := i
          val () = loop1(i - 1)
        }
    
    val () = loop1(sz2i(s1_l))
    
    fun loop2 { i : nat | i > 0 }(x : int(i)) : void =
      if x <= sz2i(s2_l) then
        {
          val () = column[0] := x
          val () = let
            fun inner_loop { j : nat | j > 0 }(y : int(j), last_diag : int) : void =
              if y <= sz2i(s1_l) then
                let
                  val old_diag = column[y]
                  val () = column[y] := min_3( column[y] + 1
                                             , column[y - 1] + 1
                                             , last_diag + bool2int(s1[y - 1], s2[x - 1])
                                             )
                in
                  inner_loop(y + 1, old_diag)
                end
              else
                ()
          in
            inner_loop(1, x - 1)
          end
          val () = loop2(x + 1)
        }
      else
        ()
    
    val () = loop2(1)
  in
    column[s1_l]
  end

extern
fun levenshtein(string, string) : int =
  "mac#"

extern
fun levenshtein_vt(s : !Strptr1, t : !Strptr1) : int =
  "mac#levenshtein"
