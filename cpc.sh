# !/bin/bash
# Description: This script can zip and backup files for the user.
# Command usage: cpc <options> <source-file> <target-directory>
# script name: cpc
# Written by: Nathan Byrne & Jack Faulkner

dirExists(){
	if [ ! -d "$1" ]; then
		echo false
	else
		echo true
	fi
}

createDir(){
	if [ $# = 1 ]; then
		mkdir $1
		dirExist=`dirExists $1`
		# Check made to make sure directory was created successfully
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
					# Directory gets created if user selects yes
					[Yy]* )
						dirExists=`createDir $trgtDir`
						# Check made to make sure directory was created successfully
						if [ $dirExists = true ]; then
							echo "Directory created successfully"
						else
							echo "Directory could not be created"
							exit
						fi
						break;;
					# Directory doesnt get created if user selects no
					[Nn]* ) 
						echo "Error: directory not created";
						echo $usage
						exit; 
						break;;
					# User gets prompted to input correct key if wrong input is selected
					* ) echo "Please answer using y/n";;
				esac
			done

		else
			# Notifies user if the target directory already exists
			echo "directory exists"
			dirExists=true
		fi

		
	fi
fi

# carries out operation based on option
if [ $options = "-c" ]; then
	while [ true ]; do
		read -p "You want to copy file \"$srcFile\" to directory \"$trgtDir\" [Y/N]" yn
		case $yn in
			# File gets copied if user selects yes
			[Yy]* )
				cp $srcFile $trgtDir
				echo "file copied"
				break;;
			# File doesnt get copied if user selects no
			[Nn]* ) 
				echo "file not copied"
				exit;;
			* ) echo "Please answer using y/n";;
		esac
	done
# executes if option is "-z"
else
	# getting the file extension of the source file
	f="$(basename -- $srcFile)"
	extension=${f##*.}
	
	if [ $extension = "gz" ]; then
		echo "-- Unzipping --"
		while [ true ]; do
			read -p "You want to unzip and move file \"$srcFile\" to directory \"$trgtDir\" [Y/N]" yn
			case $yn in
				# File gets copied if user selects yes
				[Yy]* )
					gunzip $srcFile
					new=${srcFile%.gz}
					echo $new
					mv $new $trgtDir
					echo "file unzipped and copied"
					ls $trgtDir
					break;;
				# File doesnt get copied if user selects no
				[Nn]* ) 
					echo "zipping cancelled"
					exit;;
				* ) echo "Please answer using y/n";;
			esac
		done
		
		
	else
		echo "-- Zipping --"
		while [ true ]; do
			read -p "You want to zip and move file \"$srcFile\" to directory \"$trgtDir\" [Y/N]" yn
			case $yn in
				# File gets copied if user selects yes
				[Yy]* )
					gzip $srcFile
					new="$srcFile.gz"
					mv $new $trgtDir
					echo "file zipped and copied"
					ls $trgtDir
					break;;
				# File doesnt get copied if user selects no
				[Nn]* ) 
					echo "zipping cancelled"
					exit;;
				* ) echo "Please answer using y/n";;
			esac
		done
	fi
fi



















