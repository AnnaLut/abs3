

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TABVAL_SORT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TABVALSORT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL_SORT ADD CONSTRAINT FK_TABVALSORT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TABVALSORT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL_SORT ADD CONSTRAINT FK_TABVALSORT_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TABVAL_SORT.sql =========*** End 
PROMPT ===================================================================================== 
