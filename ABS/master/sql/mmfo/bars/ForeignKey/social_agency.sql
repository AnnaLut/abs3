

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_AGENCY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SOCIALAGENCY_SOCAGNTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY ADD CONSTRAINT FK_SOCIALAGENCY_SOCAGNTYPE FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.SOCIAL_AGENCY_TYPE (TYPE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOCIALAGENCY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOCIAL_AGENCY ADD CONSTRAINT FK_SOCIALAGENCY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SOCIAL_AGENCY.sql =========*** En
PROMPT ===================================================================================== 
