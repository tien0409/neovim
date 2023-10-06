return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"jose-elias-alvarez/typescript.nvim",
	},
	config = function()
		local opts = { noremap = true, silent = true }
		map("n", "<space>e", vim.diagnostic.open_float, opts)
		map("n", "[e", vim.diagnostic.goto_prev, opts)
		map("n", "]e", vim.diagnostic.goto_next, opts)
		map("n", "<space>q", vim.diagnostic.setloclist, opts)

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				map("n", "gD", vim.lsp.buf.declaration, bufopts)
				map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
				map("n", "ga", vim.lsp.buf.code_action, bufopts)
				map("n", "K", vim.lsp.buf.hover, bufopts)
				map("n", "gi", vim.lsp.buf.implementation, bufopts)
				map("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
				map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
				map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
				map("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				map("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
				map("n", "<space>rn", vim.lsp.buf.rename, bufopts)
				map("n", "gr", "<cmd>Telescope lsp_document_symbols<CR>", bufopts)
				map("n", "<space>f", function()
					vim.lsp.buf.format({ async = true })
				end, bufopts)
			end,
		})
		-- local servers = { 'html', 'cssls', 'tsserver', 'vuels', 'jsonls', 'cssmodules_ls', 'tailwindcss', 'eslint', 'lua_ls',
		--'bashls', 'clangd', 'svelte', 'dockerls', 'yamlls' }

		-- Set up lspconfig.
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		require("lspconfig").tsserver.setup({
			capabilities = capabilities,
			cmd = { "typescript-language-server", "--stdio" },
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			root_dir = vim.loop.cwd,
		})

		local lsp_config = {
			capabilities = capabilities,
		}

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup(lsp_config)
			end,

			emmet_ls = function()
				require("lspconfig").emmet_ls.setup({
					capabilities = capabilities,
					filetypes = { "html", "css", "scss", "sass", "tmpl" },
				})
			end,

			html = function()
				require("lspconfig").html.setup({
					capabilities = capabilities,
					filetypes = { "html", "tmpl" },
				})
			end,

			tsserver = function()
				require("typescript").setup({
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					root_dir = vim.loop.cwd,
					server = vim.tbl_extend("force", lsp_config, {
						init_options = {
							preferences = {
								importModuleSpecifierPreference = "project=relative",
								jsxAttributeCompletionStylr = "none",
							},
						},
					}),
				})
			end,
		})

		map("n", "<Leader>s", "<cmd>TypescriptOrganizeImports<CR>")
		map("n", "<Leader>i", "<cmd>TypescriptAddMissingImports<CR>")
	end,
}
