

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CP_INFO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CP_INFO_BYR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_INFO ADD CONSTRAINT FK_CP_INFO_BYR FOREIGN KEY (BYR)
	  REFERENCES BARS.CP_BYR (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CP_INFO.sql =========*** End *** 
PROMPT ===================================================================================== 
