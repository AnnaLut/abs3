

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BILLS/Sequence/S_BILL_AUDIT_ID.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_BILL_AUDIT_ID ***
begin   
 execute immediate '
   CREATE SEQUENCE  BILLS.S_BILL_AUDIT_ID  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BILLS/Sequence/S_BILL_AUDIT_ID.sql =========*** E
PROMPT ===================================================================================== 
