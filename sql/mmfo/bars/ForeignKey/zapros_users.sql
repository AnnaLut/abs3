

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAPROS_USERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAPROS_USERS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_USERS ADD CONSTRAINT FK_ZAPROS_USERS_ID FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAPROS_USERS.sql =========*** End
PROMPT ===================================================================================== 
