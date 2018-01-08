

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKAND_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAND_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAND_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKAND_SKRYNKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKAND_SKRYNKA FOREIGN KEY (KF, N_SK)
	  REFERENCES BARS.SKRYNKA (KF, N_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_ND_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND ADD CONSTRAINT FK_SKRYNKA_ND_CUSTTYPE FOREIGN KEY (CUSTTYPE)
	  REFERENCES BARS.CUSTTYPE (CUSTTYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND.sql =========*** End *
PROMPT ===================================================================================== 
