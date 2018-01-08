

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_TEMPLATES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_STAFFTEMPL_TEMPLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES ADD CONSTRAINT FK_STAFFTEMPL_TEMPLTYPES FOREIGN KEY (TEMPLTYPE_ID)
	  REFERENCES BARS.STAFF_TEMPL_TYPES (TEMPLTYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTEMPL_TEMPLSCHEMES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPLATES ADD CONSTRAINT FK_STAFFTEMPL_TEMPLSCHEMES FOREIGN KEY (SCHEME_ID)
	  REFERENCES BARS.STAFF_TEMPL_SCHEMES (SCHEME_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_TEMPLATES.sql =========*** 
PROMPT ===================================================================================== 
