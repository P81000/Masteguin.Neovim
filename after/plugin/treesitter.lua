require"nvim-treesitter.configs".setup {
  ensure_installed = {
    "c",
    "cpp",
    "diff",
    "git_config",
    "gitignore",
    "vim",
    "vimdoc",
    "php",
    "phpdoc",
    "html"
  },

  sync_install = true,

  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  }
}
