import push, pop from require "kong-lapis.environment"
import set_backend, init_logger from require "kong-lapis.db.mysql"

setup_db = (opts) ->
  push "test", {
    mysql: {
      user: "root"
      database: "lapis_test"
    }
  }

  set_backend "luasql"
  init_logger!

teardown_db = ->
  pop!

{:setup_db, :teardown_db}

