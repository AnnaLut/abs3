PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_EDS_DECLS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_EDS_DECLS ***
begin   
 execute immediate '
   CREATE SEQUENCE  BARS.S_EDS_DECLS  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_EDS_DECLS.sql =========*** End **
PROMPT ===================================================================================== 

