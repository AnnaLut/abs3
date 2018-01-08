

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_COLUMNS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METACOLS_OPERLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLS_OPERLIST FOREIGN KEY (OPER_ID)
	  REFERENCES BARS.OPERLIST (CODEOPER) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLUMNS_METACOLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLUMNS_METACOLTYPES FOREIGN KEY (COLTYPE)
	  REFERENCES BARS.META_COLTYPES (COLTYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLUMNS_METARELTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLUMNS_METARELTYPES FOREIGN KEY (SHOWREL_CTYPE)
	  REFERENCES BARS.META_RELTYPES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLUMNS_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLUMNS_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACOLUMNS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_COLUMNS ADD CONSTRAINT FK_METACOLUMNS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_COLUMNS.sql =========*** End
PROMPT ===================================================================================== 
