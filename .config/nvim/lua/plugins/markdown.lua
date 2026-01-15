return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_browser =
      "brave --enable-features=UseOzonePlatform --ozone-platform=wayland"
    vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")
  end,
}

