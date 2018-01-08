

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DWH_IMPORT_STAT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_DWHIMPSTAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_IMPORT_STAT ADD CONSTRAINT XFK_DWHIMPSTAT FOREIGN KEY (STATUS)
	  REFERENCES BARS.DWH_STATUS (STATUS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DWH_IMPORT_STAT.sql =========*** 
PROMPT ===================================================================================== 
