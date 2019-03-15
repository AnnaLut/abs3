

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_SPS_UNION.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_SPS_UNION ***
begin   
 execute immediate '
   CREATE SEQUENCE  BARS.S_SPS_UNION  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 3 NOCACHE  NOORDER  NOCYCLE ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_SPS_UNION.sql =========*** End **
PROMPT ===================================================================================== 
