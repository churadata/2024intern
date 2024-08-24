{% macro rag_answer(target) %}
CREATE OR REPLACE FUNCTION PUBLIC.MAKE_RAG_ANSWER(QUESTION varchar, NUM_DOC int)
        RETURNS TABLE(answer STRING)
        LANGUAGE SQL
        AS
        $$
SELECT
    SNOWFLAKE.CORTEX.COMPLETE(
            'reka-flash',
            REPLACE(REPLACE(
                            '以下の質問に解答してください、その際には指定する文章を参考にしながら解答をすること\\n質問： __question__\\n文章： __document__'
                        , '__question__', QUESTION), '__document__', retrieval_text)
    ) as answer
FROM
    (
        SELECT
            LISTAGG(CONCAT(title, '\n####\n', text, '\n')) as retrieval_text
        FROM
            (
                SELECT
                    id,
                    title,
                    text
                FROM PUBLIC.text_vector
                WHERE TRUE
                    QUALIFY
                                ROW_NUMBER() OVER(ORDER BY VECTOR_COSINE_SIMILARITY(
                                    TEXT_VECTOR_768,
                                    SNOWFLAKE.CORTEX.EMBED_TEXT_768('e5-base-v2', QUESTION)
                                ) DESC) < NUM_DOC
            )
    )
        $$;
{% endmacro %}
