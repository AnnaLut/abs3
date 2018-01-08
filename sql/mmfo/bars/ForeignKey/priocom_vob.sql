

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PRIOCOM_VOB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PRIOCOM_VOB_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_VOB ADD CONSTRAINT FK_PRIOCOM_VOB_VOB FOREIGN KEY (BARS_VOB_CODE)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PRIOCOM_VOB.sql =========*** End 
PROMPT ===================================================================================== 
