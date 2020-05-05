-- Create user for vault service with only necessary rights
-- Prefix r_ means that it is a role
CREATE ROLE r_vault WITH NOSUPERUSER NOCREATEROLE NOCREATEDB NOREPLICATION LOGIN CONNECTION LIMIT -1 ENCRYPTED PASSWORD 's3cr3TT';
-- Create database for vault
CREATE DATABASE vault_db ENCODING 'utf-8' LC_COLLATE 'en_US.utf8' OWNER r_vault;
-- Use vault_db
\c vault_db;
-- Create schema for vault service
CREATE SCHEMA vault AUTHORIZATION r_vault;
-- Revoke rights from public schema
REVOKE ALL ON SCHEMA public FROM PUBLIC;
-- Grant rights on vault schema to r_vault
GRANT USAGE ON SCHEMA vault TO r_vault;
-- Create tables
CREATE TABLE vault.kv_store
(
    parent_path TEXT COLLATE "C" NOT NULL,
    path        TEXT COLLATE "C",
    key         TEXT COLLATE "C",
    value       BYTEA,
    CONSTRAINT pkey PRIMARY KEY (path, key)
);
ALTER TABLE vault.kv_store OWNER TO r_vault;
CREATE INDEX parent_path_idx ON vault.kv_store (parent_path);

CREATE TABLE vault.ha_locks
(
    ha_key      TEXT COLLATE "C" NOT NULL,
    ha_identity TEXT COLLATE "C" NOT NULL,
    ha_value    TEXT COLLATE "C",
    valid_until TIMESTAMP WITH TIME ZONE NOT NULL,
    CONSTRAINT ha_key PRIMARY KEY (ha_key)
);
ALTER TABLE vault.ha_locks OWNER TO r_vault;
