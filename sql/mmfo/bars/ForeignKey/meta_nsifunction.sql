

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_NSIFUNCTION.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METANSIFUNCTION_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_NSIFUNCTION ADD CONSTRAINT FK_METANSIFUNCTION_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METANSIFUNCTION_ICONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_NSIFUNCTION ADD CONSTRAINT FK_METANSIFUNCTION_ICONID FOREIGN KEY (ICON_ID)
	  REFERENCES BARS.META_ICONS (ICON_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_NSIFUNCTION.sql =========***
PROMPT ===================================================================================== 
