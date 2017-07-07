local config = require("kong-lapis.config").get()
if config.postgres then
  return require("kong-lapis.db.postgres.schema")
elseif config.mysql then
  return require("kong-lapis.db.mysql.schema")
else
  return error("You have to configure either postgres or mysql")
end
