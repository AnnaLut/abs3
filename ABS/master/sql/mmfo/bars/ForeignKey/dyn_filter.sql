

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DYN_FILTER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DYNFILTER_METATABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER ADD CONSTRAINT FK_DYNFILTER_METATABLES FOREIGN KEY (TABID)
	  REFERENCES BARS.META_TABLES (TABID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DYNFILTER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER ADD CONSTRAINT FK_DYNFILTER_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DYNFILTER_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DYN_FILTER ADD CONSTRAINT FK_DYNFILTER_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DYN_FILTER.sql =========*** End *
PROMPT ===================================================================================== 
