-- https://github.com/neovim/nvim-lspconfig
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>E", vim.diagnostic.open_float, { desc = "diagnostic open_float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "diagnostic goto_prev" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "diagnostic goto_next" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "diagnostic setloclist" })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
-- local on_attach = function(client, bufnr)
local on_attach = function(_, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local add_desc = function(desc)
		local r = vim.deepcopy(bufopts)
		r["desc"] = desc
		return r
	end
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, add_desc("LSP declaration"))
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, add_desc("LSP definition"))
	vim.keymap.set("n", "K", vim.lsp.buf.hover, add_desc("LSP Hover"))
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, add_desc("LSP implementation"))
	-- vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set("n", "<space>wl", function()
	-- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, add_desc("LSP type_definition"))
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, add_desc("LSP rename"))
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, add_desc("LSP code_action"))
	vim.keymap.set("n", "gr", vim.lsp.buf.references, add_desc("LSP references"))
	vim.keymap.set("n", "<space>F", function()
		vim.lsp.buf.format({ async = true })
	end, add_desc("LSP format"))
end

-- Set up nvim-cmp.
vim.cmd([[set completeopt=menu,menuone,noselect]])
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- ["<C-Space>"] = cmp.mapping.complete(),
		["<TAB>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- local util = require("lspconfig/util")

-- local path = util.path

-- local function get_python_path(workspace)
-- 	-- Use activated virtualenv.
-- 	if vim.env.VIRTUAL_ENV then
-- 		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
-- 	end

-- 	-- Find and use virtualenv from pipenv in workspace directory.
-- 	local match = vim.fn.glob(path.join(workspace, "Pipfile"))
-- 	if match ~= "" then
-- 		local venv = vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
-- 		return path.join(venv, "bin", "python")
-- 	end

-- 	-- Fallback to system Python.
-- 	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
-- end

-- require("lspconfig").pyright.setup({
-- 	on_attach = function()
-- 		require("lsp_signature").on_attach({
-- 			hint_enable = false,
-- 		})
-- 	end,
-- 	on_init = function(client)
-- 		client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
-- 	end,
-- })
-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

require("lspconfig")["lua_ls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
		},
	},
})
require("lspconfig")["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	-- on_init = function(client)
	-- 	client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
	-- end,
})
require("lspconfig")["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
})
require("lspconfig")["rust_analyzer"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {},
	},
})

require("lspconfig").gopls.setup{}

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.autopep8,
		null_ls.builtins.diagnostics.flake8,
	},
})
