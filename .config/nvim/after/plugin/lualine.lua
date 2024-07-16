require("lualine").setup({
  options = {
    theme = "catppuccin",
  },
  sections = { lualine_a = { "mode", "g:metals_status", "g:metals_bsp_status" } },
})
