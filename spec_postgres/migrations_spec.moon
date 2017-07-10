import setup_db, teardown_db from require "spec_postgres.helpers"

import drop_tables, truncate_tables from require "kong-lapis.spec.db"

db = require "kong-lapis.db.postgres"
import Model, enum from require "kong-lapis.db.postgres.model"
import types, create_table from require "kong-lapis.db.postgres.schema"

describe "model", ->
  setup ->
    setup_db!

  teardown ->
    teardown_db!

  it "should run blank migrations", ->
    migrations = require "kong-lapis.db.migrations"
    migrations.run_migrations {}

