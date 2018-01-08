

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GROUPS_STAFF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GROUPSSTAFF_GROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT FK_GROUPSSTAFF_GROUPS FOREIGN KEY (IDG)
	  REFERENCES BARS.GROUPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GROUPSSTAFF_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT FK_GROUPSSTAFF_STAFF2 FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GROUPSSTAFF_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT FK_GROUPSSTAFF_STAFF FOREIGN KEY (IDU)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GROUPS_STAFF.sql =========*** End
PROMPT ===================================================================================== 
