

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEC_USER_IO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SECUSERIO_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO ADD CONSTRAINT FK_SECUSERIO_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SECUSERIO_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO ADD CONSTRAINT FK_SECUSERIO_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEC_USER_IO.sql =========*** End 
PROMPT ===================================================================================== 
