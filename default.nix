{ pkgs ? import ./nixpkgs.nix }:
with pkgs;
let
  overrides = self: super: {
    doctemplates = self.doctemplates_0_5;
    pandoc = haskell.lib.justStaticExecutables
      (self.callCabal2nix "pandoc" (nix-gitignore.gitignoreSource [] ./.) {});
  };

  haskellPackages = haskell.packages.ghc865.override { inherit overrides; };

  drv = haskellPackages.pandoc;

  shell = haskellPackages.shellFor {
    withHoogle = true;
    packages = p: [ p.pandoc ];
    buildInputs = with haskellPackages; [
      cabal-install
      apply-refact
      hindent
      hlint
      stylish-haskell
      hasktags
      hoogle
      (import (builtins.fetchTarball "https://github.com/hercules-ci/ghcide-nix/tarball/master") {}).ghcide-ghc865
    ];
  };

in drv // { inherit shell; }
