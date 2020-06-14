{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = { exe = true; license-report = false; _ = false; };
    package = {
      specVersion = "2.2";
      identifier = { name = "cabal-plan"; version = "0.6.2.0"; };
      license = "GPL-2.0-or-later";
      copyright = "2016 Herbert Valerio Riedel";
      maintainer = "hvr@gnu.org";
      author = "Herbert Valerio Riedel";
      homepage = "";
      url = "";
      synopsis = "Library and utility for processing cabal's plan.json file";
      description = "This package provides a library (see \"Cabal.Plan\") for decoding @plan.json@ files as\nwell as the simple tool @cabal-plan@ for extracting and pretty printing\nthe information contained in the @plan.json@ file.\n\n@plan.json@ files are generated by [cabal](https://hackage.haskell.org/package/cabal-install)'s [Nix-style local builds](http://cabal.readthedocs.io/en/latest/nix-local-build.html) and contain detailed information about the build/install plan computed by the cabal solver.\n\n== @cabal-plan@ utility\n\nThe @cabal-plan@ executable (enabled via the @exe@ cabal flag) provides various operations:\n\n[info] Show basic report of dependency tree\n[show] Dump 'PlanJson' data-structure via 'Show' instance\n[tred] Show dependency tree as a graph\n[diff] Diff two install plans\n[list-bins] List all binaries\n[list-bin] List single binary (useful for scripting, e.g. @cabal list-bin exe:cabal-plan@)\n[fingerprint] Print SHA256 sums of dependencies' source tarballs and cabal files\n[dot] Generate graph of dependencies in @.dot@ format\n[topo] Print plan topologically sorted\n[license-report] Generate license report for a component (only available when built with @license-report@ flag enabled); see <src/example/cabal-plan.md report example for cabal-plan> (<src/example/cabal-plan.html Pandoc rendered HTML>)\n\nSee also [\"New things in Haskell package QA\" Blogpost](http://oleg.fi/gists/posts/2018-01-08-haskell-package-qa.html) for a description of the @topo@ and @dot@ operations as well as how to enable tab-completion.";
      buildType = "Simple";
      isLocal = true;
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
          (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
          (hsPkgs."base16-bytestring" or (errorHandler.buildDepError "base16-bytestring"))
          ];
        buildable = true;
        };
      exes = {
        "cabal-plan" = {
          depends = (pkgs.lib).optionals (flags.exe) ([
            (hsPkgs."cabal-plan" or (errorHandler.buildDepError "cabal-plan"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."async" or (errorHandler.buildDepError "async"))
            (hsPkgs."ansi-terminal" or (errorHandler.buildDepError "ansi-terminal"))
            (hsPkgs."base-compat" or (errorHandler.buildDepError "base-compat"))
            (hsPkgs."optics-core" or (errorHandler.buildDepError "optics-core"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."parsec" or (errorHandler.buildDepError "parsec"))
            (hsPkgs."process" or (errorHandler.buildDepError "process"))
            (hsPkgs."semialign" or (errorHandler.buildDepError "semialign"))
            (hsPkgs."singleton-bool" or (errorHandler.buildDepError "singleton-bool"))
            (hsPkgs."these" or (errorHandler.buildDepError "these"))
            (hsPkgs."topograph" or (errorHandler.buildDepError "topograph"))
            (hsPkgs."transformers" or (errorHandler.buildDepError "transformers"))
            (hsPkgs."vector" or (errorHandler.buildDepError "vector"))
            ] ++ (pkgs.lib).optionals (flags.license-report) [
            (hsPkgs."Cabal" or (errorHandler.buildDepError "Cabal"))
            (hsPkgs."tar" or (errorHandler.buildDepError "tar"))
            (hsPkgs."zlib" or (errorHandler.buildDepError "zlib"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            ]);
          buildable = if flags.exe then true else false;
          };
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchgit {
      url = "https://github.com/peti/cabal-plan.git";
      rev = "894b76c0b6bf8f7d2f881431df1f13959a8fce87";
      sha256 = "06iklj51d9kh9bhc42lrayypcpgkjrjvna59w920ln41rskhjr4y";
      });
    }