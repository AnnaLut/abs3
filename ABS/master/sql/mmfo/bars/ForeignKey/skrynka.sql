

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKA_SKRYNKAALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_SKRYNKAALL FOREIGN KEY (KF, N_SK)
	  REFERENCES BARS.SKRYNKA_ALL (KF, N_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_SKRYNKATIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_SKRYNKATIP FOREIGN KEY (KF, O_SK)
	  REFERENCES BARS.SKRYNKA_TIP (KF, O_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_ISP_MO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_ISP_MO FOREIGN KEY (ISP_MO)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA ADD CONSTRAINT FK_SKRYNKA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA.sql =========*** End *** 
PROMPT ===================================================================================== 
