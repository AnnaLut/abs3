

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/IBX_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_IBXFILES_ID_IBXTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.IBX_FILES ADD CONSTRAINT FK_IBXFILES_ID_IBXTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.IBX_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/IBX_FILES.sql =========*** End **
PROMPT ===================================================================================== 
