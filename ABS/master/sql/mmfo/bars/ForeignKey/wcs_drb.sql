

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/WCS_DRB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_WCSDRB_TID_WCSDRBTPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DRB ADD CONSTRAINT FK_WCSDRB_TID_WCSDRBTPS FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_DRB_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/WCS_DRB.sql =========*** End *** 
PROMPT ===================================================================================== 
