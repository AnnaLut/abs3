

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND_REF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKANDREF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT FK_SKRYNKANDREF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDREF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT FK_SKRYNKANDREF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDREF_SKRYNKAND ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_REF ADD CONSTRAINT FK_SKRYNKANDREF_SKRYNKAND FOREIGN KEY (KF, ND)
	  REFERENCES BARS.SKRYNKA_ND (KF, ND) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND_REF.sql =========*** E
PROMPT ===================================================================================== 