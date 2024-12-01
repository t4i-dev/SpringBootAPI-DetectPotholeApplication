# Use the official OpenJDK base 6image
FROM postgres:16

COPY init.sql /docker-entrypoint-initdb.d/

ENV POSTGRES_DB university
ENV POSTGRES_USER random
ENV POSTGRES_PASSWORD code