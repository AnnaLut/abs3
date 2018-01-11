

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_GRP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFTIPGRP_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_GRP ADD CONSTRAINT FK_STAFFTIPGRP_STAFFTIPS FOREIGN KEY (IDU)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPGRP_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_GRP ADD CONSTRAINT FK_STAFFTIPGRP_GROUPS FOREIGN KEY (IDG)
	  REFERENCES BARS.GROUPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFFTIP_GRP.sql =========*** End
PROMPT ===================================================================================== 
