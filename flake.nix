{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        pkgs = nixpkgs.legacyPackages."${system}";
        neovim = import ./neovim.nix pkgs;
      in {
        packages = {
          neovim = neovim.neovim;
          default = neovim.ceedrichVim;
        };
        homeModules.default = neovim.hmModule;
      }
    );
}
