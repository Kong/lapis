local config = require("kong-lapis.config").get()
if config.postgres then
  return require("kong-lapis.db.postgres")
elseif config.mysql then
  return require("kong-lapis.db.mysql")
else
  return error("You have to configure either postgres or mysql")
end
