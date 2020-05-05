#!/bin/bash -x

echo "Welcome to Tic tac toe Game"
 
declare -a board
#constants
PLAYER=X;
COMPUTER=O;
HEAD=1;
TAIL=0;

board=(0,0,0,0,0,0,0,0,0)

checkingToss=$((RANDOM%2))
if [[ $checkingToss == $HEAD ]]
then
	echo "Player play first"
else
	echo "computer play first"
fi
