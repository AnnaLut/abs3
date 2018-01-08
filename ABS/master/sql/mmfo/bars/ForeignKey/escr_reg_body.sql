

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_REG_BODY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DEAL_EVENT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_BODY ADD CONSTRAINT FK_DEAL_EVENT_ID FOREIGN KEY (DEAL_EVENT_ID)
	  REFERENCES BARS.ESCR_EVENTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REG_BODY_BL_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_REG_BODY ADD CONSTRAINT FK_REG_BODY_BL_ID FOREIGN KEY (DEAL_BUILD_ID)
	  REFERENCES BARS.ESCR_BUILD_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ESCR_REG_BODY.sql =========*** En
PROMPT ===================================================================================== 
