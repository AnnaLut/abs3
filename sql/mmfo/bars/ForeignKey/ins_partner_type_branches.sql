

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_TYPE_BRANCHES.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PTNTYPEBRHS__LID_LIMITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS__LID_LIMITS FOREIGN KEY (LIMIT_ID, KF)
	  REFERENCES BARS.INS_LIMITS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_FID_FEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_FID_FEES FOREIGN KEY (FEE_ID, KF)
	  REFERENCES BARS.INS_FEES (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_TID_TARIFFS FOREIGN KEY (TARIFF_ID, KF)
	  REFERENCES BARS.INS_TARIFFS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_B_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_B_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPEBRHS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_BRANCHES ADD CONSTRAINT FK_PTNTYPEBRHS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/INS_PARTNER_TYPE_BRANCHES.sql ===
PROMPT ===================================================================================== 
