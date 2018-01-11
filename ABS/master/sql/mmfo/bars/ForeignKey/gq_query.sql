

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GQ_QUERY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GQQUERY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY ADD CONSTRAINT FK_GQQUERY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GQQUERY_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY ADD CONSTRAINT FK_GQQUERY_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GQ_QUERY.sql =========*** End ***
PROMPT ===================================================================================== 
