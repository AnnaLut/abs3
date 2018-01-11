

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMERW.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERW_CUSTFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT FK_CUSTOMERW_CUSTFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.CUSTOMER_FIELD (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERW_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERW ADD CONSTRAINT FK_CUSTOMERW_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMERW.sql =========*** End **
PROMPT ===================================================================================== 
