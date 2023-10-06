return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local theme = require("tokyonight")
    theme.setup ({
      style = "night"
    })

    cmd([[colorscheme tokyonight]])
  end
}
