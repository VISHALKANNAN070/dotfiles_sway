local c = {
  bg        = "#000000",
  fg        = "#e6e6e6",
  surface   = "#111111",
  primary   = "#444444",
  secondary = "#777777",
  error     = "#ff0000",
}

vim.cmd("highlight clear")
vim.o.termguicolors = true
vim.g.colors_name = "mono_black"

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

hi("Normal",       { fg = c.fg, bg = c.bg })
hi("NormalNC",     { fg = c.fg, bg = c.bg })
hi("CursorLine",   { bg = c.surface })
hi("Visual",       { bg = c.primary, fg = c.fg })
hi("LineNr",       { fg = c.secondary })
hi("CursorLineNr", { fg = c.fg, bold = true })
hi("StatusLine",   { fg = c.fg, bg = c.surface })
hi("ErrorMsg",     { fg = c.error, bold = true })

