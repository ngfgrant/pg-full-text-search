SELECT id, document as id, document
  FROM (
    SELECT id, document, tsv
    FROM json_schema.test, plainto_tsquery('John') AS q
    WHERE (tsv @@ q))
  AS t1;
