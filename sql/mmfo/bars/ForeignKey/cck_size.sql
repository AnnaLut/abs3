

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CCK_SIZE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCK_SIZE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SIZE ADD CONSTRAINT FK_CCK_SIZE FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CCK_SIZE.sql =========*** End ***
PROMPT ===================================================================================== 
