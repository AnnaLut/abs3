

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/E_TARIF$BASE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ETARIF$BASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE ADD CONSTRAINT FK_ETARIF$BASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ETARIF$_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF$BASE ADD CONSTRAINT FK_ETARIF$_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/E_TARIF$BASE.sql =========*** End
PROMPT ===================================================================================== 
