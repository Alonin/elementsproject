#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

PARSE(){
  if [[ $1 =~ ^[0-9]{1,2}$ ]]
  then
    # Look-up element by atomic number
    echo $($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1 ") | while read ATOMIC_NUM BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELTING_C BAR BOILING_C
    do
      if ! [[ -z $NAME ]]
      then
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_C celsius and a boiling point of $BOILING_C celsius."
      else
        echo "I could not find that element in the database."
      fi
    done
    else 
    if [[ ${#1} -le 2 ]]
    then
    echo $($PSQL "SELECT atomic_number, name,  symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$1'") | while read ATOMIC_NUM BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_C BAR BOILING_C 
  do
  if ! [[ -z $NAME ]]
  then
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_C celsius and a boiling point of $BOILING_C celsius."

    else
   echo "I could not find that element in the database."
    fi
    done
    else 
  
    echo $($PSQL "SELECT atomic_number, name,  symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING (type_id) WHERE name='$1'") | while read ATOMIC_NUM BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING_C BAR BOILING_C 
    do  
    if ! [[ -z $NAME ]]
    then
        echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_C celsius and a boiling point of $BOILING_C celsius."
else
echo "I could not find that element in the database."
fi
done
    fi
    fi
}
#comment
    if [[ -z $1 ]] 
    then 
    echo "Please provide an element as an argument."
    else
    echo "$($echo PARSE $1)"
    fi