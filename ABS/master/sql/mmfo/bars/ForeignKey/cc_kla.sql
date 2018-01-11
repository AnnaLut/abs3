

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CC_KLA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CC_KLA_VIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KLA ADD CONSTRAINT FK_CC_KLA_VIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.CC_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CC_KLA.sql =========*** End *** =
PROMPT ===================================================================================== 
