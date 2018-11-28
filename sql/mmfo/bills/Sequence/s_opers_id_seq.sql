

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Sequence/S_OPERS_ID_SEQ.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_OPERS_ID_SEQ ***
begin   
 execute immediate '
   CREATE SEQUENCE  BILLS.S_OPERS_ID_SEQ  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Sequence/S_OPERS_ID_SEQ.sql =========*** En
PROMPT ===================================================================================== 
