FROM java:openjdk-8-alpine

LABEL maintiner="Kevin Edwards <kedwards@kevinedwards.ca>"

COPY build/libs/calculator-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
