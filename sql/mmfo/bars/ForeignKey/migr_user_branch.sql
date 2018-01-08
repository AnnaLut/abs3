

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MIGR_USER_BRANCH.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MIGRUB_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_BRANCH ADD CONSTRAINT FK_MIGRUB_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MIGRUB_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_BRANCH ADD CONSTRAINT FK_MIGRUB_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MIGR_USER_BRANCH.sql =========***
PROMPT ===================================================================================== 
