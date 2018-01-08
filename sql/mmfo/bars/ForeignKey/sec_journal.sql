

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEC_JOURNAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SECJOURNAL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_SECRESOURCES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_SECRESOURCES FOREIGN KEY (RESOURCE_TYPE)
	  REFERENCES BARS.SEC_RESOURCES (RES_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_SECRESOURCES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_SECRESOURCES2 FOREIGN KEY (SOURCE_TYPE)
	  REFERENCES BARS.SEC_RESOURCES (RES_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_SECACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_SECACTION FOREIGN KEY (ACTION)
	  REFERENCES BARS.SEC_ACTION (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECJOURNAL_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_JOURNAL ADD CONSTRAINT FK_SECJOURNAL_STAFF FOREIGN KEY (WHO_GRANT)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEC_JOURNAL.sql =========*** End 
PROMPT ===================================================================================== 
