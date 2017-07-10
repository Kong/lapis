
restore_config = ->
  local old_config, old_env
  setup ->
    old_config = package.loaded["kong-lapis.config"]
    old_env = package.loaded["kong-lapis.environment"]

  teardown ->
    package.loaded["kong-lapis.config"] = old_config
    package.loaded["kong-lapis.environment"] = old_env

describe "kong-lapis.env", ->
  restore_config!

  before_each ->
    package.loaded["kong-lapis.config"] = nil
    package.loaded["kong-lapis.environment"] = nil
    config = require "kong-lapis.config"

    c = require "kong-lapis.config"

    c "first", ->
      color "blue"

    c "second", ->
      color "red"

  it "should push and pop env by name", ->
    env = require "kong-lapis.environment"
    -- default env
    assert.same "development", require("kong-lapis.config").get!._name
    env.push "first"
    assert.same "first", require("kong-lapis.config").get!._name
    env.push "second"
    assert.same "second", require("kong-lapis.config").get!._name
    assert.same "red", require("kong-lapis.config").get!.color
    env.pop!
    assert.same "first", require("kong-lapis.config").get!._name
    env.pop!
    assert.same "development", require("kong-lapis.config").get!._name

    assert.has_error ->
      env.pop!

  it "should push and pop table env", ->
    env = require "kong-lapis.environment"
    env.push { color: "green" }
    assert.same "green", require("kong-lapis.config").get!.color
    env.push { color: "blue" }
    assert.same "blue", require("kong-lapis.config").get!.color
    env.pop!
    assert.same "green", require("kong-lapis.config").get!.color
    env.pop!
    assert.same nil, require("kong-lapis.config").get!.color


describe "kong-lapis.config", ->
  restore_config!

  _G.do_nothing = ->

  local config

  extend = (first, ...) ->
    for i = 1, select "#", ...
      for k,v in pairs select i, ...
        first[k] = v

    first

  with_default = (c) ->
    extend {}, config.default_config, c

  before_each ->
    package.loaded["kong-lapis.config"] = nil
    package.loaded["kong-lapis.environment"] = nil

    config = require "kong-lapis.config"
    config.reset true

  it "should create empty config", ->
    assert.same config.get"hello", with_default { _name: "hello" }

  it "should create correct object", ->
    f = ->
      burly "dad"
      color "blue"

    config "basic", ->
      do_nothing!
      color "red"
      port 80

      things ->
        cool "yes"
        yes "really"

      include ->
        height "10px"

      set "not", "yeah"

      set many: "things", are: "set"

      include f

    input = config.get "basic"
    assert.same input, with_default {
      _name: "basic"

      color: "blue"
      are: "set"
      burly: "dad"
      things: {
        yes: "really"
        cool: "yes"
      }
      not: "yeah"
      many: "things"
      height: "10px"
      port: 80
    }

  it "should create correct object", ->
    config "cool", ->
      hello {
        one: "thing"
        leads: "another"
        nest: {
          egg: true
          grass: true
        }
      }

      hello {
        dad: "son"
         nest: {
           bird: false
           grass: false
         }
      }

    input = config.get "cool"
    assert.same input, with_default {
      _name: "cool"
      hello: {
        nest: {
          grass: false
          egg: true
          bird: false
        }
        dad: "son"
        one: "thing"
        leads: "another"
      }
    }

  it "should unset", ->
    config "yeah", ->
      hello "world"
      hello!

      one "two"
      three "four"

      unset "one", "four", "three"

    assert.same config.get"yeah", with_default { _name: "yeah" }

  it "should set multiple environments", ->
    config {"multi_a", "multi_b"}, ->
      pants "cool"

    assert.same config.get"multi_a".pants, "cool"
    assert.same config.get"multi_b".pants, "cool"


  it "should set with table literal", ->
    config {"cool", "dad"}, {
      yes: true
      thing: {
        one: "two"
        three: "four"
      }
    }

    config "cool", {
      no: false
      thing: {
        one: "five"
        two: "six"
      }
    }

    assert.same with_default({
      _name: "cool"
      yes: true
      no: false
      thing: {
        one: "five"
        two: "six"
        three: "four"
      }
    }), config.get "cool"

    assert.same with_default({
      _name: "dad"
      yes: true
      thing: {
        one: "two"
        three: "four"
      }
    }), config.get "dad"


  it "should merge subsequent blocks", ->
    config {"alpha","beta","gamma"}, ->
      postgres ->
        backend "pgmoon"

    config "gamma", ->
      postgres ->
        database "lazuli_dev"

    assert.same { backend: "pgmoon" }, config.get("beta").postgres
    assert.same { backend: "pgmoon", database: "lazuli_dev" }, config.get("gamma").postgres


