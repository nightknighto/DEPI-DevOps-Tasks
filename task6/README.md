# Dockerfile & multi-stage Dockerfile

Creating Dockerfile to build a docker image of the spring-petclinic application.

Assuming we have cloned the spring-petclinic repository and we are in the root directory of the project.

## Dockerfile

```Dockerfile
FROM openjdk:17

WORKDIR /app

COPY . .

RUN ./mvnw package

CMD java -jar target/*.jar
```

## Multi-stage Dockerfile

```Dockerfile
FROM openjdk:17 AS builder

WORKDIR /app

COPY . .

RUN ./mvnw package

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target .

CMD java -jar *.jar
```

## Commands

1. Create a new Dockerfile with the content above.
2. Build the image:

```bash
docker build -t spring-petclinic .
```

3. Run the container:

```bash
docker run -p 8080:8080 spring-petclinic
```