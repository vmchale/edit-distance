let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall sha256:69bdde38a8cc01c91a1808ca3f45c29fe754c9ac96e91e6abd785508466399b4

in    prelude.default
    ⫽ { test =
        [   prelude.bin
          ⫽ { src = "test/levenshtein.dats"
            , target = "${prelude.atsProject}/test"
            , gcBin = True
            }
        ]
      , bench =
        [   prelude.bin
          ⫽ { src = "bench/bench.dats"
            , target = "${prelude.atsProject}/bench"
            , gcBin = True
            }
        ]
      , dependencies =
            prelude.mapPlainDeps [ "ats-bench" ]
          # [ prelude.lowerDeps { name = "specats", version = [ 0, 4, 0 ] } ]
      , compiler = [ 0, 4, 2 ]
      , version = [ 0, 4, 2 ]
      , atsLib = False
      }
