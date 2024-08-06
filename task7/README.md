# Docker Compose & Docker Networks

Connecting the spring-petclinic application with a MySQL database using Docker Compose and Docker Networks.

Assuming we already have the spring-petclinic as a docker image under the name `spring`.

## Docker Compose

1. Create a `docker-compose.yml` file with the following content:

```yaml
services:
  database:
    image: mysql:8
    networks:
      - clinic
    environment:
      - MYSQL_DATABASE=petclinic
      - MYSQL_PASSWORD=petclinic
      - MYSQL_USER=petclinic
      - MYSQL_ALLOW_EMPTY_PASSWORD=true
      - MYSQL_ROOT_PASSWORD=
    volumes:
      - db_vol:/var/lib/mysql
  
  app:
    image: spring
    environment:
      - SPRING_PROFILES_ACTIVE=mysql
      - MYSQL_URL=jdbc:mysql://database/petclinic
    ports:
      - 8080:8080
    networks:
      - clinic
    depends_on:
      - database

networks:
  clinic:

volumes:
  db_vol:
```

2. Run the docker-compose file:

```bash
docker-compose up
```

## Docker Networks

1. Create a new network:

```bash
docker network create clinic
```

2. Run the database container:

```bash
docker run --rm -d --name database --net clinic \
-e MYSQL_DATABASE=petclinic \
-e MYSQL_PASSWORD=petclinic \
-e MYSQL_USER=petclinic \
-e MYSQL_ALLOW_EMPTY_PASSWORD=true \
-e MYSQL_ROOT_PASSWORD= \
mysql:8
```

3. Run the spring container:

```bash
docker run --rm -d \
-e SPRING_PROFILES_ACTIVE=mysql \
-e MYSQL_URL=jdbc:mysql://database/petclinic \
--net clinic -p 8080:8080 spring
```
