
PROMPT ==============================================================================
PROMPT *** Run *** == Scripts /Sql/BARS/Sequence/REGISTER_LOG_SEQ.sql = *** Run *** =
PROMPT ==============================================================================


PROMPT *** Create  sequence REGISTER_LOG_SEQ ***
begin
   execute immediate '
   create sequence  register_log_seq  minvalue 0 maxvalue 9999999999999999999999999999 increment by 1 start with 1 cache 20 noorder  nocycle';
exception when others then
   if  sqlcode=-955  then null; else raise; end if;
end;
/
   
PROMPT ==============================================================================
PROMPT *** End *** == Scripts /Sql/BARS/Sequence/REGISTER_LOG_SEQ.sql = *** End *** =
PROMPT ==============================================================================
