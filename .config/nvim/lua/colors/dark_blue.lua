local c = {
  bg       = "#131316",
  fg       = "#e4e2e5",
  surface  = "#131316",
  primary  = "#b6c6ee",
  secondary= "#c1c6d7",
  error    = "#ffb4ab",
}

vim.cmd("highlight clear")
vim.o.termguicolors = true
vim.g.colors_name = "dark_blue"

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hi("Normal",       { fg = c.fg, bg = c.bg })
hi("NormalNC",     { fg = c.fg, bg = c.bg })
hi("CursorLine",   { bg = c.surface })
hi("Visual",       { bg = c. primary, fg = c.bg})
hi("LineNr",       { fg = c.secondary })
hi("CursorLineNr", { fg = c.primary, bold = true })
hi("StatusLine",   { fg = c.fg, bg = c.surface })
hi("ErrorMsg",     { fg = c.error })

