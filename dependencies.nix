pkgs:
with pkgs; [
  wl-clipboard

  git
  fd
  ripgrep

  # LaTeX
  texliveFull

  # LSP
  lua-language-server
  bash-language-server
  nixd
  taplo
  clang
  (rWrapper.override {
    packages = with rPackages; [
      languageserver
    ];
  })
  texlab

  # Formatters
  stylua
  alejandra
  prettierd
  clang-tools
]
