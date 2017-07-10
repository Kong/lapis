config = require "kong-lapis.cmd.templates.config"
import compile_config from require "kong-lapis.cmd.nginx"

env = setmetatable {}, __index: (key) => "<%- #{key\lower!} %>"
compile_config config, env, os_env: false, header: false

