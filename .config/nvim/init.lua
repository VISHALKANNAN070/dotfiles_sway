-- 1. START NEOVIM SOCKET
pcall(vim.fn.serverstart, "/tmp/nvim-matugen")

-- 2. DEFINE THE RELOAD FUNCTION (PUT IT HERE)
function ReloadMatugen()
  package.loaded["colors.matugen"] = nil
  require("colors.matugen")
  pcall(require("lualine").refresh)
end

-- 3. THEN LOAD THE REST
require("config.options")
require("config.keybinds")
require("config.lazy")

vim.g.mkdp_browser = "brave"
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local path = vim.fn.stdpath("config") .. "/lua/colors/matugen.lua"
    if vim.fn.filereadable(path) == 1 then
      ReloadMatugen()
    end
  end,
})

