

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CONTRACTS_ALIEN.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CONTRACTSALIEN_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CONTRACTS_ALIEN ADD CONSTRAINT FK_CONTRACTSALIEN_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CONTRACTS_ALIEN.sql =========*** 
PROMPT ===================================================================================== 
