#!/bin/bash
set -e

# Change service name

psql -v ON_ERROR_STOP=1 --username postgres<<-EOSQL
    CREATE ROLE chirp_db PASSWORD 'chirp_db';
    ALTER ROLE chirp_db LOGIN;
    ALTER ROLE chirp_db CREATEDB;
    CREATE DATABASE chirp_db OWNER chirp_db;
    CREATE DATABASE chirp_dev OWNER chirp_db;
    CREATE DATABASE chirp_test OWNER chirp_db;
    CREATE DATABASE chirp_prod OWNER chirp_db;
EOSQL
