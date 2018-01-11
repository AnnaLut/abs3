

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/EURO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_EURO_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.EURO ADD CONSTRAINT FK_EURO_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/EURO.sql =========*** End *** ===
PROMPT ===================================================================================== 
