vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.cmd([[
  cnoreabbrev <expr> W  getcmdtype() == ':' && getcmdline() ==# 'W'  ? 'w'  : 'W'
  cnoreabbrev <expr> Wq getcmdtype() == ':' && getcmdline() ==# 'Wq' ? 'wq' : 'Wq'
  cnoreabbrev <expr> WQ getcmdtype() == ':' && getcmdline() ==# 'WQ' ? 'wq' : 'WQ'
]])
