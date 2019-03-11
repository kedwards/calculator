#!/bin/bash

CALCULATOR_PORT=$(docker-compose port calculator 8080 | cut -d: -f2)

echo "Calculaor Port is: ${CALCULATOR_PORT}"

echo "test $(curl -s ${CALCULATOR_PORT}:8080/sum?a=1\&b=2) -eq 3"

test $(curl -s ${CALCULATOR_PORT}:8080/sum?a=1\&b=2) -eq 3

#./gradlew acceptanceTest -Dcalculator.url=http://localhost:8080
