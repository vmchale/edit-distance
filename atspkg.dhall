let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall sha256:38172c1bfad21ef2f1870d4489943236cee531ccc52314b8e91fa660a3f3fab7

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
      , compiler = [ 0, 4, 0 ]
      , version = [ 0, 3, 13 ]
      , atsLib = False
      }
