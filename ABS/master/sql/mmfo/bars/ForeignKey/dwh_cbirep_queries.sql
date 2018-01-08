

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DWH_CBIREP_QUERIES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DWHBIREPQUER_STATUS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES ADD CONSTRAINT FK_DWHBIREPQUER_STATUS_ID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.DWH_CBIREP_QUERY_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DWH_CBIREP_QUERIES.sql =========*
PROMPT ===================================================================================== 
