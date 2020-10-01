\c json_test

CREATE INDEX tsv_idx ON json_schema.test USING gin(tsv);
