

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CBIREP_QUERY_STATUSES_HISTORY.sql
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CBIQSHIST_CBIQSTS_STSID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES_HISTORY ADD CONSTRAINT FK_CBIQSHIST_CBIQSTS_STSID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.CBIREP_QUERY_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CBIREP_QUERY_STATUSES_HISTORY.sql
PROMPT ===================================================================================== 
