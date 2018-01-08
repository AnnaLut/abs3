

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CUR_RATES$BASE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CURRATES$BASE_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT FK_CURRATES$BASE_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CURRATES$BASE_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT FK_CURRATES$BASE_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CUR_RATES$BASE.sql =========*** E
PROMPT ===================================================================================== 
