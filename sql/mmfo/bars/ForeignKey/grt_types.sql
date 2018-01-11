

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/GRT_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_GRTTYPES_GRTGROUPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES ADD CONSTRAINT FK_GRTTYPES_GRTGROUPS FOREIGN KEY (GROUP_ID)
	  REFERENCES BARS.GRT_GROUPS (GROUP_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_GRTTYPES_GRTDETTABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.GRT_TYPES ADD CONSTRAINT FK_GRTTYPES_GRTDETTABLES FOREIGN KEY (DETAIL_TABLE_ID)
	  REFERENCES BARS.GRT_DETAIL_TABLES (TABLE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/GRT_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
