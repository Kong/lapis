config = require("kong-lapis.config").get!
if config.postgres
  require "kong-lapis.db.postgres"
elseif config.mysql
  require "kong-lapis.db.mysql"
else
  error "You have to configure either postgres or mysql"
