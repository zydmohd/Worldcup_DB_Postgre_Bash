#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#echo $($PSQL"TRUNCATE teams,games")
cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals 
do 
# Remove Headers
if [[ $winner != 'winner' ]] 
then
  
  # Check if the team name is already in the database
  TEAM_ID=$($PSQL"SELECT team_id from teams WHERE name='$winner'")
  
  if [[ -z $TEAM_ID ]]
  then
    
    INSERT_NAME_RESULT=$($PSQL"INSERT INTO teams(name) VALUES('$winner');")
    
    if [[ $INSERT_NAME_RESULT=='INSERT 0 1' ]]
    then
      echo "Team '$winner' inserted in teams successfully"
    fi
  fi
fi

# Remove Headers
if [[ $opponent != 'opponent' ]] 
then
  
  # Check if the team name is already in the database
  TEAM_ID=$($PSQL"SELECT team_id from teams WHERE name='$opponent'")
  
  if [[ -z $TEAM_ID ]]
  then
    
    INSERT_NAME_RESULT=$($PSQL"INSERT INTO teams(name) VALUES('$opponent');")
    
    if [[ $INSERT_NAME_RESULT=='INSERT 0 1' ]]
    then
      echo "Team '$opponent' inserted in teams successfully"
    fi
  fi
fi
done

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals 
do
# Insert ROWS to games table
#year
# Remove Headers
if [[ $year != 'year' ]] & [[ $round != 'round' ]] & [[ $winner != 'winner' ]] & [[ $opponent != 'opponent' ]] & [[ $winner_goals != 'winner_goals' ]] & [[ $opponent_goals != 'opponent_goals' ]]
then
  
  WINNER_ID=$($PSQL"SELECT team_id from teams WHERE name='$winner'")
  OPPONENT_ID=$($PSQL"SELECT team_id from teams WHERE name='$opponent'")
  
  INSERT_RAW_RESULT=$($PSQL"INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES('$year','$round','$WINNER_ID','$OPPONENT_ID','$winner_goals','$opponent_goals');")
  if [[ $INSERT_RAW_RESULT == 'INSERT 0 1' ]]
  then
    echo "RAW INSERTED"
  else
    "NULL values is not permited"  
  fi  
fi
done
  
  
