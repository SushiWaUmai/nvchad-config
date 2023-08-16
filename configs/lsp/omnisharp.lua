local omnisharp_extended = require "omnisharp_extended"
local pid = vim.fn.getpid()

return {
  handlers = {
    ["textDocument/definition"] = omnisharp_extended.handler,
  },
  cmd = { "omnisharp-mono", "--languageserver", "--hostPID", tostring(pid) },
}
