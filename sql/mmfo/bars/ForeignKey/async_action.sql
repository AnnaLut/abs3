

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_ACTION.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ASNACT_ACTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION ADD CONSTRAINT FK_ASNACT_ACTT FOREIGN KEY (ACTION_TYPE)
	  REFERENCES BARS.ASYNC_ACTION_TYPE (ACTION_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ASNACT_SQL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION ADD CONSTRAINT FK_ASNACT_SQL FOREIGN KEY (SQL_ID)
	  REFERENCES BARS.ASYNC_SQL (SQL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ASNACT_WEBUI ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_ACTION ADD CONSTRAINT FK_ASNACT_WEBUI FOREIGN KEY (WEBUI_ID)
	  REFERENCES BARS.ASYNC_WEBUI (WEBUI_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_ACTION.sql =========*** End
PROMPT ===================================================================================== 
