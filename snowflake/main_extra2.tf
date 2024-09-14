resource "snowflake_database" "preset_db" {
  name = "INTERN_${local.name}_DB"
}

resource "snowflake_stage" "preset_stage" {
  name        = "INTERN_${local.name}_STAGE"
  url         = "s3://2024-intern-${local.name}/"
  database    = "INTERN_${local.name}_DB"
  schema      = "PUBLIC"
  storage_integration = "S3_INT"

  epends_on = [snowflake_database.preset_db]
}

# エクストラ問題①
resource "snowflake_stage" "extra_stage" {
  name        = "INTERN_${local.name2}_STAGE"
  url         = "s3://2024-intern-${local.name2}/"
  database    = "INTERN_${local.name}_DB"
  schema      = "PUBLIC"
  storage_integration = "S3_INT"

  epends_on = [snowflake_database.preset_db]
}

# エクストラ問題② スキーマを作ろう
resource "snowflake_schema" "extra_schema" {
  name        = "INTERN_${local.name2}_SCHEMA"
  database    = "INTERN_${local.name}_DB"
  stage      = "INTERN_${local.name2}_STAGE"

  depends_on = [snowflake_stage.extra_stage]
}

# エクストラ問題② テーブルを作ろう
resource "snowflake_table" "extra_table" {
  name        = "INTERN_${local.name2}_TABLE"
  database    = "INTERN_${local.name}_DB"
  stage      = "INTERN_${local.name2}_STAGE"

  depends_on = [snowflake_stage.extra_schema]
}

resource "snowflake_table" "table" {
  database                    = snowflake_schema.extra_schema.database
  schema                      = snowflake_schema.extra_schema.name
  name                        = "INTERN_${local.name2}_TABLE"
  comment                     = "A table."

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
