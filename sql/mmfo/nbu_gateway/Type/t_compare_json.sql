CREATE OR REPLACE TYPE t_compare_json AS OBJECT (
  id                  NUMBER,                                    
  report_id           NUMBER,
  object_id           NUMBER,
  json                CLOB
)
/
