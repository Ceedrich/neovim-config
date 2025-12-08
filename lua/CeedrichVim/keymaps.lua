vim.g.mapleader = " "

local keymap = vim.keymap
local wk = require("which-key")

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Indenting
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent right and reselect" })

-- Use the system clipboard
keymap.set({ "v", "n" }, "<C-y>", '"+y')
keymap.set({ "v", "n" }, "<C-p>", '"+p')
keymap.set({ "v", "n" }, "<C-x>", '"+x')

-- Telescope
do
	local builtin = require("telescope.builtin")

	wk.add({ "<leader>f", group = "Find" })
	keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
	keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
	keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })
	keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
	keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
end

-- neogit
wk.add({ "<leader>g", group = "Git" })
keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Git Window" })

-- Oil
do
	local oil = require("oil")
	oil.setup({
		columns = {
			"icon",
		},
		delete_to_trash = true,
		watch_for_changes = true,
		view_options = {
			show_hidden = true,
		},
	})
	vim.keymap.set("n", "<leader>e", "<cmd>Oil --float<cr>", { desc = "open parent directory" })
end

-- harpoon
do
	local harpoon = require("harpoon")
	wk.add({ "<leader>h", group = "Harpoon" })

	vim.keymap.set("n", "<leader>ha", function()
		harpoon:list():add()
	end, { desc = "Add current file to harpoon list" })
	vim.keymap.set("n", "<leader>hh", function()
		harpoon.ui:toggle_quick_menu(harpoon:list())
	end, { desc = "Open harpoon list" })

	vim.keymap.set("n", "<leader>h1", function()
		harpoon:list():select(1)
	end, { desc = "Open file 1 from harpoon list" })
	vim.keymap.set("n", "<leader>h2", function()
		harpoon:list():select(2)
	end, { desc = "Open file 2 from harpoon list" })
	vim.keymap.set("n", "<leader>h3", function()
		harpoon:list():select(3)
	end, { desc = "Open file 3 from harpoon list" })
	vim.keymap.set("n", "<leader>h4", function()
		harpoon:list():select(4)
	end, { desc = "Open file 4 from harpoon list" })

	-- Toggle previous & next buffers stored within Harpoon list
	vim.keymap.set("n", "<C-S-H>", function()
		harpoon:list():prev()
	end)
	vim.keymap.set("n", "<C-S-L>", function()
		harpoon:list():next()
	end)
end

keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format buffer" })
