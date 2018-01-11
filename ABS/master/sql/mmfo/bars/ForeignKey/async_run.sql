

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_RUN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ASNRUN_ACT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_RUN ADD CONSTRAINT FK_ASNRUN_ACT FOREIGN KEY (ACTION_ID)
	  REFERENCES BARS.ASYNC_ACTION (ACTION_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_RUN.sql =========*** End **
PROMPT ===================================================================================== 
