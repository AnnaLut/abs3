

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/PRIOCOM_CREDIT_NBS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_PRIOCOM_CREDIT_NBS_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_CREDIT_NBS ADD CONSTRAINT FK_PRIOCOM_CREDIT_NBS_PS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/PRIOCOM_CREDIT_NBS.sql =========*
PROMPT ===================================================================================== 
