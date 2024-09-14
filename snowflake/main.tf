resource "snowflake_database" "preset_db" {
  name = "INTERN_${local.name}_DB"
}

resource "snowflake_stage" "preset_stage" {
  name        = "INTERN_${local.name}_STAGE"
  url         = "s3://2024-intern-${local.name}/"
  database    = "INTERN_${local.name}_DB"
  schema      = "PUBLIC"
  storage_integration = "S3_INT"
  depends_on = [ snowflake_database.preset_db ]
}

# エクストラ問題② スキーマを作ろう
resource "snowflake_schema" "extra_schema" {
  name        = "INTERN_${local.name2}_SCHEMA"
  database    = "INTERN_${local.name}_DB"
  depends_on = [snowflake_database.preset_db]
}

# エクストラ問題② テーブルを作ろう
resource "snowflake_table" "table" {
  database                    = snowflake_schema.extra_schema.database
  schema                      = snowflake_schema.extra_schema.name
  name                        = "INTERN_${local.name2}_TABLE"
  comment                     = "A table."
  depends_on = [snowflake_schema.extra_schema]

  column {
    name     = "identity"
    type     = "NUMBER(38,0)"
    nullable = true
  }

  column {
    name     = "data"
    type     = "text"
    nullable = false
    collate  = "en-ci"
  }

  column {
    name = "DATE"
    type = "TIMESTAMP_NTZ(9)"
  }

  column {
    name    = "extra"
    type    = "VARIANT"
    comment = "extra data"
  }

  primary_key {
    name = "my_key"
    keys = ["data"]
  }
}
