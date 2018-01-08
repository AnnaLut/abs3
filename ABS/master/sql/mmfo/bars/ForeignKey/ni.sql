

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/NI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_PS_NI ***
begin   
 execute immediate '
  ALTER TABLE BARS.NI ADD CONSTRAINT R_PS_NI FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/NI.sql =========*** End *** =====
PROMPT ===================================================================================== 
