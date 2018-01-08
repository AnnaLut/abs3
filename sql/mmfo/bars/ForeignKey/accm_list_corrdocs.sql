

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCM_LIST_CORRDOCS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCMLISTCRDOCS_ACCMCAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS ADD CONSTRAINT FK_ACCMLISTCRDOCS_ACCMCAL FOREIGN KEY (CALDT_ID)
	  REFERENCES BARS.ACCM_CALENDAR (CALDT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCMLISTCRDOCS_ACCMCAL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_LIST_CORRDOCS ADD CONSTRAINT FK_ACCMLISTCRDOCS_ACCMCAL2 FOREIGN KEY (CORDT_ID)
	  REFERENCES BARS.ACCM_CALENDAR (CALDT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCM_LIST_CORRDOCS.sql =========*
PROMPT ===================================================================================== 
