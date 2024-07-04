#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

MAIN_MENU() {
  echo -e "How may I help you?\n"

  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  echo $SERVICES | sed -E 's/([0-9])/\n\1/g;s/ \|/)/g'

  read SERVICE_SELECTION

  case $SERVICE_SELECTION in
  1) TRIM_SELECTED ;;
  2) CUT_SELECTED ;;
  3) STYLE_SELECTED ;;
  4) COLOR_SELECTED ;;
  *) MAIN_MENU ;; 
  esac

}

TRIM_SELECTED() {
  echo "Option $SERVICE_SELECTION selected."
}
CUT_SELECTED() {
  echo "Option $SERVICE_SELECTION selected."
}
STYLE_SELECTED() {
  echo "Option $SERVICE_SELECTION selected."
}
COLOR_SELECTED() {
  echo "Option $SERVICE_SELECTION selected."
}

MAIN_MENU
