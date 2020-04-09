# !/bin/bash
# Description: This script can zip and backup files for the user.
# Command usage: cpc <options> <source-file> <target-directory>
# script name: cpc
# Written by: Nathan Byrne & Jack Faulkner

# function checks if a directory exists
# pass directory path as parameter
dirExists(){
	if [ ! -d "$1" ]; then
		echo false
	else
		echo true
	fi
}

# functions attempts to create directory and lets user know if it was successful
# pass directory path as parameter
createDir(){
	# check if user has passed a parameter
	if [ $# = 1 ]; then
		# make the directory
		mkdir $1
		# Check made to make sure directory was created successfully
		dirExist=`dirExists $1`
		if [ $dirExist = true ]; then
			# return true if dir made
			echo true
		else
			# return false if dir not made
			echo false
		fi;
	else
		echo "No parameters given, please give a directory as a parameter"
	fi;
}

#--------------------------------------------------------------------------

usage="Usage: cpc [-cz] [source-file] [target-directory]"
dirExists=false
options=""
srcFile=""
trgtDir=""

# checking if three arguments are passed
if [ $# != 3 ]; then
	# error message
	echo "Error: Incorrect number of arguments"
	echo $usage
	exit
else
	# store given arguments
	options=$1
	srcFile=$2
	trgtDir=$3

	# check if given options are valid
	if ! [[ $options = "-c" || $options = "-z" ]]; then
		echo "Error: incorrect options"
		echo $usage
		exit
	fi

	# checking if the source file exists
	if [ ! -f "$srcFile" ]; then
		# error message
		echo "Error: source-file does not exist"
		echo $usage
		exit
	else
		# check if directory exists
		dirExist=`dirExists $trgtDir`
		if [ $dirExist = false ]; then
			echo "Target directory does not exist"
			# prompts user if they would like to create the missing directory
			while [ true ]; do
				read -p "Would you like to create the directory: \"$trgtDir\" [Y/N]" yn
				case $yn in
					# Directory gets created if user inputs "y"
					[Yy]* )
						dirExists=`createDir $trgtDir`
						# Check made to make sure directory was created successfully
						if [ $dirExists = true ]; then
							echo "Directory created successfully"
						else
							echo "Error: directory could not be created"
							echo $usage
							exit
						fi
						break;;
					# Directory doesnt get created if user inputs "n"
					[Nn]* ) 
						echo "Error: directory not created";
						echo $usage
						exit;;
					# User gets prompted to input correct key if wrong input is selected
					* ) echo "Please answer using y/n";;
				esac
			done

		else
			# Notifies user if the target directory already exists
			echo "Directory exists"
		fi

		
	fi
fi

# the following if statements carry out the relevant operation based on option selected

# executes if option is "-c"
if [ $options = "-c" ]; then
	# prompt user if they want to continue copying file
	while [ true ]; do
		read -p "Are you sure you want to copy file \"$srcFile\" to directory \"$trgtDir\" [Y/N]" yn
		case $yn in
			# File gets copied if user selects "yes"
			[Yy]* )
				cp $srcFile $trgtDir
				echo "File copied"
				break;;
			# File doesnt get copied if user selects "no"
			[Nn]* ) 
				echo "File not copied"
				exit;;
			* ) echo "Please answer using y/n";;
		esac
	done
# executes if option is "-z"
else
	# getting the file extension of the source file
	f="$(basename -- $srcFile)"
	extension=${f##*.}
	
	# check if file is already zipped
	if [ $extension = "gz" ]; then
		echo "-- Unzipping --"
		while [ true ]; do
			read -p "Are you sure you want to unzip and move file \"$srcFile\" to directory \"$trgtDir\" [Y/N]" yn
			case $yn in
				# File gets unzipped & moved if user selects "yes"
				[Yy]* )
					gunzip $srcFile
					new=${srcFile%.gz}
					mv $new $trgtDir
					echo "File unzipped and moved"
					break;;
				# File doesnt get unzipped & moved if user selects "no"
				[Nn]* ) 
					echo "Unzipping cancelled"
					exit;;
				* ) echo "Please answer using y/n";;
			esac
		done
	# else executes if file is not already zipped
	else
		echo "-- Zipping --"
		while [ true ]; do
			read -p "Are you sure you want to zip and move file \"$srcFile\" to directory \"$trgtDir\" [Y/N]" yn
			case $yn in
				# File gets zipped & moved if user selects "yes"
				[Yy]* )
					gzip $srcFile
					new="$srcFile.gz"
					mv $new $trgtDir
					echo "File zipped and moved"
					break;;
				# Zipping is cancelled if user selects "no"
				[Nn]* ) 
					echo "Zipping cancelled"
					exit;;
				* ) echo "Please answer using y/n";;
			esac
		done
	fi
fi



















