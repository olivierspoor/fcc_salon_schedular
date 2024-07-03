#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

CREATE_CUSTOMERS_TABLE=$($PSQL "
  CREATE TABLE customers(
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR(15) UNIQUE NOT NULL,
  name VARCHAR(30)
)")

CREATE_APPOINTMENTS_TABLE=$($PSQL "
  CREATE TABLE appointments(
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT,
  service_id INT,
  time VARCHAR(10)  
)")

CREATE_SERVICES_TABLE=$($PSQL "
  CREATE TABLE services(
  service_id SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL  
)")

SET_FOREIGN_KEY_CUSTOMER_ID=$($PSQL "
ALTER TABLE appointments
    ADD FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
")

SET_FOREIGN_KEY_SERVICE_ID=$($PSQL "
ALTER TABLE appointments
    ADD FOREIGN KEY(service_id) REFERENCES services(service_id)
")
