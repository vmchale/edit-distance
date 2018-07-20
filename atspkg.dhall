let prelude = http://hackage.haskell.org/package/ats-pkg/src/dhall/atspkg-prelude.dhall
in

prelude.default ⫽
  { test =
    [ prelude.bin ⫽
      { src = "test/levenshtein.dats"
      , target = "${prelude.atsProject}/test"
      , gcBin = True
      }
    , prelude.bin ⫽
      { src = "test/bench.dats"
      , target = "${prelude.atsProject}/bench"
      , gcBin = True
      }
    ]
  , dependencies =
        prelude.mapPlainDeps [ "ats-bench" ]
            # [ prelude.lowerDeps { name = "specats", version = [0,4,0] } ]
  }
