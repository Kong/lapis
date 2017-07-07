local config = require("kong-lapis.config").get()
if config.postgres then
  return require("kong-lapis.db.postgres.model")
elseif config.mysql then
  return require("kong-lapis.db.mysql.model")
else
  return error("You have to configure either postgres or mysql")
end
