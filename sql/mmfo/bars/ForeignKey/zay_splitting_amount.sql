

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_SPLITTING_AMOUNT.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  constraint FK_ZAYSPLITTINGAMNT_ZAYSALETPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_SPLITTING_AMOUNT ADD CONSTRAINT FK_ZAYSPLITTINGAMNT_ZAYSALETPS FOREIGN KEY (SALE_TP)
	  REFERENCES BARS.ZAY_SALE_TYPES (TP_ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/ForeignKey/ZAY_SPLITTING_AMOUNT.sql ========
PROMPT ===================================================================================== 
