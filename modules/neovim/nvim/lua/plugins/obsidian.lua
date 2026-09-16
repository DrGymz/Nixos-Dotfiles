require("obsidian").setup({
	legacy_commands = false,
	workspaces = {
		{ name = "school", path = "~/School" },
	},
	templates = {
		folder = "dailies",
	},
	daily_notes = {
		folder = "dailies",
		date_format = "YYYY-MM-DD",
		template = "daily template.md",
		workdays_only = false,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})

vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>")
vim.keymap.set("n", "<leader>od", "<cmd>Obsidian today<cr>")
vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<cr>")
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<cr>")
vim.keymap.set("n", "<leader>oq", "<cmd>Obsidian quick_switch<cr>")
vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<cr>")
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian template<cr>")
vim.keymap.set("n", "<leader>oT", "<cmd>Obsidian toc<cr>")
