pkgs:
with pkgs; [
  wl-clipboard

  git
  fd
  ripgrep

  # LSP
  lua-language-server
  nixd
  typescript-language-server
  astro-language-server
  tailwindcss
  tailwindcss-language-server
  taplo
  # rust-with-analyzer
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
