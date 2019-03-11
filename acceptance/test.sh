#!/bin/bash

test $(curl -s loclhost:8080/sum?a=1\&b=2) -eq 3

#./gradlew acceptanceTest -Dcalculator.url=http://localhost:8080