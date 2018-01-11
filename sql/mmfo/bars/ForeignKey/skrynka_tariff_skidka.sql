

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TARIFF_SKIDKA.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKATARIFFSKIDKA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA ADD CONSTRAINT FK_SKRYNKATARIFFSKIDKA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRTRFSK_SKRYNKATARIFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA ADD CONSTRAINT FK_SKRTRFSK_SKRYNKATARIFF FOREIGN KEY (KF, TARIFF)
	  REFERENCES BARS.SKRYNKA_TARIFF (KF, TARIFF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFFSKIDKA_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF_SKIDKA ADD CONSTRAINT FK_SKRYNKATARIFFSKIDKA_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TARIFF_SKIDKA.sql =======
PROMPT ===================================================================================== 
