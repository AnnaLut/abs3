

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/USER_LOGIN_STMT.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_USERLOGINSTMT_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_LOGIN_STMT ADD CONSTRAINT FK_USERLOGINSTMT_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/USER_LOGIN_STMT.sql =========*** 
PROMPT ===================================================================================== 
