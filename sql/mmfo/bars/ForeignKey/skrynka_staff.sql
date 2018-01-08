

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_STAFF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKASTAFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKASTAFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKASTAFF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKASTAFF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_STAFF_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKA_STAFF_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.SKRYNKA_STAFF_TIP (TIP) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_STAFF_USERID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKA_STAFF_USERID FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_STAFF.sql =========*** En
PROMPT ===================================================================================== 
