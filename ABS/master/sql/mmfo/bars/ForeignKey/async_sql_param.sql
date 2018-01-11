

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_SQL_PARAM.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ASNSQLPAR_PAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ASYNC_SQL_PARAM ADD CONSTRAINT FK_ASNSQLPAR_PAR FOREIGN KEY (PARAM_ID)
	  REFERENCES BARS.ASYNC_PARAM (PARAM_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ASYNC_SQL_PARAM.sql =========*** 
PROMPT ===================================================================================== 
