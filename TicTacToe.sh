#!/bin/bash -x 

echo "Welcome to Tic tac toe Game"
 
declare -a board
#constants
HEAD=1;
TAIL=0;
GAMESTATUS=1
NUMBEROFROWS=3;
NUMBEROFCOLUMNS=3;
BOARD_POSITION=10;

playerTurn=false
winner=false
turn=0
player=''
computer=''
nonEmptyCount=1
computerP=0
playerP=0
compWinMove=false
function boardInitialize(){

	for (( i=1 ; i<=$BOARD_POSITION; i++ ))
	do
		board[$i]=0 
	done
}

function  printBoard(){

	echo " -------------"
	echo " | "${board[1]}" | "${board[2]}" | "${board[3]}" | "
	echo " -------------"
	echo " | "${board[4]}" | "${board[5]}" | "${board[6]}" | "
	echo " -------------"
	echo " | "${board[7]}" | "${board[8]}" | "${board[9]}" | "
	echo " -------------"

}

function cornerCheck()
{
	 if [ $compWinMove = false ]
   then
		for((i=1; i<=BOARD_POSITION; i=$(($i+2)) ))
		do
		if [ ${board[$i]} == '-' ]
		then
			computerP=$i
            	board[$computerP]=$computer
            	compWinMove=true
            break
				fi
				if [ $i -eq 3 ]
				then
					i=$(($i+2))
				fi
		done
	fi
}

function middleCheck()
{
	middle=5
	if [[ $compWinMove = false ]] && [[ ${board[$middle]} == '-' ]]
	then
		computerP=$middle
               board[$computerP]=$computer
               compWinMove=true
   fi

}

function randomCheck(){
	 if [ $compWinMove = false ]
	 then
                for((i=2; i<=BOARD_POSITION; i=$(($i+2)) ))
                do
                if [ ${board[$i]} == '-' ]
                then
                        computerP=$i
                board[$computerP]=$computer
                compWinMove=true
                break
                 fi
                  if [ $i -eq 3 ] || [ $i -eq 6 ]
                  then
                          i=$(($i+1))
                  fi
                done
        fi


}


function checkHorizontalCase(){

	numberOfRows=3
	position=1
	counter=1
	while [ $counter -le 3 ]
	do
		if [[ ${board[$position]} == ${board[$position+1]} ]] && [[ ${board[$position+1]} == ${board[$position+2]} ]] && [[ ${board[$position+2]} == $1 ]]
		then
			printBoard
			echo "$1 wins"
			winner=true
			break
		else
			position=$(( $position+$numberOfRows ))
		fi
	counter=$(( $counter+1 ))
	done
}

function checkVerticalCase(){
	numberOfRows=3
	position=1
	counter=1
	while [ $counter -le 3 ]
	do
		if [[ ${board[$position]} == ${board[$position+3]} ]] && [[ ${board[$position+3]}  ==  ${board[$position+6]} ]] && [[ ${board[$position+6]} == $1 ]]
		then
			printBoard
			echo "$1 Wins"
			winner=true
			break


		else
			position=$(( $position+1 ))
		fi
	counter=$(( $counter+1 ))
	done
}

function checkDiagonalCase()
{
	position=1
	counter=1
	while [ $counter -le 2 ]
	do
		if [[ ${board[$position]} == ${board[$position+4]} ]] && [[ ${board[$position+4]}  ==  ${board[$position+8]} ]] && [[ ${board[$position+8]} == $1 ]]
		then
			printBoard
			echo " $1 wins "
			winner=true
			break
		elif [[ ${board[$position+2]} == ${board[$position+4]} ]] && [[  ${board[$position+4]}  ==  ${board[$position+6]} ]] && [[ ${board[$position+6]} == $1 ]]
		then
			printBoard
			echo " $1 wins "
			winner=true
			break
		fi
		counter=$(($counter+1))
	done
}

function checkTieCase(){

	while [ ${board[$nonEmptyCount]} != 0 ]
	do
		if [ $nonEmptyCount -eq 9 ]
		then
			printBoard
			echo "Game Is Tie"
			winner=true
			break
		else
			nonEmptyCount=$(($nonEmptyCount+1))
		fi
	done

}

