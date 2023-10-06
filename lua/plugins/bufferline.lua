return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				right_mouse_command = "vert sbuffer %d",
				show_close_icon = false,
				separator_style = os.getenv("KITTY_WINDOW_ID") and "slant" or "padded_slant",
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count)
					return "(" .. count .. ")"
				end,
				custom_filter = function(buf_number)
					-- filter out filetypes you don't want to see
					if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
						return true
					end
					-- filter out by buffer name
					if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
						return true
					end
					-- filter out based on arbitrary rules
					-- e.g. filter out vim wiki buffer from tabline in your work repo
					if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
						return true
					end
				end,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "PanelHeading",
						padding = 1,
					},
					{
						filetype = "DiffviewFiles",
						text = "Diff View",
						highlight = "PanelHeading",
						padding = 1,
					},
					{
						filetype = "flutterToolsOutline",
					},
				},
			},
		})

		keymap.set("n", "<Leader>t", ":tabnew", { desc = "Create new tab buffer" })
		keymap.set("n", "<Leader>c", ":BufferLinePick<CR>", { desc = "Pick the buffer tab" })
		keymap.set("n", "<Leader>d", ":bn<CR> :bd#<CR>", { desc = "Remove buffer tab" })
		keymap.set("n", "<TAB>", ":bnext<CR>", { desc = "Go to next buffer" })
		keymap.set("n", "<S-TAB>", ":bprevious<CR>", { desc = "Go to previous buffer" })
	end,
}
