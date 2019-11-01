castfn arrayptr_alloca_encode : {a:vt@ype} {l:addr} {n:int} (array_v(INV(a), l, n) | ptr(l)) -<0> arrayptr(a, l, n)

fun {a:vt@ype} array_ptr_alloca {dummy:addr}{n:int} (pf : void @ dummy | asz : size_t(n)) :
  [l:agz] (array_v(a?, l, n), array_v(a?, l, n) -> void @ dummy| ptr(l))

fn levenshtein { m, n : nat } (s1 : string(m), s2 : string(n)) : int

fn levenshtein_(s1 : string, s2 : string) : int

fn levenshtein_vt {m:nat}{n:nat} (s1 : !strnptr(m), s2 : !strnptr(n)) : int
