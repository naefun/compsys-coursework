# !/bin/bash
# Description: This script takes in two integer arguments and prints even numbers and a message depending on what it is divisible by.
# Command usage: evenfruit.sh <first number> <second number>
# script name: evenfruit.sh
# Authors: Nathan Byrne (190051783) & Jack Faulkner (190051808)

# Function prompts user for input and checks that it is an integer
getNum(){
	# Regular expression used to check input against
	re='^[0-9]+$'
	
	read -p "Please enter an integer: " num1 leftover
	# While loop checks input against regular expression to ensure it is a number, if not then it will ask for input again
	while ! [[ $num1 =~ $re ]]; do
		read -p "Please enter an integer: " num1 leftover
	done
	
	# return the number
	echo $num1
}


#----------------------------------------------------------------------------------------------------------

# Store user arguments in variables
arg1=$1
arg2=$2

# Case statement checks how many arguments have been passed
case $# in
	# If user gives no arguments, script will ask for two numbers
	0 )
		echo "You are required to input two numbers"
		arg1=`getNum`
		arg2=`getNum`;;
	# If user gives one argument, script will ask for one number
	1 )
		echo "You only gave one number"
		arg2=`getNum`;;
	# If user gives two arguments, script will give confirmation message
	2 )
		echo "Thank you...";;
	# For all other situations, which can only be when more than 2 arguments are given, user is notified
	* )
		echo "You gave more than two integers, only the first two will be used.";;
esac

# Notify the user of the numbers which are being used
echo "the numbers are $arg1 & $arg2"

# For loop iterating through numbers (from first number given +1 to, but not including, the second number given)
for((var=$((arg1+1)); var<$arg2; var++)); do 
	# Check if current number is even
	if [ $((var%2)) = 0 ];then
		# message variable will be printed after the number itself
		message=""
		# If the number is a multiple of 7, then set message to "orange"
		if [ $((var%7)) = 0 ];then
			message=":orange"
		fi
		# If the number is a multiple of 11, then set message to "banana"
		if [ $((var%11)) = 0 ];then
			message=":banana"
		fi
		# If the number is a multiple of 26, then set message to "pear"
		if [ $((var%26)) = 0 ];then
			message=":pear"
		fi
		# Print the number and message
		echo $var$message
	fi
done

echo "What is with the fruit obsession?"

































