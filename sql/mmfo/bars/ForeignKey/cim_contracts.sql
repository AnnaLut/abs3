

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIM_CONTRACTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CIMCONTRACTS_OWNERUID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS ADD CONSTRAINT FK_CIMCONTRACTS_OWNERUID FOREIGN KEY (OWNER_UID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRACTS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS ADD CONSTRAINT FK_CIMCONTRACTS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRACTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS ADD CONSTRAINT FK_CIMCONTRACTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRACTS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS ADD CONSTRAINT FK_CIMCONTRACTS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIM_CONTRACTS.sql =========*** En
PROMPT ===================================================================================== 
