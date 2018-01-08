

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_ORDER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ORDER_TVBV_REF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT FK_ORDER_TVBV_REF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STO_PROD ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STO_PROD FOREIGN KEY (PRODUCT_ID)
	  REFERENCES BARS.STO_PRODUCT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STAFF$BA ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STAFF$BA FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STO_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STO_TYPE FOREIGN KEY (ORDER_TYPE_ID)
	  REFERENCES BARS.STO_TYPE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_ORDER.sql =========*** End **
PROMPT ===================================================================================== 
