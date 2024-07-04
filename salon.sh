#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Appointment Scheduler ~~~~~\n"

MAIN_MENU() {

  if [[ $1 ]]
    then
    echo -e "\n$1"
  fi

  echo -e "How may I help you?\n"

  SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  echo $SERVICES | sed -E 's/([0-9])/\n\1/g;s/ \|/)/g'
  echo "x) Exit"

  read SERVICE_ID_SELECTED

  if [[ $SERVICE_ID_SELECTED = x ]]
    then 
      EXIT
    elif [[ $SERVICE_ID_SELECTED != [1-4] ]] 
    then
      MAIN_MENU "Please enter a valid option"
    else
      ITEM_SELECTED
  fi
}

ITEM_SELECTED() {
  echo "Option $SERVICE_ID_SELECTED selected."
}

EXIT() {
  echo "Thank you. Goodbye"
}

MAIN_MENU
