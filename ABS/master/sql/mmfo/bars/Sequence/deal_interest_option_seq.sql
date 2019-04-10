
PROMPT ====================================================================================== 
PROMPT *** Run *** == Scripts /Sql/BARS/Sequence/DEAL_INTEREST_OPTION_SEQ.sql = *** Run *** =
PROMPT ======================================================================================


PROMPT *** Create  sequence DEAL_INTEREST_OPTION_SEQ ***
begin
   execute immediate '
   CREATE SEQUENCE  DEAL_INTEREST_OPTION_SEQ  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
   ';
exception when others then
   if  sqlcode=-955  then null; else raise; end if;
end;
/
   
PROMPT ======================================================================================
PROMPT *** End *** == Scripts /Sql/BARS/Sequence/DEAL_INTEREST_OPTION_SEQ.sql = *** End *** =
PROMPT ======================================================================================
