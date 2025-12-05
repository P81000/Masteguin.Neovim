local lsp_zero = require("lsp-zero")
vim.lsp.set_log_level("off")

local function get_invoked_path()
  local arg0 = vim.fn.argv(0)

  if arg0 == "" or arg0 == nil then
    return vim.loop.cwd()
  end

  if vim.fn.isdirectory(arg0) == 0 then
    return vim.fn.fnamemodify(arg0, ":p:h")
  else
    return vim.fn.fnamemodify(arg0, ":p")
  end
end

local root_dir = get_invoked_path()
local PROJECT_ROOT = "/home/pmasteguin/dev"
local PHP_ROOT = "/home/pmasteguin/dev/php"
local temp_file = nil

local function is_in_c_dev_tree()
  if root_dir:sub(1, #PROJECT_ROOT) ~= PROJECT_ROOT then
    return false
  end

  if root_dir:sub(1, #PHP_ROOT) == PHP_ROOT then
    return false
  end

  return true
end

local function is_ephemeral_context()
  local args = table.concat(vim.v.argv, " ")
  return args:match("nvimdiff") or args:match("difftool") or root_dir:match("^/tmp") or root_dir == "/"
end

local function create_temp_ccls()
  if is_ephemeral_context() then
    vim.notify(" Contexto efêmero detectado - ignorando .ccls e LSP", vim.log.levels.WARN)
    return nil
  end

  if not is_in_c_dev_tree() then
    return nil
  end

  local temp_file = root_dir .. "/.ccls"
  local fd = io.open(temp_file, "w")
  if not fd then
    vim.notify("❌ Falha ao criar .ccls temporário", vim.log.levels.ERROR)
    return nil
  end

  fd:write("%clang\n")
  fd:write("-isystem/usr/include\n")
  fd:write("-isystem/usr/local/include\n")
  fd:write("-isystem/usr/lib/llvm-18/lib/clang/18/include\n\n")

  fd:write("-DDEBUG\n")
  fd:write("-D_REENTRANT\n")
  fd:write("-DFREERDP_EXPORTS\n")
  fd:write("-DWITH_X11\n")
  fd:write("-DWITH_CLIENT_CHANNELS\n\n")

  local handle = io.popen("find " .. root_dir .. " -type d -not -path '*/.*' 2>/dev/null")
  if handle then
    for dir in handle:lines() do
      fd:write("-I" .. dir .. "\n")
    end
    handle:close()
  end

  fd:write("-Wall\n")
  fd:write("-Wextra\n")
  fd:write("-Wpedantic\n")
  fd:write("-Wshadow\n")
  fd:write("-Wunused\n")
  fd:write("-Wuninitialized\n")
  fd:write("-Wmissing-prototypes\n")
  fd:write("-Wmissing-include-dirs\n")
  fd:write("-Wredundant-decls\n")
  fd:write("-Wstrict-prototypes\n")
  fd:write("-Wimplicit-function-declaration\n")
  fd:write("-Wundef\n")
  fd:write("-Werror=return-type\n")
  fd:write("-Werror=implicit\n\n")
-- 
--   -- Flags para C++ e headers
--   fd:write("%cpp %hpp\n")
--   fd:write("-std=c++17\n")
--   fd:write("-Wall\n")
--   fd:write("-Wextra\n")
--   fd:write("-Wpedantic\n")
--   fd:write("-Wshadow\n")
--   fd:write("-Wunused\n")
--   fd:write("-Wuninitialized\n")
--   fd:write("-Wmissing-include-dirs\n")
--   fd:write("-Wredundant-decls\n")
--   fd:write("-Wundef\n")
--   fd:write("-Werror=return-type\n")
--   fd:write("-Werror=implicit\n\n")

  fd:close()
  vim.notify("✅ Arquivo .ccls criado em " .. temp_file, vim.log.levels.INFO)
  return temp_file
end

temp_file = create_temp_ccls()

local function ccls_update()
  local new_path = create_temp_ccls()

  if not new_path then
    vim.notify("Falha ao recriar .ccls", vim.log.levels.ERROR)
  end

  temp_file = new_path

  local clients = vim.lsp.get_active_clients({ name = "ccls" })
  if #clients == 0 then
    vim.notify("CCLS não ativo", vim.log.levels.WARN)
    return
  end

  for _, client in ipairs(clients) do
    client.request("workspace/executeCommand", { command = "ccls.reload" })
  end
end

vim.api.nvim_create_user_command("CclsUpdate", ccls_update, {})

vim.keymap.set("n", "<leader>lr", ccls_update, { noremap = true, silent = true })

require("lspsaga").setup({
  ui = {
    border = "rounded",
    winblend = 5,
    title = true,
    expand = "",
    collapse = "",
    colors = { normal_bg = "#1e2030" },
  },
  hover = { max_width = 0.95, max_height = 0.9, open_link = "gx", open_cmd = "!xdg-open" },
  symbol_in_winbar = { enable = false },
  request_timeout = 5000,
})

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({ buffer = bufnr })
end)

if not is_ephemeral_context() and is_in_c_dev_tree() then
  vim.lsp.config("ccls", {
    cmd = { "ccls" },
    filetypes = { "c", "cpp", "objc", "objcpp", "h", "hpp", "cuda" },
    root_markers = { ".ccls", ".git" },
    init_options = {
      cache = { directory = ".ccls-cache", hierarchicalPath = true },
      highlight = { lsRanges = true },
      completion = { detailedLabel = true },
      crossFileRename = true,
      client = { snippetSupport = false },
      hierarchy = { qualified = true },
      codeLens = { localVariables = true },
      clang = {
        resourceDir = "/usr/lib/llvm-18/lib/clang/18/include",
        extraArgs = {},
      },
      index = {
        threads = 8,
        initialNoLinkage = false,
        onChange = true,
        trackDependency = 2,
        reparseForDependency = true,
        reparseOnFiles = true,
        implementationHierarchy = true,
        initialBlacklist = {},
        initialWhitelist = { ".*" },
      },
      workspaceSymbol = { caseSensitivity = 1, maxNum = 50000, sort = true },
    },
    capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          }
        }
      }
    ),
    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true, noremap = true }
      local keymap = vim.keymap.set

      keymap("n", "gd", vim.lsp.buf.definition, opts)
      keymap("n", "gD", vim.lsp.buf.declaration, opts)
      keymap("n", "gi", vim.lsp.buf.implementation, opts)
      keymap("n", "gr", vim.lsp.buf.references, opts)
      keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
      keymap("n", "gh", "<cmd>Lspsaga finder def+ref<CR>", opts)
      keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)

      vim.notify("🧠 CCLS anexado ao buffer " .. bufnr, vim.log.levels.INFO)

      vim.defer_fn(function()
        client.request("workspace/executeCommand", { command = "ccls.reload" })
        vim.notify("🔁 Cache e índices recarregados", vim.log.levels.INFO)
      end, 1200)
    end,
  })

  vim.lsp.enable("ccls")
end

vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if temp_file and vim.fn.filereadable(temp_file) == 1 then
      vim.fn.delete(temp_file)
      vim.notify("🧹 Arquivo .ccls temporário removido", vim.log.levels.INFO)
    end
  end,
})
