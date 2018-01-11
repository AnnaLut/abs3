

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIN_DEBT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINDEBT_FINDEBM ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_DEBT ADD CONSTRAINT FK_FINDEBT_FINDEBM FOREIGN KEY (MOD_ABS)
	  REFERENCES BARS.FIN_DEBM (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIN_DEBT.sql =========*** End ***
PROMPT ===================================================================================== 
