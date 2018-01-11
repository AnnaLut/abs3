

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ACC.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKAACC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT FK_SKRYNKAACC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_ACC_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT FK_SKRYNKA_ACC_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.SKRYNKA_ACC_TIP (TIP) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAACC_SKRYNKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT FK_SKRYNKAACC_SKRYNKA FOREIGN KEY (KF, N_SK)
	  REFERENCES BARS.SKRYNKA (KF, N_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT FK_SKRYNKAACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ACC ADD CONSTRAINT FK_SKRYNKAACC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ACC.sql =========*** End 
PROMPT ===================================================================================== 
