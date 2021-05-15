#!/bin/bash

count=1

for param in $@ ;
do
	echo "Next Parameter :  $param"
	count=$(( $count + 1 ))
done
