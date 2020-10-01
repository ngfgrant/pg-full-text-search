CREATE DATABASE json_test OWNER postgres;

\c json_test

CREATE SCHEMA IF NOT EXISTS json_schema;

CREATE TABLE json_schema.test(
  id    SERIAL    PRIMARY KEY     NOT NULL,
  document jsonb,
  tsv tsvector
);

CREATE FUNCTION document_trigger() RETURNS trigger AS $$
    begin
      new.tsv := setweight(to_tsvector('pg_catalog.english', coalesce(new.document->>'first_name','')), 'A') ||
      setweight(to_tsvector('pg_catalog.english', coalesce(new.document->>'last_name','')), 'A') ||
      setweight(to_tsvector('pg_catalog.english', coalesce(new.document->>'email','')), 'C') ||
      setweight(to_tsvector('pg_catalog.english', coalesce(new.document->>'address','')), 'B') ||
      setweight(to_tsvector('pg_catalog.english', coalesce(new.document->>'date_of_birth','')), 'D');
      return new;
    end
$$ LANGUAGE plpgsql;

CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
    ON json_schema.test FOR EACH ROW EXECUTE FUNCTION document_trigger();
