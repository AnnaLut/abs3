PROMPT ===================================================================================== 
PROMPT *** Run *** =========== Scripts /Sql/BARS/Sequence/S_PROCESS.sql ======== *** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  sequence S_PROCESS ***

begin
   execute immediate '
   CREATE SEQUENCE  BARS.S_PROCESS  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE 
   ';
exception when others then
   if  sqlcode=-955  then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** =========== Scripts /Sql/BARS/Sequence/S_PROCESS.sql ======== *** End *** 
PROMPT ===================================================================================== 
