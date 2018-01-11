

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SMS_ACC_TEMPLATES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SMS_TEMPLATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_ACC_TEMPLATES ADD CONSTRAINT FK_SMS_TEMPLATES FOREIGN KEY (ID)
	  REFERENCES BARS.SMS_TEMPLATES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SMS_ACC_TEMPLATES.sql =========**
PROMPT ===================================================================================== 
