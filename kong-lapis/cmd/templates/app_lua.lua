return [[local lapis = require("kong-lapis")
local app = lapis.Application()

app:get("/", function()
  return "Welcome to Lapis " .. require("kong-lapis.version")
end)

return app
]]
