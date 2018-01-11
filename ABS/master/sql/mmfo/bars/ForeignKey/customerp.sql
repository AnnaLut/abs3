

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMERP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CUSTOMERP_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERP ADD CONSTRAINT FK_CUSTOMERP_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERP_CUSTOMERFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERP ADD CONSTRAINT FK_CUSTOMERP_CUSTOMERFIELD FOREIGN KEY (PARID)
	  REFERENCES BARS.CUSTOMER_FIELD (PARID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUSTOMERP.sql =========*** End **
PROMPT ===================================================================================== 
