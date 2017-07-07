local config = require("kong-lapis.cmd.templates.config")
local compile_config
compile_config = require("kong-lapis.cmd.nginx").compile_config
local env = setmetatable({ }, {
  __index = function(self, key)
    return "<%- " .. tostring(key:lower()) .. " %>"
  end
})
return compile_config(config, env, {
  os_env = false,
  header = false
})
