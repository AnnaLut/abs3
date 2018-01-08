

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_PAYMENTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CPREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PAYMENTS ADD CONSTRAINT FK_CPREF FOREIGN KEY (CP_REF)
	  REFERENCES BARS.CP_DEAL (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_PAYMENTS.sql =========*** End 
PROMPT ===================================================================================== 
