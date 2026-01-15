return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  opts = function()
    local logo = [[
      ███╗   ██╗██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██║   ██║██║████╗ ████║
      ██╔██╗ ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    logo = string.rep("\n", 6) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = { statusline = false },
      config = {
        header = vim.split(logo, "\n"),

        center = {
          {
            icon = " ",
            desc = "Find File",
            key = "f",
            action = function()
              require("telescope.builtin").find_files()
            end,
          },
          {
            icon = " ",
            desc = "Search Text",
            key = "g",
            action = function()
              require("telescope.builtin").live_grep()
            end,
          },
          {
            icon = " ",
            desc = "Projects",
            key = "p",
            action = function()
              require("telescope.builtin").find_files({
                cwd = "~/Projects",
              })
            end,
          },
          {
            icon = " ",
            desc = "Edit Config",
            key = "c",
            action = function()
              require("telescope.builtin").find_files({
                cwd = vim.fn.stdpath("config"),
              })
            end,
          },
	  {
  icon = "󰈙 ",
  desc = "New Note",
  key = "n",
  action = function()
    local name = vim.fn.input("Note name: ")
    if name == "" then return end

    local dir = vim.fn.expand("~/Notes")
    vim.fn.mkdir(dir, "p")

    if not name:match("%.md$") then
      name = name .. ".md"
    end

    vim.cmd("edit " .. dir .. "/" .. name)
    vim.cmd("startinsert")
  end,
},

	},

        footer = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100) / 100
          return {
            "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
    }

    -- spacing + key alignment
    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 35 - #button.desc)
      button.key_format = "  %s"
    end

    return opts
  end,
}

