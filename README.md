# Steps to make apache server available for laravel

### 1.- Create container with system
```bash
docker run -d --rm -p 8000:80 -v /proyect:/opt/data kevinvegara92/laravel4.2-enviroment:latest
```
### 2.- Enter the container
```bash
docker exec -it IdContainer bash
```
### 3.- Composer install
```bash
composer install
```
## Ready the server, you can access through port 8000

### Note
#### There may be problems with folder permissions on unix, you must give permissions to /vendor, /app/storage

#### 
# docker-compose example

```yml
version: "3"

services:
  web:
    image: kevinvergara92/laravel4.2-enviroment:latest
    container_name: web_laravel4_2
    ports:
      - 8000:80
    volumes:
      - .:/opt/data
```
