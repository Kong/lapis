config = require("kong-lapis.config").get!
if config.postgres
  require "kong-lapis.db.postgres.schema"
elseif config.mysql
  require "kong-lapis.db.mysql.schema"
else
  error "You have to configure either postgres or mysql"
