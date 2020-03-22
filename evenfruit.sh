# !/bin/bash
# This is a calculator script.
# script name: evenfruit.sh

#REGULAR EXPRESSIONS -- https://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash/806923

getNum(){
	re='^[0-9]+$'
	
	read -p "Please enter an integer: " num1 leftover
	while ! [[ $num1 =~ $re ]]; do
		read -p "Please enter an integer: " num1 leftover
	done
	
	echo $num1
}


#----------------------------------------------------------------------------------------------------------

arg1=$1
arg2=$2

case $# in
	0 )
		echo "You are required to input two numbers"
		arg1=`getNum`
		arg2=`getNum`;;
		
	1 )
		echo "You only gave one number"
		arg2=`getNum`;;
	2 )
		echo "Thank you...";;
	* )
		echo "You gave more than two integers, only the first two will be used.";;
esac

echo "the numbers are $arg1 & $arg2"

for((var=$((arg1+1)); var<$arg2; var++)); do 
	if [ $((var%2)) = 0 ];then
		message=""
		if [ $((var%7)) = 0 ];then
			message=":orange"
		fi
		if [ $((var%11)) = 0 ];then
			message=":banana"
		fi
		if [ $((var%26)) = 0 ];then
			message=":pear"
		fi
		echo $var$message
	fi
done

echo "What is with the fruit obsession?"

































