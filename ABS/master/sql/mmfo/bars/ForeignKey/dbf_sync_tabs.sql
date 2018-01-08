

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DBF_SYNC_TABS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DBFSYNCTABS_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBF_SYNC_TABS ADD CONSTRAINT FK_DBFSYNCTABS_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DBF_SYNC_TABS.sql =========*** En
PROMPT ===================================================================================== 
