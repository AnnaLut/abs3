

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_GRT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CCGRT_GRTDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_GRT ADD CONSTRAINT FK_CCGRT_GRTDEALS FOREIGN KEY (GRT_DEAL_ID)
	  REFERENCES BARS.GRT_DEALS (DEAL_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_GRT.sql =========*** End *** =
PROMPT ===================================================================================== 
