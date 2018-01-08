

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/BRATES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_BRATES_BRTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRATES ADD CONSTRAINT FK_BRATES_BRTYPES FOREIGN KEY (BR_TYPE)
	  REFERENCES BARS.BR_TYPES (BR_TYPE) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/BRATES.sql =========*** End *** =
PROMPT ===================================================================================== 
