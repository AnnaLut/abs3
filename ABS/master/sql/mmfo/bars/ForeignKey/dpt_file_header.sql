

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_HEADER.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPTFILEHDR_SOCIALFTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER ADD CONSTRAINT FK_DPTFILEHDR_SOCIALFTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.SOCIAL_FILE_TYPES (TYPE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEHDR_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER ADD CONSTRAINT FK_DPTFILEHDR_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEHDR_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER ADD CONSTRAINT FK_DPTFILEHDR_STAFF FOREIGN KEY (USR_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILEHDR_SOCAGNCTP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_HEADER ADD CONSTRAINT FK_DPTFILEHDR_SOCAGNCTP FOREIGN KEY (AGENCY_TYPE)
	  REFERENCES BARS.SOCIAL_AGENCY_TYPE (TYPE_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPT_FILE_HEADER.sql =========*** 
PROMPT ===================================================================================== 
