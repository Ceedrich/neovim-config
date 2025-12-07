pkgs:
with pkgs; [
  wl-clipboard

  git
  fd
  ripgrep

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

  # Formatters
  stylua
  alejandra
  prettierd
  clang-tools
]
