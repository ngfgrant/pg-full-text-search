SELECT document->>'first_name' as "fname", document->>'last_name' as "lname"
  FROM(
    SELECT id, document
    FROM json_schema.test, websearch_to_tsquery('english', '"John" -"John Smith"') AS q
    WHERE (tsv @@ q))
    AS t1
    LIMIT 20;


SELECT
    document->>'first_name' as "fname",
    document->>'last_name' as "lname",
    document->>'address' as address,
    docs.rank as "rank"
    FROM (
        SELECT
            id,
            document,
            ts_rank_cd(tsv, query) AS rank
        FROM json_schema.test, websearch_to_tsquery('english', '"John" -shaw') AS query
        WHERE query @@ tsv
        LIMIT 100
    )
AS docs ORDER BY rank DESC;


INSERT INTO json_schema.test (document) VALUES
('{"id": "a2d8ed16-cf2d-4c14-8140-c5df0c05c76e","first_name": "Niall","last_name": "Grant","email": "niall.grant@example.com","address": "10 Drury Lane"}');
