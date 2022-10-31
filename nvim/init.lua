-- so % to reload
vim.cmd("set clipboard+=unnamedplus")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("let g:sneak#label = 1")
vim.keymap.set("n", "<leader>h", ":noh<return>", {})
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<leader>wH", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>wV", "<cmd>vsplit<cr>")
vim.keymap.set("n", "H", "<cmd>tabnext<cr>")
vim.keymap.set("n", "L", "<cmd>tabprevious<cr>")

-- nvim-tree config
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("user.plugins")
require("user.wilder")
require("user.telescope")
require("user.lsp")

require("fidget").setup({})
require("nvim-tree").setup({})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<return>", {})
vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]])
vim.cmd([[colorscheme tokyonight]])
