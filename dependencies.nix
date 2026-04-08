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
  astro-language-server
  vscode-json-languageserver
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
  github-ac 

  # Formatters
  stylua
  alejandra
  prettierd
  clang-tools
]
