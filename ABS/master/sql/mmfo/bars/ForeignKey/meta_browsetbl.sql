

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_BROWSETBL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METABROWSETBL_METACOLUMNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT FK_METABROWSETBL_METACOLUMNS FOREIGN KEY (HOSTTABID, HOSTCOLKEYID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METABROWSETBL_METACOLUMNS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT FK_METABROWSETBL_METACOLUMNS2 FOREIGN KEY (ADDTABID, ADDCOLKEYID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METABROWSETBL_METACOLUMNS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT FK_METABROWSETBL_METACOLUMNS3 FOREIGN KEY (ADDTABID, VAR_COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METABROWSETBL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_BROWSETBL ADD CONSTRAINT FK_METABROWSETBL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_BROWSETBL.sql =========*** E
PROMPT ===================================================================================== 
