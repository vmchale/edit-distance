let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall sha256:38172c1bfad21ef2f1870d4489943236cee531ccc52314b8e91fa660a3f3fab7

in  λ(x : List Natural) →
      prelude.makePkg { x, name = "edit-distance", githubUsername = "vmchale" }
