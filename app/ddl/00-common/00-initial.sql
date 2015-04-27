-- An extension that we need enabled, use uuids all over the place.
create extension if not exists "uuid-ossp";

-- Drop the schema if dbClean is true.
drop schema if exists common cascade;

-- Create the common schema.
create schema if not exists common;
comment on schema common is 'Elements and objects common to all databases.';