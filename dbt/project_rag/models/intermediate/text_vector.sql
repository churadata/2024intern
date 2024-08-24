{{ config(
    post_hook=rag_answer(target)
) }}

SELECT
    id,
    title,
    text,
    SNOWFLAKE.CORTEX.EMBED_TEXT_768('e5-base-v2', text) as text_vector_768
FROM
    {{ ref("unique_text") }}
LIMIT 100