-- so % to reload
-- vim.cmd("set clipboard+=unnamedplus")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mousemodel = "extend" -- no popup
vim.opt.wrap = false
vim.cmd("let g:sneak#label = 1")
vim.keymap.set("n", "<leader>h", ":noh<return>", { desc = "no highlight" })
vim.keymap.set("n", "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<Leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<Leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("v", "<Leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("i", "jk", "<Esc>")
-- vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)
vim.keymap.set("n", "<leader><leader>x", "<Plug>JupyterExecute")
vim.keymap.set("n", "<leader><leader>X", "<Plug>JupyterExecuteAll")
vim.keymap.set("n", "<leader><leader>r", "<Plug>JupyterRestart")
vim.keymap.set("n", "<leader>Y", "\"+y")
vim.keymap.set("n", "<leader>P", "\"+p")
vim.keymap.set("v", "<leader>Y", "\"+y")
vim.keymap.set("v", "<leader>P", "\"+p")
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
vim.keymap.set("n", "<leader>wH", "<cmd>split<cr>", { desc = "Horz split" })
vim.keymap.set("n", "<leader>wV", "<cmd>vsplit<cr>", { desc = "Vertical split" })
vim.keymap.set("n", "H", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "L", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<return>", { desc = "Toggle NvimTreeToggle" })
-- vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- nvim-tree config
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("user.plugins")
require("user.telescope")

require("fidget").setup({})
require("nvim-tree").setup({})
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pyright", "rust_analyzer" },
	automatic_installation = true,
})
require("user.lsp")
--format when saving
vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
vim.cmd([[colorscheme tokyonight]])

local wk = require("which-key")

wk.register({
	f = {
		name = "Telescope", -- optional group name
	},
	w = {
		name = "Window Ops", -- optional group name
	},
}, { prefix = "<leader>" })
