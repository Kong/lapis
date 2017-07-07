[[lapis = require "kong-lapis"

class extends lapis.Application
  "/": =>
    "Welcome to Lapis #{require "kong-lapis.version"}!"
]]
