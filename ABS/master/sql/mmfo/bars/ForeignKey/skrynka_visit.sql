

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_VISIT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKAVISIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT ADD CONSTRAINT FK_SKRYNKAVISIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAVISIT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT ADD CONSTRAINT FK_SKRYNKAVISIT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAVISIT_SKRYNKAND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_VISIT ADD CONSTRAINT FK_SKRYNKAVISIT_SKRYNKAND FOREIGN KEY (KF, ND)
	  REFERENCES BARS.SKRYNKA_ND (KF, ND) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_VISIT.sql =========*** En
PROMPT ===================================================================================== 
