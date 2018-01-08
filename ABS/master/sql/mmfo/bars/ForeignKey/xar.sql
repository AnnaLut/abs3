

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XAR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_XAR_PAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.XAR ADD CONSTRAINT FK_XAR_PAP FOREIGN KEY (PAP)
	  REFERENCES BARS.PAP (PAP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XAR.sql =========*** End *** ====
PROMPT ===================================================================================== 
