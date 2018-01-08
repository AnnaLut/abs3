

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND_ARC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKANDARC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDARC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDARC_SKRYNKAALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_SKRYNKAALL FOREIGN KEY (KF, N_SK)
	  REFERENCES BARS.SKRYNKA_ALL (KF, N_SK) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKANDARC_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_ND_ARC ADD CONSTRAINT FK_SKRYNKANDARC_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_ND_ARC.sql =========*** E
PROMPT ===================================================================================== 
