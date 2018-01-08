

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTENSION_LOG.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTEXTLOG_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG ADD CONSTRAINT FK_DPTEXTLOG_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTEXTLOG_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_EXTENSION_LOG ADD CONSTRAINT FK_DPTEXTLOG_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_EXTENSION_LOG.sql =========**
PROMPT ===================================================================================== 
