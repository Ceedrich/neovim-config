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

        ceedrichVimPlugin =
          pkgs.vimUtils.buildVimPlugin
          {
            name = "CeedrichVim";
            src = ./.;
            dependencies = with pkgs.vimPlugins; [
              # General
              catppuccin-nvim
              plenary-nvim
              nvim-web-devicons
              alpha-nvim

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

              # LSP
              nvim-lspconfig
              lspkind-nvim
              rustaceanvim
              crates-nvim
            ];
          };

        extraPackages = with pkgs; [
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
        ];

        neovim = pkgs.neovim.override {
          configure = {
            customRC = ''
              lua << EOF
                require("CeedrichVim").init()
              EOF
            '';
            packages.main = {start = [ceedrichVimPlugin];};
          };
          extraMakeWrapperArgs = ''--suffix PATH : ${pkgs.lib.makeBinPath extraPackages}'';
        };
      in {
        packages.default = neovim;
      }
    );
}
