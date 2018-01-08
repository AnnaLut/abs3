

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FX_SPOT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FXSPOT_CODCAGENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SPOT ADD CONSTRAINT FK_FXSPOT_CODCAGENT FOREIGN KEY (CODCAGENT)
	  REFERENCES BARS.CODCAGENT (CODCAGENT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FX_SPOT.sql =========*** End *** 
PROMPT ===================================================================================== 
