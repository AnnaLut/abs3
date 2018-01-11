

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANK_METALS$LOCAL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANKMETLOC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL ADD CONSTRAINT FK_BANKMETLOC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETLOC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL ADD CONSTRAINT FK_BANKMETLOC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETLOC_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL ADD CONSTRAINT FK_BANKMETLOC_KOD FOREIGN KEY (KOD)
	  REFERENCES BARS.BANK_METALS (KOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANK_METALS$LOCAL.sql =========**
PROMPT ===================================================================================== 
