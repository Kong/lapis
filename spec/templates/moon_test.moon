
import Widget from require "kong-lapis.html"

class MoonTest extends Widget
  content: =>
    div class: "greeting", ->
      text "hello world"
