

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_REFT_AKALIST.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FINMON_REFT_AKALIST_C1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_REFT_AKALIST ADD CONSTRAINT FK_FINMON_REFT_AKALIST_C1 FOREIGN KEY (C1)
	  REFERENCES BARS.FINMON_REFT (C1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FINMON_REFT_AKALIST.sql =========
PROMPT ===================================================================================== 
