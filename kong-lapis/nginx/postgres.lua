io.stderr:write("WARNING: The module `kong-lapis.nginx.postgres` has moved to `kong-lapis.db.postgres`\n  Please update your require statements as the old path will no longer be\n  available in future versions of kong-lapis.\n\n")
return require("kong-lapis.db.postgres")
