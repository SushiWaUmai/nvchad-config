local util = require "lspconfig/util"

return {
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false,
      },
      cargo = {
        allFeatures = true,
      },
    },
  },
}
