

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ACC_CLB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ACC_CLB_CLBANKS_CLBID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_CLB ADD CONSTRAINT FK_ACC_CLB_CLBANKS_CLBID FOREIGN KEY (CLBID)
	  REFERENCES BARS.CLBANKS (CLBID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ACC_CLB.sql =========*** End *** 
PROMPT ===================================================================================== 
