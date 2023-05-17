#!/bin/bash
while true
do
	sleep 2
	cat output.txt | tail -1 | netcat -q0 localhost 50000
done
