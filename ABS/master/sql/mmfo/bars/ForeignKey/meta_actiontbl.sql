

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/META_ACTIONTBL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_METAACTIONTBL_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL ADD CONSTRAINT FK_METAACTIONTBL_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAACTIONTBL_METAACTCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL ADD CONSTRAINT FK_METAACTIONTBL_METAACTCODES FOREIGN KEY (ACTION_CODE)
	  REFERENCES BARS.META_ACTIONCODES (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_METAACTIONTBL_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ACTIONTBL ADD CONSTRAINT FK_METAACTIONTBL_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/META_ACTIONTBL.sql =========*** E
PROMPT ===================================================================================== 
