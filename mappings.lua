---@type MappingsTable
local M = {}
local opts = { noremap = true, silent = true, nowait = true }

M.general = {
  n = {
    ["<A-p>"] = { "<cmd>Copilot<CR>", "Get Copilot suggestions" },
    ["<A-Up>"] = { ":resize -2<CR>", "", opts = opts },
    ["<A-Down>"] = { "<cmd>resize +2<CR>", "", opts = opts },
    ["<A-Left>"] = { "<cmd>vertical resize -2<CR>", "", opts = opts },
    ["<A-Right>"] = { "<cmd>vertical resize +2<CR>", "", opts = opts },
    ["<C-\\>"] = { "<cmd>lua require('nvterm.terminal').toggle('horizontal')<CR>", "Toggle Terminal", opts = opts },
  },
  i = {
    ["<C-H>"] = { "<C-W>", "Delete one word", opts = opts },
  },
  t = {
    ["<C-\\>"] = { "<cmd>lua require('nvterm.terminal').toggle('horizontal')<CR>", "Toggle Terminal", opts = opts },
  },
}

-- more keybinds!

return M
