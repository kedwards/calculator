#!/bin/sh

VAL=$(curl -s localhost:8765/sum?a=1\&b=2)

if [ ${VAL} == 3 ]
then
    exit 0
else
    exit 1
fi

#./gradlew acceptanceTest -Dcalculator.url=http://localhost:8080
