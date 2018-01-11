

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TABLE_COL_ALIAS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TABCOLALIAS_TABALIAS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_COL_ALIAS ADD CONSTRAINT FK_TABCOLALIAS_TABALIAS FOREIGN KEY (TABLE_NAME)
	  REFERENCES BARS.TABLE_ALIAS (TABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TABLE_COL_ALIAS.sql =========*** 
PROMPT ===================================================================================== 
