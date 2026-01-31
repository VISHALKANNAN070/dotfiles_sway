-- Load core config
require("config.options")
require("config.keybinds")
require("config.lazy")

-- Browser for markdown preview
vim.g.mkdp_browser = "brave"

-- Apply dark_blue theme on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local ok, _ = pcall(require, "colors.dark_blue")
    if not ok then
      vim.notify("colors.dark_blue not found", vim.log.levels.WARN)
    end
  end,
})

