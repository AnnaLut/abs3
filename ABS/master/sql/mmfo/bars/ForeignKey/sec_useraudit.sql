

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEC_USERAUDIT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SECUSERAUDIT_SECRECTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT ADD CONSTRAINT FK_SECUSERAUDIT_SECRECTYPE FOREIGN KEY (LOG_LEVEL)
	  REFERENCES BARS.SEC_RECTYPE (SEC_RECTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECUSERAUDIT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USERAUDIT ADD CONSTRAINT FK_SECUSERAUDIT_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEC_USERAUDIT.sql =========*** En
PROMPT ===================================================================================== 
