

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DEMAND_ACC_TYPE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DEMANDACCTYPE_CARDTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_ACC_TYPE ADD CONSTRAINT FK_DEMANDACCTYPE_CARDTYPE FOREIGN KEY (CARD_TYPE)
	  REFERENCES BARS.DEMAND_CARD_TYPE (CARD_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEMANDACCTYPE_TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEMAND_ACC_TYPE ADD CONSTRAINT FK_DEMANDACCTYPE_TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DEMAND_ACC_TYPE.sql =========*** 
PROMPT ===================================================================================== 
