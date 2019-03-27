

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TAMOZHDOC_REESTR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TAMOZHDOCREESTR_CONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TAMOZHDOC_REESTR ADD CONSTRAINT FK_TAMOZHDOCREESTR_CONTRACTS FOREIGN KEY (PID)
	  REFERENCES BARS.TOP_CONTRACTS (PID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TAMOZHDOC_REESTR.sql =========***
PROMPT ===================================================================================== 