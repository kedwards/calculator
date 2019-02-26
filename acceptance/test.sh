#!/bin/bash

CALCULATOR_PORT=$(docker-compose port calculator 8080 | cut -d: -f2)

sleep 30
test $(curl calculator:8080/sum?a=1\&b=2) -eq 3
#./gradlew acceptanceTest -Dcalculator.url=http://localhost:8080
