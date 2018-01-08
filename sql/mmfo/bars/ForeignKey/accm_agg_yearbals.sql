

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACCM_AGG_YEARBALS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACCMAGGYBALS_ACCMSTATECAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_AGG_YEARBALS ADD CONSTRAINT FK_ACCMAGGYBALS_ACCMSTATECAL FOREIGN KEY (CALDT_ID)
	  REFERENCES BARS.ACCM_CALENDAR (CALDT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACCM_AGG_YEARBALS.sql =========**
PROMPT ===================================================================================== 
