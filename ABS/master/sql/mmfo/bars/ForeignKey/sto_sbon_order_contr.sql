

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_SBON_ORDER_CONTR.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SBON_RECEIV_REF_STO_RECEIV ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SBON_ORDER_CONTR ADD CONSTRAINT FK_SBON_RECEIV_REF_STO_RECEIV FOREIGN KEY (ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_SBON_ORDER_CONTR.sql ========
PROMPT ===================================================================================== 
