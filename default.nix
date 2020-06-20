{ pkgs, tag ? "master", version ? "8.8.3" }:
let
  l = file: builtins.fromJSON (builtins.readFile file);

  hsPkgs = with pkgs.haskell-nix;
    stackProject {
      src = cleanSourceHaskell {
        src = source."hls-${tag}";
        name = "hls-source";
      };
      cache = l (./cache + "-${tag}/${version}.json");
      modules = [{ packages.haskell-language-server.doCheck = false; }];

      stackYaml = "stack-${version}.yaml";
    };
in hsPkgs.haskell-language-server.components
