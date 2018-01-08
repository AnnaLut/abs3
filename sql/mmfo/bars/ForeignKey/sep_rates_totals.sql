

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/SEP_RATES_TOTALS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_SEPRATESTOTALS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_TOTALS ADD CONSTRAINT FK_SEPRATESTOTALS_ID FOREIGN KEY (ID)
	  REFERENCES BARS.SEP_RATES_CALENDAR (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/SEP_RATES_TOTALS.sql =========***
PROMPT ===================================================================================== 
