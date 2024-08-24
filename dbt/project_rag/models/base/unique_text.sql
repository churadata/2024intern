SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY title) as id, TITLE, TEXT
FROM
    {{ source("public", "RAG_SOURCE_FROM_PARQUET") }}
ORDER BY
    id