fn levenshtein { m, n : nat } (s1 : string(m), s2 : string(n)) : int

fn levenshtein_(s1 : string, s2 : string) : int

fn levenshtein_vt {m:nat}{n:nat} (s1 : !strnptr(m), s2 : !strnptr(n)) : int
