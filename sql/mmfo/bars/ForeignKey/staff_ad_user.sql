

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_AD_USER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFF_AD_USER_REF_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER ADD CONSTRAINT FK_STAFF_AD_USER_REF_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_AD_USER.sql =========*** En
PROMPT ===================================================================================== 
