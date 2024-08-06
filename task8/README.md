# Multi-file Docker Compose

Creating multi-file Docker Compose configurations, where each file defines a specific database service to be used in the application.

## Files

1. `compose.yml` - Main configuration file.

```yaml
services:
  app:
    image: nightknighto/spring-petclinic
    ports:
      - 8080:8080
    networks:
      - clinic
    depends_on:
      - database

networks:
  clinic:
```

2. `compose.override.yml` - Default override configuration file.

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
      - db_vol_sql:/var/lib/mysql

  app:
    environment:
      - SPRING_PROFILES_ACTIVE=mysql
      - MYSQL_URL=jdbc:mysql://database/petclinic

volumes:
  db_vol_sql:
```

3. `compose.prod.yml` - Second option override configuration file.

```yaml
services:
  database:
    image: postgres:16.3
    ports:
      - 5432:5432
    environment:
      - POSTGRES_PASSWORD=petclinic
      - POSTGRES_USER=petclinic
      - POSTGRES_DB=petclinic
    networks:
      - clinic
    volumes:
      - db_vol_psql:/var/lib/postgresql/data

  app:
    environment:
      - SPRING_PROFILES_ACTIVE=postgres
      - POSTGRES_URL=jdbc:postgresql://database/petclinic

volumes:
  db_vol_psql:
```

## Running the application

1. Running the application with MySQL database (default configuration):

```bash
docker-compose -f compose.yml up
```

> This will use the default configuration from `compose.yml` and the defaault override `compose.override.yml`.

2. Running the application with PostgreSQL database (second option configuration):

```bash
docker-compose -f compose.yml -f compose.prod.yml up
```

> This will use the default configuration from `compose.yml` and the second option override `compose.prod.yml`.