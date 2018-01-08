

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_TEMPL_TYPES.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TEMPLTYPES_TEMPLTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_TEMPL_TYPES ADD CONSTRAINT FK_TEMPLTYPES_TEMPLTYPES FOREIGN KEY (PARENT_ID)
	  REFERENCES BARS.STAFF_TEMPL_TYPES (TEMPLTYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/STAFF_TEMPL_TYPES.sql =========**
PROMPT ===================================================================================== 
