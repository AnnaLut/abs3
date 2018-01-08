

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_CALL_SETTINGS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METACALLSETTINGS_CALLFROM ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_CALL_SETTINGS ADD CONSTRAINT FK_METACALLSETTINGS_CALLFROM FOREIGN KEY (CALL_FROM)
	  REFERENCES BARS.CALL_TAB_NAME (NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACALLSETTINGS_CODEAPP ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_CALL_SETTINGS ADD CONSTRAINT FK_METACALLSETTINGS_CODEAPP FOREIGN KEY (TABID, CODEAPP)
	  REFERENCES BARS.REFAPP (TABID, CODEAPP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACALLSETTINGS_FUNCID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_CALL_SETTINGS ADD CONSTRAINT FK_METACALLSETTINGS_FUNCID FOREIGN KEY (TABID, FUNCID)
	  REFERENCES BARS.META_NSIFUNCTION (TABID, FUNCID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METACALLSETTINGS_TABID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_CALL_SETTINGS ADD CONSTRAINT FK_METACALLSETTINGS_TABID FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_CALL_SETTINGS.sql =========*
PROMPT ===================================================================================== 
