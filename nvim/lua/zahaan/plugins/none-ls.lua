-- lua/zahaan/plugins/none-ls.lua --

return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- safe require
		local ok, null_ls = pcall(require, "null-ls")
		if not ok then
			vim.notify("none-ls (null-ls) not found", vim.log.levels.ERROR)
			return
		end

		local utils = require("null-ls.utils")

		-- builtins
		local formatting = null_ls.builtins.formatting

		-- augroup (clear = true avoids duplication on reload)
		local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

		null_ls.setup({
			root_dir = utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),

			sources = {
				formatting.prettierd.with({
					-- ADDED "yaml" HERE to stop Prettier from overriding yamlls
					disabled_filetypes = { "markdown", "md", "yaml" },
				}),

				formatting.stylua,
			},
			on_attach = function(client, bufnr)
				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({
						group = augroup,
						buffer = bufnr,
					})

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- CHANGED FILTER HERE to allow both none-ls and yamlls
							vim.lsp.buf.format({
								bufnr = bufnr,
								timeout_ms = 2000,
								filter = function(c)
									return c.name == "null-ls" or c.name == "none-ls" or c.name == "yamlls"
								end,
							})
						end,
					})
				end
			end,
		})
	end,
}
