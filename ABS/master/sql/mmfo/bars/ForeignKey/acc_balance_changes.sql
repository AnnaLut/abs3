

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_BALANCE_CHANGES.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCBALCH_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES ADD CONSTRAINT FK_ACCBALCH_ACCOUNTS FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCBALCH_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES ADD CONSTRAINT FK_ACCBALCH_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_BALANCE_CHANGES.sql =========
PROMPT ===================================================================================== 
