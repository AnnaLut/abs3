

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_REZERV23.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_REF_CP_REZERV23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REZERV23 ADD CONSTRAINT FK_REF_CP_REZERV23 FOREIGN KEY (REF)
	  REFERENCES BARS.CP_DEAL (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_REZERV23.sql =========*** End 
PROMPT ===================================================================================== 
