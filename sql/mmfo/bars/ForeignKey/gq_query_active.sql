

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GQ_QUERY_ACTIVE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GQQUERYACTIVE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_ACTIVE ADD CONSTRAINT FK_GQQUERYACTIVE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GQQUERYACTIVE_GQQUERY ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_ACTIVE ADD CONSTRAINT FK_GQQUERYACTIVE_GQQUERY FOREIGN KEY (QUERY_ID)
	  REFERENCES BARS.GQ_QUERY (QUERY_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GQ_QUERY_ACTIVE.sql =========*** 
PROMPT ===================================================================================== 
