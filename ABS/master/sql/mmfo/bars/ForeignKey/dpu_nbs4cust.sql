

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/DPU_NBS4CUST.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_DPUNBS4CUST_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_NBS4CUST ADD CONSTRAINT FK_DPUNBS4CUST_PS FOREIGN KEY (NBS_DEP)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/DPU_NBS4CUST.sql =========*** End
PROMPT ===================================================================================== 
