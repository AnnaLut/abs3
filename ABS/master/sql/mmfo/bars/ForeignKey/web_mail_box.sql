

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WEB_MAIL_BOX.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WEBMAILBOX_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_BOX ADD CONSTRAINT FK_WEBMAILBOX_STAFF FOREIGN KEY (MAIL_SENDER_ID)
	  REFERENCES BARS.WEB_MAIL_FROM (USER_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WEB_MAIL_BOX.sql =========*** End
PROMPT ===================================================================================== 
