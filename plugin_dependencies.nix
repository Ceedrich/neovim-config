pkgs:
with pkgs.vimPlugins; [
  # General
  catppuccin-nvim
  plenary-nvim
  nvim-web-devicons
  alpha-nvim

  vimtex

  # Completion / Snippets
  luasnip
  nvim-cmp
  cmp-nvim-lsp
  cmp-buffer
  cmp-path
  cmp_luasnip
  friendly-snippets

  # Tools
  telescope-nvim
  telescope-fzf-native-nvim
  which-key-nvim
  harpoon2
  otter-nvim
  diffview-nvim
  dropbar-nvim
  dressing-nvim
  oil-nvim
  lualine-nvim
  nvim-treesitter.withAllGrammars
  nvim-surround
  nvim-autopairs
  gitsigns-nvim
  neogit
  indent-blankline-nvim
  todo-comments-nvim
  comment-nvim
  none-ls-nvim
  render-markdown-nvim

  # LSP
  nvim-lspconfig
  lspkind-nvim
  rustaceanvim
  crates-nvim
]
