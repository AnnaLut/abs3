

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INT_RECKONINGS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_RECK_REF_ACCR_DOCUMENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS ADD CONSTRAINT FK_RECK_REF_ACCR_DOCUMENT FOREIGN KEY (ACCRUAL_DOCUMENT_ID)
	  REFERENCES BARS.OPER (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RECK_REF_PAYM_DOCUMENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS ADD CONSTRAINT FK_RECK_REF_PAYM_DOCUMENT FOREIGN KEY (PAYMENT_DOCUMENT_ID)
	  REFERENCES BARS.OPER (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RECK_REF_ACCOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS ADD CONSTRAINT FK_RECK_REF_ACCOUNT FOREIGN KEY (ACCOUNT_ID)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_RECK_LINE_REF_GROUP_LINE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_RECKONINGS ADD CONSTRAINT FK_RECK_LINE_REF_GROUP_LINE FOREIGN KEY (GROUPING_LINE_ID)
	  REFERENCES BARS.INT_RECKONINGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INT_RECKONINGS.sql =========*** E
PROMPT ===================================================================================== 
