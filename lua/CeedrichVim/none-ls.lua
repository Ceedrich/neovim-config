local none_ls = require("null-ls")

none_ls.setup({
  sources = {
    none_ls.builtins.formatting.stylua,
    none_ls.builtins.formatting.alejandra,
    none_ls.builtins.formatting.prettierd,
    none_ls.builtins.formatting.clang_format,
  },
})
