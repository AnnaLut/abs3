

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ATM_REF2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ATMREF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATM_REF2 ADD CONSTRAINT FK_ATMREF2 FOREIGN KEY (REF1)
	  REFERENCES BARS.ATM_REF1 (REF1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ATM_REF2.sql =========*** End ***
PROMPT ===================================================================================== 
