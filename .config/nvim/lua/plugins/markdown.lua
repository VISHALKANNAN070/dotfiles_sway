return {
  -- 1. In-Editor Rendering (Visuals)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      heading = {
        -- Custom icons often used in Arch/minimalist setups
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
    },
  },

  -- 2. Your Existing Browser Preview (Wayland optimized)
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    init = function()
      -- Maintains your specific Wayland flags for Brave
      vim.g.mkdp_browser = "brave --enable-features=UseOzonePlatform --ozone-platform=wayland"
      vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>")
    end,
  },
}
