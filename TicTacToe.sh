#!/bin/bash -x

echo "Welcome to Tic tac toe Game"
 
declare -a board
#constants
PLAYER=X;
COMPUTER=O;

function initializingBoard(){

	board=(0,0,0,0,0,0,0,0,0)

}

initializingBoard
