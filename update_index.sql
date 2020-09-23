\c json_test

UPDATE json_schema.test SET tsv = to_tsvector('english',
coalesce(document->>'first_name','') || ' ' ||
coalesce(document->>'last_name','') || ' ' ||
coalesce(document->>'email','') || ' ' ||
coalesce(document->>'address','')
);

CREATE INDEX tsv_idx ON json_schema.test USING gin(tsv);
