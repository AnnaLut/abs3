

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/TABVAL$GLOBAL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_TABVAL_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT FK_TABVAL_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TABVAL_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT FK_TABVAL_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/TABVAL$GLOBAL.sql =========*** En
PROMPT ===================================================================================== 
