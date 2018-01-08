

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_ORDER_TRACKING.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STO_ORDER_TRACKING_ORDER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING ADD CONSTRAINT FK_STO_ORDER_TRACKING_ORDER_ID FOREIGN KEY (ORDER_ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDER_TRACKING_USER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING ADD CONSTRAINT FK_STO_ORDER_TRACKING_USER_ID FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_ORDER_TRACKING.sql =========*
PROMPT ===================================================================================== 
