

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/MSG_CODES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_MSGCODES_ERRMODULES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MSG_CODES ADD CONSTRAINT FK_MSGCODES_ERRMODULES FOREIGN KEY (MOD_CODE)
	  REFERENCES BARS.ERR_MODULES (ERRMOD_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/MSG_CODES.sql =========*** End **
PROMPT ===================================================================================== 
