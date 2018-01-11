

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_ORDER_EXTRA_ATTRIBUTES.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STO_ORDE_REFERENCE_STO_ORDE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_EXTRA_ATTRIBUTES ADD CONSTRAINT FK_STO_ORDE_REFERENCE_STO_ORDE FOREIGN KEY (ORDER_ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_ORDER_EXTRA_ATTRIBUTES.sql ==
PROMPT ===================================================================================== 
