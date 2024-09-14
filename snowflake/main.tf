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
