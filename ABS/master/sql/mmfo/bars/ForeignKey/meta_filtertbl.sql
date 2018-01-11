

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_FILTERTBL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METAFILTERTBL_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT FK_METAFILTERTBL_METACOLUMNS FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFILTERTBL_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT FK_METAFILTERTBL_METATABLES FOREIGN KEY (FILTER_TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFILTERTBL_METAFLTCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT FK_METAFILTERTBL_METAFLTCODES FOREIGN KEY (FILTER_CODE)
	  REFERENCES BARS.META_FILTERCODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFILTERTBL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FILTERTBL ADD CONSTRAINT FK_METAFILTERTBL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_FILTERTBL.sql =========*** E
PROMPT ===================================================================================== 
