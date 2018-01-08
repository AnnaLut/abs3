

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WEB_MAIL_TO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WEBMAILTO_MAILBOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO ADD CONSTRAINT FK_WEBMAILTO_MAILBOX FOREIGN KEY (MAIL_ID)
	  REFERENCES BARS.WEB_MAIL_BOX (MAIL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WEBMAILTO_MAILFROM ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_TO ADD CONSTRAINT FK_WEBMAILTO_MAILFROM FOREIGN KEY (MAIL_RECIPIENT_ID)
	  REFERENCES BARS.WEB_MAIL_FROM (USER_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WEB_MAIL_TO.sql =========*** End 
PROMPT ===================================================================================== 
