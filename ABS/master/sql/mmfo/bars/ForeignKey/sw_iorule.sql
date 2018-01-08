

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_IORULE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWIORULE_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_IORULE ADD CONSTRAINT FK_SWIORULE_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_IORULE.sql =========*** End **
PROMPT ===================================================================================== 
