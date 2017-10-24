
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_DPTINT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_DPTINT ***

begin   
 execute immediate '
   CREATE SEQUENCE  BARS.S_DPTINT  
   MINVALUE 1 MAXVALUE 999999999999999999999999999 
   INCREMENT BY 1 START WITH 3 CACHE 20 NOORDER  NOCYCLE ';
   exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  S_DPTINT ***
grant SELECT    on S_DPTINT     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_DPTINT.sql =========*** End **
PROMPT ===================================================================================== 

