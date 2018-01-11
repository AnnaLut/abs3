

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SYNC_PARAMS_LIST.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SYNCPARAMSLIST_SNAME ***
begin   
 execute immediate '
  ALTER TABLE BARS.SYNC_PARAMS_LIST ADD CONSTRAINT FK_SYNCPARAMSLIST_SNAME FOREIGN KEY (SERVICE_NAME)
	  REFERENCES BARS.SYNC_METADATA (SERVICE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SYNC_PARAMS_LIST.sql =========***
PROMPT ===================================================================================== 
