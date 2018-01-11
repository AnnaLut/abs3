

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WEB_MAIL_ATTACH.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WEBMAILATTACH_MAILBOX ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_MAIL_ATTACH ADD CONSTRAINT FK_WEBMAILATTACH_MAILBOX FOREIGN KEY (MAIL_ID)
	  REFERENCES BARS.WEB_MAIL_BOX (MAIL_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WEB_MAIL_ATTACH.sql =========*** 
PROMPT ===================================================================================== 
