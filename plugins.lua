local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  {
    "NvChad/nvim-colorizer.lua",
    enabled = true,
  },

  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "j-hui/fidget.nvim",
  },

  {
    "saecki/crates.nvim",
  },

  {
    "rrethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      delay = 120,
      filetypes_denylist = {
        "NvimTree",
        "alpha",
        "TelescopePrompt",
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)

      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        signature = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  {
    "wakatime/vim-wakatime",
    event = "VimEnter",
  },

  {
    "github/copilot.vim",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "iamcco/markdown-preview.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "nacro90/numb.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require "alpha.themes.dashboard"
      dashboard.section.header.val = {
        "  ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗  ",
        "  ████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║  ",
        "  ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║  ",
        "  ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║  ",
        "  ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║  ",
        "  ╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝  ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "Find file", ":Telescope find_files <CR>"),
        dashboard.button("t", "Find text", ":Telescope live_grep <CR>"),
        dashboard.button("b", "Browse Folder", ":NvimTreeToggle<CR>"),
        dashboard.button("c", "Config", ":e " .. vim.fn.stdpath "config" .. "/init.lua <CR>"),
        dashboard.button("p", "Update Packages", ":Lazy <CR>"),
        dashboard.button("h", "Check Health", ":checkhealth <CR>"),
        dashboard.button("q", "Quit", ":qa<CR>"),
      }

      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = true
      return dashboard
    end,
    config = function(_, dashboard)
      -- thanks to https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },

  {
    "lvimuser/lsp-inlayhints.nvim",
    opts = {
      inlay_hints = {
        parameter_hints = {
          show = false,
          separator = ", ",
        },
        type_hints = {
          show = true,
          prefix = "",
          separator = ", ",
          remove_colon_end = false,
          remove_colon_start = false,
        },
        labels_separator = "  ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
      },
    },
  },

  {
    "b0o/SchemaStore.nvim",
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },
}

return plugins
