#!/bin/bash

if [ -f "diff.txt" ];
then
	if [ -s "diff.txt" ];
	then
		exit 1
	else
		echo "Difference is empty!"
		echo "Tests are passed!"
	fi
else
	echo "diff.txt file doesn't exist"
	echo "Run the tests to generate the file"
	exit 1
fi