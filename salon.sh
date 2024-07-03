#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

MAIN_MENU() {
  echo -e "How may I help you?\n"

  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  echo $SERVICES | sed -E 's/([0-9])/\n\1/g;s/ \|/)/g'

}

MAIN_MENU
