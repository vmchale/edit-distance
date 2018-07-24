staload UN = "prelude/SATS/unsafe.sats"

extern
fun alloca {n:int}(bsz : size_t(n)) :<!wrt> [l:agz] (b0ytes(n) @ l | ptr(l)) =
  "mac#"

extern
castfn arrayptr_alloca_encode : {a:vt@ype} {l:addr} {n:int} (array_v(INV(a), l, n) | ptr(l)) -<0> arrayptr(a, l, n)

extern
fun {a:vt@ype} array_ptr_alloca {n:int} (asz : size_t(n)) :<!wrt> [l:agz] (array_v(a?, l, n) | ptr(l))

implement {a} array_ptr_alloca {n} (asz) =
  let
    val [l:addr](pf | p) = alloca(asz * sizeof<a>)
    prval pf = __assert(pf) where
    { extern
      praxi __assert(pf : b0ytes(n*sizeof(a)) @ l) : array_v(a?, l, n) }
  in
    (pf | p)
  end

// end of [array_ptr_alloc]
// Ported over from
// https://en.wikibooks.org/wiki/Algorithm_Implementation/Strings/Levenshtein_distance#C
//
// With contributions from Hongwei Xi and Artyom Shalkhakov
fn levenshtein { m, n : nat }(s1 : string(m), s2 : string(n)) : int =
  let
    val s1_l: size_t(m) = length(s1)
    val s2_l: size_t(n) = length(s2)
    val column = arrayptr_make_uninitized<int>(s1_l + 1)
    val () = arrayptr_initize<int>(column, s1_l + 1) where
    { implement array_initize$init<int> (i, x) =
        x := sz2i(i) }
    val column = arrayptr_refize(column)
    
    fun loop2 { i : nat | i > 0 && i <= n+1 } .<n-i+1>. (x : int(i)) : void =
      if x <= sz2i(s2_l) then
        {
          val () = column[0] := x
          val () = let
            fun inner_loop { j : nat | j > 0 && j <= m+1 } .<m-j+1>. (y : int(j), last_diag : int) : void =
              if y <= sz2i(s1_l) then
                let
                  fn min_3(x : int, y : int, z : int) : int =
                    min(x, (min(y, z)))
                  
                  fn bool2int(x : char, y : char) : int =
                    if x = y then
                      0
                    else
                      1
                  
                  var old_diag = column[y]
                  val () = column[y] := min_3( column[y] + 1
                                             , column[y - 1] + 1
                                             , last_diag + bool2int(s1[y - 1], s2[x - 1])
                                             )
                in
                  inner_loop(y + 1, old_diag)
                end
          in
            inner_loop(1, x - 1)
          end
          val () = loop2(x + 1)
        }
    
    val () = loop2(1)
  in
    column[s1_l]
  end

fn levenshtein_(s1 : string, s2 : string) : int =
  let
    extern
    castfn witness(s : string) : [m:nat] string(m)
  in
    levenshtein(witness(s1), witness(s2))
  end

fn levenshtein_vt {m:nat}{n:nat}(s1 : !strnptr(m), s2 : !strnptr(n)) : int =
  levenshtein{m,n}($UN.castvwtp1(s1), $UN.castvwtp1(s2))
