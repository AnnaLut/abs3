

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TOP_CONTRACTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TOPCONTRACTS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_COUNTRY FOREIGN KEY (BENEFCOUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_COUNTRY2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_COUNTRY2 FOREIGN KEY (BANKCOUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TOPCONTRACTS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TOP_CONTRACTS ADD CONSTRAINT FK_TOPCONTRACTS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TOP_CONTRACTS.sql =========*** En
PROMPT ===================================================================================== 
