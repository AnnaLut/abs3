

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BR_KAZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BR_KAZ_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_KAZ ADD CONSTRAINT FK_BR_KAZ_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BR_KAZ.sql =========*** End *** =
PROMPT ===================================================================================== 
