staload UN = "prelude/SATS/unsafe.sats"

extern
fun alloca {n:int}(bsz : size_t(n)) :<!wrt> [l:agz] (b0ytes(n) @ l | ptr(l)) =
  "mac#"

extern
castfn arrayptr_alloca_encode : {a:vt0p} {l:addr} {n:int} (array_v(INV(a), l, n) | ptr(l)) -<0> arrayptr(a, l, n)

extern
fun {a:vt0p} array_ptr_alloca {n:int} (asz : size_t(n)) :<!wrt> [l:agz] (array_v(a?, l, n) | ptr(l))

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
fn levenshtein {m:nat}{n:nat}(s1 : string(m), s2 : string(n)) : int =
  let
    val s1_l: size_t(m) = length(s1)
    val s2_l: size_t(n) = length(s2)
    
    fn array_initialize() : arrayref(int, m+1) =
      let
        val (pf_arr | p_arr) = array_ptr_alloca<int>(succ(s1_l))
        var p1_arr = ptr1_succ<int>(p_arr)
        prval (pf1_at, pf_arr) = array_v_uncons{int?}(pf_arr)
        val () = ptr_set<int>(pf1_at | p_arr, 0)
        var i: int = 0
        prval [larr:addr]EQADDR () = eqaddr_make_ptr(p1_arr)
        var p = p1_arr
        prvar pf0 = array_v_nil{int}()
        prvar pf1 = pf_arr
        val () = while* { i : nat | i <= m }  .<m-i>. ( i : int(i)
                                                      , p : ptr(larr+i*sizeof(int))
                                                      , pf0 : array_v(int, larr, i)
                                                      , pf1 : array_v(int?, larr+i*sizeof(int), m-i)
                                                      ) : ( pf0 : array_v(int, larr, m)
                                                          , pf1 : array_v(int?, larr+i*sizeof(int), 0)
                                                          ) =>
            (i < sz2i(s1_l))
            {
              prval (pf_at, pf1_res) = array_v_uncons{int?}(pf1)
              prval () = pf1 := pf1_res
              var c = g0ofg1(i)
              val () = ptr_set<int>(pf_at | p, c)
              val () = p := ptr1_succ<int>(p)
              prval () = pf0 := array_v_extend{int}(pf0, pf_at)
              val () = i := i + 1
            }
        prval () = pf_arr := pf0
        prval () = array_v_unnil{int?}(pf1)
        prval pf_arr = array_v_cons{int}(pf1_at, pf_arr)
        var res = arrayptr_alloca_encode(pf_arr | p_arr)
      in
        arrayptr_refize(res)
      end
    
    val column = array_initialize()
    
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
  levenshtein{m}{n}($UN.castvwtp1(s1), $UN.castvwtp1(s2))
