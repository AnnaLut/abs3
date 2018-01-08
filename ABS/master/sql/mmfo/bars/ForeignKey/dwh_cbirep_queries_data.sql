

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DWH_CBIREP_QUERIES_DATA.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DWHCBIREPQDATA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES_DATA ADD CONSTRAINT FK_DWHCBIREPQDATA_ID FOREIGN KEY (CBIREP_QUERIES_ID)
	  REFERENCES BARS.DWH_CBIREP_QUERIES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DWH_CBIREP_QUERIES_DATA.sql =====
PROMPT ===================================================================================== 
