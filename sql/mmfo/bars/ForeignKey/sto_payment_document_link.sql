

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STO_PAYMENT_DOCUMENT_LINK.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PM_DOC_LINK_REF_PAYM ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_DOCUMENT_LINK ADD CONSTRAINT FK_PM_DOC_LINK_REF_PAYM FOREIGN KEY (PAYMENT_ID)
	  REFERENCES BARS.STO_PAYMENT (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STO_PAYMENT_DOCUMENT_LINK.sql ===
PROMPT ===================================================================================== 
