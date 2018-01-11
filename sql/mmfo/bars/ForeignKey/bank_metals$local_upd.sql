

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BANK_METALS$LOCAL_UPD.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BANKMETALSLUPD_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD ADD CONSTRAINT FK_BANKMETALSLUPD_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETALSLUPD_BANKMETALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD ADD CONSTRAINT FK_BANKMETALSLUPD_BANKMETALS FOREIGN KEY (KOD)
	  REFERENCES BARS.BANK_METALS (KOD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BANKMETALSLUPD_METALACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANK_METALS$LOCAL_UPD ADD CONSTRAINT FK_BANKMETALSLUPD_METALACTION FOREIGN KEY (ACTION_ID)
	  REFERENCES BARS.BANK_METALS_ACTION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BANK_METALS$LOCAL_UPD.sql =======
PROMPT ===================================================================================== 
