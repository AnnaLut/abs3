

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_SBON_ORDER_NO_CONTR.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SBON_NOCONTR_REF_STO_ORDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_NO_CONTR ADD CONSTRAINT FK_SBON_NOCONTR_REF_STO_ORDER FOREIGN KEY (ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_SBON_ORDER_NO_CONTR.sql =====
PROMPT ===================================================================================== 
