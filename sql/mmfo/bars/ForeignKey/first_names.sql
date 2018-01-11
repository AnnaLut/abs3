

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/FIRST_NAMES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_FIRSTNAMES_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIRST_NAMES ADD CONSTRAINT FK_FIRSTNAMES_SEX FOREIGN KEY (SEXID)
	  REFERENCES BARS.SEX (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/FIRST_NAMES.sql =========*** End 
PROMPT ===================================================================================== 
