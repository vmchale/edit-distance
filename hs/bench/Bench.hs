module Main (main) where

import           Criterion.Main
import           Text.EditDistance

main :: IO ()
main =
    defaultMain [ bgroup "edit distance"
                      [ bench "levenshteinDistance" $ nf (levenshteinDistance defaultEditCosts "exclude") "excude"
                      ]
                ]
