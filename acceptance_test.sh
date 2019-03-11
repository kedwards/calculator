#!/bin/sh

VAL=$(curl -s localhost:8765/sum?a=1\&b=2)

echo ${VAL}

#./gradlew acceptanceTest -Dcalculator.url=http://localhost:8080
