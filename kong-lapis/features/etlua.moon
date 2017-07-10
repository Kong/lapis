
loadkit = require "loadkit"

import EtluaWidget from require "kong-lapis.etlua"

loadkit.register "etlua", (file, mod, fname) ->
  widget, err = EtluaWidget\load file\read "*a"

  if err
    error "[#{fname}] #{err}"

  widget

