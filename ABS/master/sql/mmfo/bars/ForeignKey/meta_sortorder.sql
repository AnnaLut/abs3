

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_SORTORDER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METASORTORDER_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER ADD CONSTRAINT FK_METASORTORDER_METACOLUMNS FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METASORTORDER_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_SORTORDER ADD CONSTRAINT FK_METASORTORDER_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_SORTORDER.sql =========*** E
PROMPT ===================================================================================== 
