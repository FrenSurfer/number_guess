#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

USERNAME_FUNC() {

  echo -e "\nEnter your username:\n"

  read USERNAME

  USER_ID=$($PSQL "SELECT user_id FROM userinfo WHERE username = '$USERNAME'")

  #username is found
  if [[ $USER_ID ]]
    then
    GAME_PLAYED=$($PSQL "SELECT games_played FROM userinfo WHERE username='$USERNAME'")
    BEST_GAME=$($PSQL "SELECT best_game FROM userinfo WHERE username='$USERNAME'")
    echo  "Welcome back, $USERNAME! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
    
  # username is not found
  elif [[ -z $USER_ID ]]
    then
    #insert new user
    INSERT_NEW_USER=$($PSQL "INSERT INTO userinfo(username, games_played, best_game) VALUES('$USERNAME', 0, 0)")
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
    GAME_PLAYED=$($PSQL "SELECT games_played FROM userinfo WHERE username='$USERNAME'")
    BEST_GAME=$($PSQL "SELECT best_game FROM userinfo WHERE username='$USERNAME'")
  fi
}

USERNAME_FUNC

NUMBER_GUESSING_FUNC() {

  echo -e "\nGuess the secret number between 1 and 1000:\n"
  read USER_INPUT

  while [[ ! $USER_INPUT =~ ^[0-9]+$ ]]
  do
    if [[ ! $USER_INPUT =~ ^[0-9]+$ ]]
    then 
      echo -e "\nThat is not an integer, guess again:"
    fi
    read USER_INPUT
  done

  random_number=$RANDOM
  random_number=$((random_number % 1000 + 1))
  #echo $random_number
  user_count=0

  #number guessing while/if statement
  while [[ $USER_INPUT -ne $random_number ]]
  do
    if [[ ! $USER_INPUT =~ ^[0-9]+$ ]]
    then 
      echo "That is not an integer, guess again:"

    elif [[ $USER_INPUT -gt $random_number ]]
    then
      echo -e "\nIt's lower than that, guess again:"
      (( user_count ++ ))
      read USER_INPUT
  
    elif [[ $USER_INPUT -lt $random_number ]]
    then
      echo -e "\nIt's higher than that, guess again:"
      (( user_count ++ ))
      read USER_INPUT
    fi
  done

  ((user_count ++))
  INSERT_GAME=$($PSQL "UPDATE userinfo SET games_played = games_played + 1 WHERE username='$USERNAME'")
  BEST_GAME_ALREADY=$($PSQL "SELECT best_game FROM userinfo WHERE username = '$USERNAME'")
  
  if [[ $BEST_GAME_ALREADY -eq 0 ]]
  then
    INSERT_BEST_GAME=$($PSQL "UPDATE userinfo set best_game = $user_count WHERE username='$USERNAME'")
  elif [[ $BEST_GAME_ALREADY -gt $user_count ]]
  then
    INSERT_BEST_GAME=$($PSQL "UPDATE userinfo set best_game = $user_count WHERE username='$USERNAME'")
  fi
  echo  "You guessed it in $user_count tries. The secret number was $random_number. Nice job!"
}
NUMBER_GUESSING_FUNC