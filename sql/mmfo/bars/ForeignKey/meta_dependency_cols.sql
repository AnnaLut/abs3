

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_DEPENDENCY_COLS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_META_DEP_META_ACTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT FK_META_DEP_META_ACTTYPE FOREIGN KEY (ACTION_TYPE)
	  REFERENCES BARS.META_DEP_ACTIONTYPE (ACTION_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_META_DEP_META_COL ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT FK_META_DEP_META_COL FOREIGN KEY (TABID, COLID)
	  REFERENCES BARS.META_COLUMNS (TABID, COLID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_META_DEP_META_EVENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_DEPENDENCY_COLS ADD CONSTRAINT FK_META_DEP_META_EVENT FOREIGN KEY (EVENT)
	  REFERENCES BARS.META_DEP_EVENT (EVENT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_DEPENDENCY_COLS.sql ========
PROMPT ===================================================================================== 
