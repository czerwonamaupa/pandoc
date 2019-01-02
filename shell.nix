{ pkgs ? import <nixpkgs> {} }:
with pkgs.haskellPackages;
(callPackage ./. {}).env.overrideAttrs(old: {
  buildInputs = old.buildInputs ++ [
    cabal-install
    cabal2nix
    apply-refact
    hlint
    stylish-haskell
    hasktags
    hoogle
  ];
})
