

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_ACCIDENTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_INSACCIDENTS_DID_DEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS ADD CONSTRAINT FK_INSACCIDENTS_DID_DEALS FOREIGN KEY (DEAL_ID, KF)
	  REFERENCES BARS.INS_DEALS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSACCIDENTS_BRANCH_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS ADD CONSTRAINT FK_INSACCIDENTS_BRANCH_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSACCIDENTS_STFID_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_ACCIDENTS ADD CONSTRAINT FK_INSACCIDENTS_STFID_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_ACCIDENTS.sql =========*** En
PROMPT ===================================================================================== 
