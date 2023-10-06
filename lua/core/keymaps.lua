map("n", "<Left>", ':echo "Use h"<CR>')
map("n", "<Right>", ':echo "Use l"<CR>')
map("n", "<Up>", ':echo "Use k"<CR>')
map("n", "<Down>", ':echo "Use j"<CR>')

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")
map("n", "<Leader>p", ":Telescope neoclip<CR>")

map("v", "<S-TAB>", "<gv")
map("v", "<TAB>", ">gv")

map("n", "<C-a>", "ggVG")

map("n", "<Leader>m", ":nohl<CR>")

map("n", "<Leader>\\", ":vsplit<CR>")
map("n", "<Leader>/", ":split<CR>")

map("i", "<C-c>", "<esc>")
map("n", "<C-c>", "<esc>")
map("v", "<C-c>", "<esc>")

map("i", "jk", "<esc>")
map("n", "<Leader>f", ":Prettier<CR>")
map("x", "<Leader>f", ":Prettier<CR>")
