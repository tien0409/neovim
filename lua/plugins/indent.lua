return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local indent = require("ibl")
		local hooks = require("ibl.hooks")

		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			"RainbowCyan",
		}

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
			vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		end)

		g.rainbow_delimiters = { highlight = highlight }
		indent.setup({
			indent = {
				char = "▏",
				-- buftype_exclude = { "terminal", "help" },
				-- show_current_context = true,
				-- show_current_context_start = true,
				-- show_end_of_line = true,
				-- space_char_blankline = " ",
				-- char_highlight_list = {
				-- 	"IndentBlanklineIndent1",
				-- },
			},
			scope = {
				enabled = true,
				highlight = highlight,
			},
		})
		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
