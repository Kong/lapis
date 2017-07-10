{
  new: (flags) =>
    -- no new files needed

  server: (flags, environment) =>
    import push, pop from require "kong-lapis.environment"
    import start_server from require "kong-lapis.cmd.cqueues"

    push environment

    config = require("kong-lapis.config").get!
    app_module = config.app_class or "app"
    start_server app_module

    pop!
}
