

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_APP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFTIPAPP_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_APP ADD CONSTRAINT FK_STAFFTIPAPP_STAFFTIPS FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_APP.sql =========*** End
PROMPT ===================================================================================== 
