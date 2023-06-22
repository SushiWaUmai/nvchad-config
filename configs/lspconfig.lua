local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lsp_inlayhints = require "lsp-inlayhints"
local mason_lspconfig = require "mason-lspconfig"

local lspconfig = require "lspconfig"

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local function setup_language_server(server)
  local opts = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      lsp_inlayhints.on_attach(client, bufnr)
    end,

    flags = {
      debounce_text_changes = 150,
    },
    capabilities = {
      offsetEncoding = "utf-8",
    },
  }

  local lang_opts_status_ok, lang_opts = pcall(require, "custom.configs.lsp." .. server)
  if lang_opts_status_ok then
    opts = vim.tbl_deep_extend("force", lang_opts, opts)
  end

  opts = vim.tbl_deep_extend("force", { capabilities = capabilities }, opts)

  lspconfig[server].setup(opts)
end

for _, server in pairs(mason_lspconfig.get_installed_servers()) do
  if server ~= "lua_ls" then
    setup_language_server(server)
  end
end
