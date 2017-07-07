
.PHONY: test local build global watch lint test_db mysql_test_db clean

test:
	busted spec
	busted spec_postgres
	busted spec_mysql
	busted spec_openresty

local: build
	luarocks make --force --local

global: build
	sudo luarocks make kong-lapis-1.5.2-1.rockspec

build:
	moonc kong-lapis
	moonc spec_openresty/s2
	moonc spec_mysql/models.moon

watch: build
	moonc -w kong-lapis

lint:
	moonc lint_config.moon
	moonc -l $$(find kong-lapis | grep moon$$)

test_db:
	-dropdb -U postgres lapis_test
	createdb -U postgres lapis_test

mysql_test_db:
	echo 'drop database if exists lapis_test' | mysql -u root
	echo 'create database lapis_test' | mysql -u root

clean:
	rm $$(find kong-lapis/ | grep \.lua$$)
