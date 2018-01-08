

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GRT_DEAL_STATUSES_HIST.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GRTDLSTATHIST_GRTDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES_HIST ADD CONSTRAINT FK_GRTDLSTATHIST_GRTDEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDLSTATHIST_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES_HIST ADD CONSTRAINT FK_GRTDLSTATHIST_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTDLSTATHIST_GRTDLSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_DEAL_STATUSES_HIST ADD CONSTRAINT FK_GRTDLSTATHIST_GRTDLSTATUS FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.GRT_DEAL_STATUSES (STATUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GRT_DEAL_STATUSES_HIST.sql ======
PROMPT ===================================================================================== 
