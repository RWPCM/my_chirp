FROM postgres:alpine
MAINTAINER Régis

# Nothing to adapt in this file

ENV POSTGRES_USER postgres

# The init-db.sh script sets the database, it will be executed after the entrypoint
COPY scripts/db/init-db.sh /docker-entrypoint-initdb.d/init-db.sh

# The backup script performs a backup of the database every minute + a monthly backup
RUN mkdir -p /dumps
RUN chmod -R 777 /dumps

COPY scripts/db/backup.sh /docker-entrypoint-initdb.d/backup.sh

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
# RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/${POSTGRES_VERSION}/main/postgresql.conf``
# RUN echo "listen_addresses='*'" >> /var/lib/postgresql/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Set the default command to run when starting the container
CMD ["postgres"]
