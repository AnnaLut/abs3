

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/CASH_Z.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_CASH_Z_SK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_Z ADD CONSTRAINT FK_CASH_Z_SK FOREIGN KEY (SK)
	  REFERENCES BARS.SK (SK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/CASH_Z.sql =========*** End *** =
PROMPT ===================================================================================== 
