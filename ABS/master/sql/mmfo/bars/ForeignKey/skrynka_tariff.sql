

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TARIFF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SKRYNKA_TARIFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKA_TARIFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF_SKRYNKATIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKATARIFF_SKRYNKATIP FOREIGN KEY (KF, O_SK)
	  REFERENCES BARS.SKRYNKA_TIP (KF, O_SK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_TARIFF_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKA_TARIFF_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.SKRYNKA_TARIFF_TIP (TIP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKATARIFF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_TARIFF ADD CONSTRAINT FK_SKRYNKATARIFF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SKRYNKA_TARIFF.sql =========*** E
PROMPT ===================================================================================== 
