let prelude =
      https://raw.githubusercontent.com/vmchale/atspkg/master/ats-pkg/dhall/atspkg-prelude.dhall sha256:c04fe26a86f2e2bd5c67c17f213ee30379d520f5fad11254a8f17e936250e27e

in  λ(x : List Natural) →
      prelude.makePkg { x, name = "edit-distance", githubUsername = "vmchale" }
