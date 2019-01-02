{ pkgs ? import <nixpkgs> {} }:
with pkgs;
let
  overrides = self: super: {
    doctemplates = self.doctemplates_0_5;
  };

  source-overrides = {
  };

in (haskellPackages.extend (
  lib.composeExtensions
    (haskellPackages.packageSourceOverrides source-overrides)
    overrides)
).callCabal2nix "pandoc" (nix-gitignore.gitignoreSource [] ./.) {}
