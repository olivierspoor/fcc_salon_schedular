#!/bin/bash

PSQL="psql -x --username=freecodecamp --dbname=salon --tuples-only -c"

# Clear database
CLEAR_DATABASE=$($PSQL "DROP TABLE customers, appointments, services")
