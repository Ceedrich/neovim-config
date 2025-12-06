-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {},
  auto_install = false,
  highlight = { enable = true, disable = "latex" },
  ident = { enable = true },
  autotag = { enable = true },
})
-- LSP
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("ceedrichVim.lsp", {}),
  callback = function(_)
    local keymap = vim.keymap
    local opts = { silent = true }

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "K", vim.lsp.buf.hover, opts)

    opts.desc = "Code actinos"
    keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts)

    opts.desc = "Go to References"
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Rename symbol"
    keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
  end,
})

-- local lspconfig = require("lspconfig")

-- local defaultSetup = function(server_name)
-- 	lspconfig[server_name].setup({
-- 		capabilities = capabilities,
-- 		on_attach = on_attach,
-- 	})
-- end

vim.lsp.enable({
  "lua_ls",
  "nixd",
  "astro",
  "taplo",
  "ts_ls",
  "tailwindcss",
  "clangd",
  "r_language_server",
  "glsl_analyzer",
  "qmlls"
})

-- From https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config("lua_ls", {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

require("crates").setup()
