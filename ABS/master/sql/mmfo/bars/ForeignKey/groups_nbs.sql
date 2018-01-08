

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GROUPS_NBS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GROUPSNBS_GROUPSACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_NBS ADD CONSTRAINT FK_GROUPSNBS_GROUPSACC FOREIGN KEY (ID)
	  REFERENCES BARS.GROUPS_ACC (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GROUPSNBS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_NBS ADD CONSTRAINT FK_GROUPSNBS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GROUPS_NBS.sql =========*** End *
PROMPT ===================================================================================== 
