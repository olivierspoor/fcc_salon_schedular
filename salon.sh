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

  # use phone number to check for existing customer
  echo "What is your phone number?"
  read CUSTOMER_PHONE

  while [[ -z $CUSTOMER_PHONE ]] 
    do
      echo "Please enter a valid phone number."
      read CUSTOMER_PHONE
    done

  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  # if customers doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
    then
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME

    # insert new customer
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
  fi

  # get customer id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  echo $CUSTOMER_ID

  # ask for a time
  echo -e "\nWhat time would you like to schedule?"
  read SERVICE_TIME
 
  # insert appointment
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")

  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed 's/ ^//')
  CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed 's/ ^//')

  echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."
}

EXIT() {
  echo "Thank you. Have a nice day."
}

MAIN_MENU
