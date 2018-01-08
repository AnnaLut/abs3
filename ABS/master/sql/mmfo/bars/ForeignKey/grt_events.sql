

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GRT_EVENTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GRTEVENTS_GRTEVTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENTS ADD CONSTRAINT FK_GRTEVENTS_GRTEVTTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.GRT_EVENT_TYPES (EVENT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTEVENTS_GRTDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_EVENTS ADD CONSTRAINT FK_GRTEVENTS_GRTDEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GRT_EVENTS.sql =========*** End *
PROMPT ===================================================================================== 
