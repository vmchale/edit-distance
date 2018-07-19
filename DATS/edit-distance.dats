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

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload "prelude/SATS/string.sats"

fun min_3(x : int, y : int, z : int) : int =
  min(x, (min(y, z)))

fun bool2int(x : char, y : char) : int =
  if x = y then
    0
  else
    1

fun levenshtein_ats {m:nat}{n:nat}(x : string(m), y : string(n)) : int =
  let
    val x_l: size_t = string_length(x)
    val y_l: size_t = string_length(y)
    val column: arrszref(int) = arrszref_make_elt(x_l + 1, 0)
    
    fun loop1 {i:nat}(i : int(i)) : void =
      case+ i of
        | 0 => ()
        | i =>> {
          val () = column[i] := i
          val () = loop1(i - 1)
        }
    
    val () = loop1(sz2i(x_l))
    
    fun loop2 {j:nat}(j : int(j)) : void =
      case+ j of
        | 0 => ()
        | _ =>> let
          val () = column[0] := (sz2i(y_l) - j)
          
          fun inner_loop {k:nat}(k : int(k), last_diag : int) : void =
            case- k of
              | 0 => ()
              | _ when k > 0 =>> {
                val old_diag = column[k]
                val () = column[k] := min_3( column[x_l - k] + 1
                                           , column[k - 1] + 1
                                           , last_diag + bool2int(x[k - 1], y[j - 1])
                                           )
                val () = inner_loop(k - 1, old_diag)
              }
          
          val _ = inner_loop(sz2i(y_l), j - 1)
        in
          loop2(j - 1)
        end
    
    val () = loop2(sz2i(y_l))
  in
    column[x_l]
  end

extern
fun levenshtein(string, string) : int =
  "mac#"

extern
fun levenshtein_vt(s : !Strptr1, t : !Strptr1) : int =
  "mac#levenshtein"
