

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GROUPS_STAFF_ACC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GROUPSSTAFFACC_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF_ACC ADD CONSTRAINT FK_GROUPSSTAFFACC_GROUPS FOREIGN KEY (IDG)
	  REFERENCES BARS.GROUPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GROUPS_STAFF_ACC.sql =========***
PROMPT ===================================================================================== 
