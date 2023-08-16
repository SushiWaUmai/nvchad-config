local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins
local h = require "null-ls.helpers"
local methods = require "null-ls.methods"
local FORMATTING = methods.internal.FORMATTING

local dotnet_format = h.make_builtin {
  name = "dotnet",
  method = { FORMATTING },
  filetypes = { "c#", "cs", "csharp" },
  generator_opts = {
    command = "dotnet",
    args = { "format", "whitespace", "--include", "$FILENAME" },
    to_stdin = false,
  },
  factory = h.formatter_factory,
}

local gofmt = h.make_builtin {
  name = "gofmt",
  method = { FORMATTING },
  filetypes = { "go" },
  generator_opts = {
    command = "gofmt",
    args = { "$FILENAME" },
  },
  factory = h.formatter_factory,
}

local sources = {
  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  dotnet_format,
  gofmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
