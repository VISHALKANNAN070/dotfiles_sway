return {
  {
    "kristijanhusak/vim-dadbod",
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle" },
  },
  {
    "kristijanhusak/vim-dadbod-completion",
    ft = { "sql" },
  },
}

