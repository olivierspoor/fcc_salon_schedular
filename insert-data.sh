#!/bin/bash

PSQL="psql -x --username=freecodecamp --dbname=salon --tuples-only -c"

INSERT_SERVICES=$($PSQL "INSERT INTO
services(name) VALUES('trim'), ('cut'), ('style'), ('color')
")
