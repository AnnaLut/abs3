

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MIGR_WEBUSERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MIGRWEBUSERS_USERTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_WEBUSERS ADD CONSTRAINT FK_MIGRWEBUSERS_USERTYPES FOREIGN KEY (USER_TYPE)
	  REFERENCES BARS.MIGR_USER_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_MIGRWEBUSERS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_WEBUSERS ADD CONSTRAINT FK_MIGRWEBUSERS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MIGR_WEBUSERS.sql =========*** En
PROMPT ===================================================================================== 
