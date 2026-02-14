local c = {
 bg        = "#0e1a12",
fg        = "#dde5db",
surface   = "#0e1a12",
primary   = "#6fa96b",
secondary = "#a8b3a5",
error     = "#8a3b2e",

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

