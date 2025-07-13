-- Lualine
require("lualine").setup({
	icons_enabled = true,
	theme = "catppuccin",
})

-- Telescope
do
	local telescope = require("telescope")
	local telescopeConfig = require("telescope.config")
	-- Clone the default Telescope configuration
	local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

	-- I want to search in hidden/dot files.
	table.insert(vimgrep_arguments, "--hidden")
	-- I don't want to search in the `.git` directory.
	table.insert(vimgrep_arguments, "--glob")
	table.insert(vimgrep_arguments, "!**/.git/*")

	telescope.setup({
		defaults = {
			-- `hidden = true` is not supported in text grep commands.
			vimgrep_arguments = vimgrep_arguments,
		},
		pickers = {
			find_files = {
				-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
				find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
			},
		},
	})
end

-- nvim-surround
require("nvim-surround").setup({})

-- indent-blankline
require("ibl").setup({ indent = { char = "" } })

-- autopairs
do
	local autopairs = require("nvim-autopairs")

	autopairs.setup({})

	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

-- gitsigns
do
	require("gitsigns").setup({
		on_attach = function(bufnr)
			local gitsigns = require("gitsigns")

			local function map(mode, l, r, opts)
				opts = opts or {}
				local additional_opts = { buffer = bufnr }

				for k, v in pairs(additional_opts) do
					opts[k] = v
				end

				vim.keymap.set(mode, l, r, opts)
			end

			local wk = require("which-key")
			wk.add({ "<leader>gh", group = "Git Hunk" })

			map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "git stage *buffer*" })
			map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "git reset *buffer*" })

			map("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "git stage *hunk*" })
			map("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "git stage *hunk*" })

			map("v", "<leader>ghs", function()
				gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }, { desc = "git stage *hunk*" })
			end)

			map("v", "<leader>ghr", function()
				gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }, { desc = "git stage *hunk*" })
			end)
		end,
	})
end

-- Neogit
require("neogit").setup()

-- Comments
require("todo-comments").setup({
	keywords = {
		ERROR = {
			icon = "",
			color = "error",
		},
	},
	highlight = {
		pattern = [[.*<(KEYWORDS)\s*]],
	},
})

require("Comment").setup()
