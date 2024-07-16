FROM openjdk:17

WORKDIR /app

COPY . .

RUN ./mvnw package

CMD java -jar target/*.jar

