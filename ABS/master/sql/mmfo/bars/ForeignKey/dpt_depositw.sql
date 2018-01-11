

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSITW.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint XFK_DPT_DEPOSITW_DPT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW ADD CONSTRAINT XFK_DPT_DEPOSITW_DPT_ID FOREIGN KEY (DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT (DEPOSIT_ID) ON DELETE CASCADE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITW_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW ADD CONSTRAINT FK_DPTDEPOSITW_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITW_DPTFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW ADD CONSTRAINT FK_DPTDEPOSITW_DPTFIELD FOREIGN KEY (TAG)
	  REFERENCES BARS.DPT_FIELD (TAG) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITW_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW ADD CONSTRAINT FK_DPTDEPOSITW_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTDEPOSITW_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSITW ADD CONSTRAINT FK_DPTDEPOSITW_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_DEPOSITW.sql =========*** End
PROMPT ===================================================================================== 
