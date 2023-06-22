local options = {
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 2,
  conceallevel = 0, colorcolumn = "120",
  fileencoding = "utf-8",
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = true,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  timeoutlen = 100,
  undofile = true,
  updatetime = 300,
  writebackup = false,
  expandtab = false,
  cursorline = true,
  number = true,
  relativenumber = true,
  shiftwidth = 2,
  tabstop = 2,
  signcolumn = "yes",
  wrap = false,
  guifont = "MesloLGS Nerd Font Mono:h12",
  confirm = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "c"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set autoindent]]

local autocmd = vim.api.nvim_create_autocmd

-- shamelessly stolen from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- This file is automatically loaded by plugins.init
local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})
