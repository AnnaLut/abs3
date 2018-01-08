

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XML_GATE_RECEIPT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_XML_GATE_RECEIPT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT ADD CONSTRAINT FK_XML_GATE_RECEIPT_ID FOREIGN KEY (ID)
	  REFERENCES BARS.XML_GATE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_XMLGATERECEIPT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT ADD CONSTRAINT FK_XMLGATERECEIPT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XML_GATE_RECEIPT.sql =========***
PROMPT ===================================================================================== 
