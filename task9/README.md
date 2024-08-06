# Complete production application deployment with Docker Compose

We will be deploying the spring-petclinic application with multiple instances, a MySQL database, and a load balancer (nginx) using Docker Compose.

## Files

1. `compose.yml`

```yaml
services:
  app:
    image: nightknighto/spring-petclinic
    environment:
      MYSQL_URL: jdbc:mysql://database/petclinic
      SPRING_PROFILES_ACTIVE: mysql
    healthcheck:
      test:
        - CMD-SHELL
        - wget -O - localhost:8080
      timeout: 5s
      interval: 30s
      retries: 3
      start_period: 0s
    networks:
      - clinic
    deploy:
      replicas: 2
      restart_policy:
        condition: on-failure
    depends_on:
      database:
        condition: service_healthy

  database:
    image: mysql:8
    healthcheck:
      test: mysqladmin ping -h 127.0.0.1 -u $$MYSQL_USER --password=$$MYSQL_PASSWORD
      interval: 30s
      timeout: 10s
      retries: 10
      start_period: 15s
    environment:
      MYSQL_ALLOW_EMPTY_PASSWORD: "true"
      MYSQL_DATABASE: petclinic
      MYSQL_PASSWORD: petclinic
      MYSQL_ROOT_PASSWORD: ""
      MYSQL_USER: petclinic
    networks:
      - clinic
    volumes:
      - db_vol_sql:/var/lib/mysql
    
  web:
    image: nginx:alpine
    networks:
      - clinic
    ports:
      - 86:80
    volumes:
      - ./conf:/etc/nginx/conf.d
    depends_on:
      app:
        condition: service_healthy

networks:
  clinic:

volumes:
  db_vol_sql:
```

2. `conf/default.conf`

```nginx
server {
    listen 80;
    server_name petclinic.com;

    location / {
        proxy_pass http://app:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## Commands

```bash
docker-compose up
```