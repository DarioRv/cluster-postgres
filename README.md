# Cluster con Postgres

Contenido:

- Cluster de Postgres con 1 nodo maestro y 1 nodo esclavo.
- Balanceador de carga con Failover.
- Postgres Exporter.
- Prometheus.
- Grafana.
- Código SQL para crear tablas de la base de datos.
- Código SQL para insertar datos en las tablas de la base de datos.

## Uso

Para levantar el cluster de Postgres, ejecutar el siguiente comando:

```bash
docker-compose up -d
```

Para detener el cluster de Postgres, ejecutar el siguiente comando:

```bash
docker-compose down -v
```

> [!CAUTION]
> Este comando borra todos los contenedores y volúmenes creados por `docker-compose up`.

## Acceso

- Cluster de Postgres (balanceador de carga): `localhost:5434`
- Grafana: `localhost:3000`
- Prometheus: `prometheus:9090`
- PgAdmin: `localhost:8080`

## Credenciales

- PgAdmin:
  - email: `admin@admin.com`
  - password: `admin`
- Postgres:
  - username: `user`
  - password: `password`
- Grafana:
  - username: `admin`
  - password: `admin`

## Notas

> [!NOTE]
> A tener en cuenta

```
Id de dashboards en Grafana:

- 455: PostgreSQL Overview
```

```
Añadir prometheus como fuente de datos en Grafana:

- URL: http://prometheus:9090
```
