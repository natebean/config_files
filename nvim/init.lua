-- so % to reload
-- vim.cmd("set clipboard+=unnamedplus")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd("let g:sneak#label = 1")
vim.keymap.set("n", "<leader>h", ":noh<return>", {})
vim.keymap.set("n", "<Leader>y", '"+y')
vim.keymap.set("n", "<Leader>p", '"+p')
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>wl", "<C-w>l")
vim.keymap.set("n", "<leader>wh", "<C-w>h")
vim.keymap.set("n", "<leader>wj", "<C-w>j")
vim.keymap.set("n", "<leader>wk", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<leader>wH", "<cmd>split<cr>")
vim.keymap.set("n", "<leader>wV", "<cmd>vsplit<cr>")
vim.keymap.set("n", "H", "<cmd>tabnext<cr>")
vim.keymap.set("n", "L", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<return>", {})
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

--format when saving
vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
vim.cmd([[colorscheme tokyonight]])

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
	ensure_installed = { "sumneko_lua", "pyright", "rust_analyzer" },
	automatic_installation = true,
})
require("user.lsp")
