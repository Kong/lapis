config = require("kong-lapis.config").get!
if config.postgres
  require "kong-lapis.db.postgres.model"
elseif config.mysql
  require "kong-lapis.db.mysql.model"
else
  error "You have to configure either postgres or mysql"
