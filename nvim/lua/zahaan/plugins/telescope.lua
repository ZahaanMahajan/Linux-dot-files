-- Telescope
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-file-browser.nvim",
	},
	keys = {
		{
			"<leader>fP",
			function()
				require("telescope.builtin").find_files({
					cwd = require("lazy.core.config").options.root,
				})
			end,
			desc = "Find Plugin File",
		},
		{
			"sf",
			function()
				local telescope = require("telescope")
				local function telescope_buffer_dir()
					return vim.fn.expand("%:p:h")
				end
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = telescope_buffer_dir(),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = true,
					initial_mode = "normal",
					layout_strategy = "horizontal",
					layout_config = {
						height = 0.9,
						width = 0.95,
						preview_width = 0.5,
						preview_cutoff = 120,
						prompt_position = "top",
					},
				})
			end,
			desc = "Open File Browser with the path of the current buffer",
		},
		{
			";f",
			function()
				require("telescope.builtin").find_files({ no_ignore = false, hidden = true })
			end,
			desc = "Find files (respects .gitignore)",
		},
		{
			";r",
			function()
				require("telescope.builtin").live_grep({ additional_args = { "--hidden" } })
			end,
			desc = "Live grep (respects .gitignore)",
		},
		{
			";b",
			function()
				require("telescope.builtin").buffers()
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end,
			desc = "List open buffers",
		},
		{
			";t",
			function()
				require("telescope.builtin").help_tags()
			end,
			desc = "Help tags",
		},
		{
			";;",
			function()
				require("telescope.builtin").resume()
			end,
			desc = "Resume last picker",
		},
		{
			";e",
			function()
				require("telescope.builtin").diagnostics()
			end,
			desc = "List diagnostics",
		},
		{
			";s",
			function()
				require("telescope.builtin").treesitter()
			end,
			desc = "Treesitter symbols",
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local fb_actions = telescope.extensions.file_browser.actions

		opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
			wrap_results = true,
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			winblend = 0,
			mappings = { n = {} },
		})

		opts.pickers = {
			diagnostics = {
				theme = "ivy",
				initial_mode = "normal",
				layout_config = { preview_cutoff = 9999 },
			},
		}

		opts.extensions = {
			file_browser = {
				theme = "dropdown",
				hijack_netrw = true,
				mappings = {
					["n"] = {
						["N"] = fb_actions.create,
						["h"] = fb_actions.goto_parent_dir,
						["/"] = function()
							vim.cmd("startinsert")
						end,
						["<C-u>"] = function(prompt_bufnr)
							for _ = 1, 10 do
								actions.move_selection_previous(prompt_bufnr)
							end
						end,
						["<C-d>"] = function(prompt_bufnr)
							for _ = 1, 10 do
								actions.move_selection_next(prompt_bufnr)
							end
						end,
						["<PageUp>"] = actions.preview_scrolling_up,
						["<PageDown>"] = actions.preview_scrolling_down,
					},
				},
			},
		}

		telescope.setup(opts)
		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
	end,
}
