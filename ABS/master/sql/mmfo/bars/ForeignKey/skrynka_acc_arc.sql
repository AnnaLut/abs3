

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ACC_ARC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKAACCARC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC ADD CONSTRAINT FK_SKRYNKAACCARC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAACCARC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC ADD CONSTRAINT FK_SKRYNKAACCARC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAACCARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC ADD CONSTRAINT FK_SKRYNKAACCARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAACCARC_SKRYNKAACCTIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC_ARC ADD CONSTRAINT FK_SKRYNKAACCARC_SKRYNKAACCTIP FOREIGN KEY (TIP)
	  REFERENCES BARS.SKRYNKA_ACC_TIP (TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ACC_ARC.sql =========*** 
PROMPT ===================================================================================== 
