

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_FUNC_SETTINGS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METAFUNCSETTINGS_AFTFUNCID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FUNC_SETTINGS ADD CONSTRAINT FK_METAFUNCSETTINGS_AFTFUNCID FOREIGN KEY (AFTER_FUNC_ID)
	  REFERENCES BARS.META_FUNC_SETTINGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFUNCSETTINGS_FUNCID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FUNC_SETTINGS ADD CONSTRAINT FK_METAFUNCSETTINGS_FUNCID FOREIGN KEY (TABID, FUNCID)
	  REFERENCES BARS.META_NSIFUNCTION (TABID, FUNCID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFUNCSETTINGS_MAINSETID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FUNC_SETTINGS ADD CONSTRAINT FK_METAFUNCSETTINGS_MAINSETID FOREIGN KEY (MAIN_SET_ID)
	  REFERENCES BARS.META_CALL_SETTINGS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAFUNCSETTINGS_TABID ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_FUNC_SETTINGS ADD CONSTRAINT FK_METAFUNCSETTINGS_TABID FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_FUNC_SETTINGS.sql =========*
PROMPT ===================================================================================== 
