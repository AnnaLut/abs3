

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/COMPEN9760.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_COMPEN9760_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN9760 ADD CONSTRAINT FK_COMPEN9760_MFO FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ON DELETE CASCADE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/COMPEN9760.sql =========*** End *
PROMPT ===================================================================================== 
