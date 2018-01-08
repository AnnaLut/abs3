

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_PAR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCPAR_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_PAR ADD CONSTRAINT FK_ACCPAR_METACOLUMNS FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_PAR.sql =========*** End *** 
PROMPT ===================================================================================== 
