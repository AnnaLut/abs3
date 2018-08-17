PROMPT *** Create  type t_ead_sync_que_list as objec ***
begin 
  execute immediate 'create or replace type t_ead_sync_que_list force as table of t_ead_sync_que_line';
exception when others then       
  if sqlcode=-02303 then null; else raise; end if; 
end; 
/
  GRANT EXECUTE ON "BARS"."T_EAD_SYNC_QUE_LIST" TO "BARS_ACCESS_DEFROLE";
  GRANT EXECUTE ON "BARS"."T_EAD_SYNC_QUE_LIST" TO "BARSREADER_ROLE";
/
