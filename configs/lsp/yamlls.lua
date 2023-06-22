local schemastore = require "schemastore"

return {
  settings = {
    yaml = {
      schemas = schemastore.yaml.schemas(),
      validate = { enable = true },
    },
  },
}
