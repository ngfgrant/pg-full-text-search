CREATE DATABASE json_test OWNER postgres;

\c json_test

CREATE SCHEMA IF NOT EXISTS json_schema;

CREATE TABLE json_schema.test(
  id    SERIAL    PRIMARY KEY     NOT NULL,
  document jsonb,
  tsv tsvector
);
