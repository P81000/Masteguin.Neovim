require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {
      "bash"        ,
      "c"           ,
      "cpp"         ,
      "csv"         ,
      "diff"        ,
      "dockerfile"  ,
      "git_config"  ,
      "gitignore"   ,
      "html"        ,
      "java"        ,
      "javascript"  ,
      "json"        ,
      "latex"       ,
      "lua"         ,
      "markdown"    ,
      "perl"        ,
      "python"      ,
      "query"       ,
      "rust"        ,
      "slint"       ,
      "toml"        ,
      "vim"         ,
      "vimdoc"      ,
      "yaml"        ,
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  
  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
}
