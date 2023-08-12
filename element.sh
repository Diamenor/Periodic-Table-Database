#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c" # --no-align

# if no arguments are provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
# if the argument is the element atomic number
elif [[ $1 =~ ^[0-9]+$ ]]
then
  RESULT=$($PSQL "SELECT * FROM elements 
          FULL JOIN properties USING (atomic_number)
          FULL JOIN types USING (type_id)
          WHERE atomic_number=$1")
  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$RESULT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
# if the argument is the element symbol
elif [[ ${#1} -le 2 ]]
then
  RESULT=$($PSQL "SELECT * FROM elements 
          FULL JOIN properties USING (atomic_number)
          FULL JOIN types USING (type_id)
          WHERE symbol='$1'")
  
  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$RESULT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
# if the argument is the element name
elif [[ ${#1} -gt 2 ]]
then
  RESULT=$($PSQL "SELECT * FROM elements 
          FULL JOIN properties USING (atomic_number)
          FULL JOIN types USING (type_id)
          WHERE name='$1'")
  
  if [[ -z $RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$RESULT" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING BAR BOILING BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi