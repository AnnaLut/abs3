

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ANB1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ANB1_NREP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1 ADD CONSTRAINT FK_ANB1_NREP FOREIGN KEY (NREP)
	  REFERENCES BARS.ANB0 (NREP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ANB1.sql =========*** End *** ===
PROMPT ===================================================================================== 
