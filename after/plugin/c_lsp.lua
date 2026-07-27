-- c_lsp.lua
local lsp_zero = require("lsp-zero")

local root_dir = vim.fn.getcwd()
local PROJECT_ROOT = "/Users/masteguin/dev/codes"

local LLVM_BIN_CPP = "/Users/masteguin/dev/.homebrew/opt/llvm/bin/clang++"
local LLVM_BIN_C = "/Users/masteguin/dev/.homebrew/opt/llvm/bin/clang"
local CLANGD_CMD = "/Users/masteguin/dev/.homebrew/opt/llvm/bin/clangd"

local function is_in_c_dev_tree()
  return root_dir:sub(1, #PROJECT_ROOT) == PROJECT_ROOT
end

local function is_ephemeral_context()
  local args = table.concat(vim.v.argv, " ")
  return args:match("nvimdiff") or args:match("difftool") or root_dir:match("^/tmp") or root_dir == "/"
end

local status_saga, lspsaga = pcall(require, "lspsaga")
if status_saga then
  lspsaga.setup({ ui = { border = "rounded", winblend = 5, title = true } })
end

if not is_ephemeral_context() and is_in_c_dev_tree() then
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local cmp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if cmp_status then capabilities = cmp_nvim_lsp.default_capabilities() end

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  -- Sterilize environment to prevent bash_profile crashes
  local sterile_env = vim.fn.environ()
  sterile_env.CPATH = nil
  sterile_env.CPLUS_INCLUDE_PATH = nil
  sterile_env.CPPFLAGS = nil

  -- Base command shared by both C and C++
  local base_cmd = {
      CLANGD_CMD,
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--limit-results=20",
      "--query-driver=" .. LLVM_BIN_CPP .. "," .. LLVM_BIN_C
  }

  -- Keymaps shared by both servers
  local on_attach_custom = function(client, bufnr)
    local opts = { buffer = bufnr, silent = true, noremap = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    vim.keymap.set("n", "gh", "<cmd>Lspsaga finder def+ref<CR>", opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  end

  -- ==========================================================
  -- SERVER 1: C++ CONFIGURATION
  -- ==========================================================
  vim.lsp.config("clangd_cpp", {
    cmd = base_cmd,
    cmd_env = sterile_env,
    filetypes = { "cpp", "objc", "objcpp", "hpp" },
    root_markers = { "compile_commands.json", ".git" },
    capabilities = capabilities,
    init_options = {
      fallbackFlags = {
        "-std=c++23",
        "-D_LIBCPP_DISABLE_AVAILABILITY",
        "-Wall",
        "-Werror",
        "-Wextra"
      }
    },
    on_attach = on_attach_custom,
  })
  vim.lsp.enable("clangd_cpp")

  -- ==========================================================
  -- SERVER 2: PURE C CONFIGURATION
  -- ==========================================================
  vim.lsp.config("clangd_c", {
    cmd = base_cmd,
    cmd_env = sterile_env,
    filetypes = { "c", "h" },
    root_markers = { "compile_commands.json", ".git" },
    capabilities = capabilities,
    init_options = {
      fallbackFlags = {
        "-std=c11",
        "-Wall",
        "-Werror",
        "-Wextra"
      }
    },
    on_attach = on_attach_custom,
  })
  vim.lsp.enable("clangd_c")
end

vim.diagnostic.config({ virtual_text = { spacing = 2, prefix = "●" }, severity_sort = true })
