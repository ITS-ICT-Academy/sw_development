FROM postgres:17.3-alpine

# POSTGRES DOCKER OFFICIAL IMAGE
# The PostgreSQL image uses several environment variables which are easy to miss.
# The only variable required is POSTGRES_PASSWORD, the rest are optional.
#
# Warning: the Docker specific variables will only have an effect if you start the container with a data directory that is empty;
# any pre-existing database will be left untouched on container startup.
#
# POSTGRES_PASSWORD
# This environment variable is required for you to use the PostgreSQL image. It must not be empty or undefined.
# This environment variable sets the superuser password for PostgreSQL. The default superuser is defined by the POSTGRES_USER environment variable.
# Note 1: The PostgreSQL image sets up trust authentication locally so you may notice a password is not required when connecting from localhost
# (inside the same container). However, a password will be required if connecting from a different host/container.
# Note 2: This variable defines the superuser password in the PostgreSQL instance, as set by the initdb script during initial container startup.
# It has no effect on the PGPASSWORD environment variable that may be used by the psql client at runtime, as described at
# https://www.postgresql.org/docs/current/libpq-envars.html. PGPASSWORD, if used, will be specified as a separate environment variable.
#
# POSTGRES_USER
# This optional environment variable is used in conjunction with POSTGRES_PASSWORD to set a user and its password.
# This variable will create the specified user with superuser power and a database with the same name.
# If it is not specified, then the default user of postgres will be used.
# Be aware that if this parameter is specified, PostgreSQL will still show The files belonging to this database system will be owned
# by user 'postgres' during initialization. This refers to the Linux system user (from /etc/passwd in the image) that the postgres daemon runs as,
# and as such is unrelated to the POSTGRES_USER option. See the section titled 'Arbitrary --user Notes' for more details.
#
# POSTGRES_DB
# This optional environment variable can be used to define a different name for the default database that is created when the image is first started.
# If it is not specified, then the value of POSTGRES_USER will be used.

ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB

#COPY sql /docker-entrypoint-initdb.d
