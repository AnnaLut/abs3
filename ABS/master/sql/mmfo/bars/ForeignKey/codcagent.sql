

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CODCAGENT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CODCAGENT_REZID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CODCAGENT ADD CONSTRAINT FK_CODCAGENT_REZID FOREIGN KEY (REZID)
	  REFERENCES BARS.REZID (REZID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CODCAGENT.sql =========*** End **
PROMPT ===================================================================================== 
