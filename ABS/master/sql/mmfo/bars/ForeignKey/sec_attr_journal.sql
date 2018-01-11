

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEC_ATTR_JOURNAL.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SECATTRJOURNAL_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_STAFF2 FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECATTRJOURNAL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECATTRJOURNAL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_STAFF FOREIGN KEY (WHO_GRANT)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECATTRJOURNAL_SECATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_ATTR_JOURNAL ADD CONSTRAINT FK_SECATTRJOURNAL_SECATTR FOREIGN KEY (ATTR_ID)
	  REFERENCES BARS.SEC_ATTRIBUTES (ATTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEC_ATTR_JOURNAL.sql =========***
PROMPT ===================================================================================== 
