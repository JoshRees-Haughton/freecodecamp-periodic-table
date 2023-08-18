#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_OUTPUT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE atomic_number = $1")
  if [[ -z $ELEMENT_OUTPUT ]]
  then
    echo I could not find that element in the database.
  else
    echo "$ELEMENT_OUTPUT" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE_ID
  do
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
  done
  fi
else
  if [[ $1 =~ ^[a-zA-Z]{3,}+$ ]]
  then
    ELEMENT_OUTPUT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE name = '$1'")
    if [[ -z $ELEMENT_OUTPUT ]]
    then
      echo I could not find that element in the database.
    else
      echo "$ELEMENT_OUTPUT" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE_ID
      do
        TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
    else
      if [[ $1 =~ ^[a-zA-Z]+$ ]]
      then
        ELEMENT_OUTPUT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) WHERE symbol = '$1'")
        if [[ -z $ELEMENT_OUTPUT ]]
        then
          echo I could not find that element in the database.
        else
          echo "$ELEMENT_OUTPUT" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE_ID
          do
            TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
          done
        fi      
    fi
  fi
fi

