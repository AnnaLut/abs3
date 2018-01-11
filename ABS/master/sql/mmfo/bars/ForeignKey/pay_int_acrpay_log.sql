

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PAY_INT_ACRPAY_LOG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PAY_INT_ACRPAY_BATCH_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAY_INT_ACRPAY_LOG ADD CONSTRAINT FK_PAY_INT_ACRPAY_BATCH_ID FOREIGN KEY (BATCH_ID)
	  REFERENCES BARS.PAY_INT_ACRPAY_BATCH (BATCH_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PAY_INT_ACRPAY_LOG.sql =========*
PROMPT ===================================================================================== 
