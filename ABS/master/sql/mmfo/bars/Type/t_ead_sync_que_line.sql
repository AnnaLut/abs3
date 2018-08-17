PROMPT *** Create  type t_ead_sync_que_line as objec ***
begin 
  execute immediate 'create or replace type t_ead_sync_que_line as object
( id        number,
  crt_date  date,
  obj_id    varchar2(100),
  status_id varchar2(100),
  err_count number,
  type_id   varchar2(100)
)';
exception when others then       
  if sqlcode=-02303 then null; else raise; end if; 
end; 
/
  GRANT EXECUTE ON "BARS"."T_EAD_SYNC_QUE_LINE" TO "BARS_ACCESS_DEFROLE";
  GRANT EXECUTE ON "BARS"."T_EAD_SYNC_QUE_LINE" TO "BARSREADER_ROLE";
/
