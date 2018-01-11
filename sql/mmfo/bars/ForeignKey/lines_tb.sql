

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/LINES_TB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  constraint R_LINES_ZAG_TB ***
begin   
 execute immediate '
  ALTER TABLE BARS.LINES_TB ADD CONSTRAINT R_LINES_ZAG_TB FOREIGN KEY (FN, DAT)
	  REFERENCES BARS.ZAG_TB (FN, DAT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/LINES_TB.sql =========*** End ***
PROMPT ===================================================================================== 
