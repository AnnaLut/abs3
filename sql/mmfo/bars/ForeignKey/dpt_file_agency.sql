

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_AGENCY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTFILEAGENCY_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY ADD CONSTRAINT FK_DPTFILEAGENCY_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEAGENCY_AGENCYID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY ADD CONSTRAINT FK_DPTFILEAGENCY_AGENCYID FOREIGN KEY (AGENCY_ID)
	  REFERENCES BARS.SOCIAL_AGENCY (AGENCY_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEAGENCY_HEADERID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_AGENCY ADD CONSTRAINT FK_DPTFILEAGENCY_HEADERID FOREIGN KEY (HEADER_ID)
	  REFERENCES BARS.DPT_FILE_HEADER (HEADER_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_AGENCY.sql =========*** 
PROMPT ===================================================================================== 
