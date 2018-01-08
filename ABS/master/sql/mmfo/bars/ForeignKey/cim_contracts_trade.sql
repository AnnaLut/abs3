

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CIM_CONTRACTS_TRADE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CIMCONTRTRADE_CONTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_CONTR FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRTRADE_SPEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_SPEC FOREIGN KEY (SPEC_ID)
	  REFERENCES BARS.CIM_CONTRACT_SPECS (SPEC_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRTRADE_SUBJ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_SUBJ FOREIGN KEY (SUBJECT_ID)
	  REFERENCES BARS.CIM_CONTRACT_SUBJECTS (SUBJECT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRTRADE_DLINE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_DLINE FOREIGN KEY (DEADLINE)
	  REFERENCES BARS.CIM_CONTRACT_DEADLINES (DEADLINE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CIM_CONTRACTS_TRADE.sql =========
PROMPT ===================================================================================== 
