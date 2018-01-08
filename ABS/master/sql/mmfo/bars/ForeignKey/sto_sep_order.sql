

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_SEP_ORDER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SEP_RECEIV_REF_STO_RECEIVER ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_SEP_ORDER ADD CONSTRAINT FK_SEP_RECEIV_REF_STO_RECEIVER FOREIGN KEY (ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_SEP_ORDER.sql =========*** En
PROMPT ===================================================================================== 
