

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_KEYS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFKEYS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KEYS ADD CONSTRAINT FK_STAFFKEYS_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFKEYS_SGNTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KEYS ADD CONSTRAINT FK_STAFFKEYS_SGNTYPES FOREIGN KEY (KEY_TYPE)
	  REFERENCES BARS.SGN_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_KEYS.sql =========*** End *
PROMPT ===================================================================================== 
