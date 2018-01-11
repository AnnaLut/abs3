

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEC_AUDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SECAUDIT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_AUDIT ADD CONSTRAINT FK_SECAUDIT_STAFF FOREIGN KEY (REC_UID)
	  REFERENCES BARS.STAFF$BASE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECAUDIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_AUDIT ADD CONSTRAINT FK_SECAUDIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECAUDIT_SECRECTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_AUDIT ADD CONSTRAINT FK_SECAUDIT_SECRECTYPE FOREIGN KEY (REC_TYPE)
	  REFERENCES BARS.SEC_RECTYPE (SEC_RECTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEC_AUDIT.sql =========*** End **
PROMPT ===================================================================================== 
