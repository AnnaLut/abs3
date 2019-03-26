

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSTRANS/Sequence/S_INPUT_TYPES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_INPUT_TYPES ***
begin   
 execute immediate '
   CREATE SEQUENCE  BARSTRANS.S_INPUT_TYPES  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSTRANS/Sequence/S_INPUT_TYPES.sql =========***
PROMPT ===================================================================================== 
