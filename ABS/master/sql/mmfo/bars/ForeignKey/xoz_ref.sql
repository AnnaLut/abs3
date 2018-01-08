

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/XOZ_REF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_XOZREF_REF1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XOZ_REF ADD CONSTRAINT FK_XOZREF_REF1 FOREIGN KEY (REF1)
	  REFERENCES BARS.OPER (REF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/XOZ_REF.sql =========*** End *** 
PROMPT ===================================================================================== 
