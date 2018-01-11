

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SW_TEMPLATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SWTEMPLATE_TABVAL_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TEMPLATE ADD CONSTRAINT FK_SWTEMPLATE_TABVAL_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SW_TEMPLATE.sql =========*** End 
PROMPT ===================================================================================== 
