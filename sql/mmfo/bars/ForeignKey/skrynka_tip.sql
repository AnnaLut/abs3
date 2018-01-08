

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TIP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYN_TIP_REF_ETALON ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT FK_SKRYN_TIP_REF_ETALON FOREIGN KEY (ETALON_ID)
	  REFERENCES BARS.SKRYNKA_TIP_ETALON (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_TIP_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT FK_SKRYNKA_TIP_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATIP_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TIP ADD CONSTRAINT FK_SKRYNKATIP_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TIP.sql =========*** End 
PROMPT ===================================================================================== 
