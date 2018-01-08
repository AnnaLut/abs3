

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/IBX_TYPES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSIBOXTYPES_ID_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_TYPES ADD CONSTRAINT FK_WCSIBOXTYPES_ID_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/IBX_TYPES.sql =========*** End **
PROMPT ===================================================================================== 
