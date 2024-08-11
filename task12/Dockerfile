FROM openjdk:17-alpine

WORKDIR /app

COPY . .

RUN ./mvnw package

CMD java -jar /app/target/*.jar