function checkWinningMove(){
	counter=1
	winMove=false

	for (( i=1; i<=3; i++ ))
	do
		if [[ ${board[$counter]} == ${board[$counter+$1+$1]} ]] && [[ ${board[$counter+$1]} == 0 ]] &&[[ ${board[$counter]} == $computer ]]
		then
			computerP=$(( $counter+$1 ))
			echo " winning move is " $computerP
			board[$computerP]=$computer
			winMove=true
			break
		elif [[ ${board[$counter]} == ${board[$counter+$1]} ]] && [[ ${board[$counter+$1+$1]} == 0 ]] && [[ ${board[$counter]} == $computer ]]
		then
			computerP=$(( $counter+$1+$1 ))
			echo "winning move is " $computerP
			board[$computerP]=$computer
			winMove=true
			break
		elif [[ ${board[$counter+$1]} == ${board[$counter+$1+$1]} ]] && [[ ${board[$counter]} == '-' ]] && [[ ${board[$counter+$1]} == $computer ]]
		then
			computerP=$counter
			echo "winning move is " $computerP
			board[$computerP]=$computer
			winMove=true
			break
		fi
	counter=$(( $counter+$2 ))
	done
}

function checkWinningMovePlayer(){
        counterPlayer=1
        winMovePlayer=false

        for (( i=1; i<=3; i++ ))
        do
                if [[ ${board[$counterPlayer]} == ${board[$counterPlayer+$1+$1]} ]] && [[ ${board[$counterPlayer+$1]} == 0 ]] &&[[ ${board[$counterPlayer]} == $player ]]
                then
                        playerP=$(( $counterPlayer+$1 ))
                        echo "player winning move is " $playerP
                        board[$playerP]=$player
                        winMovePlayer=true
                        break
                elif [[ ${board[$counterPlayer]} == ${board[$counterPlayer+$1]} ]] && [[ ${board[$counterPlayer+$1+$1]} == 0 ]] && [[ ${board[$counterPlayer]} == $player ]]
                then
                        playerP=$(( $counterPlayer+$1+$1 ))
                        echo "player winning move is " $playerP
                        board[$playerP]=$player
                        winMovePlayer=true
                        break
                elif [[ ${board[$counterPlayer+$1]} == ${board[$counterPlayer+$1+$1]} ]] && [[ ${board[$counterPlayer]} == '-' ]] && [[ ${board[$counterPlayer+$1]} == $player ]]
                then
                        playerP=$counter
                        echo "player winning move is " $playerP
                        board[$playerP]=$player
                        winMovePlayer=true
                        break
                fi
        counterPlayer=$(( $counterPlayer+$2 ))
        done
}






function userInput() {
	row=1
	column=3
	winMovePlayer=false
	read -p "Enter you position in between 1 to 9: " POSITION
	checkWinningMovePlayer $row $column
        checkWinningMovePlayer $column $row
	if [ $winMovePlayer == false ]
	then
		if [ ${board[$POSITION]} -eq $TAIL ]
		then
			echo "player turn"
			board[$POSITION]=$player
			printBoard
			turn=$(( $turn + 1 ))
		else
			echo "Invalid input"
			userInput
		fi
	fi
		playerTurn=false

}


function computerInput(){
	row=1
	column=3
	winMove=false

	echo "Computer is Playing"
	checkWinningMove $row $column
	checkWinningMove $column $row
	cornerCheck
	middleCheck
	randomCheck
	POSITION=$((RANDOM%9+1))

	if [ $winMove == false ]
	then
		if [ ${board[$POSITION]} == $TAIL ]
		then
			board[$POSITION]=$computer
		else
			echo "Wrong move "
			computerInput
		fi
	fi
		playerTurn=true
}


function ticTacToe(){

	checkingToss=$((RANDOM%2))
	if [[ $checkingToss -eq $HEAD ]]
	then
		playerTurn=true
		player='X'
		computer='O'
		echo "Player play first"
		printBoard

	else
		player='X'
		computer='O'
		echo "computer play first"
	fi
}

boardInitialize
ticTacToe

while [ $winner == false ]
do
	
		printBoard
		if [ $playerTurn == true ]
		then 
			userInput
			checkHorizontalCase $player
			checkVerticalCase $player
			checkDiagonalCase $player
			checkTieCase $player
		else
			computerInput
			checkHorizontalCase $computer
                        checkVerticalCase $computer
                        checkDiagonalCase $computer
			checkTieCase $computer
		fi
done
