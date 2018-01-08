

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SNO_REF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SNOREF_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNO_REF ADD CONSTRAINT FK_SNOREF_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SNO_REF.sql =========*** End *** 
PROMPT ===================================================================================== 
